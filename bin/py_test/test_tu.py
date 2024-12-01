#!/usr/bin/env python
# -*- coding: utf-8 -*-

import tt_util as tu

print(tu.fn_dirname('aa/bb' , 'img_', '_out'))
print(tu.fn_dirname('aa/bb/', 'img_', '_out'))
print(tu.fn_filename('aa/bb/cc.png', 'img_', '_out', '.jpg'))
print(tu.fn_filename_ext('aa/bb/cc.png'))
