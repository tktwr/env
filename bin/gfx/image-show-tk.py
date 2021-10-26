#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import cv2
import cv_util as cu
import numpy as np
from ttpy import FileName
from tkinter import *
from tkinter import ttk
from tkinter import filedialog
from tkinter.scrolledtext import ScrolledText


class Image():
    def __init__(self, fname=""):
        print(f"Image::__init__")
        self.disp_max_wh = [500, 500]
        if fname != "":
            self.load(fname)

    def __del__(self):
        print(f"Image::__del__")

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

class App():
    def __init__(self, name="App", w=500, h=500):
        print(f"App::__init__")
        self.name = name
        self.w = w
        self.h = h
        self.I = {}
        self.switch_nr = 0

    def __del__(self):
        print(f"App::__del__")

    def parse_args(self):
        parser = argparse.ArgumentParser(description='show images')
        parser.add_argument('-s', '--size',
                            nargs='+',
                            type=int,
                            default=[500, 500],
                            help='set display size [w, h]')
        parser.add_argument('-p', '--pos',
                            nargs='+',
                            type=int,
                            default=[0, 0],
                            help='set position [x, y]')
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

    def clear_text(self):
        self.text_field.delete('1.0', 'end')

    def add_text(self, text):
        self.text_field.insert('insert', text)

    def add_line(self, text):
        self.add_text(f"{text}\n")

    def eval_cmd(self, text):
        self.add_line(f">>> {text}")
        eval(f"self.{text}")

    #------------------------------------------------------
    # image command
    #------------------------------------------------------
    def img_load(self, nr, fname):
        I = Image(fname)
        self.I[nr] = I

    def img_load_dlg(self, nr):
        fname = filedialog.askopenfilename() 
        self.img_load(nr, fname)
        self.img_show(nr)

    def img_save(self, nr, fname):
        I = self.I[nr]
        I.save(fname)

    def img_save_dlg(self, nr):
        fname = filedialog.asksaveasfilename(
            filetypes = [("PNG", ".png"), ("EXR", ".exr"), ("HDR", ".hdr") ],
            defaultextension = "png"
            )
        self.img_save(nr, fname)

    def img_info(self, nr=1):
        img = self.img_get(nr)
        h, w, c = cu.cv_size(img)
        min = img.min(axis=(0, 1))
        max = img.max(axis=(0, 1))

        self.add_line(f"height    = {h}")
        self.add_line(f"width     = {w}")
        self.add_line(f"channels  = {c}")
        self.add_line(f"img.shape = {img.shape}")
        self.add_line(f"img.dtype = {img.dtype}")
        self.add_line(f"type(img) = {type(img)}")
        self.add_line(f"min       = {min}")
        self.add_line(f"max       = {max}")

    def img_show(self, nr):
        I = self.I[nr]

        cv2.imshow(f"Image {nr}", I.disp_img)

        self.add_line(f"fname     = {I.fname}")
        self.img_info(nr)

    def img_show_crop(self, nr, uv):
        I = self.I[nr]
        crop_xy = I.uv_to_xy(uv)
        crop_wh = self.args.crop_size

        I.make_crop_uv_img(uv, crop_wh)
        val = I.pick_uv(uv)

        cv2.imshow(f"Crop {nr}", I.crop_img)

        self.add_line(f"uv        = {uv}")
        self.add_line(f"crop_xy   = {crop_xy}")
        self.add_line(f"crop_wh   = {crop_wh}")
        self.add_line(f"val       = {val}")

    def img_mult(self, nr1, val):
        img1 = self.img_get(nr1)
        oimg = img1 * val
        self.img_set(0, oimg, "mult")
        self.img_show(0)

    def img_diff(self, nr1=1, nr2=2):
        img1 = self.img_get(nr1)
        img2 = self.img_get(nr2)
        oimg = np.abs(img1 - img2)
        self.img_set(0, oimg, "diff")
        self.img_show(0)

    def img_add(self, nr1=1, nr2=2):
        img1 = self.img_get(nr1)
        img2 = self.img_get(nr2)
        oimg = img1 + img2
        self.img_set(0, oimg, "add")
        self.img_show(0)

    def img_switch(self, nr1=1, nr2=2):
        img1 = self.img_get(nr1)
        img2 = self.img_get(nr2)
        if self.switch_nr == nr1:
            oimg = img2
            self.switch_nr = nr2
        else:
            oimg = img1
            self.switch_nr = nr1
        self.img_set(0, oimg, "switch")
        self.img_show(0)

    def img_range(self, nr, min, max):
        img = self.img_get(nr)
        oimg = np.clip((img - min) / (max - min), 0.0, 1.0)
        self.img_set(0, oimg, "range")
        self.img_show(0)

    def img_power(self, nr, val):
        img = self.img_get(nr)
        oimg = np.power(img, val)
        self.img_set(0, oimg, "power")
        self.img_show(0)

    def img_get(self, nr):
        return self.I[nr].img

    def img_set(self, nr, img, name):
        I = Image()
        I.set_img(img, name)
        self.I[nr] = I

    def quit(self):
        quit()

    def help(self):
        self.add_line(f"img_load(nr, fname)      ... load an image to the image nr")
        self.add_line(f"img_load_dlg(nr)         ... load an image by dialog to the image nr")
        self.add_line(f"img_save(nr, fname)      ... save an image to the image nr")
        self.add_line(f"img_save_dlg(nr)         ... save an image by dialog to the image nr")
        self.add_line(f"img_info(nr=1)           ... info the image nr")
        self.add_line(f"img_show(nr)             ... show the image nr")
        self.add_line(f"img_show_crop(nr, uv)    ... show the cropped image nr")
        self.add_line(f"img_mult(nr, val)        ... multiply val to the image nr")
        self.add_line(f"img_diff(nr1=1, nr2=2)   ... diff between image nr1 and nr2")
        self.add_line(f"img_add(nr1=1, nr2=2)    ... add the image nr1 to the image nr2")
        self.add_line(f"img_switch(nr1=1, nr2=2) ... switch image nr1 and nr2")
        self.add_line(f"img_range(nr, min, max)  ... range from min to max")
        self.add_line(f"img_power(nr, val)       ... power")
        self.add_line(f"quit()                   ... quit this app")
        self.add_line(f"help()                   ... print help")

    #------------------------------------------------------
    # run gui
    #------------------------------------------------------
    def run(self):
        root = Tk()

        menubar = Menu(root)

        # File Menu
        filemenu = Menu(menubar, tearoff=0)
        filemenu.add_command(label='Open Image 1',
                command=lambda: self.eval_cmd(f"img_load_dlg(1)"))
        filemenu.add_command(label='Open Image 2',
                command=lambda: self.eval_cmd(f"img_load_dlg(2)"))
        filemenu.add_command(label='Save Image 0',
                command=lambda: self.eval_cmd(f"img_save_dlg(0)"))
        filemenu.add_command(label='Clear Text',
                command=lambda: self.eval_cmd(f"clear_text()"))
        filemenu.add_separator()
        filemenu.add_command(label='Exit',
                command=lambda: self.eval_cmd(f"quit()"))

        # Help
        helpmenu = Menu(menubar, tearoff=0)
        helpmenu.add_command(label='Help',
                command=lambda: self.eval_cmd(f"help()"))
        
        # Add
        menubar.add_cascade(label='File', menu=filemenu)
        menubar.add_cascade(label='Help', menu=helpmenu)
        
        root.config(menu=menubar)

        root.title(self.name)
        root.minsize(self.w, self.h)
        root.rowconfigure(0, weight=1)
        root.columnconfigure(0, weight=1)
        root.grid()
        
        frame1 = ttk.Frame(root)
        frame1.rowconfigure(0, weight=1)
        frame1.columnconfigure(0,weight=1)
        frame1.grid(sticky=(E, W, S, N))

        text_field = ScrolledText(frame1)
        text_field.place(x=0, y=0, width=self.w, height=self.h)
        text_field.grid(row=0, column=0, sticky=(E, W, S, N))

        self.text_field = text_field

        frame2 = ttk.Frame(root)
        frame2.rowconfigure(0, weight=1)
        frame2.columnconfigure(0,weight=1)
        frame2.grid(sticky=(E, W, S, N))

        input_var = StringVar()
        input_text = ttk.Entry(
            frame2,
            textvariable=input_var,
            width=20)
        input_text.grid(row=0, column=0, sticky=(E, W, S, N))

        button1 = ttk.Button(
            frame2, text='Enter',
            command=lambda: self.eval_cmd(f"{input_var.get()}")
            )
        button1.grid(row=0, column=1, sticky=(E, W, S, N))

        nr = 1
        for fname in self.args.file:
            self.eval_cmd(f"img_load({nr}, '{fname}')")
            self.eval_cmd(f"img_show({nr})")
            nr += 1

        root.mainloop()


if __name__ == "__main__":
    app = App("image-show-tk.py", 500, 500)
    app.parse_args()
    app.run()

