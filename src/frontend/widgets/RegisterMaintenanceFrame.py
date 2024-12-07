import customtkinter as ctk
from frontend.Settings import *
from backend.db_connection import Database  # Import the Database class
from frontend.Utils import Utils
import re

class RegisterMaintenanceFrame(ctk.CTkFrame):
    def __init__(self, master):
        super().__init__(master)
        self.configure(fg_color=GRAY, corner_radius=10)

        self.scroll_frame, self.bottom_frame = Utils.configure_layout(self, "Cadastro de Manutenção")
        self._create_widgets()

    def _create_widgets(self):
        # Comboboxes
        self.combobox_installation = Utils.insert_combobox(self.scroll_frame, "Instalação Esportiva:", values=["Carregando..."], command=self._update_spaces)
        self.combobox_space = Utils.insert_combobox(self.scroll_frame, "Espaço Esportivo:", values=["Selecione uma instalação"])
        self.combobox_contract = Utils.insert_combobox(self.scroll_frame, "Contrato:", values=["Carregando..."])
        
        # Load installations and contracts in the combobox
        self._load_installations()
        self._load_contracts()

        self.entry_type = Utils.insert_entry(self.scroll_frame, "Tipo de Manutenção:", placeholder="Digite o tipo de manutenção (ex: Limpeza, Pintura)")
        self.entry_date = Utils.insert_entry(self.scroll_frame, "Data da Manutenção:", placeholder="DD/MM/AAAA")
        self.entry_start_time = Utils.insert_entry(self.scroll_frame, "Horário de Início:", placeholder="HH:MM")
        self.entry_end_time = Utils.insert_entry(self.scroll_frame, "Horário de Término:", placeholder="HH:MM")

        form_entry = [
            self.entry_type,
            self.entry_date,
            self.entry_start_time,
            self.entry_end_time
        ]
        
        form_combobox = [
            self.combobox_installation,
            self.combobox_space,
            self.combobox_contract
        ]
        
        # Save and clear buttons
        Utils.insert_save_button(self.bottom_frame, self._save_maintenance)
        Utils.insert_clear_button(self.bottom_frame, lambda: Utils.clear_form(form_entry=form_entry, form_combobox=form_combobox))

    def _load_installations(self):
        """
        Load CNPJs of sports facilities from the database into the combobox.
        """
        db = Database()
        try:
            installations = db.get_installations()
            # inserir "Selecione uma instalação" no início da lista
            if installations:
                installations.insert(0, "Selecione uma instalação")
                self.combobox_installation.set("Selecione uma instalação")
                self.combobox_installation.configure(values=installations)
            else:
                self.combobox_installation.configure(values=["Nenhuma instalação encontrada"])
        except Exception as e:
            print("Erro ao carregar instalações:", e)
            Utils.show_error("Erro de Banco de Dados", "Erro ao carregar instalações: " + str(e))
        finally:
            db.close()
            
    def _load_contracts(self):
        """
        Load available contracts from the database into the combobox.
        """
        db = Database()
        try:
            contracts = db.get_contracts()
            if contracts:
                contracts.insert(0, "Selecione um contrato")
                self.combobox_contract.set("Selecione um contrato")
                self.combobox_contract.configure(values=contracts)
            else:
                self.combobox_contract.configure(values=["Nenhum contrato encontrado"])
        except Exception as e:
            print("Erro ao carregar contratos:", e)
            Utils.show_error("Erro de Banco de Dados", "Erro ao carregar contratos: " + str(e))
        finally:
            db.close()

    def _update_spaces(self, event):
        """
        Update the spaces combobox based on the selected installation.
        """
        selected_cnpj = self.combobox_installation.get()
        if not selected_cnpj or selected_cnpj == "Nenhuma instalação encontrada":
            self.combobox_space.configure(values=["Selecione uma instalação"])
            return

        db = Database()
        try:
            name_spaces = db.get_spaces(selected_cnpj)
            if name_spaces:
                name_spaces.insert(0, "Selecione um espaço")
                self.combobox_space.set("Selecione um espaço")
                self.combobox_space.configure(values=name_spaces)
            else:
                self.combobox_space.configure(values=["Nenhum espaço disponível"])
        except Exception as e:
            print("Erro ao carregar espaços esportivos:", e)
            Utils.show_error("Erro de Banco de Dados", "Erro ao carregar espaços esportivos: " + str(e))
        finally:
            db.close()

    def _save_maintenance(self):
        # Collect data from form fields
        try:
            instalacao_esportiva = self.combobox_installation.get()
            espaco_esportivo = self.combobox_space.get().split("-")[0]
            contrato = self.combobox_contract.get()
            tipo = self.entry_type.get()
            data_reserva = self.entry_date.get()
            horario_inicio = self.entry_start_time.get()
            horario_termino = self.entry_end_time.get()
            
            # Validations
            default_installation = ["Selecione uma instalação", "Nenhuma instalação encontrada", "Selecione um item"]
            if not instalacao_esportiva or instalacao_esportiva in default_installation:
                Utils.show_error("Erro de Validação", "Selecione uma instalação válida.")
                return
            
            default_space = ["Selecione uma instalação", "Nenhum espaço disponível", "Selecione um item"]
            if not espaco_esportivo or espaco_esportivo in default_space:
                Utils.show_error("Erro de Validação", "Selecione um espaço válido.")
                return
            
            if not contrato or contrato == "Selecione um contrato":
                Utils.show_error("Erro de Validação", "Selecione um contrato válido.")
                return
            
            # Tratar se o formato da data está em DD/MM/AAAA
            if not re.match(r"\d{2}/\d{2}/\d{4}", data_reserva) and data_reserva != "":
                Utils.show_error("Erro de Validação", "Formato de data inválido. Use DD/MM/AAAA.")
                return


            # Prepare data dictionary
            data = {
                'data_reserva': data_reserva,
                'hora_inicio': horario_inicio,
                'hora_termino': horario_termino,
                'instalacao': instalacao_esportiva,
                'nro_espaco': espaco_esportivo,
                'tipo': tipo,
                'contrato': contrato,
                'status': 'MARCADA', # default status
                'funcionario_responsavel': 1  # exemplo
            }

            # Insert data into the database
            db = Database()
            try:
                db.insert_maintenance(data)
                Utils.show_info("Sucesso", "Manutenção salva com sucesso!")
            except Exception as e:
                print("Erro ao salvar Manutenção:", e)
                Utils.show_error("Erro de Banco de Dados", "Erro ao salvar Manutenção: " + str(e))
            finally:
                db.close()
        except ValueError as ve:
            Utils.show_error("Erro de Validação", str(ve))
        except Exception as e:
            print("Erro inesperado:", e)
            Utils.show_error("Erro Inesperado", "Ocorreu um erro inesperado: " + str(e))
        
