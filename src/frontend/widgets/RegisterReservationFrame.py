import customtkinter as ctk
from frontend.Settings import *
from backend.db_connection import Database  # Import the Database class
from frontend.Utils import Utils
import re

class RegisterReservationFrame(ctk.CTkFrame):
    def __init__(self, master):
        super().__init__(master)
        self.configure(fg_color=GRAY, corner_radius=10)

        self.scroll_frame, self.bottom_frame = Utils.configure_layout(self, "Cadastro de Reserva")

        self._create_widgets()


    def _create_widgets(self):
        # Form fields
        self.entry_user = Utils.insert_entry(self.scroll_frame, "ID Usuário:", placeholder="Digite o ID do usuário")
        
        # Comboboxes
        self.combobox_installation = Utils.insert_combobox(self.scroll_frame, "Instalação Esportiva:", values=["Carregando..."], command=self._update_spaces)
        self.combobox_space = Utils.insert_combobox(self.scroll_frame, "Espaço Esportivo:", values=["Selecione uma instalação"])
        
        # Load installations in the combobox
        self._load_installations()

        self.entry_type = Utils.insert_entry(self.scroll_frame, "Tipo de Reserva:", placeholder="Digite o tipo de reserva (ex: Futebol, Basquete)")
        self.entry_people = Utils.insert_entry(self.scroll_frame, "Quantidade de Pessoas:", placeholder="Digite a quantidade de pessoas")
        self.entry_date = Utils.insert_entry(self.scroll_frame, "Data da Reserva:", placeholder="DD/MM/AAAA")
        self.entry_start_time = Utils.insert_entry(self.scroll_frame, "Horário de Início:", placeholder="HH:MM")
        self.entry_end_time = Utils.insert_entry(self.scroll_frame, "Horário de Término:", placeholder="HH:MM")

        form_entry = [
            self.entry_user,
            self.entry_type,
            self.entry_people,
            self.entry_date,
            self.entry_start_time,
            self.entry_end_time
        ]
        
        form_combobox = [
            self.combobox_installation,
            self.combobox_space
        ]
        
        # Save and clear buttons
        Utils.insert_save_button(self.bottom_frame, self._save_reservation)
        Utils.insert_clear_button(self.bottom_frame, lambda: Utils.clear_form(form_entry=form_entry, form_combobox=form_combobox))

    def _load_installations(self):
        """
        Load CNPJs of sports facilities from the database into the combobox.
        """
        db = Database()
        try:
            db.cursor.execute("SELECT CNPJ FROM Instalacao_Esportiva")
            installations = [row[0] for row in db.cursor.fetchall()]
            # inserir "Selecione uma instalação" no início da lista
            installations.insert(0, "Selecione uma instalação")
            self.combobox_installation.set("Selecione uma instalação")
            if installations:
                self.combobox_installation.configure(values=installations)
            else:
                self.combobox_installation.configure(values=["Nenhuma instalação encontrada"])
        except Exception as e:
            print("Erro ao carregar instalações:", e)
            Utils.show_error("Erro de Banco de Dados", "Erro ao carregar instalações: " + str(e))
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
            db.cursor.execute("SELECT Nro_Espaco, Tipo FROM Espaco_Esportivo WHERE Instalacao = :cnpj", {'cnpj': selected_cnpj})
            name_spaces = [f"{str(row[0])} - {str(row[1])}" for row in db.cursor.fetchall()]
            if name_spaces:
                self.combobox_space.configure(values=name_spaces)
            else:
                self.combobox_space.configure(values=["Nenhum espaço disponível"])
        except Exception as e:
            print("Erro ao carregar espaços esportivos:", e)
            Utils.show_error("Erro de Banco de Dados", "Erro ao carregar espaços esportivos: " + str(e))
        finally:
            db.close()

    def _save_reservation(self):
        # Collect data from form fields
        try:
            usuario = self.entry_user.get()
            instalacao_esportiva = self.combobox_installation.get()
            espaco_esportivo = self.combobox_space.get().split("-")[0] # pegar o id do espaço esportivo (self.combobox_space.get() retorna: 1 - Futebol)
            tipo_reserva = self.entry_type.get()
            quantidade_pessoas = self.entry_people.get()
            data_reserva = self.entry_date.get()
            horario_inicio = self.entry_start_time.get()
            horario_termino = self.entry_end_time.get()
            
            
            
            
            # Tratar se o formato da data está em DD/MM/AAAA
            if not re.match(r"\d{2}/\d{2}/\d{4}", data_reserva) and data_reserva != "":
                Utils.show_error("Erro de Validação", "Formato de data inválido. Use DD/MM/AAAA.")
                return

            # Fetch user ID based on username
            usuario_id, usuario_nome = self.get_user(usuario)

            # Prepare data dictionary
            data = {
                'data_reserva': data_reserva,
                'hora_inicio': horario_inicio,
                'hora_termino': horario_termino,
                'instalacao': instalacao_esportiva,
                'nro_espaco': espaco_esportivo,
                'usuario_id': usuario_id,
                'nome_reserva': f'Reserva de {usuario_nome}',
                'quantidade_pessoas': quantidade_pessoas,
                'tipo': tipo_reserva,
                'funcionario_responsavel': 1  # exemplo
            }

            # Insert data into the database
            db = Database()
            try:
                db.insert_reservation(data)
                Utils.show_info("Sucesso", "Reserva salva com sucesso!")
            except Exception as e:
                print("Erro ao salvar reserva:", e)
                Utils.show_error("Erro de Banco de Dados", "Erro ao salvar reserva: " + str(e))
            finally:
                db.close()
        except ValueError as ve:
            Utils.show_error("Erro de Validação", str(ve))
        except Exception as e:
            print("Erro inesperado:", e)
            Utils.show_error("Erro Inesperado", "Ocorreu um erro inesperado: " + str(e))

    def get_user(self, user_id):
        """
        Fetches the user ID based on the username.
        You need to implement this method to fetch the U_ID from the database.
        """
        db = Database()
        try:
            db.cursor.execute("SELECT U_ID, NOME FROM Usuario WHERE U_ID = :u_id", {'u_id': user_id})
            result = db.cursor.fetchone()
            if result:
                return result[0], result[1]
            else:
                Utils.show_error("Erro de Validação", "Usuário não encontrado.")
                # raise ValueError("Usuário não encontrado.")
        except Exception as e:
            print("Erro ao buscar usuário:", e)
            Utils.show_error("Erro de Banco de Dados", "Erro ao buscar usuário: " + str(e))
            # raise
        finally:
            db.close()
        
