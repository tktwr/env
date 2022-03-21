import os
os.environ['OPENCV_IO_ENABLE_OPENEXR'] = '1'
import cv2
import cv_util as cu
import numpy as np
import tkinter as tk
from PIL import Image, ImageTk


def cvimg_to_imgtk(img):
    img = cu.cv_cvt_dtype(img, 'uint8')
    img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    img_pil = Image.fromarray(img_rgb)
    img_tk  = ImageTk.PhotoImage(img_pil)
    return img_tk


#======================================================
# ImageWinBase
#======================================================
class ImageWinBase(tk.Frame):
    def __init__(self, parent, app, nr, win_type, uv=(0.5, 0.5)):
        print(f"ImageWinBase::__init__")
        super().__init__(parent)
        self.pack()

        self.parent = parent
        self.app = app
        self.nr = nr

        self.I = app.I[nr]
        self.win_img = self.I.get_img(win_type)

        #self.parent.title(f"Image {nr}: {win_type}")

    def __del__(self):
        print(f"ImageWinBase::__del__")

    def resize(self, img):
        h, w = img.shape[:2]
        win_h = h + 30
        win_w = w
        #self.parent.geometry(f"{win_w}x{win_h}")

    def create_canvas(self, img):
        self.img_tk = cvimg_to_imgtk(img)
        w = self.img_tk.width()
        h = self.img_tk.height()
        self.canvas = tk.Canvas(self.parent, width=w, height=h)
        self.canvas.create_image(0, 0, image=self.img_tk, anchor='nw')
        self.canvas.bind('<Button-1>', self.mouse_canvas)
        self.canvas.bind('<Button-3>', self.mouse_canvas)
        self.canvas.bind('<B1-Motion>', self.mouse_canvas)
        self.canvas.pack()

    def update_canvas(self, img):
        self.img_tk = cvimg_to_imgtk(img)
        self.canvas.create_image(0, 0, image=self.img_tk, anchor='nw')

    def mouse_canvas(self, event):
        if event.num == 3:
            self.app.cmd_close_crop(self.app.active_nr)
        else:
            xy = (event.x, event.y)
            uv = self.xy_to_uv(xy)
            self.update_status(uv)
            self.app.cmd_show_crop(uv, self.app.active_nr)

    def xy_to_uv(self, xy):
        # xy in window
        x, y = xy

        # window image size
        h, w = self.win_img.shape[:2]

        # uv
        uv = (x/(w-1), y/(h-1))

        return uv

    def update_status(self, uv):
        uv = np.clip(uv, 0, 1)
        u, v = uv

        # original image size
        H, W = self.I.img.shape[:2]

        # XY in original image
        XY = (int(u * (W-1)), int(v * (H-1)))

        val = self.I.pick_uv(uv)

        uv_str = f"({u:.2f}, {v:.2f})"
        text = f"uv={uv_str}, XY={XY}, val={val}"
        main_win = self.app.main_win
        if hasattr(main_win, 'status_text') and main_win.status_text != None:
            main_win.status_text.set(text)


#======================================================
# ImageFrame
#======================================================
class ImageFrame(ImageWinBase):
    def __init__(self, parent, app, nr, uv=(0.5, 0.5)):
        super().__init__(parent, app, nr, 'disp', uv)

        self.create_canvas(self.win_img)
        self.resize(self.win_img)
        self.update_status(uv)


#======================================================
# ImageWin
#======================================================
class ImageWin(ImageWinBase):
    def __init__(self, parent, app, nr, uv=(0.5, 0.5), geom=''):
        super().__init__(parent, app, nr, 'disp', uv)

        self.create_menu()
        self.create_canvas(self.win_img)
        self.resize(self.win_img)
        self.update_status(uv)
        if geom != '':
            self.parent.geometry(geom)

    def create_menu(self):
        menubar = tk.Menu(self.parent)

        # File Menu
        file_menu = tk.Menu(menubar, tearoff=0)
        file_menu.add_command(label='Open Image',
                command=lambda: self.app.eval_cmd(f"load_dlg({self.nr})", show=True))
        file_menu.add_command(label='Save Image',
                command=lambda: self.app.eval_cmd(f"save_dlg({self.nr})"))

        menubar.add_cascade(label='File', menu=file_menu)

        self.parent.config(menu=menubar)


#======================================================
# CropWin
#======================================================
class CropWin(ImageWinBase):
    def __init__(self, parent, app, nr, uv=(0.5, 0.5), geom=''):
        super().__init__(parent, app, nr, 'crop', uv)

        self.create_canvas(self.win_img)
        self.resize(self.win_img)
        if geom != '':
            self.parent.geometry(geom)


