import os
os.environ['OPENCV_IO_ENABLE_OPENEXR'] = '1'
import cv2
import tt_util as tu
import cv_util as cu

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
            col = cu.color_cvt_dtype((0.5, 0.5, 0.5), 'uint8')
            img = cu.img_create((h, w, 3), 'uint8', col)
            self.set_img(img, 'default')
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
        if win_type == "orig":
            return self.img
        elif win_type == "disp":
            return self.disp_img
        elif win_type == "crop":
            return self.crop_img

    def load(self, fname):
        img = cu.imgfile_load(fname)
        self.set_img(img, fname)

    def save(self, fname):
        cu.imgfile_save(fname, self.img)

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
        self.disp_img = cu.img_fit(self.img, max_wh)
        return self.disp_img

    def make_crop_xy_img(self, xy, wh):
        center = (wh[0]//2, wh[1]//2)
        p1 = (center[0] - 5, center[1] - 5)
        p2 = (center[0] + 5, center[1] + 5)
        color = (0, 0, 255)

        oimg = cu.img_crop_center(self.img, xy, wh)
        oimg = cv2.rectangle(oimg, p1, p2, color, 1)
        self.crop_img = oimg
        return self.crop_img

    def make_crop_uv_img(self, uv, wh):
        xy = self.uv_to_xy(uv)
        return self.make_crop_xy_img(xy, wh)


