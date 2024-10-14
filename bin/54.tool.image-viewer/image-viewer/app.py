import numpy as np
import cv_util as cu
import tkinter as tk
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
        self.active_nr = 0

    def __del__(self):
        print(f"App::__del__")

    #------------------------------------------------------
    # private
    #------------------------------------------------------
    def get_active_nr(self, nr=-1):
        if nr != -1:
            self.active_nr = nr

        if self.main_win != None:
            self.main_win.img_listbox_activate(self.active_nr)

        return self.active_nr

    def get_last_nr(self):
        if len(self.I) == 0:
            return 0
        else:
            return max(self.I.keys())

    def get_I(self, nr=-1):
        nr = self.get_active_nr(nr)
        return self.I[nr]

    def set_I(self, I, nr=-1):
        nr = self.get_active_nr(nr)
        self.I[nr] = I
        if self.main_win != None:
            text = f'{nr} {I.fname} {I.img.shape} {I.img.dtype}'
            self.main_win.img_listbox_add(text)
            self.main_win.img_listbox_activate(self.active_nr)

    def append_I(self, I):
        nr = self.get_last_nr() + 1
        self.set_I(I, nr)

    def delete_I(self, nr=-1):
        nr = self.get_active_nr(nr)
        self.I.pop(nr, None)

    #------------------------------------------------------
    # window
    #------------------------------------------------------
    def create_win(self, win_dict, nr, win_type, uv=(0.5, 0.5)):
        if win_type == "disp":
            win_dict[nr] = img_win.ImageWin(tk.Toplevel(), self, nr, uv)
        elif win_type == "crop":
            geom = f'500x500+1000+0'
            win_dict[nr] = img_win.CropWin(tk.Toplevel(), self, nr, uv, geom)

    def update_win(self, win_dict, nr, win_type, uv=(0.5, 0.5)):
        I = self.get_I(nr)
        img = I.get_img(win_type)
        win = win_dict.get(nr, None)
        if win == None:
            self.create_win(win_dict, nr, win_type, uv)
        else:
            win.update_canvas(img)
            win.update_status(uv)

    def update_frame(self, nr, uv=(0.5, 0.5)):
        I = self.get_I(nr)
        img = I.get_img('disp')
        field = self.main_win.image_field
        field.update_canvas(img)
        field.update_status(uv)

    #------------------------------------------------------
    # get/set image command
    #------------------------------------------------------
    def cmd_get_img(self, nr):
        I = self.get_I(nr)
        return I.img

    def cmd_set_img(self, nr, img, name):
        I = img_pkg.ImagePkg()
        I.set_img(img, name)
        self.set_I(I, nr)

    def append_img(self, img, name):
        nr = self.get_last_nr() + 1
        self.cmd_set_img(nr, img, name)

    #------------------------------------------------------
    # image io command
    #------------------------------------------------------
    def cmd_load(self, fname, nr=-1):
        I = img_pkg.ImagePkg(fname)
        self.set_I(I, nr)

    def cmd_save(self, fname, nr=-1):
        I = self.get_I(nr)
        I.save(fname)

    def cmd_load_dlg(self, nr=-1):
        fname = filedialog.askopenfilename() 
        if fname != "":
            nr = self.get_last_nr() + 1
            self.cmd_load(fname, nr)
            self.cmd_close_crop(nr)
            self.cmd_close_disp(nr)

    def cmd_save_dlg(self, nr=-1):
        fname = filedialog.asksaveasfilename(
            filetypes = [("PNG", ".png"), ("JPG", ".jpg"), ("EXR", ".exr"), ("HDR", ".hdr") ],
            defaultextension = "png"
            )
        self.cmd_save(fname, nr)

    #------------------------------------------------------
    # window command
    #------------------------------------------------------
    def cmd_show(self, nr=-1):
        I = self.get_I(nr)
        I.make_disp_img(self.args.size)
        self.update_frame(nr)

    def cmd_show_crop(self, uv, nr=-1):
        I = self.get_I(nr)
        I.make_crop_uv_img(uv, self.args.crop_size)
        self.update_win(self.crop_win, self.active_nr, "crop", uv)

    def cmd_close_all(self):
        keys = list(self.I.keys())
        for i in keys:
            self.cmd_close(i)
    
    def cmd_close(self, nr):
        self.I.pop(nr, None)
        self.cmd_close_disp(nr)
        self.cmd_close_crop(nr)

    def cmd_close_disp(self, nr):
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

    def cmd_info(self, nr=-1):
        I = self.get_I(nr)
        img = I.img
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
    def cmd_new(self, shape, dtype, val):
        img = cu.img_create(shape, dtype, val)
        self.append_img(img, "new")

    def cmd_channel(self, ch, nr=-1):
        I = self.get_I(nr)
        oimg = I.img[:, :, ch]
        self.append_img(oimg, f"channel_{ch}_{I.fname}")

    def cmd_mult(self, val, nr=-1):
        I = self.get_I(nr)
        oimg = I.img * val
        self.append_img(oimg, f'mult_{I.fname}')

    def cmd_power(self, val, nr=-1):
        I = self.get_I(nr)
        oimg = np.power(I.img, val)
        self.append_img(oimg, f'power_{I.fname}')

    def cmd_add(self, nr1, nr2):
        img1 = self.cmd_get_img(nr1)
        img2 = self.cmd_get_img(nr2)
        oimg = img1 + img2
        self.append_img(oimg, "add")

    def cmd_diff(self, nr1, nr2):
        img1 = self.cmd_get_img(nr1)
        img2 = self.cmd_get_img(nr2)
        oimg = np.abs(img1 - img2)
        self.append_img(oimg, "diff")

    def cmd_range(self, min, max, nr=-1):
        I = self.get_I(nr)
        oimg = np.clip((I.img - min) / (max - min), 0.0, 1.0)
        self.append_img(oimg, f'range_{I.fname}')

    def cmd_brightness_contrast(self, brightness, contrast, nr=-1):
        I = self.get_I(nr)
        oimg = cu.img_brightness_contrast(I.img, brightness, contrast)
        self.append_img(oimg, f'brightness_contrast_{I.fname}')

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
        self.cmd_print(f"load(fname, nr)               ... load an image to the image nr")
        self.cmd_print(f"save(fname, nr)               ... save an image to the image nr")
        self.cmd_print(f"load_dlg(nr)                  ... load an image by dialog to the image nr")
        self.cmd_print(f"save_dlg(nr)                  ... save an image by dialog to the image nr")
        self.cmd_print(f"---                           ... ---")
        self.cmd_print(f"show(nr)                      ... show the image nr")
        self.cmd_print(f"show_crop(nr, uv)             ... show the cropped image nr")
        self.cmd_print(f"close_all()                   ... close all images")
        self.cmd_print(f"close(nr)                     ... close the image nr")
        self.cmd_print(f"info_all()                    ... info all images")
        self.cmd_print(f"info(nr)                      ... info the image nr")
        self.cmd_print(f"---                           ... ---")
        self.cmd_print(f"new(shape, dtype, val)        ... create a new image")
        self.cmd_print(f"channel(ch, nr)               ... get a channel")
        self.cmd_print(f"mult(val, nr)                 ... multiply val to the image nr")
        self.cmd_print(f"power(val, nr)                ... power")
        self.cmd_print(f"add(nr1, nr2)                 ... add the image nr1 to the image nr2")
        self.cmd_print(f"diff(nr1, nr2)                ... diff between image nr1 and nr2")
        self.cmd_print(f"range(min, max, nr)           ... range from min to max")
        self.cmd_print(f"brightness_contrast(b, c, nr) ... set brightness and contrast")
        self.cmd_print(f"---                           ... ---")
        self.cmd_print(f"print(text)                   ... print text")
        self.cmd_print(f"clear()                       ... clear text")
        self.cmd_print(f"quit()                        ... quit this app")
        self.cmd_print(f"help()                        ... print help")

    #------------------------------------------------------
    # private functions
    #------------------------------------------------------
    def eval_cmd(self, text, show=False):
        self.cmd_print(f">>> {text}")
        eval(f"self.cmd_{text}")
        if show:
            eval(f"self.cmd_show()")

    #------------------------------------------------------
    # run gui
    #------------------------------------------------------
    def run(self):
        root = tk.Tk()

        self.main_win = main_win.MainWin(root, self)

        nr = 0
        for fname in self.args.files:
            fname = fname.replace('\\', '/')
            self.eval_cmd(f"load('{fname}', {nr})")
            nr += 1
        self.eval_cmd(f"show()")

        root.mainloop()


