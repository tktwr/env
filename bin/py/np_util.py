import numpy as np


# -----------------------------------------------------
def img_channel(img, ch):
    h, w = img.shape[:2]
    return img[:, :, ch].reshape([h, w, 1])


def img_split(img):
    R = img[:, :, 0]
    G = img[:, :, 1]
    B = img[:, :, 2]
    return [R, G, B]


def img_merge(R, G, B):
    return np.stack([R, G, B], axis=-1)


def img_del_alpha(img):
    return img[:, :, (0, 1, 2)]


def img_add_alpha(img):
    R = img[:, :, 0]
    G = img[:, :, 1]
    B = img[:, :, 2]
    A = np.ones_like(R)
    return np.stack([R, G, B, A], axis=-1)


# -----------------------------------------------------
def img_scale(img, hw):
    sh, sw, ch = img.shape
    dh, dw = hw
    if sh == dh and sw == dw:
        return img

    out = []
    for y in range(dh):
        for x in range(dw):
            out.append(img[int(sh * y / dh)][int(sw * x / dw)])

    return np.array(out).reshape([dh, dw, ch])


def img_blend(img1, img2, msk):
    '''
    Blend images

    Args:
        img1: image1
        img2: image2
        msk : mask image

    Returns:
        img: blended image
    '''
    return (np.ones_like(msk) - msk) * img1 + msk * img2


def img_mask(img, msk=None):
    if msk is None:
        msk = np.ones_like(img)
    return msk[..., 0].astype(bool)
