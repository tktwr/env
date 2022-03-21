import argparse
import tt_util as tu
import cv_util as cu
import tkinter as tk
from tkinter import ttk
from tkinter import font
from tkinter.scrolledtext import ScrolledText
import img_pkg
import img_win


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
        self.app.I[nr] = img_pkg.ImagePkg()
        win = img_win.ImageFrame(self.parent,
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


