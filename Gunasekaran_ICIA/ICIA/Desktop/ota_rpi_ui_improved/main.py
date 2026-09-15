# integrated_main_uart.py
# Integrated UI + framed UART sender (combines main.py UI + UART_send.py framing)
# Save as integrated_main_uart.py and run with python3
import os, sys, signal, time, threading, logging, struct
from pathlib import Path
import tkinter as tk
from tkinter import ttk, messagebox, filedialog

try:
    import requests
except Exception:
    requests = None
try:
    import serial, serial.tools.list_ports
except Exception:
    serial = None
try:
    import psutil
except Exception:
    psutil = None

# ---------------- Protocol constants (from UART_send.py) ----------------
HEADER_H = 0xAA
HEADER_L = 0x55
FOOTER_H = 0x55
FOOTER_L = 0xAA

PKT_TYPE_DATA_FIRST = 0x01
PKT_TYPE_DATA_MID   = 0x00
PKT_TYPE_DATA_LAST  = 0x02

PAYLOAD_CAP = 1010          # payload bytes in the struct
FRAME_SIZE = 1024           # full frame bytes
CRC_INDEX = FRAME_SIZE - 3  # index of CRC byte (1021)
FOOTER_INDEX = FRAME_SIZE - 2
crc_start = 2               # CRC starts at pkt_type

DEFAULT_DELAY = 0.5         # delay between frames (seconds) - can be tuned

# --------------- UI / download constants (from main.py) ------------------
DEFAULT_URL = "http://192.168.12.10:8000/firmware.bin"
DOWNLOAD_DIR = Path.home() / "ota_downloads"
DOWNLOAD_FILE = DOWNLOAD_DIR / "firmware.bin"
TMP_FILE = DOWNLOAD_DIR / "firmware.tmp"
CHUNK_SIZE = 8192
BAUDS = [9600,19200,38400,57600,115200,230400,460800,921600]

# Logging
logging.basicConfig(level=logging.INFO, format="[%(asctime)s] %(message)s")
logger = logging.getLogger("rpi_ui")

stop_event = threading.Event()

def handle_sigterm(signum, frame):
    logger.info("SIGTERM received, shutting down cleanly...")
    stop_event.set()
    if app and hasattr(app, "after"):
        app.after(100, app.quit)

signal.signal(signal.SIGTERM, handle_sigterm)
signal.signal(signal.SIGINT, handle_sigterm)

# -------------------- helper functions (CRC / framing) --------------------
def human_size(n):
    for unit in ['B','KB','MB','GB']:
        if n < 1024.0:
            return f"{n:.1f}{unit}"
        n /= 1024.0
    return f"{n:.1f}TB"

def calc_crc_xor(data: bytes) -> int:
    """
    Same algorithm as your UART_send.py -- returns 8-bit CRC/truncation.
    """
    curr_crc = 0xAA
    sum1 = curr_crc & 0xFF
    sum2 = (curr_crc >> 8) & 0xFF
    for byte in data:
        sum1 = (sum1 + byte) % 255
        sum2 = (sum2 + sum1) % 255
    return ((sum2 << 8) | sum1) & 0xFF

def build_frame(pkt_type, seq, payload_bytes, file_size):
    """
    Build the 1024-byte frame used by your receiver:
    header(2), pkt_type(1), seq(2), payload_len(2), file_size(4),
    payload (1010 max), crc, footer(2) -> total 1024 bytes.
    """
    if len(payload_bytes) > PAYLOAD_CAP:
        raise ValueError("payload too large")

    frame = bytearray(FRAME_SIZE)
    frame[0] = HEADER_H
    frame[1] = HEADER_L
    frame[2] = pkt_type & 0xFF
    struct.pack_into("<H", frame, 3, seq & 0xFFFF)
    struct.pack_into("<H", frame, 5, len(payload_bytes) & 0xFFFF)
    struct.pack_into("<I", frame, 7, file_size & 0xFFFFFFFF)
    frame[11:11 + len(payload_bytes)] = payload_bytes
    crc_end = 11 + len(payload_bytes)
    crc = calc_crc_xor(bytes(frame[crc_start:crc_end]))
    frame[CRC_INDEX] = crc
    frame[FOOTER_INDEX] = FOOTER_H
    frame[FOOTER_INDEX + 1] = FOOTER_L
    return bytes(frame)

# ------------------------- Network / IP helpers --------------------------
def get_ip_info():
    if psutil:
        data = {}
        for name, snics in psutil.net_if_addrs().items():
            ipv4s = [s.address for s in snics if getattr(s, "family", None) and getattr(s.family, "name", "") == "AF_INET"]
            if ipv4s:
                data[name] = ipv4s
        return data
    import socket
    return {"host": [socket.gethostbyname(socket.gethostname())]}

def get_primary_ip():
    for name, ips in get_ip_info().items():
        if any(k in name.lower() for k in ("wlan","wifi","wl")):
            return ips[0]
    for ips in get_ip_info().values():
        for ip in ips:
            if not ip.startswith("127."):
                return ip
    return None

# ------------------------------- UI class --------------------------------
class UI(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("RPi OTA UI (framed UART sender)")
        self.geometry("820x560")
        self.protocol("WM_DELETE_WINDOW", self._on_close)
        self.url = tk.StringVar(value=DEFAULT_URL)
        self.status = tk.StringVar(value="Empty")
        self.progress = tk.IntVar(value=0)
        self.port = tk.StringVar()
        self.baud = tk.IntVar(value=115200)
        self._is_downloading = False
        self.send_delay = tk.DoubleVar(value=DEFAULT_DELAY)  # small control for inter-frame delay
        self._build()
        self._refresh_ports()
        self._update_status()
        self.after(1500, self._periodic)

    def _build(self):
        top = ttk.Frame(self, padding=10); top.pack(fill=tk.X)
        ttk.Label(top, text="URL:").grid(row=0,column=0)
        ttk.Entry(top, textvariable=self.url, width=70).grid(row=0,column=1)
        ttk.Button(top,text="Download",command=self.download).grid(row=0,column=2,padx=5)
        ttk.Button(top,text="Browse",command=self._browse).grid(row=0,column=3)

        info = ttk.Frame(self,padding=10); info.pack(fill=tk.X)
        self.ip_lbl = ttk.Label(info,text="-"); self.ip_lbl.pack(anchor=tk.W)
        self.text = tk.Text(info,width=80,height=4,state="disabled",background="#f4f6f8"); self.text.pack()

        ttk.Label(info,text="Status:").pack(anchor=tk.W)
        self.status_lbl = ttk.Label(info,textvariable=self.status,foreground="red"); self.status_lbl.pack(anchor=tk.W)

        serialf = ttk.Frame(self,padding=10); serialf.pack(fill=tk.X)
        self.combo = ttk.Combobox(serialf,textvariable=self.port,width=25,state="readonly"); self.combo.pack(side=tk.LEFT)
        ttk.Button(serialf,text="Refresh",command=self._refresh_ports).pack(side=tk.LEFT,padx=4)
        ttk.Combobox(serialf,textvariable=self.baud,values=BAUDS,width=10,state="readonly").pack(side=tk.LEFT,padx=4)
        ttk.Button(serialf,text="UART_SEND",command=self.send_uart).pack(side=tk.LEFT,padx=4)

        # small control for frame delay
        ttk.Label(serialf, text="Delay(s):").pack(side=tk.LEFT, padx=6)
        ttk.Entry(serialf, textvariable=self.send_delay, width=6).pack(side=tk.LEFT)

        self.pb = ttk.Progressbar(self,orient="horizontal",length=780,variable=self.progress); self.pb.pack(pady=5)
        self.log = tk.Text(self,height=12,state="disabled",background="#fafafa"); self.log.pack(fill=tk.BOTH,expand=True)

    def logmsg(self,msg):
        ts=time.strftime("%H:%M:%S")
        self.log.config(state="normal")
        self.log.insert("end",f"[{ts}] {msg}\n")
        self.log.see("end")
        self.log.config(state="disabled")
        logger.info(msg)

    def _browse(self):
        f=filedialog.askopenfilename(title="Select BIN",filetypes=[("BIN","*.bin"),("All","*.*")])
        if f:self.url.set(f"file://{f}")

    def _refresh_ports(self):
        if not serial:
            self.logmsg("pyserial not available")
            return
        ports=[p.device for p in serial.tools.list_ports.comports()]
        self.combo["values"]=ports
        if ports:self.port.set(ports[0])
        self.logmsg(f"Ports: {ports}")

    def _periodic(self):
        if stop_event.is_set():self.quit();return
        self._update_status()
        self.after(1500,self._periodic)

    def _update_status(self):
        ip=get_primary_ip() or "-"
        self.ip_lbl.config(text=f"RPi IP: {ip}")
        txt="\n".join([f"{k}: {', '.join(v)}" for k,v in get_ip_info().items()])
        self.text.config(state="normal");self.text.delete("1.0",tk.END);self.text.insert("1.0",txt);self.text.config(state="disabled")
        if self._is_downloading:self.status.set("Downloading...");self.status_lbl.config(foreground="orange")
        else:
            if DOWNLOAD_FILE.exists():self.status.set("Downloaded");self.status_lbl.config(foreground="green")
            else:self.status.set("Empty");self.status_lbl.config(foreground="red")


    def download(self):
        if self._is_downloading:return
        threading.Thread(target=self._dl_thread,daemon=True).start()

    def _dl_thread(self):
        self._is_downloading=True
        url=self.url.get()
        try:
            self.logmsg(f"Downloading {url}")
            DOWNLOAD_DIR.mkdir(parents=True, exist_ok=True)
            if url.startswith("file://"):
                src=url[7:]
                with open(src,"rb") as f, open(TMP_FILE,"wb") as o:
                    while True:
                        d=f.read(CHUNK_SIZE)
                        if not d:break
                        o.write(d)
                os.replace(TMP_FILE,DOWNLOAD_FILE)
                self.logmsg(f"Copied from local {src}")
            else:
                if not requests:self.logmsg("requests missing");return
                with requests.get(url,stream=True) as r:
                    total=int(r.headers.get("content-length",0));done=0
                    with open(TMP_FILE,"wb") as f:
                        for c in r.iter_content(chunk_size=CHUNK_SIZE):
                            if stop_event.is_set():return
                            if c:
                                f.write(c);done+=len(c)
                                if total:self.progress.set(int(done*100/total))
                os.replace(TMP_FILE,DOWNLOAD_FILE)
                self.logmsg(f"Downloaded {DOWNLOAD_FILE}")
        except Exception as e:
            self.logmsg(f"Error: {e}")
        finally:
            self._is_downloading=False
            self._update_status()
            self.progress.set(0)

    # ------------------- Replaced sender: framed UART transfer -------------------
    def send_uart(self):
        # ensure file exists first
        if not DOWNLOAD_FILE.exists():
            messagebox.showwarning("No file","Download first or browse to a .bin")
            return
        port=self.port.get()
        baud=self.baud.get()
        # start background sender so UI doesn't block
        threading.Thread(target=self._uart_thread, args=(port, baud, self.send_delay.get()), daemon=True).start()

    def _uart_thread(self, port, baud, delay_between_frames):
        if not serial:
            self.logmsg("pyserial not installed")
            return
        try:
            filesize = DOWNLOAD_FILE.stat().st_size
            if filesize == 0:
                self.logmsg("File empty, nothing to send")
                return

            self.logmsg(f"Opening {port} @ {baud} and sending {human_size(filesize)} in {PAYLOAD_CAP}-byte payload frames")
            seq = 0
            bytes_sent = 0
            chunk_count = 0
            first_frame = True

            with open(DOWNLOAD_FILE, "rb") as f, serial.Serial(port, baud, timeout=1) as s:
                start_time = time.time()
                while True:
                    chunk = f.read(PAYLOAD_CAP)
                    if not chunk:
                        break

                    is_last = (bytes_sent + len(chunk)) == filesize
                    if first_frame:
                        pkt_type = PKT_TYPE_DATA_FIRST
                    elif is_last:
                        pkt_type = PKT_TYPE_DATA_LAST
                    else:
                        pkt_type = PKT_TYPE_DATA_MID

                    frame = build_frame(pkt_type, seq, chunk, filesize)
                    # send frame
                    s.write(frame)
                    s.flush()

                    chunk_count += 1
                    bytes_sent += len(chunk)
                    percent = int(bytes_sent * 100 / filesize)
                    # update UI
                    self.progress.set(percent)
                    self.logmsg(f"Sent seq={seq} pkt=0x{pkt_type:02X} len={len(chunk)} ({percent}%)")
                    seq = (seq + 1) & 0xFFFF
                    first_frame = False

                    # optional delay to give device time to process
                    if delay_between_frames and delay_between_frames > 0:
                        time.sleep(delay_between_frames)

                elapsed = time.time() - start_time
                self.logmsg(f"✅ Transfer complete: {human_size(bytes_sent)} in {elapsed:.2f}s ({chunk_count} frames)")
        except Exception as e:
            self.logmsg(f"UART error: {e}")
        finally:
            self.progress.set(0)

    def _on_close(self):
        stop_event.set();self.quit()

# ----------------------------- run app -----------------------------------
app=None
def main():
    global app
    app=UI();app.mainloop()

if __name__=="__main__":
    main()
