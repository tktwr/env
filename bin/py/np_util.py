import numpy as np


def scale_img(img, hw):
    sh, sw, ch = img.shape
    dh, dw = hw
    if sh == dh and sw == dw:
        return img
    else:
        return np.array([[ img[int(sh * r / dh)][int(sw * c / dw)] for c in range(dw)] for r in range(dh)]).reshape([dh, dw, ch])


def blend(img1, img2, msk):
    return (np.ones_like(msk) - msk) * img1 + msk * img2


def get_channel(img, ch):
    h, w = img.shape[:2]
    return img[:, :, ch].reshape([h, w, 1])


def split(img):
    R = img[:, :, 0]
    G = img[:, :, 1]
    B = img[:, :, 2]
    return [R, G, B]


def merge(R, G, B):
    return np.stack([R, G, B], axis=-1)


def del_alpha(img):
    return img[:, :, (0, 1, 2)]


def add_alpha(img):
    R = img[:, :, 0]
    G = img[:, :, 1]
    B = img[:, :, 2]
    A = np.ones_like(R)
    return np.stack([R, G, B, A], axis=-1)


def setup_mask(img, msk=None):
    if msk is None:
        msk = np.ones_like(img)
    return msk[..., 0].astype(bool)
