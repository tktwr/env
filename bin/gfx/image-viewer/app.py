import numpy as np
import cv_util as cu
import tkinter as tk
from tkinter import font
from tkinter import filedialog
import img_pkg
import img_win
import main_win


#======================================================
# App
#======================================================
class App():
    def __init__(self, args, name="App", w=500, h=500):
        print(f"App::__init__")
        self.args = args
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
        I = img_pkg.ImagePkg()
        I.set_img(img, name)
        self.I[nr] = I

    #------------------------------------------------------
    # image io command
    #------------------------------------------------------
    def cmd_load(self, nr, fname):
        I = img_pkg.ImagePkg(fname)
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
                win_dict[nr] = img_win.ImageWin(tk.Toplevel(), self, nr, win_type, uv)
            elif win_type == "crop":
                geom = f'500x500+1000+0'
                win_dict[nr] = img_win.CropWin(tk.Toplevel(), self, nr, win_type, uv, geom)
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

        self.main_win = main_win.MainWin(root, self)

        nr = 1
        for fname in self.args.files:
            fname = fname.replace('\\', '/')
            self.eval_cmd(f"load({nr}, '{fname}')")
            self.eval_cmd(f"show({nr})")
            nr += 1

        root.mainloop()


