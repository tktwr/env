#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import cv2
import cv_util as cu
import numpy as np
from ttpy import FileName
import tkinter as tk
from tkinter import ttk
from tkinter import font
from tkinter import filedialog
from tkinter.scrolledtext import ScrolledText
from PIL import Image, ImageTk


def cvimg_to_imgtk(img):
    if img.dtype == np.float32:
        img = np.clip(img * 255, 0, 255).astype(np.uint8)

    img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    img_pil = Image.fromarray(img_rgb)
    img_tk  = ImageTk.PhotoImage(img_pil)
    return img_tk

class ImagePkg():
    def __init__(self, fname=""):
        print(f"ImagePkg::__init__")
        self.disp_max_wh = [500, 500]
        if fname != "":
            self.load(fname)

    def __del__(self):
        print(f"ImagePkg::__del__")

    def set_img(self, img, fname):
        h, w = img.shape[:2]

        self.fname = fname
        self.img = img
        self.wh = (w, h)
        self.make_disp_img(self.disp_max_wh)

    def load(self, fname):
        img = cu.cv_load(fname)
        self.set_img(img, fname)

    def save(self, fname):
        cu.cv_save(fname, self.img)

    def pick_xy(self, xy):
        x, y = xy
        return self.img[y, x]

    def pick_uv(self, uv):
        xy = self.uv_to_xy(uv)
        return self.pick_xy(xy)

    def uv_to_xy(self, uv):
        u, v = uv
        w, h = self.wh
        return (int(u * (w-1)), int(v * (h-1)))

    def xy_to_uv(self, xy):
        x, y = xy
        w, h = self.wh
        return (float(x)/(w-1), float(y)/(h-1))

    def size_wh(self):
        return self.wh

    def make_disp_img(self, max_wh):
        w_max, h_max = max_wh
        w, h = self.wh
        img = self.img

        if h >= w and h > h_max:
            dst_size = (0, h_max)
            oimg = cu.cv_resize_img(img, dst_size)
        elif w >= h and w > w_max:
            dst_size = (w_max, 0)
            oimg = cu.cv_resize_img(img, dst_size)
        else:
            dst_size = (0, 0)
            oimg = img

        self.disp_img = oimg
        return oimg

    def make_crop_xy_img(self, xy, wh):
        oimg = cu.cv_crop_center_img(self.img, xy, wh)
        self.crop_img = oimg
        return oimg

    def make_crop_uv_img(self, uv, wh):
        xy = self.uv_to_xy(uv)
        return self.make_crop_xy_img(xy, wh)


class ImageWin(tk.Frame):
    def __init__(self, root, app, nr, type, uv=(0.5, 0.5)):
        super().__init__(root)
        self.pack()

        self.root = root
        self.app = app
        self.nr = nr
        self.type = type

        self.I = app.I[nr]
        if type == "disp":
            self.img = self.I.disp_img
        elif type == "crop":
            self.img = self.I.crop_img

        img_tk = cvimg_to_imgtk(self.img)
        self.create_canvas(img_tk)
        self.create_status()
        self.update_status(uv)

        h, w = self.img.shape[:2]
        win_h = h + 30
        win_w = w

        self.root.geometry(f"{win_w}x{win_h}")
        self.root.title(f"Image {nr}: {type}")

    def create_canvas(self, img_tk):
        self.img_tk = img_tk
        self.canvas = tk.Canvas(self.root, width=img_tk.width(), height=img_tk.height())
        self.canvas.bind('<Button-1>', self.mouse_canvas)
        self.canvas.bind('<B1-Motion>', self.mouse_canvas)
        self.canvas.create_image(0, 0, image=self.img_tk, anchor='nw')
        self.canvas.pack()

    def create_status(self):
        self.status_text = tk.StringVar()
        label = ttk.Label(self.root,
            textvariable=self.status_text,
            relief='sunken',
            #relief='groove',
            font=self.app.text_font
            )
        label.pack(fill = tk.X)

    def update_canvas(self, img_tk):
        self.img_tk = img_tk
        self.canvas.create_image(0, 0, image=self.img_tk, anchor='nw')

    def update_status(self, uv):
        u, v = uv

        # original image size
        H, W = self.I.img.shape[:2]

        # XY in original image
        XY = (int(u * (W-1)), int(v * (H-1)))

        val = self.I.pick_uv(uv)

        uv_str = f"({u:.2f}, {v:.2f})"
        text = f"uv={uv_str}, XY={XY}, bgr={val}"
        self.status_text.set(text)

    def mouse_canvas(self, event):
        xy = (event.x, event.y)
        uv = self.xy_to_uv(xy)
        self.update_status(uv)
        self.app.cmd_show_crop(self.nr, uv)

    def xy_to_uv(self, xy):
        # xy in window
        x, y = xy

        # window image size
        h, w = self.img.shape[:2]

        # uv
        uv = (x/(w-1), y/(h-1))

        return uv


class MainWin(tk.Frame):
    def __init__(self, root, app):
        super().__init__(root)
        self.pack()
        self.root = root
        self.app = app

        menubar = tk.Menu(root)

        # File Menu
        filemenu = tk.Menu(menubar, tearoff=0)
        filemenu.add_command(label='Open Image 1',
                command=lambda: self.app.eval_cmd(f"load_dlg(1)"))
        filemenu.add_command(label='Open Image 2',
                command=lambda: self.app.eval_cmd(f"load_dlg(2)"))
        filemenu.add_command(label='Save Image 0',
                command=lambda: self.app.eval_cmd(f"save_dlg(0)"))
        filemenu.add_command(label='Clear Text',
                command=lambda: self.app.eval_cmd(f"clear()"))
        filemenu.add_separator()
        filemenu.add_command(label='Exit',
                command=lambda: self.app.eval_cmd(f"quit()"))

        # Help
        helpmenu = tk.Menu(menubar, tearoff=0)
        helpmenu.add_command(label='Help',
                command=lambda: self.app.eval_cmd(f"help()"))
        
        # Add
        menubar.add_cascade(label='File', menu=filemenu)
        menubar.add_cascade(label='Help', menu=helpmenu)
        
        root.config(menu=menubar)
        root.title(self.app.name)
        
        self.create_text_field()
        self.create_input()

    def create_text_field(self):
        frame = ttk.Frame(self.root)
        frame.pack(expand = True, fill = tk.BOTH)

        text_field = ScrolledText(frame, font=self.app.text_font)
        text_field.place(x=0, y=0, width=self.app.w, height=self.app.h)
        text_field.pack(expand = True, fill = tk.BOTH)
        text_field.configure(fg='gray80', bg='gray20')

        self.app.text_field = text_field

    def create_input(self):
        frame = ttk.Frame(self.root)
        frame.pack(fill = tk.X)

        #style = ttk.Style()
        #style.configure("Dark.TLabel", foreground="gold", background="gray20")

        input_var = tk.StringVar()
        input_text = ttk.Entry(frame,
            textvariable=input_var,
            #style="Dark.TLabel",
            font=self.app.text_font
            )
        input_text.pack(side = tk.LEFT, expand = True, fill = tk.X)

        button1 = ttk.Button(frame,
            text='Enter',
            command=lambda: self.app.eval_cmd(f"{input_var.get()}")
            )
        button1.pack(side = tk.RIGHT)


class App():
    def __init__(self, name="App", w=500, h=500):
        print(f"App::__init__")
        self.name = name
        self.w = w
        self.h = h
        self.I = {}
        self.disp_win = {}
        self.crop_win = {}
        self.switch_nr = 0

    def __del__(self):
        print(f"App::__del__")

    #------------------------------------------------------
    # image command
    #------------------------------------------------------
    def cmd_load(self, nr, fname):
        I = ImagePkg(fname)
        self.I[nr] = I

    def cmd_load_dlg(self, nr):
        fname = filedialog.askopenfilename() 
        self.cmd_load(nr, fname)
        self.cmd_show(nr)

    def cmd_save(self, nr, fname):
        I = self.I[nr]
        I.save(fname)

    def cmd_save_dlg(self, nr):
        fname = filedialog.asksaveasfilename(
            filetypes = [("PNG", ".png"), ("EXR", ".exr"), ("HDR", ".hdr") ],
            defaultextension = "png"
            )
        self.cmd_save(nr, fname)

    def cmd_info(self, nr=1):
        img = self.cmd_get_img(nr)
        h, w, c = cu.cv_size(img)
        min = img.min(axis=(0, 1))
        max = img.max(axis=(0, 1))

        self.cmd_print(f"height    = {h}")
        self.cmd_print(f"width     = {w}")
        self.cmd_print(f"channels  = {c}")
        self.cmd_print(f"img.shape = {img.shape}")
        self.cmd_print(f"img.dtype = {img.dtype}")
        self.cmd_print(f"type(img) = {type(img)}")
        self.cmd_print(f"min       = {min}")
        self.cmd_print(f"max       = {max}")

    def cmd_show(self, nr):
        I = self.I[nr]

        ImageWin(tk.Toplevel(), self, nr, "disp")

        self.cmd_print(f"fname     = {I.fname}")
        self.cmd_info(nr)

    def cmd_show_crop(self, nr, uv):
        I = self.I[nr]
        crop_wh = self.args.crop_size

        I.make_crop_uv_img(uv, crop_wh)

        if nr not in self.crop_win:
            self.crop_win[nr] = ImageWin(tk.Toplevel(), self, nr, "crop", uv)
        else:
            img_tk = cvimg_to_imgtk(I.crop_img)
            self.crop_win[nr].update_canvas(img_tk)
            self.crop_win[nr].update_status(uv)

    def cmd_new(self, nr, shape, dtype, val):
        img = cu.cv_create_img(shape, dtype, val)
        self.cmd_set_img(nr, img, "new")
        self.cmd_show(nr)

    def cmd_channel(self, nr, ch):
        img = self.cmd_get_img(nr)
        oimg = img[:, :, ch]
        self.cmd_set_img(0, oimg, f"channel_{ch}")
        self.cmd_show(0)

    def cmd_mult(self, nr1, val):
        img1 = self.cmd_get_img(nr1)
        oimg = img1 * val
        self.cmd_set_img(0, oimg, "mult")
        self.cmd_show(0)

    def cmd_power(self, nr, val):
        img = self.cmd_get_img(nr)
        oimg = np.power(img, val)
        self.cmd_set_img(0, oimg, "power")
        self.cmd_show(0)

    def cmd_add(self, nr1=1, nr2=2):
        img1 = self.cmd_get_img(nr1)
        img2 = self.cmd_get_img(nr2)
        oimg = img1 + img2
        self.cmd_set_img(0, oimg, "add")
        self.cmd_show(0)

    def cmd_diff(self, nr1=1, nr2=2):
        img1 = self.cmd_get_img(nr1)
        img2 = self.cmd_get_img(nr2)
        oimg = np.abs(img1 - img2)
        self.cmd_set_img(0, oimg, "diff")
        self.cmd_show(0)

    def cmd_switch(self, nr1=1, nr2=2):
        img1 = self.cmd_get_img(nr1)
        img2 = self.cmd_get_img(nr2)
        if self.switch_nr == nr1:
            oimg = img2
            self.switch_nr = nr2
        else:
            oimg = img1
            self.switch_nr = nr1
        self.cmd_set_img(0, oimg, "switch")
        self.cmd_show(0)

    def cmd_range(self, nr, min, max):
        img = self.cmd_get_img(nr)
        oimg = np.clip((img - min) / (max - min), 0.0, 1.0)
        self.cmd_set_img(0, oimg, "range")
        self.cmd_show(0)

    #------------------------------------------------------
    # command
    #------------------------------------------------------
    def cmd_get_img(self, nr):
        return self.I[nr].img

    def cmd_set_img(self, nr, img, name):
        I = ImagePkg()
        I.set_img(img, name)
        self.I[nr] = I

    def cmd_print(self, text):
        self.add_text(f"{text}\n")

    def cmd_clear(self):
        self.text_field.delete('1.0', 'end')

    def cmd_quit(self):
        quit()

    def cmd_help(self):
        self.cmd_print(f"load(nr, fname)            ... load an image to the image nr")
        self.cmd_print(f"load_dlg(nr)               ... load an image by dialog to the image nr")
        self.cmd_print(f"save(nr, fname)            ... save an image to the image nr")
        self.cmd_print(f"save_dlg(nr)               ... save an image by dialog to the image nr")
        self.cmd_print(f"info(nr=1)                 ... info the image nr")
        self.cmd_print(f"show(nr)                   ... show the image nr")
        self.cmd_print(f"show_crop(nr, uv)          ... show the cropped image nr")
        self.cmd_print(f"new(nr, shape, dtype, val) ... create a new image")
        self.cmd_print(f"channel(nr, ch)            ... get a channel")
        self.cmd_print(f"mult(nr, val)              ... multiply val to the image nr")
        self.cmd_print(f"power(nr, val)             ... power")
        self.cmd_print(f"add(nr1=1, nr2=2)          ... add the image nr1 to the image nr2")
        self.cmd_print(f"diff(nr1=1, nr2=2)         ... diff between image nr1 and nr2")
        self.cmd_print(f"switch(nr1=1, nr2=2)       ... switch image nr1 and nr2")
        self.cmd_print(f"range(nr, min, max)        ... range from min to max")
        self.cmd_print(f"print(text)                ... print text")
        self.cmd_print(f"clear()                    ... clear text")
        self.cmd_print(f"quit()                     ... quit this app")
        self.cmd_print(f"help()                     ... print help")

    #------------------------------------------------------
    # parse_args
    #------------------------------------------------------
    def parse_args(self):
        parser = argparse.ArgumentParser(description='show images')
        parser.add_argument('-xy',
                            nargs='+',
                            type=int,
                            default=[0, 0],
                            help='set position [x, y]')
        parser.add_argument('-s', '--size',
                            nargs='+',
                            type=int,
                            default=[500, 500],
                            help='set display size [w, h]')
        parser.add_argument('-cs', '--crop_size',
                            nargs='+',
                            type=int,
                            default=[500, 500],
                            help='set crop size [w, h]')
        parser.add_argument('file',
                            nargs='*',
                            type=str,
                            help='input file')
        self.args = parser.parse_args()

    #------------------------------------------------------
    # private functions
    #------------------------------------------------------
    def add_text(self, text):
        self.text_field.insert('insert', text)

    def eval_cmd(self, text):
        self.cmd_print(f">>> {text}")
        eval(f"self.cmd_{text}")

    #------------------------------------------------------
    # run gui
    #------------------------------------------------------
    def run(self):
        root = tk.Tk()

        self.text_font = font.Font(family="Cica", size=14)
        #print(font.families())

        MainWin(root, self)

        nr = 1
        for fname in self.args.file:
            fname = fname.replace('\\', '/')
            self.eval_cmd(f"load({nr}, '{fname}')")
            self.eval_cmd(f"show({nr})")
            nr += 1

        root.mainloop()


if __name__ == "__main__":
    app = App("image-show-tk.py", 500, 500)
    app.parse_args()
    app.run()

