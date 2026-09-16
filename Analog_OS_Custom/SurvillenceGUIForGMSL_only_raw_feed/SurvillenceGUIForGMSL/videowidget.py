import datetime
from PyQt5.QtWidgets import QWidget
from PyQt5.QtCore import Qt, QTimer
from PyQt5.QtGui import QImage, QPainter, QPen, QFont, QColor

class VideoWidget(QWidget):
    def __init__(self, name, parent=None):
        super().__init__(parent)
        self.m_name = name
        self.m_frame = QImage()
        self.m_online = False
        self.m_fps, self.m_lat, self.m_count = 0, 0, 0
        self.timer = QTimer(self)
        self.timer.timeout.connect(self._tick)
        self.timer.start(1000)

    def setFrame(self, qimg, lat):
        self.m_frame, self.m_lat = qimg, lat
        self.m_online, self.m_count = True, self.m_count + 1
        self.update()

    def setOffline(self):
        self.m_online, self.m_frame = False, QImage()
        self.update()

    def _tick(self):
        self.m_fps, self.m_count = self.m_count, 0

    def paintEvent(self, event):
        p = QPainter(self)
        p.fillRect(self.rect(), Qt.black)
        if not self.m_frame.isNull() and self.m_online:
            scaled = self.m_frame.scaled(self.size(), Qt.KeepAspectRatio, Qt.FastTransformation)
            p.drawImage((self.width()-scaled.width())//2, (self.height()-scaled.height())//2, scaled)
        
        p.setPen(QPen(QColor("#ffb300") if self.m_online else Qt.red, 2))
        p.drawRect(self.rect().adjusted(1,1,-2,-2))
        
        p.setPen(Qt.green)
        p.setFont(QFont("Monospace", 10, QFont.Bold))
        text = f"{self.m_name} | {self.m_fps} FPS | {self.m_lat:.1f}ms" if self.m_online else f"{self.m_name} - NO SIGNAL"
        p.drawText(15, 25, text)
        p.end()