import customtkinter as ctk
from frontend.Settings import *
from tkinter import messagebox


class Utils:
    
    @staticmethod
    def show_error(title, message):
        """
        Show an error pop-up.
        """
        messagebox.showerror(title, message)

    @staticmethod
    def show_info(title, message):
        """
        Show an informational pop-up.
        """
        messagebox.showinfo(title, message)
    
    @staticmethod
    def insert_entry(scroll_frame, text, placeholder=""):
        card = ctk.CTkFrame(scroll_frame, fg_color="transparent", corner_radius=8)
        card.pack(fill="x", padx=16, pady=16)
        card.columnconfigure((0,1), weight=1, uniform="card")
        label = ctk.CTkLabel(card, text=text, font=H5)
        # label.pack(side="left", padx=16)
        label.grid(row=0, column=0, padx=16, sticky="w")
        entry = ctk.CTkEntry(card, width=400, border_color=LIGHT_BLUE, font=H5_no_bold,
                             placeholder_text=placeholder)
        # entry.pack(side="right", padx=16)
        entry.grid(row=0, column=1, padx=16, sticky="nswe")
        return entry

    @staticmethod
    def insert_combobox(scroll_frame, text, values, command=None):
        card = ctk.CTkFrame(scroll_frame, fg_color="transparent", corner_radius=8)
        card.pack(fill="x", padx=16, pady=16)
        card.columnconfigure((0,1), weight=1, uniform="card")
        label = ctk.CTkLabel(card, text=text, font=H5)
        # label.pack(side="left", padx=16)
        label.grid(row=0, column=0, padx=16, sticky="w")
        combobox = ctk.CTkComboBox(card, width=400, border_color=LIGHT_BLUE, font=H5_no_bold,
                                   button_color=LIGHT_BLUE, button_hover_color=DARK_BLUE,
                                   dropdown_font=H5_no_bold, dropdown_fg_color=LIGHT_GRAY,
                                   values=values, command=command)
        # combobox.pack(side="right", padx=16)
        combobox.grid(row=0, column=1, padx=16, sticky="nswe")
        return combobox
    
    @staticmethod
    def clear_form(form_entry, form_combobox):
        # Clear form fields
        for field in form_entry:
            if field.get() != "":
                field.delete(0, 'end')
        for field in form_combobox:
            field.set("Selecione um item")
    
    @staticmethod
    def insert_save_button(bottom_frame, command):
        # Save button
        btn_save = ctk.CTkButton(
            bottom_frame,
            text="Salvar",
            font=H5,
            fg_color=LIGHT_BLUE,
            hover_color=DARK_BLUE,
            text_color=BLACK,
            command=command
        )
        btn_save.pack(side="right", padx=16, pady=16)
    
    @staticmethod
    def insert_search_button(bottom_frame, command):
        # Save button
        btn_save = ctk.CTkButton(
            bottom_frame,
            text="Pesquisar",
            font=H5,
            fg_color=LIGHT_BLUE,
            hover_color=DARK_BLUE,
            text_color=BLACK,
            command=command
        )
        btn_save.pack(side="right", padx=16, pady=16)
    
    @staticmethod
    def insert_clear_button(bottom_frame, command):
        # Clear button
        btn_clear = ctk.CTkButton(
            bottom_frame,
            text="Limpar",
            font=H5,
            border_color=LIGHT_BLUE,
            border_width=2,
            fg_color="transparent",
            hover_color=DARK_BLUE,
            text_color=LIGHT_BLUE,
            command=command
        )
        btn_clear.pack(side="left", padx=16, pady=16)
    
    @staticmethod
    def configure_layout(frame, text):
        scroll_frame = ctk.CTkScrollableFrame(frame, fg_color="transparent", corner_radius=10,
                                                   label_text=text, label_font=H4,
                                                   label_fg_color=LIGHT_BLUE, label_text_color=BLACK)
        scroll_frame.pack(fill="both", expand=True, padx=8, pady=8)
        
        bottom_frame = ctk.CTkFrame(frame, fg_color="transparent", height=64, corner_radius=10)
        bottom_frame.pack(fill="both", padx=8, pady=8)
        
        return scroll_frame, bottom_frame
    
    @staticmethod
    def configure_search_layout(frame, text):
        scroll_frame = ctk.CTkScrollableFrame(frame, fg_color=BLACK, corner_radius=10,
                                                   label_text=text, label_font=H4,
                                                   label_fg_color=LIGHT_BLUE, label_text_color=BLACK)
        scroll_frame.pack(fill="both", expand=True, padx=8, pady=8)

        filter_frame = ctk.CTkFrame(frame, fg_color="transparent", corner_radius=10)
        filter_frame.pack(fill="both", padx=8, pady=0)
        
        bottom_frame = ctk.CTkFrame(frame, fg_color="transparent", height=64, corner_radius=10)
        bottom_frame.pack(fill="both", padx=8, pady=8)
        
        return scroll_frame, filter_frame, bottom_frame