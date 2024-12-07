import customtkinter as ctk
from frontend.Settings import *

class Sidebar(ctk.CTkFrame):
    def __init__(self, master):
        super().__init__(master)
        self.configure(width=300)
        self.configure(fg_color=GRAY, corner_radius=0)

        # Criar botões
        self.btn_cadastro_reserva = ctk.CTkButton(self, text="Cadastrar Reserva Esportiva", corner_radius=0, height=48, font=H5,
                                                  fg_color="transparent", hover_color=BLACK, anchor="w",
                                                  border_spacing=16)
        self.btn_cadastro_reserva.pack(fill="x", pady=(20,0), padx=0)

        self.btn_cadastro_manutencao = ctk.CTkButton(self, text="Cadastrar Manutenção", corner_radius=0, height=48, font=H5,
                                                     border_spacing=16,
                                                     fg_color="transparent", hover_color=BLACK, anchor="w")
        self.btn_cadastro_manutencao.pack(fill="x", pady=0, padx=0)

        self.btn_consulta = ctk.CTkButton(self, text="Consultar Reservas", corner_radius=0, height=48, font=H5,
                                          border_spacing=16,
                                          fg_color="transparent", hover_color=BLACK, anchor="w")
        self.btn_consulta.pack(fill="x", pady=0, padx=0)
        
        
        self.label_funcionario = ctk.CTkLabel(self, text="Funcionário logado: 1", text_color=LIGHT_GRAY, font=H6, fg_color=GRAY, anchor="w")
        self.label_funcionario.pack(fill="x", side="bottom", pady=(16), padx=16)

    def set_button_commands(self, cadastro_reserva_command, cadastro_manutencao_command, consulta_command):
        self.btn_cadastro_reserva.configure(command=cadastro_reserva_command)
        self.btn_cadastro_manutencao.configure(command=cadastro_manutencao_command)
        self.btn_consulta.configure(command=consulta_command)
    
    def get_button(self, index):
        if index == 0:
            return self.btn_cadastro_reserva
        elif index == 1:
            return self.btn_cadastro_manutencao
        elif index == 2:
            return self.btn_consulta
