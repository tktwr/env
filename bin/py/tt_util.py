#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import re
import glob
import time
import subprocess
import json
import argparse
import numpy as np
import shutil


# -----------------------------------------------------
# exists
# -----------------------------------------------------
def sh_isfile(fname):
    return os.path.isfile(fname)

def sh_isdir(dirname):
    return os.path.isdir(dirname)

def sh_exists(fname):
    return os.path.exists(fname)

# -----------------------------------------------------
# file
# -----------------------------------------------------
def sh_touch(ofname):
    with open(ofname, 'w') as f:
        f.write('')

def sh_rm(fname):
    os.remove(fname)

def sh_cp(src_file, dst_file):
    shutil.copy(src_file, dst_file)

def sh_mv(src_file, dst_file):
    shutil.move(src_file, dst_file)

# -----------------------------------------------------
# dir
# -----------------------------------------------------
def sh_ls(dirname='.'):
    print(os.listdir(dirname))

def sh_glob(pattern):
    return glob.glob(pattern)

def sh_getcwd():
    return os.getcwd()

def sh_chdir(dirname):
    os.chdir(dirname)

def sh_mkdir(dirname, exist_ok=True):
    if dirname != '':
        #os.mkdir(dirname)
        os.makedirs(dirname, exist_ok=exist_ok)

def sh_rmdir(dirname, ignore_errors=True):
    shutil.rmtree(dirname, ignore_errors=ignore_errors)

def sh_cpdir(src_dir, dst_dir):
    shutil.copytree(src_dir, dst_dir)

def sh_mvdir(src_dir, dst_dir):
    shutil.move(src_dir, dst_dir)

# -----------------------------------------------------
# log
# -----------------------------------------------------
def log_sep_0(s):
    print(f'=== {s} ====================', file=sys.stderr)


def log_sep(s):
    print(f'--- {s} --------------------', file=sys.stderr)


def log(s):
    print(f'{s}', file=sys.stderr)


def log_title(title, sep='-', sep_n=55, place='center'):
    separator = sep * sep_n
    n = len(title)
    out = separator
    if place == 'left':
        out = title + separator[n:]
    elif place == 'right':
        out = separator[:-n] + title
    elif place == 'center':
        nn = len(separator) - n
        r = nn % 2
        nl = int(nn / 2)
        nr = int(nn / 2) + r
        sepl = separator[:nl]
        sepr = separator[-nr:]
        out = sepl + title + sepr
    print(f'{out}', flush=True, file=sys.stderr)


# -----------------------------------------------------
# list
# -----------------------------------------------------
def lst_split_sublists(lst, mx):
    '''
    Split the list into sublists, each of length mx
    '''
    return [lst[i:i+mx] for i in range(0, len(lst), mx)]


def lst_prefix_match(lst, prefix):
    return [i for i in lst if i.startswith(prefix)]


def get_all_funcs(lst, prefix='f_'):
    if len(sys.argv) == 1:
        func_lst = lst_prefix_match(lst, prefix)
    else:
        func_lst = sys.argv[1:]
    log(f'func_lst: {func_lst}')
    return func_lst


def tile_fill(nelm, nx, ny):
    mod = 0
    fill = 0
    if nx > 0 and ny > 0:
        fill = nx * ny - nelm
    elif nx == 0 and ny > 0:
        nx, mod = divmod(nelm, ny)
        if mod > 0:
            nx += 1
            fill = ny - mod
    elif ny == 0 and nx > 0:
        ny, mod = divmod(nelm, nx)
        if mod > 0:
            ny += 1
            fill = nx - mod
    return (nx, ny, fill)


# -----------------------------------------------------
# argparse
# -----------------------------------------------------
class MyHelpFormatter(argparse.RawDescriptionHelpFormatter,
                      argparse.ArgumentDefaultsHelpFormatter,
                      argparse.MetavarTypeHelpFormatter):
    pass


def parser(desc, epilog=''):
    parser = argparse.ArgumentParser(
        formatter_class=MyHelpFormatter,
        description=desc,
        epilog=epilog)
    return parser


# -----------------------------------------------------
def print_args(args):
    print(f"--- args ---")
    print(f"{args}")


# -----------------------------------------------------
# string
# -----------------------------------------------------
def str_expand_env(s):
    r = re.search(r'\$\w+', s)
    if r is not None:
        matched = r.group()
        env_var = matched[1:]
        if os.getenv(env_var) is not None:
            s = s.replace(matched, os.environ[env_var])
    return s


# -----------------------------------------------------
# filename
# -----------------------------------------------------
def fn_dirname(path, prefix='', postfix=''):
    '''
    Examples:
        tu.fn_dirname('aa/bb' , 'img_', '_out')
        aa/img_bb_out
        tu.fn_dirname('aa/bb/', 'img_', '_out')
        aa/img_bb_out
    '''
    path = path.rstrip('/')
    parent_dirname = os.path.dirname(path)
    base_dirname = os.path.basename(path)
    return f'{parent_dirname}/{prefix}{base_dirname}{postfix}'

def fn_filename(path, prefix='', postfix='', ext=''):
    '''
    Examples:
        tu.fn_filename('aa/bb/cc.png', 'img_', '_out', '.jpg')
        aa/bb/img_cc_out.jpg
    '''
    dirname = os.path.dirname(path)
    filename = os.path.basename(path)
    name, _ext = os.path.splitext(filename)
    if ext != '':
        _ext = ext
    return f'{dirname}/{prefix}{name}{postfix}{_ext}'

def fn_filename_ext(path):
    '''
    Examples:
        tu.fn_filename_ext('aa/bb/cc.png')
        .png
    '''
    filename = os.path.basename(path)
    name, ext = os.path.splitext(filename)
    return ext

# -----------------------------------------------------
# FileName
# -----------------------------------------------------
def expand_env(path):
    path = os.path.expanduser(path)
    path = os.path.expandvars(path)
    return path

class FileName():
    def __init__(self, orig_path):
        path = expand_env(orig_path)
        path = os.path.realpath(path)
        path = os.path.abspath(path)

        self._orig_path = orig_path
        self._dirname = os.path.dirname(path)
        self._filename = os.path.basename(path)

    def origname(self):
        return self._orig_path

    def dirname(self):
        return self._dirname

    def abspath(self, prefix='', postfix='', ext=''):
        return f'{self.dirname()}/{self.filename(prefix, postfix, ext)}'

    def filename(self, prefix='', postfix='', ext=''):
        if ext == '':
            ext = self.ext()
        return f'{self.name(prefix, postfix)}{ext}'

    def name(self, prefix='', postfix=''):
        name, ext = os.path.splitext(self._filename)
        return f'{prefix}{name}{postfix}'

    def ext(self):
        '''
        Returns:
            aa/bb/cc.txt -> .txt
            aa/bb/cc     -> ''
        '''
        name, ext = os.path.splitext(self._filename)
        return ext


# -----------------------------------------------------
# path
# -----------------------------------------------------
def drive_unix(match):
    return f'/{match.group(1).lower()}'


def drive_windows(match):
    return f'{match.group(1).upper()}:/'


def path_unix(fname, prefix='/mnt', expand=False, realpath=True):
    if expand:
        fname = expand_env(fname)
    fname = fname.replace('\\', '/')
    fname = re.sub(f'^{prefix}', '', fname)
    fname = re.sub(f'^([c-zC-Z]):', drive_unix, fname)
    fname = re.sub(f'^(/[c-z]/)', f'{prefix}\\1', fname)
    if realpath and os.path.islink(fname):
        fname = os.path.realpath(fname)
    return fname


def path_mixed(fname, prefix='/mnt', expand=False, realpath=True):
    if expand:
        fname = expand_env(fname)
    fname = re.sub(f'^{prefix}', '', fname)
    fname = re.sub(f'^/([c-zC-Z])/', drive_windows, fname)
    fname = fname.replace('\\', '/')
    if realpath and os.path.islink(fname):
        fname = os.path.realpath(fname)
    return fname


def path_windows(fname, prefix='/mnt', expand=False, realpath=True):
    if expand:
        fname = expand_env(fname)
    fname = re.sub(f'^{prefix}', '', fname)
    fname = re.sub(f'^/([c-zC-Z])/', drive_windows, fname)
    fname = fname.replace('/', r'\\')
    if realpath and os.path.islink(fname):
        fname = os.path.realpath(fname)
    return fname


# -----------------------------------------------------
# image size
# -----------------------------------------------------
def fix_size(src_wh: tuple[int, int], dst_wh: tuple[int, int]):
    '''
    Args:
        src_wh: src size
        dst_wh: dst size

    Note:
        dst_wh:
            (0, 0): source size
            (w, 0): set width, keep aspect ratio
            (0, h): set height, keep aspect ratio
            (w, h): set width and height, not keep aspect ratio
    '''
    sw, sh = src_wh
    w, h = dst_wh

    if w == 0 and h == 0:
        return (sw, sh)
    elif w > 0 and h == 0:
        return (w, int(w * (sh / sw)))
    elif w == 0 and h > 0:
        return (int(h * (sw / sh)), h)
    else:
        return (w, h)


def fit_size(src_wh, max_wh):
    '''
    Compute the maximized size

    Args:
        src_wh: source size
        max_wh: maximum size
    '''
    w, h = src_wh
    w_max, h_max = max_wh

    if h >= w and h > h_max:
        dst_wh = (0, h_max)
    elif w >= h and w > w_max:
        dst_wh = (w_max, 0)
    else:
        dst_wh = (0, 0)

    return fix_size(src_wh, dst_wh)


# -----------------------------------------------------
# timeit
# -----------------------------------------------------
def timeit(func):
    def wrapper(*args, **kargs):
        time_list = []
        for i in range(5):
            start = time.time()
            func(*args, **kargs)
            end = time.time()
            time_list.append(end - start)
        avg = np.mean(time_list)
        median = np.median(time_list)
        print(f"{func.__name__}: avg={avg:.3f} sec, median={median:.3f} sec")
    return wrapper


# -----------------------------------------------------
# text (string)
# -----------------------------------------------------
def read_text(fname):
    with open(fname, "r", encoding="utf-8") as f:
        return f.read()

def write_text(fname, text):
    with open(fname, "w", encoding="utf-8") as f:
        f.write(text)

# -----------------------------------------------------
# lines (list os string)
# -----------------------------------------------------
def text2lines(text):
    return text.splitlines()

def read_lines(fname, del_null=False):
    with open(fname, "r", encoding="utf-8") as f:
        lst = f.readlines()
        lst = [i.strip() for i in lst]
        if del_null:
            lst = [i for i in lst if i != '']
        return lst

def write_lines(fname, lst, del_null=False):
    with open(fname, "w", encoding="utf-8") as f:
        if del_null:
            lst = [i for i in lst if i != '']
        lst = [i + "\n" for i in lst]
        f.writelines(lst)

# -----------------------------------------------------
# json (dict)
# -----------------------------------------------------
def text2json(json_text):
    return json.loads(json_text)

def read_json(fname):
    with open(fname, "r", encoding="utf-8") as f:
        return json.load(f)

def write_json(fname, dct):
    with open(fname, "w", encoding="utf-8") as f:
        text = json.dumps(dct, indent=4, ensure_ascii=False)
        f.write(text)

# -----------------------------------------------------
# subprocess
# -----------------------------------------------------
def run(command):
    proc = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

    while True:
        line = proc.stdout.readline().decode('utf-8', 'replace')
        if line:
            sys.stdout.write(line)
        if not line and proc.poll() is not None:
            break

# =====================================================
# main
# =====================================================
import pprint

def f_test_sys_path():
    pprint.pprint(sys.path)

def f_test_path_os():
    def _f_test(fname):
        fname_unix = path_unix(fname, expand=True)
        fname_mix  = path_mixed(fname, expand=True)
        fname_win  = path_windows(fname, expand=True)
        print('--- test_path ---')
        print(f'orig : {fname}')
        print(f'unix : {fname_unix}')
        print(f'mix  : {fname_mix}')
        print(f'win  : {fname_win}')

    _f_test('$HOME/aa\\bb/cc.txt')
    _f_test('$HOME/WinHome/.bashrc')
    _f_test('$MY_DATA/aa\\bb/cc.txt')
    _f_test('D:/aa\\bb/cc.txt')
    _f_test('/d/aa\\bb/cc.txt')
    _f_test('/mnt/d/aa\\bb/mnt/cc.txt')

def f_test_fn():
    print(fn_dirname('aa/bb' , 'img_', '_out'))
    print(fn_dirname('aa/bb/', 'img_', '_out'))
    print(fn_filename('aa/bb/cc.png', 'img_', '_out', '.jpg'))
    print(fn_filename_ext('aa/bb/cc.png'))

def f_test_filename():
    FN = FileName("$HOME/a/b/c/d.png")

    print(f"FN.origname() = {FN.origname()}")
    print(f"FN.dirname()  = {FN.dirname()}")
    print(f"FN.abspath()  = {FN.abspath(prefix='pre_', postfix='_post', ext='.jpg')}")
    print(f"FN.filename() = {FN.filename(prefix='pre_', postfix='_post', ext='.jpg')}")
    print(f"FN.filename() = {FN.filename()}")
    print(f"FN.name()     = {FN.name()}")
    print(f"FN.ext()      = {FN.ext()}")

def f_test_io_text():
    text = '''
key1 1
key2 2
key3 3
'''
    write_text(f'_output.txt', text)
    text = read_text('_output.txt')
    print(text)

def f_test_io_lines():
    text = '''
key1 1
key2 2
key3 3
'''
    lst = text2lines(text)
    write_lines(f'_output_lines.txt', lst)
    lst = read_lines('_output_lines.txt')
    print(lst)

def f_test_io_json():
    json_text = '''
{
  "key1": 1,
  "key2": 2,
  "key3": 3
}
'''
    json_data = text2json(json_text)
    write_json(f'_output.json', json_data)
    json_data = read_json('_output.json')
    print(json_data)

# -----------------------------------------------------
import types

def get_global_funcs(prefix=''):
    lst = [name for name, obj in globals().items() if isinstance(obj, types.FunctionType)]
    if prefix != '':
        lst = [i for i in lst if i.startswith(prefix)]
    return lst

def run_funcs():
    func_lst = get_global_funcs('f_test_')
    for func in func_lst:
        log_title(f' [{func}] ')
        eval(f'{func}()')

# -----------------------------------------------------
if __name__ == '__main__':
    run_funcs()
