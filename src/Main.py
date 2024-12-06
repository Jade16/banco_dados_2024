import customtkinter as ctk
from frontend.widgets.MainFrame import MainFrame

class App(ctk.CTk):
    def __init__(self):
        super().__init__()
        self.title("Sistema de Reservas Esportivas")
        self.geometry("1080x600")
        self.resizable(False, False)

        # Iniciar tela no centro
        self._center_window(1080, 600)

        # Inicializar o frame principal
        self.main_frame = MainFrame(self)
        self.main_frame.pack(fill="both", expand=True)
        
        self.bind_all("<1>", lambda event: self._callback_focus(event)) # Remove o foco de widgets ao clicar fora deles

    def _center_window(self, width, height):
        screen_width = self.winfo_screenwidth()
        screen_height = self.winfo_screenheight()
        x = int(screen_width / 2 - width / 2)
        y = int(screen_height / 2 - height / 2)
        self.geometry(f"{width}x{height}+{x}+{y}")
    
    def _callback_focus(self, event):
        try:    event.widget.focus_set()
        except: pass

if __name__ == '__main__':
    app = App()
    app.mainloop()

