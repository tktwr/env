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

        self.I = app.I[nr]

        if type == "disp":
            self.img = self.I.disp_img
        elif type == "crop":
            self.img = self.I.crop_img
        title = f"Image {nr}: {type}"

        self.root = root
        self.app = app
        self.nr = nr
        self.type = type

        self.root.geometry("500x500")
        self.root.title(title)
        self.set_img(self.img)

        orig_h, orig_w = self.I.img.shape[:2]
        val = self.I.pick_uv(uv)

        self.status_text = tk.StringVar()
        self.status_text.set(f"wh=[{orig_w} {orig_h}] uv={uv} bgr={val}")

        label = ttk.Label(root,
            textvariable=self.status_text,
            relief='sunken',
            font=self.app.text_font
            )
        label.pack(fill = tk.X)

        h, w = self.img.shape[:2]
        win_h = h + 30
        win_w = w
        self.root.geometry(f"{win_w}x{win_h}")

    def set_img(self, img):
        if img.dtype == np.float32:
            img = np.clip(img * 255, 0, 255).astype(np.uint8)

        img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        img_pil = Image.fromarray(img_rgb)
        self.img_tk  = ImageTk.PhotoImage(img_pil)

        h, w = img.shape[:2]
        self.canvas = tk.Canvas(self.root, width=w, height=h)
        self.canvas.bind('<Button-1>', self.mouse_canvas)
        self.canvas.create_image(0, 0, image=self.img_tk, anchor='nw')
        self.canvas.pack()

    def mouse_canvas(self, event):
        # original image size
        H, W = self.I.img.shape[:2]
        # window image size
        h, w = self.img.shape[:2]
        # xy in window
        xy = (event.x, event.y)
        x, y = xy
        # uv in window
        uv = (x/(w-1), y/(h-1))
        u, v = uv
        # XY in original image
        XY = (int(u * (W-1)), int(v * (H-1)))

        val = self.I.pick_uv(uv)

        uv_str = f"({u:.2f}, {v:.2f})"
        text = f"xy={xy}, uv={uv_str}, XY={XY}, bgr={val}"
        self.status_text.set(text)

        self.app.cmd_show_crop(self.nr, uv)


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
                command=lambda: self.app.eval_cmd(f"cmd_load_dlg(1)"))
        filemenu.add_command(label='Open Image 2',
                command=lambda: self.app.eval_cmd(f"cmd_load_dlg(2)"))
        filemenu.add_command(label='Save Image 0',
                command=lambda: self.app.eval_cmd(f"cmd_save_dlg(0)"))
        filemenu.add_command(label='Clear Text',
                command=lambda: self.app.eval_cmd(f"clear_text()"))
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
        img = self.cmd_get(nr)
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

    def cmd_show(self, nr):
        I = self.I[nr]

        #cv2.imshow(f"Image {nr}", I.disp_img)
        ImageWin(tk.Toplevel(), self, nr, "disp")

        self.add_line(f"fname     = {I.fname}")
        self.cmd_info(nr)

    def cmd_show_crop(self, nr, uv):
        I = self.I[nr]
        crop_xy = I.uv_to_xy(uv)
        crop_wh = self.args.crop_size

        I.make_crop_uv_img(uv, crop_wh)
        val = I.pick_uv(uv)

        #cv2.imshow(f"Crop {nr}", I.crop_img)
        ImageWin(tk.Toplevel(), self, nr, "crop", uv)

        self.add_line(f"uv        = {uv}")
        self.add_line(f"crop_xy   = {crop_xy}")
        self.add_line(f"crop_wh   = {crop_wh}")
        self.add_line(f"val       = {val}")

    def cmd_new(self, nr, shape, dtype, val):
        img = cu.cv_create_img(shape, dtype, val)
        self.cmd_set(nr, img, "new")
        self.cmd_show(nr)

    def cmd_channel(self, nr, ch):
        img = self.cmd_get(nr)
        oimg = img[:, :, ch]
        self.cmd_set(0, oimg, f"channel_{ch}")
        self.cmd_show(0)

    def cmd_mult(self, nr1, val):
        img1 = self.cmd_get(nr1)
        oimg = img1 * val
        self.cmd_set(0, oimg, "mult")
        self.cmd_show(0)

    def cmd_power(self, nr, val):
        img = self.cmd_get(nr)
        oimg = np.power(img, val)
        self.cmd_set(0, oimg, "power")
        self.cmd_show(0)

    def cmd_add(self, nr1=1, nr2=2):
        img1 = self.cmd_get(nr1)
        img2 = self.cmd_get(nr2)
        oimg = img1 + img2
        self.cmd_set(0, oimg, "add")
        self.cmd_show(0)

    def cmd_diff(self, nr1=1, nr2=2):
        img1 = self.cmd_get(nr1)
        img2 = self.cmd_get(nr2)
        oimg = np.abs(img1 - img2)
        self.cmd_set(0, oimg, "diff")
        self.cmd_show(0)

    def cmd_switch(self, nr1=1, nr2=2):
        img1 = self.cmd_get(nr1)
        img2 = self.cmd_get(nr2)
        if self.switch_nr == nr1:
            oimg = img2
            self.switch_nr = nr2
        else:
            oimg = img1
            self.switch_nr = nr1
        self.cmd_set(0, oimg, "switch")
        self.cmd_show(0)

    def cmd_range(self, nr, min, max):
        img = self.cmd_get(nr)
        oimg = np.clip((img - min) / (max - min), 0.0, 1.0)
        self.cmd_set(0, oimg, "range")
        self.cmd_show(0)

    def cmd_get(self, nr):
        return self.I[nr].img

    def cmd_set(self, nr, img, name):
        I = ImagePkg()
        I.set_img(img, name)
        self.I[nr] = I

    def quit(self):
        quit()

    def help(self):
        self.add_line(f"cmd_load(nr, fname)            ... load an image to the image nr")
        self.add_line(f"cmd_load_dlg(nr)               ... load an image by dialog to the image nr")
        self.add_line(f"cmd_save(nr, fname)            ... save an image to the image nr")
        self.add_line(f"cmd_save_dlg(nr)               ... save an image by dialog to the image nr")
        self.add_line(f"cmd_info(nr=1)                 ... info the image nr")
        self.add_line(f"cmd_show(nr)                   ... show the image nr")
        self.add_line(f"cmd_show_crop(nr, uv)          ... show the cropped image nr")
        self.add_line(f"cmd_new(nr, shape, dtype, val) ... create a new image")
        self.add_line(f"cmd_channel(nr, ch)            ... get a channel")
        self.add_line(f"cmd_mult(nr, val)              ... multiply val to the image nr")
        self.add_line(f"cmd_power(nr, val)             ... power")
        self.add_line(f"cmd_add(nr1=1, nr2=2)          ... add the image nr1 to the image nr2")
        self.add_line(f"cmd_diff(nr1=1, nr2=2)         ... diff between image nr1 and nr2")
        self.add_line(f"cmd_switch(nr1=1, nr2=2)       ... switch image nr1 and nr2")
        self.add_line(f"cmd_range(nr, min, max)        ... range from min to max")
        self.add_line(f"quit()                         ... quit this app")
        self.add_line(f"help()                         ... print help")

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
            self.eval_cmd(f"cmd_load({nr}, '{fname}')")
            self.eval_cmd(f"cmd_show({nr})")
            nr += 1

        root.mainloop()


if __name__ == "__main__":
    app = App("image-show-tk.py", 500, 500)
    app.parse_args()
    app.run()

