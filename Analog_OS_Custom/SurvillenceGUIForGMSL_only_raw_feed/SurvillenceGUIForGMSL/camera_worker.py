import time, cv2
from PyQt5.QtCore import QThread, pyqtSignal
from PyQt5.QtGui import QImage
from v4l2_driver import V4L2CameraThreaded, ColorCorrector

class CameraWorker(QThread):
    newFrame = pyqtSignal(int, object, float)

    def __init__(self, device_path, cam_id, width, height, flip_h=False, flip_v=False):
        super().__init__()
        self.device_path, self.cam_id = device_path, cam_id
        self.width, self.height = width, height
        self.flip_h, self.flip_v = flip_h, flip_v
        self.running = True
        self.enabled = True # Use this to show/hide without freezing hardware

    def run(self):
        try:
            self.cam = V4L2CameraThreaded(self.device_path, 1920, 1080, self.width, self.height).start()
            while self.running:
                t_start = time.time()
                bgr = self.cam.read_latest() # Always read to keep Pi5 hardware happy
                
                if bgr is not None and self.enabled:
                    img = ColorCorrector.apply(bgr)
                    if self.flip_h: img = cv2.flip(img, 1)
                    if self.flip_v: img = cv2.flip(img, 0)

                    rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
                    h, w, ch = rgb.shape
                    qt_img = QImage(rgb.data, w, h, ch * w, QImage.Format_RGB888).copy()
                    lat = (time.time() - t_start) * 1000
                    self.newFrame.emit(self.cam_id, qt_img, lat)
                else:
                    time.sleep(0.01) # Low CPU mode when disabled
            self.cam.stop()
        except: pass

    def stop(self):
        self.running = False
        self.wait(1000)
