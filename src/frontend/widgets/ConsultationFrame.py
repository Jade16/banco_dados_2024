import customtkinter as ctk
from frontend.Settings import *
from backend.db_connection import Database
from frontend.Utils import Utils
import re

class ConsultationFrame(ctk.CTkFrame):
    def __init__(self, master):
        super().__init__(master)
        self.configure(fg_color=GRAY, corner_radius=10)

        self.scroll_frame, self.filter_frame, self.bottom_frame = Utils.configure_search_layout(self, "Consulta de Reservas")
        self._create_widgets()

    def _create_widgets(self):
        # Filtros
        self.entry_date = Utils.insert_entry(self.filter_frame, "Data:", placeholder="DD/MM/AAAA")
        self.combobox_installation = Utils.insert_combobox(
            self.filter_frame, "Instalação Esportiva:", values=["Carregando..."], command=self._update_spaces
        )
        self.combobox_space = Utils.insert_combobox(
            self.filter_frame, "Espaço Esportivo:", values=["Selecione uma instalação"]
        )

        # Botões
        Utils.insert_search_button(self.bottom_frame, self._perform_search)
        Utils.insert_clear_button(self.bottom_frame, self._clear_filters)

        # Carregar instalações esportivas no combobox
        self._load_installations()

    def _load_installations(self):
        """
        Carrega as instalações esportivas no combobox.
        """
        db = Database()
        try:
            installations = db.get_installations()
            installations.insert(0, "Selecione uma instalação")
            self.combobox_installation.set("Selecione uma instalação")
            self.combobox_installation.configure(values=installations)
        except Exception as e:
            print("Erro ao carregar instalações:", e)
            Utils.show_error("Erro de Banco de Dados", f"Erro ao carregar instalações: {str(e)}")
        finally:
            db.close()

    def _update_spaces(self, event):
        """
        Atualiza o combobox de espaços esportivos com base na instalação selecionada.
        """
        selected_cnpj = self.combobox_installation.get()
        if not selected_cnpj or selected_cnpj == "Selecione uma instalação":
            self.combobox_space.configure(values=["Selecione uma instalação"])
            self.combobox_space.set("Selecione uma instalação")
            return

        db = Database()
        try:
            spaces = db.get_spaces(selected_cnpj)
            # adicionar "Selecione um espaço" no início da lista
            if spaces:
                spaces.insert(0, "Selecione um espaço")
                self.combobox_space.set("Selecione um espaço")
                self.combobox_space.configure(values=spaces)
            else:
                self.combobox_space.configure(values=["Nenhum espaço disponível"])
        except Exception as e:
            print("Erro ao carregar espaços esportivos:", e)
            Utils.show_error("Erro de Banco de Dados", f"Erro ao carregar espaços esportivos: {str(e)}")
        finally:
            db.close()

    def _perform_search(self):
        """
        Coleta os filtros preenchidos e chama a função de consulta no banco.
        """
        default_installations = ["Selecione uma instalação", "Nenhuma instalação encontrada", "Selecione um item"]
        default_spaces = ["Selecione um espaço", "Nenhum espaço disponível", "Selecione uma instalação", "Selecione um item"]
        filters = {
            'reservation_date': self.entry_date.get(),
            'installation': self.combobox_installation.get() if self.combobox_installation.get() not in default_installations else None,
            'space': self.combobox_space.get().split(" - ")[0] if self.combobox_space.get() not in default_spaces else None,
        }

        # Validação de filtros obrigatórios
        if not filters['reservation_date'] and not filters['installation']:
            Utils.show_error("Erro de Validação", "Preencha pelo menos o filtro de Data ou Instalação Esportiva.")
            return

        if filters['reservation_date'] and not re.match(r"\d{2}/\d{2}/\d{4}", filters['reservation_date']):
            Utils.show_error("Erro de Validação", "Formato de data inválido. Use DD/MM/AAAA.")
            return

        db = Database()
        try:
            results = db.search_reservations(filters)
            self._display_results(results)
        except Exception as e:
            print("Erro ao realizar a consulta:", e)
            Utils.show_error("Erro de Banco de Dados", f"Erro ao realizar a consulta: {str(e)}")
        finally:
            db.close()

    def _display_results(self, results):
        # Limpa resultados anteriores
        for widget in self.scroll_frame.winfo_children():
            widget.destroy()

        if not results:
            Utils.show_info("Consulta Finalizada", "Nenhuma reserva encontrada com os filtros selecionados.")
            return

        for row in results:
            (id_reserva, data_reserva, hora_inicio, hora_termino,
            instalacao, nro_espaco, tipo_reserva,
            nome_instalacao, nome_cidade, tipo_espaco) = row

            card = ctk.CTkFrame(self.scroll_frame, fg_color=WHITE, corner_radius=8)
            card.pack(fill="x", padx=16, pady=8)
            text_color = BLACK
            ctk.CTkLabel(card, text=f"ID Reserva: {id_reserva}", font=H5, text_color=text_color).pack(anchor="w", padx=16, pady=4)
            ctk.CTkLabel(card, text=f"Data: {data_reserva.strftime('%d/%m/%Y')}", font=H5, text_color=text_color).pack(anchor="w", padx=16, pady=4)
            ctk.CTkLabel(card, text=f"Horário: {hora_inicio.strftime('%H:%M')} - {hora_termino.strftime('%H:%M')}", 
                         font=H5, text_color=text_color).pack(anchor="w", padx=16, pady=4)
            ctk.CTkLabel(card, text=f"Instalação: {nome_instalacao}", font=H5, text_color=text_color).pack(anchor="w", padx=16, pady=4)
            ctk.CTkLabel(card, text=f"CNPJ: {instalacao}", font=H5, text_color=text_color).pack(anchor="w", padx=16, pady=4)
            ctk.CTkLabel(card, text=f"Cidade: {nome_cidade}", font=H5, text_color=text_color).pack(anchor="w", padx=16, pady=4)
            ctk.CTkLabel(card, text=f"Espaço Esportivo: {tipo_espaco}", font=H5, text_color=text_color).pack(anchor="w", padx=16, pady=4)
            ctk.CTkLabel(card, text=f"Tipo de Reserva: {tipo_reserva}", font=H5, text_color=text_color).pack(anchor="w", padx=16, pady=4)


    def _clear_filters(self):
        """
        Limpa os filtros da tela e os cards da busca.
        """
        Utils.clear_form(form_entry=[self.entry_date], form_combobox=[self.combobox_installation, self.combobox_space])
        for widget in self.scroll_frame.winfo_children():
            widget.destroy()

