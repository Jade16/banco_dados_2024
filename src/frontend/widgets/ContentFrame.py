import customtkinter as ctk
from .RegisterReservationFrame import RegisterReservationFrame
from .RegisterMaintenanceFrame import RegisterMaintenanceFrame
from .ConsultationFrame import ConsultationFrame
from .Sidebar import Sidebar
from frontend.Settings import *

class ContentFrame(ctk.CTkFrame):
    def __init__(self, master):
        super().__init__(master)
        self.configure(fg_color=DARK_GRAY, corner_radius=0)

        # Configurar layout
        self.columnconfigure(0, weight=1)
        self.rowconfigure(0, weight=1)

        # Criar um frame vazio inicial
        self.current_frame = None

    def show_cadastro_reserva(self):
        self._clear_current_frame()
        self.current_frame = RegisterReservationFrame(self)
        self.current_frame.grid(row=0, column=0, sticky="nsew", padx=64, pady=32)

    def show_cadastro_manutencao(self):
        self._clear_current_frame()
        self.current_frame = RegisterMaintenanceFrame(self)
        self.current_frame.grid(row=0, column=0, sticky="nsew", padx=64, pady=32)

    def show_consulta(self):
        self._clear_current_frame()
        self.current_frame = ConsultationFrame(self)
        self.current_frame.grid(row=0, column=0, sticky="nsew", padx=64, pady=32)

    def _clear_current_frame(self):
        if self.current_frame is not None:
            self.current_frame.destroy()
            self.current_frame = None
