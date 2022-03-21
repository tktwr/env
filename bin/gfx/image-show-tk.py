#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
os.environ['OPENCV_IO_ENABLE_OPENEXR'] = '1'
import cv2
import argparse
import tt_util as tu
import cv_util as cu
import numpy as np
import tkinter as tk
from tkinter import ttk
from tkinter import font
from tkinter import filedialog
from tkinter.scrolledtext import ScrolledText
from PIL import Image, ImageTk


def cvimg_to_imgtk(img):
    img = cu.cv_cvt_dtype(img, 'uint8')
    img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    img_pil = Image.fromarray(img_rgb)
    img_tk  = ImageTk.PhotoImage(img_pil)
    return img_tk


#======================================================
# ImagePkg
#======================================================
class ImagePkg():
    def __init__(self, fname=""):
        print(f"ImagePkg::__init__")
        if fname != "":
            self.load(fname)
        else:
            w, h = (500, 500)
            img = cu.cv_create_img((h, w, 3), 'uint8', (0, 0, 0))
            self.set_img(img, fname)
            self.make_disp_img((w, h))

    def __del__(self):
        print(f"ImagePkg::__del__")

    def set_img(self, img, fname):
        h, w = img.shape[:2]
        fn = tu.FileName(fname)
        self.dirname = fn.dirname()
        self.fname = fn.filename()
        self.wh = (w, h)
        self.img = img
        self.disp_img = None
        self.crop_img = None

    def get_img(self, win_type):
        if win_type == "disp":
            return self.disp_img
        elif win_type == "crop":
            return self.crop_img

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

    def make_disp_img(self, max_wh):
        self.disp_img = cu.cv_fit_img(self.img, max_wh)
        return self.disp_img

    def make_crop_xy_img(self, xy, wh):
        center = (wh[0]//2, wh[1]//2)
        p1 = (center[0] - 5, center[1] - 5)
        p2 = (center[0] + 5, center[1] + 5)
        color = (0, 0, 255)

        oimg = cu.cv_crop_center_img(self.img, xy, wh)
        oimg = cv2.rectangle(oimg, p1, p2, color, 1)
        self.crop_img = oimg
        return self.crop_img

    def make_crop_uv_img(self, uv, wh):
        xy = self.uv_to_xy(uv)
        return self.make_crop_xy_img(xy, wh)


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
        self.win_type = win_type

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
            self.app.cmd_close_crop(self.nr)
        else:
            xy = (event.x, event.y)
            uv = self.xy_to_uv(xy)
            self.update_status(uv)
            self.app.cmd_show_crop(self.nr, uv)

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
    def __init__(self, parent, app, nr, win_type, uv=(0.5, 0.5)):
        super().__init__(parent, app, nr, win_type, uv)

        self.create_canvas(self.win_img)
        self.resize(self.win_img)
        self.update_status(uv)


#======================================================
# ImageWin
#======================================================
class ImageWin(ImageWinBase):
    def __init__(self, parent, app, nr, win_type, uv=(0.5, 0.5), geom=''):
        super().__init__(parent, app, nr, win_type, uv)

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
                command=lambda: self.app.eval_cmd(f"load_dlg({self.nr})"))
        file_menu.add_command(label='Save Image',
                command=lambda: self.app.eval_cmd(f"save_dlg({self.nr})"))

        menubar.add_cascade(label='File', menu=file_menu)

        self.parent.config(menu=menubar)


#======================================================
# CropWin
#======================================================
class CropWin(ImageWinBase):
    def __init__(self, parent, app, nr, win_type, uv=(0.5, 0.5), geom=''):
        super().__init__(parent, app, nr, win_type, uv)

        self.create_canvas(self.win_img)
        self.resize(self.win_img)
        if geom != '':
            self.parent.geometry(geom)


#======================================================
# MainWin
#======================================================
class MainWin(tk.Frame):
    def __init__(self, parent, app):
        print(f"MainWin::__init__")
        super().__init__(parent)
        self.pack()

        self.parent = parent
        self.app = app
        self.status_text = None

        self.create_menu()
        #self.create_combobox()
        self.create_image_field(1, 'disp')
        self.create_image_list()
        self.create_text_field()
        self.create_input()
        self.create_status()

        self.parent.title(self.app.name)

    def __del__(self):
        print(f"MainWin::__del__")

    #------------------------------------------------------
    # create widget
    #------------------------------------------------------
    def create_menu(self):
        menubar = tk.Menu(self.parent)

        # File Menu
        file_menu = tk.Menu(menubar, tearoff=0)
        file_menu.add_command(label='Open Image 1',
                command=lambda: self.app.eval_cmd(f"load_dlg(1)"))
        file_menu.add_command(label='Open Image 2',
                command=lambda: self.app.eval_cmd(f"load_dlg(2)"))
        file_menu.add_command(label='Save Image 0',
                command=lambda: self.app.eval_cmd(f"save_dlg(0)"))
        file_menu.add_command(label='Info All Images',
                command=lambda: self.app.eval_cmd(f"info_all()"))
        file_menu.add_command(label='Close All Images',
                command=lambda: self.app.eval_cmd(f"close_all()"))
        file_menu.add_separator()
        file_menu.add_command(label='Exit',
                command=self.menu_quit,
                accelerator="Ctrl+q")

        # Edit Menu
        edit_menu = tk.Menu(menubar, tearoff=0)
        edit_menu.add_command(label='Linear to sRGB',
                command=lambda: self.app.eval_cmd(f"power(1, 1/2.2)"))
        edit_menu.add_command(label='sRGB to Linear',
                command=lambda: self.app.eval_cmd(f"power(1, 2.2)"))

        # Help Menu
        help_menu = tk.Menu(menubar, tearoff=0)
        help_menu.add_command(label='Help',
                command=lambda: self.app.eval_cmd(f"help()"))
        help_menu.add_command(label='Clear Text',
                command=lambda: self.app.eval_cmd(f"clear()"))

        menubar.add_cascade(label='File', menu=file_menu)
        menubar.add_cascade(label='Edit', menu=edit_menu)
        menubar.add_cascade(label='Help', menu=help_menu)

        self.parent.config(menu=menubar)
        self.bind_all("<Control-q>", self.menu_quit)

    def create_combobox(self):
        img_list = ['Easy', 'Normal', 'Hard']
        img_list_combobox = ttk.Combobox(self.parent,
            values=img_list,
            )
        img_list_combobox.pack(expand=True, fill=tk.X)

    def create_image_field(self, nr, win_type, uv=(0.5, 0.5)):
        self.app.I[nr] = ImagePkg()
        win = ImageFrame(self.parent,
            self.app, nr, win_type, uv)
        win.pack()
        self.app.disp_win[nr] = win

    def create_image_list(self):
        frame = ttk.Frame(self.parent)
        frame.pack(expand=True, fill=tk.X)

        var = tk.StringVar()
        listbox = tk.Listbox(frame,
            height=4,
            font=self.app.text_font,
            listvariable=var)

        scrollbar = ttk.Scrollbar(frame,
            orient='vertical',
            command=listbox.yview)
        listbox['yscrollcommand'] = scrollbar.set

        listbox.configure(fg='gray80', bg='gray20')
        listbox.pack(side='left', fill=tk.X, expand=True)
        scrollbar.pack(side='right', fill='both')
        self.listbox = listbox

    def create_text_field(self):
        frame = ttk.Frame(self.parent)
        frame.pack(expand=True, fill=tk.BOTH)

        w, h = (80, 10)
        text_field = ScrolledText(frame,
            font=self.app.text_font,
            width=w, height=h)
        #text_field.place(x=0, y=0, width=self.app.w, height=self.app.h)
        text_field.configure(fg='gray80', bg='gray20')
        text_field.pack(expand=True, fill=tk.BOTH)
        self.text_field = text_field

    def create_input(self):
        frame = ttk.Frame(self.parent)
        frame.pack(fill=tk.X)

        #style = ttk.Style()
        #style.configure("Dark.TLabel", foreground="gold", background="gray20")

        input_var = tk.StringVar()
        input_text = ttk.Entry(frame,
            textvariable=input_var,
            #style="Dark.TLabel",
            font=self.app.text_font
            )
        input_text.pack(side=tk.LEFT, expand=True, fill=tk.X)
        input_text.bind('<Return>', self.key_enter)

        btn_enter = ttk.Button(frame,
            text='Enter',
            command=self.key_enter
            )
        btn_enter.pack(side = tk.RIGHT)
        self.input_var = input_var

    def create_status(self):
        #frame = ttk.Frame(self.parent)
        #frame.pack(expand=True, fill=tk.X)

        self.status_text = tk.StringVar()
        label = ttk.Label(self.parent,
            textvariable=self.status_text,
            relief='sunken',
            #relief='groove',
            font=self.app.text_font
            )
        label.pack(expand=True, fill=tk.X)

    #------------------------------------------------------
    # operate widget
    #------------------------------------------------------
    def menu_quit(self, event=None):
        self.app.eval_cmd(f"quit()")

    def add_text_to_image_list(self, text):
        self.listbox.insert('end', text)

    def add_text(self, text):
        self.text_field.insert('insert', text)
        self.text_field.see('end')

    def clear_text(self):
        self.text_field.delete('1.0', 'end')

    def key_enter(self, event=None):
        self.app.eval_cmd(f"{self.input_var.get()}")
        #self.app.cmd_print(f"{event.keysym}")


#======================================================
# App
#======================================================
class App():
    def __init__(self, name="App", w=500, h=500):
        print(f"App::__init__")
        self.name = name
        self.w = w
        self.h = h
        self.I = {}
        self.main_win = None
        self.disp_win = {}
        self.crop_win = {}
        self.switch_nr = 0

    def __del__(self):
        print(f"App::__del__")

    #------------------------------------------------------
    # get/set image command
    #------------------------------------------------------
    def cmd_get_img(self, nr):
        return self.I[nr].img

    def cmd_set_img(self, nr, img, name):
        I = ImagePkg()
        I.set_img(img, name)
        self.I[nr] = I

    #------------------------------------------------------
    # image io command
    #------------------------------------------------------
    def cmd_load(self, nr, fname):
        I = ImagePkg(fname)
        self.I[nr] = I
        text = f'{nr} {I.fname} {I.img.shape} {I.img.dtype}'
        self.main_win.add_text_to_image_list(text)

    def cmd_save(self, nr, fname):
        I = self.I[nr]
        I.save(fname)

    def cmd_load_dlg(self, nr):
        fname = filedialog.askopenfilename() 
        if fname != "":
            self.cmd_load(nr, fname)
            self.cmd_close_crop(nr)
            self.cmd_close_disp(nr)
            self.cmd_show(nr)

    def cmd_save_dlg(self, nr):
        fname = filedialog.asksaveasfilename(
            filetypes = [("PNG", ".png"), ("JPG", ".jpg"), ("EXR", ".exr"), ("HDR", ".hdr") ],
            defaultextension = "png"
            )
        self.cmd_save(nr, fname)

    #------------------------------------------------------
    # window command
    #------------------------------------------------------
    def create_or_update(self, win_dict, nr, win_type, uv=(0.5, 0.5)):
        if nr not in win_dict:
            if win_type == "disp":
                win_dict[nr] = ImageWin(tk.Toplevel(), self, nr, win_type, uv)
            elif win_type == "crop":
                geom = f'500x500+1000+0'
                win_dict[nr] = CropWin(tk.Toplevel(), self, nr, win_type, uv, geom)
        else:
            I = self.I[nr]
            img = I.get_img(win_type)
            win_dict[nr].update_canvas(img)
            win_dict[nr].update_status(uv)

    def cmd_show(self, nr):
        I = self.I[nr]
        disp_wh = self.args.size

        I.make_disp_img(disp_wh)
        self.create_or_update(self.disp_win, nr, "disp")

        self.cmd_info(nr)

    def cmd_show_crop(self, nr, uv):
        I = self.I[nr]
        crop_wh = self.args.crop_size

        I.make_crop_uv_img(uv, crop_wh)
        self.create_or_update(self.crop_win, nr, "crop", uv)

    def cmd_close_all(self):
        keys = list(self.I.keys())
        for i in keys:
            self.cmd_close(i)
    
    def cmd_close(self, nr):
        self.I.pop(nr, None)
        self.cmd_close_disp(nr)
        self.cmd_close_crop(nr)

    def cmd_close_disp(self, nr):
        return
        win = self.disp_win.pop(nr, None)
        if win != None:
            win.parent.destroy()

    def cmd_close_crop(self, nr):
        win = self.crop_win.pop(nr, None)
        if win != None:
            win.parent.destroy()

    def cmd_info_all(self):
        for nr in self.I:
            I = self.I[nr]
            self.cmd_print(f"{nr} {I.fname} {I.img.shape} {I.img.dtype}")

    def cmd_info(self, nr=1):
        I = self.I[nr]
        img = self.cmd_get_img(nr)
        min = img.min(axis=(0, 1))
        max = img.max(axis=(0, 1))

        self.cmd_print(f"dirname   = {I.dirname}")
        self.cmd_print(f"fname     = {I.fname}")
        self.cmd_print(f"img.shape = {img.shape}")
        self.cmd_print(f"img.dtype = {img.dtype}")
        self.cmd_print(f"min       = {min}")
        self.cmd_print(f"max       = {max}")

    #------------------------------------------------------
    # image operation command
    #------------------------------------------------------
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

    def cmd_brightness_contrast(self, nr, brightness, contrast):
        img = self.cmd_get_img(nr)
        oimg = cu.cv_brightness_contrast_img(img, brightness, contrast)
        self.cmd_set_img(0, oimg, "brightness_contrast")
        self.cmd_show(0)

    #------------------------------------------------------
    # command
    #------------------------------------------------------
    def cmd_print(self, text):
        self.main_win.add_text(f"{text}\n")

    def cmd_clear(self):
        self.main_win.clear_text()

    def cmd_quit(self):
        quit()

    def cmd_help(self):
        self.cmd_print(f"load(nr, fname)                               ... load an image to the image nr")
        self.cmd_print(f"save(nr, fname)                               ... save an image to the image nr")
        self.cmd_print(f"load_dlg(nr)                                  ... load an image by dialog to the image nr")
        self.cmd_print(f"save_dlg(nr)                                  ... save an image by dialog to the image nr")
        self.cmd_print(f"show(nr)                                      ... show the image nr")
        self.cmd_print(f"show_crop(nr, uv)                             ... show the cropped image nr")
        self.cmd_print(f"close_all()                                   ... close all images")
        self.cmd_print(f"close(nr)                                     ... close the image nr")
        self.cmd_print(f"info_all()                                    ... info all images")
        self.cmd_print(f"info(nr=1)                                    ... info the image nr")
        self.cmd_print(f"new(nr, shape, dtype, val)                    ... create a new image")
        self.cmd_print(f"channel(nr, ch)                               ... get a channel")
        self.cmd_print(f"mult(nr, val)                                 ... multiply val to the image nr")
        self.cmd_print(f"power(nr, val)                                ... power")
        self.cmd_print(f"add(nr1=1, nr2=2)                             ... add the image nr1 to the image nr2")
        self.cmd_print(f"diff(nr1=1, nr2=2)                            ... diff between image nr1 and nr2")
        self.cmd_print(f"switch(nr1=1, nr2=2)                          ... switch image nr1 and nr2")
        self.cmd_print(f"range(nr, min, max)                           ... range from min to max")
        self.cmd_print(f"brightness_contrast(nr, brightness, contrast) ... set brightness and contrast")
        self.cmd_print(f"print(text)                                   ... print text")
        self.cmd_print(f"clear()                                       ... clear text")
        self.cmd_print(f"quit()                                        ... quit this app")
        self.cmd_print(f"help()                                        ... print help")

    #------------------------------------------------------
    # parse_args
    #------------------------------------------------------
    def parse_args(self):
        parser = argparse.ArgumentParser(
            formatter_class=tu.MyHelpFormatter,
            description='show images')

        parser.add_argument('-xy',
                            type=int,
                            nargs=2,
                            default=[0, 0],
                            help='set position [x, y]')
        parser.add_argument('-s', '--size',
                            type=int,
                            nargs=2,
                            default=[500, 500],
                            help='set display size [w, h]')
        parser.add_argument('-cs', '--crop_size',
                            type=int,
                            nargs=2,
                            default=[500, 500],
                            help='set crop size [w, h]')
        parser.add_argument('files',
                            type=str,
                            nargs='*',
                            help='input files')

        self.args = parser.parse_args()

    #------------------------------------------------------
    # private functions
    #------------------------------------------------------
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

        self.main_win = MainWin(root, self)

        nr = 1
        for fname in self.args.files:
            fname = fname.replace('\\', '/')
            self.eval_cmd(f"load({nr}, '{fname}')")
            self.eval_cmd(f"show({nr})")
            nr += 1

        root.mainloop()


if __name__ == "__main__":
    app = App("image-show-tk.py", 500, 500)
    app.parse_args()
    app.run()

