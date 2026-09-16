import os, time, subprocess
from PyQt5.QtWidgets import (QMainWindow, QWidget, QGridLayout, QVBoxLayout, QLabel,
                             QAction, QDialog, QComboBox, QDialogButtonBox, QCheckBox)
from PyQt5.QtCore import Qt, pyqtSlot
from videowidget import VideoWidget
from camera_worker import CameraWorker

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Pi5 GMSL 4-Cam CCTV Monitor")
        self.resize(1280, 800)
        self.setStyleSheet("background-color: #0c0c0c; color: #EEE;")

        self.cam_power = {i: True for i in range(4)}
        self.cam_res = {i: (640, 480) for i in range(4)}
        self.cam_mirror = {i: (False, False) for i in range(4)}
        self.workers = {i: None for i in range(4)}
        self.video_map = {0: '/dev/video3', 1: '/dev/video1', 2: '/dev/video2', 3: '/dev/video0'}

        self.init_ui()
        self.setup_hardware_permanent()
        self.start_initial_workers()

    def init_ui(self):
        mb = self.menuBar()
        mb.setStyleSheet("QMenuBar { background: #1a1a1a; color: #ffb300; font-weight: bold; }")
        ctrl = mb.addMenu("&Controls")
        ctrl.addAction("Power Control", self.show_power_dialog)
        ctrl.addAction("Resolution Settings", self.show_res_dialog)
        ctrl.addAction("Mirror/Flip", self.show_mirror_dialog)

        self.central = QWidget(); self.setCentralWidget(self.central)
        self.grid = QGridLayout(self.central); self.grid.setSpacing(2); self.grid.setContentsMargins(2,2,2,2)
        self.views = [VideoWidget(f"CAM {i}") for i in range(4)]
        for i, v in enumerate(self.views): self.grid.addWidget(v, i//2, i%2)

    def setup_hardware_permanent(self):
        media_dev = "/dev/media0"
        pipeline = f"""
        media-ctl -d {media_dev} -r
        media-ctl -d {media_dev} --set-route '"max96724 10-0027":0 [0/0->4/0[1], 1/0->4/1[1], 2/0->4/2[1], 3/0->4/3[1]]'
        media-ctl -d {media_dev} --set-route '"csi2":0 [0/0 -> 1/0 [1], 0/1 -> 2/0 [1], 0/2 -> 3/0 [1], 0/3 -> 4/0 [1]]'
        media-ctl -d {media_dev} -l "'csi2':1 -> 'rp1-cfe-csi2-ch0':0 [1]"
        media-ctl -d {media_dev} -l "'csi2':2 -> 'rp1-cfe-csi2-ch1':0 [1]"
        media-ctl -d {media_dev} -l "'csi2':3 -> 'rp1-cfe-csi2-ch2':0 [1]"
        media-ctl -d {media_dev} -l "'csi2':4 -> 'rp1-cfe-csi2-ch3':0 [1]"
        """
        subprocess.run(pipeline, shell=True)
        for i in range(4):
            subprocess.run(f"v4l2-ctl -d /dev/video{i} --set-fmt-video width=1920,height=1080,pixelformat=RGGB", shell=True)
        time.sleep(0.5)

    def start_initial_workers(self):
        for i in range(4):
            dev = self.video_map[i]
            w, h = self.cam_res[i]
            mh, mv = self.cam_mirror[i]
            self.workers[i] = CameraWorker(dev, i, w, h, mh, mv)
            self.workers[i].newFrame.connect(self.on_frame)
            self.workers[i].start()

    def apply_config(self):
        for i in range(4):
            if self.workers[i]:
                self.workers[i].enabled = self.cam_power[i]
                self.workers[i].flip_h = self.cam_mirror[i][0]
                self.workers[i].flip_v = self.cam_mirror[i][1]
            if not self.cam_power[i]:
                self.views[i].setOffline()

    @pyqtSlot(int, object, float)
    def on_frame(self, cid, qimg, lat):
        if self.cam_power[cid]:
            self.views[cid].setFrame(qimg, lat)

    def show_power_dialog(self):
        d = QDialog(self); d.setWindowTitle("Power Control"); l = QVBoxLayout(d); cbs = {}
        for i in range(4):
            cb = QCheckBox(f"Enable CAM {i}"); cb.setChecked(self.cam_power[i]); cbs[i] = cb; l.addWidget(cb)
        bb = QDialogButtonBox(QDialogButtonBox.Ok | QDialogButtonBox.Cancel); bb.accepted.connect(d.accept); l.addWidget(bb)
        if d.exec_():
            for i in range(4): self.cam_power[i] = cbs[i].isChecked()
            self.apply_config()

    def show_res_dialog(self):
        d = QDialog(self); d.setWindowTitle("Resolution Settings (Max one 1080p)"); l = QVBoxLayout(d)
        combos = {}

        # The Logic: If one is 1080p, others must downgrade
        def enforce_single_1080p():
            sender = self.sender()
            if sender.currentText() == "1080p":
                for i in range(4):
                    if combos[i] != sender and combos[i].currentText() == "1080p":
                        combos[i].blockSignals(True) # Prevent recursive loops
                        combos[i].setCurrentText("720p")
                        combos[i].blockSignals(False)

        for i in range(4):
            l.addWidget(QLabel(f"CAM {i} Output:"))
            c = QComboBox()
            c.addItems(["480p", "720p", "1080p"])
            
            # Set current value
            curr = self.cam_res[i]
            res_str = "480p" if curr==(640,480) else "720p" if curr==(1280,720) else "1080p"
            c.setCurrentText(res_str)
            
            # Connect the enforcement logic
            c.currentTextChanged.connect(enforce_single_1080p)
            
            combos[i] = c
            l.addWidget(c)

        bb = QDialogButtonBox(QDialogButtonBox.Ok | QDialogButtonBox.Cancel)
        bb.accepted.connect(d.accept); l.addWidget(bb)
        
        if d.exec_():
            m = {"480p": (640, 480), "720p": (1280, 720), "1080p": (1920, 1080)}
            for i in range(4):
                self.cam_res[i] = m[combos[i].currentText()]
            
            # Restart workers to apply resolution change
            for i in range(4): self.workers[i].stop()
            self.start_initial_workers()
            self.apply_config()

    def show_mirror_dialog(self):
        d = QDialog(self); d.setWindowTitle("Mirror Settings"); l = QGridLayout(d); checks = {}
        for i in range(4):
            h, v = QCheckBox("H-Flip"), QCheckBox("V-Flip")
            h.setChecked(self.cam_mirror[i][0]); v.setChecked(self.cam_mirror[i][1])
            l.addWidget(QLabel(f"CAM {i}:"), i, 0); l.addWidget(h, i, 1); l.addWidget(v, i, 2); checks[i] = (h, v)
        bb = QDialogButtonBox(QDialogButtonBox.Ok | QDialogButtonBox.Cancel); bb.accepted.connect(d.accept); l.addWidget(bb, 4, 0, 1, 3)
        if d.exec_():
            for i in range(4): self.cam_mirror[i] = (checks[i][0].isChecked(), checks[i][1].isChecked())
            self.apply_config()

    def closeEvent(self, event):
        for i in range(4):
            if self.workers[i]: self.workers[i].stop()
        super().closeEvent(event)
