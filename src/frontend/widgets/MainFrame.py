import customtkinter as ctk
from .Sidebar import Sidebar
from .ContentFrame import ContentFrame
from frontend.Settings import *

class MainFrame(ctk.CTkFrame):
    def __init__(self, master):
        super().__init__(master)
        self.configure(fg_color=DARK_GRAY)

        # Configurar layout
        self.columnconfigure(0, weight=0)  # Sidebar
        self.columnconfigure(1, weight=1)  # Content
        self.rowconfigure(0, weight=1)

        # Criar a sidebar
        self.sidebar = Sidebar(self)
        self.sidebar.grid(row=0, column=0, sticky="ns")

        # Criar o content frame
        self.content_frame = ContentFrame(self)
        self.content_frame.grid(row=0, column=1, sticky="nsew")

        # Configurar os comandos dos botões da sidebar
        self.sidebar.set_button_commands(
            cadastro_reserva_command=self.show_cadastro_reserva,
            cadastro_manutencao_command=self.show_cadastro_manutencao,
            consulta_command=self.show_consulta
        )
        
        self.show_cadastro_reserva()

    def show_cadastro_reserva(self):
        self.content_frame.show_cadastro_reserva()
        for i in range(3):
            self.sidebar.get_button(i).configure(fg_color="transparent")
        self.sidebar.get_button(0).configure(fg_color=BLACK)

    def show_cadastro_manutencao(self):
        self.content_frame.show_cadastro_manutencao()
        for i in range(3):
            self.sidebar.get_button(i).configure(fg_color="transparent")
        self.sidebar.get_button(1).configure(fg_color=BLACK)

    def show_consulta(self):
        self.content_frame.show_consulta()
        for i in range(3):
            self.sidebar.get_button(i).configure(fg_color="transparent")
        self.sidebar.get_button(2).configure(fg_color=BLACK)
