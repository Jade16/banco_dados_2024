import customtkinter as ctk
from frontend.Settings import *

class ConsultationFrame(ctk.CTkFrame):
    def __init__(self, master):
        super().__init__(master)
        self.configure(fg_color=GRAY)

        # Configurar layout
        self.columnconfigure(0, weight=1)
        self.rowconfigure((0, 1, 2, 3), weight=1)

        self._create_widgets()

    def _create_widgets(self):
        # Campo de busca
        self.label_search = ctk.CTkLabel(self, text="Pesquisar:")
        self.label_search.grid(row=0, column=0, pady=5, padx=10, sticky="w")
        self.entry_search = ctk.CTkEntry(self)
        self.entry_search.grid(row=1, column=0, pady=5, padx=10, sticky="ew")

        self.btn_search = ctk.CTkButton(self, text="Buscar", command=self._perform_search)
        self.btn_search.grid(row=2, column=0, pady=5, padx=10, sticky="e")

        # Área de resultados
        self.results_frame = ctk.CTkScrollableFrame(self, fg_color=BLACK)
        self.results_frame.grid(row=3, column=0, pady=10, padx=10, sticky="nsew")

    def _perform_search(self):
        # Lógica para buscar no banco de dados Oracle SQL
        # Substitua este print pela lógica de conexão e consulta no banco
        search_term = self.entry_search.get()
        print(f"Buscando por: {search_term}")

        # Exemplo de resultados (substitua pela consulta real)
        self._display_results([
            {"tipo": "Reserva", "espaco": "Quadra 1", "data": "2023-11-01", "detalhes": "Horário: 10h-12h"},
            {"tipo": "Manutenção", "espaco": "Campo 2", "data": "2023-11-02", "detalhes": "Reparos no gramado"},
        ])

    def _display_results(self, results):
        # Limpar resultados anteriores
        for widget in self.results_frame.winfo_children():
            widget.destroy()

        # Exibir novos resultados
        for result in results:
            result_label = ctk.CTkLabel(
                self.results_frame,
                text=f"{result['tipo']} - {result['espaco']} - {result['data']} - {result['detalhes']}",
                anchor="w"
            )
            result_label.pack(fill="x", pady=5)
