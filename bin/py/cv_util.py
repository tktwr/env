#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
os.environ['OPENCV_IO_ENABLE_OPENEXR'] = '1'
import cv2
import numpy as np
import tt_util as tu


# -----------------------------------------------------
# convert dtype
# -----------------------------------------------------
def dtype_maximum(dtype):
    if dtype == 'uint8':
        maximum = 255
    elif dtype == 'uint16':
        maximum = 65535
    elif dtype == 'float32':
        maximum = 1.0
    elif dtype == 'float64':
        maximum = 1.0
    return maximum


def color_cvt_dtype(col, dst_dtype):
    '''
        col: [0.0, 1.0]
    '''
    dmax = dtype_maximum(dst_dtype)
    return (np.array(col) * dmax).astype(dst_dtype)


def ext_to_dtype(ext):
    e2d = {
        '.png': 'uint8',
        '.jpg': 'uint8',
        '.exr': 'float32',
    }
    return e2d[ext]


# =====================================================
# interface for image
# =====================================================
def img_size(img):
    if len(img.shape) == 3:
        h, w, ch = img.shape[:3]
    else:
        h, w = img.shape[:2]
        ch = 1
    return (h, w, ch)


def img_reshape_3d(img):
    if len(img.shape) > 2:
        return img
    h, w = img.shape
    return img.reshape([h, w, 1])


def img_channel(img, ch):
    return img[:, :, ch]


def img_split(img):
    return cv2.split(img)


def img_merge(img_list):
    return cv2.merge(img_list)


# -----------------------------------------------------
# convert
# -----------------------------------------------------
def img_cvt_dtype(img, dst_dtype):
    if dst_dtype not in ('uint8', 'uint16', 'float32', 'float64'):
        return img

    if img.dtype == dst_dtype:
        return img

    smax = dtype_maximum(img.dtype)
    dmax = dtype_maximum(dst_dtype)
    return np.clip(img / smax * dmax, 0, dmax).astype(dst_dtype)


def img_cvt_channels(img, dst_ch):
    if dst_ch not in (1, 3, 4):
        return img

    h, w, ch = img_size(img)

    if ch == dst_ch:
        return img

    img_list = list(cv2.split(img))
    img_one = np.ones_like(img_list[0]) * dtype_maximum(img.dtype)

    # -----------------------------------------------------
    if ch == 3 and dst_ch == 1:
        return img_list[0]

    if ch == 4 and dst_ch == 1:
        return img_list[0]

    # -----------------------------------------------------
    if ch == 1 and dst_ch == 3:
        return cv2.merge([img_list[0], img_list[0], img_list[0]])

    if ch == 4 and dst_ch == 3:
        return cv2.merge([img_list[0], img_list[1], img_list[2]])

    # -----------------------------------------------------
    if ch == 1 and dst_ch == 4:
        return cv2.merge([img_list[0], img_list[0], img_list[0], img_one])

    if ch == 3 and dst_ch == 4:
        img_list.append(img_one)
        return cv2.merge(img_list)

    return img


# -----------------------------------------------------
def img_u8_to_f32(img):
    return (img / 255.0).astype('float32')

def img_f32_to_u8(img):
    return np.clip(img * 255, 0, 255).astype('uint8')

# -----------------------------------------------------
def img_bgr_to_rgb(img):
    spl = cv2.split(img)
    return cv2.merge((spl[2], spl[1], spl[0]))

def img_rgb_to_bgr(img):
    return img_bgr_to_rgb(img)

# -----------------------------------------------------
def img_bgr_to_lab(img):
    return cv2.cvtColor(img, cv2.COLOR_BGR2LAB)

def img_lab_to_bgr(img):
    return cv2.cvtColor(img, cv2.COLOR_LAB2BGR)

# -----------------------------------------------------
def img_bgr_to_hsv(img):
    return cv2.cvtColor(img, cv2.COLOR_BGR2HSV_FULL)

def img_hsv_to_bgr(img):
    return cv2.cvtColor(img, cv2.COLOR_HSV2BGR_FULL)

# -----------------------------------------------------
def img_bgr_to_gray(img):
    return cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

def img_gray_to_bgr(img):
    return cv2.cvtColor(img, cv2.COLOR_GRAY2BGR)

# -----------------------------------------------------
def img_linear_to_srgb(img):
    return np.power(img, 1.0 / 2.2)

def img_srgb_to_linear(img):
    return np.power(img, 2.2)

# -----------------------------------------------------
# cmap
# -----------------------------------------------------
import matplotlib.pyplot as plt


def cmap_list(cmap_name='viridis', n_colors=256):
    cmap = plt.get_cmap(cmap_name)
    rgb = cmap(np.linspace(0, 1, n_colors))
    bgr = rgb[:, [2, 1, 0, 3]]
    return bgr


def img_cmap_lut(img):
    color_list = cmap_list()
    n_colors = len(color_list)
    img = np.clip(img, 0, 1)
    scaled_value = img * (n_colors - 1)

    lo = np.floor(scaled_value).astype(int)
    up = np.ceil(scaled_value).astype(int)

    exact_matches = (lo == up)

    lo_color = color_list[lo]
    up_color = color_list[up]
    t = scaled_value - lo

    return np.where(exact_matches[..., None], lo_color, (1 - t[..., None]) * lo_color + t[..., None] * up_color)


# -----------------------------------------------------
# convert pixel value
# -----------------------------------------------------
def img_mult(img, val):
    dtype = img.dtype
    img = img_cvt_dtype(img, 'float32')
    img *= val
    return img_cvt_dtype(img, dtype)


def img_diff(img1, img2, scale=1.0):
    dtype = img1.dtype
    h, w, ch = img_size(img1)
    if ch == 3:
        img1 = img_bgr_to_gray(img1)
        img2 = img_bgr_to_gray(img2)
    img1 = img_cvt_dtype(img1, 'float32')
    img2 = img_cvt_dtype(img2, 'float32')
    oimg = np.abs(img1 - img2)
    min_val = oimg.min()
    max_val = oimg.max()
    print(f'img_diff: min_val, max_val: {min_val:.3f} {max_val:.3f}')
    oimg = img_cmap_lut(oimg * scale)
    oimg = img_cvt_dtype(oimg, dtype)
    return img_cvt_channels(oimg, 3)


def img_brightness_contrast(img, brightness, contrast):
    '''
    Args:
        brightness: [-1, 1]
        contrast  : [-1, 1]
    '''
    a = 1.0 + contrast
    b = brightness - contrast * 0.5

    dtype = img.dtype
    img = img_cvt_dtype(img, 'float32')

    img = a * img + b
    img = np.clip(img, 0.0, None)

    return img_cvt_dtype(img, dtype)


# -----------------------------------------------------
# create
# -----------------------------------------------------
def img_create(shape, dtype, val):
    return (np.ones(shape) * val).astype(dtype)


def img_create_hgrad(shape, dtype, co0, co1):
    img = np.ones(shape)
    h, w = shape[:2]
    for y in range(0, h):
        for x in range(0, w):
            t = float(x) / (w - 1)
            img[y, x] = (1 - t) * co0 + t * co1
    return img.astype(dtype)


def img_create_vgrad(shape, dtype, co0, co1):
    img = np.ones(shape)
    h, w = shape[:2]
    for y in range(0, h):
        for x in range(0, w):
            t = float(y) / (h - 1)
            img[y, x] = (1 - t) * co0 + t * co1
    return img.astype(dtype)


def img_create_check(shape, dtype, co0, co1, nelm):
    h, w, ch = shape
    nx, ny = nelm

    ih = h // ny
    iw = w // nx
    ishape = (ih, iw, ch)

    img0 = img_create(ishape, dtype, co0)
    img1 = img_create(ishape, dtype, co1)

    img_list_y = []
    for y in range(ny):
        img_list_x = []
        for x in range(nx):
            mx = x % 2
            my = y % 2
            if (mx + my) == 1:
                img_list_x.append(img1)
            else:
                img_list_x.append(img0)
        img_list_y.append(img_list_x)
    return imglst_htile(img_list_y)


def img_create_hstripe(shape, dtype, co0, co1, nelm):
    '''
    create a horizontal stripe image
    '''
    h, w, ch = shape
    nx, ny = nelm

    ih = h // ny
    ishape = (ih, w, ch)

    img0 = img_create(ishape, dtype, co0)
    img1 = img_create(ishape, dtype, co1)

    img_list_y = []
    for y in range(ny):
        my = y % 2
        if my == 1:
            img_list_y.append(img1)
        else:
            img_list_y.append(img0)
    return imglst_vconcat(img_list_y)


def img_create_se_stripe(shape, dtype, co0, co1, nelm):
    '''
    create a stripe image in the southeast direction
    '''
    h, w, ch = shape
    nx, ny = nelm
    iw = w // nx

    img = img_create(shape, dtype, co0)

    for y in range(0, h):
        for x in range(0, w):
            mx = ((x - y) // iw) % 2
            if mx == 1:
                img[y, x] = co1
    return img


# -----------------------------------------------------
# resize
# -----------------------------------------------------
def img_resize(img, dst_wh):
    h, w = img.shape[:2]
    src_wh = (w, h)
    new_wh = tu.fix_size(src_wh, dst_wh)

    if src_wh == new_wh:
        return img
    else:
        return cv2.resize(img, new_wh, interpolation=cv2.INTER_AREA)


def img_fit(img, dst_wh):
    h, w = img.shape[:2]
    src_wh = (w, h)
    fit_size = tu.fit_size(src_wh, dst_wh)
    return img_resize(img, fit_size)


# -----------------------------------------------------
# crop
# -----------------------------------------------------
def img_crop_simple(img, pos, size):
    '''
    Args:
        pos  : [x, y]
        size : [w, h]
    '''
    top    = pos[1]
    bottom = pos[1] + size[1]
    left   = pos[0]
    right  = pos[0] + size[0]
    return img[top:bottom, left:right]


def img_crop(img, pos, size, centering=False):
    '''
    Crop an image

    Args:
        pos : [x, y]
        size: [w, h]

    Returns:
        img: cropped image
    '''
    h, w, ch = img_size(img)

    if ch == 1:
        dst_shape = (size[1], size[0])
    else:
        dst_shape = (size[1], size[0], ch)
    dst_img = np.zeros(dst_shape, dtype=img.dtype)

    # crop in the img
    top    = pos[1]
    bottom = pos[1] + size[1]
    left   = pos[0]
    right  = pos[0] + size[0]

    top = 0 if top < 0 else top
    left = 0 if left < 0 else left
    bottom = h if bottom > h else bottom
    right = w if right > w else right

    crop_h = bottom - top
    crop_w = right - left
    if not (crop_h > 0 and crop_w > 0):
        return dst_img

    crop_img = img[top:bottom, left:right]

    # fill in the dst_img
    dx = 0
    dy = 0
    dh = bottom - top
    dw = right - left

    if centering:
        if dh < size[1]:
            dy = size[1] - dh
            dy //= 2
        if dw < size[0]:
            dx = size[0] - dw
            dx //= 2
    else:
        if dh < size[1] and top == 0:
            dy = size[1] - dh
        if dw < size[0] and left == 0:
            dx = size[0] - dw

    dst_img[dy:dy + dh, dx:dx + dw] = crop_img

    return dst_img


def img_crop_center(img, center, size):
    '''
    Args:
        center : [x, y]
        size   : [w, h]
    '''
    pos = [0, 0]
    pos[0] = center[0] - (size[0] // 2)
    pos[1] = center[1] - (size[1] // 2)
    return img_crop(img, pos, size)


# =====================================================
# interface for file
# =====================================================
def imgfile_info_short(fname):
    img = imgfile_load(fname)
    print(f'{fname} {img.shape} {img.dtype}')


def imgfile_info(fname):
    img = imgfile_load(fname)
    h, w, ch = img_size(img)
    min = img.min(axis=(0, 1))
    max = img.max(axis=(0, 1))

    print(f'filename  = {fname}')
    print(f"height    = {h}")
    print(f"width     = {w}")
    print(f"channels  = {ch}")
    print(f"img.shape = {img.shape}")
    print(f"img.dtype = {img.dtype}")
    print(f"type(img) = {type(img)}")
    print(f"min       = {min}")
    print(f"max       = {max}")


def imgfile_load(ifname):
    FN = tu.FileName(ifname)
    return cv2.imread(FN.abspath(), cv2.IMREAD_UNCHANGED)


def imgfile_save(ofname, img):
    FN = tu.FileName(ofname)

    img = img_cvt_dtype(img, ext_to_dtype(FN.ext()))

    print(f"imgfile_save: {ofname} {img.shape} {img.dtype}")
    tu.sh_mkdir(FN.dirname())
    cv2.imwrite(FN.abspath(), img)


def imgfile_resize(ifname, ofname, dst_size):
    img = imgfile_load(ifname)
    oimg = img_resize(img, dst_size)
    imgfile_save(ofname, oimg)


def imgfile_pick(fname, x, y):
    img = imgfile_load(fname)
    return img[y, x]


# =====================================================
# tiling image
# =====================================================
def imglst_cvt(img_list, channels=3, dtype='uint8'):
    l = []
    for img in img_list:
        img = img_cvt_channels(img, channels)
        img = img_cvt_dtype(img, dtype)
        l.append(img)
    return l


def imglst_hconcat(img_list, interpolation=cv2.INTER_AREA):
    l = imglst_cvt(img_list)
    h_min = min(i.shape[0] for i in l)
    img_list_resize = [cv2.resize(i, (int(h_min * i.shape[1] / i.shape[0]), h_min), interpolation=interpolation) for i in l]
    return cv2.hconcat(img_list_resize)


def imglst_vconcat(img_list, interpolation=cv2.INTER_AREA):
    l = imglst_cvt(img_list)
    w_min = min(i.shape[1] for i in l)
    img_list_resize = [cv2.resize(i, (w_min, int(w_min * i.shape[0] / i.shape[1])), interpolation=interpolation) for i in l]
    return cv2.vconcat(img_list_resize)


def imglst_htile(img_list_2d, interpolation=cv2.INTER_AREA):
    img_list_v = [imglst_hconcat(img_list_h, interpolation) for img_list_h in img_list_2d]
    return imglst_vconcat(img_list_v, interpolation)


def imglst_vtile(img_list_2d, interpolation=cv2.INTER_AREA):
    img_list_h = [imglst_vconcat(img_list_v, interpolation) for img_list_v in img_list_2d]
    return imglst_hconcat(img_list_h, interpolation)


def imglst_to_imglst2d(l, step):
    return [l[i:i + step] for i in range(0, len(l), step)]


# =====================================================
#
# =====================================================
def img_flip_x(img):
    return np.fliplr(img)


def img_flip_y(img):
    return np.flipud(img)


def img_normalize(img, min_val=0, max_val=0):
    if min_val == 0 and max_val == 0:
        min_val = img.min()
        max_val = img.max()
    return (img - min_val) / (max_val - min_val)


def img_compare(img1, img2):
    sz_img1 = img_size(img1)
    sz_img2 = img_size(img2)
    # if sz_img1 != sz_img2:
    #     raise ValueError(f"different image size: {sz_img1}, {sz_img2}")

    h, w, ch = sz_img1
    half_w = w // 2
    img1 = img_crop_simple(img1 , (0      , 0) , (half_w , h))
    img2 = img_crop_simple(img2 , (half_w , 0) , (half_w , h))
    oimg = imglst_hconcat([img1, img2])
    return oimg


def img_add_label(img, label_type, ifname, nr):
    ifname = os.path.abspath(ifname)
    if label_type == 'FILE':
        name = ifname.split('/')[-1]
    elif label_type == 'DIR':
        name = ifname.split('/')[-2]
    elif label_type == 'NUM':
        name = f'{nr})'
    elif label_type == 'ALPHA':
        ch = chr(ord('a') + nr - 1)
        name = f'{ch})'
    else:
        name = ''

    if name != '':
        h, w, ch = img_size(img)
        xy = (int(0.05 * w), int(0.95 * h))
        color = (255, 255, 255)
        cv2.putText(img, name, xy, cv2.FONT_HERSHEY_SIMPLEX, 1, color, 1, cv2.LINE_AA)


