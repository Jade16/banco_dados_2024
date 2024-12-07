import cx_Oracle
import platform

class Database:
    def __init__(self):
        try:
            # No Linux, não chame init_oracle_client se o LD_LIBRARY_PATH estiver configurado
            if platform.system() == "Windows" and not cx_Oracle.clientversion():
                cx_Oracle.init_oracle_client(lib_dir=r"C:\\oracle\\instantclient_23_6")
        except Exception as e:
            print("Erro ao inicializar o cliente Oracle:", e)
               
        # Update these with your Oracle DB credentials
        self.dsn = cx_Oracle.makedsn(
            host="orclgrad1.icmc.usp.br",
            port=1521,
            service_name="pdb_elaine.icmc.usp.br"
        )
        self.connection = cx_Oracle.connect(
            user="a13696679",
            password="senhafoda.123",
            dsn=self.dsn
        )
        self.cursor = self.connection.cursor()

    def insert_reservation(self, data):
        """
        Inserts reservation data into the database.
        :param data: A dictionary containing reservation details.
        """
        # Generate a new ID_Reserva
        self.cursor.execute("SELECT NVL(MAX(ID_Reserva), 0) + 1 FROM Reserva")
        new_id_reserva = self.cursor.fetchone()[0]

        # Prepare SQL statements
        insert_reserva_sql = """
        INSERT INTO Reserva (
            ID_Reserva,
            Data_Reserva,
            Hora_Inicio,
            Hora_Termino,
            Instalacao,
            Nro_Espaco,
            Tipo_Reserva
        ) VALUES (
            :id_reserva,
            TO_DATE(:data_reserva, 'DD/MM/YYYY'),
            TO_TIMESTAMP(:hora_inicio, 'HH24:MI'),
            TO_TIMESTAMP(:hora_termino, 'HH24:MI'),
            :instalacao,
            :nro_espaco,
            :tipo_reserva
        )
        """

        insert_reserva_esportiva_sql = """
        INSERT INTO Reserva_Esportiva (
            ID_Reserva,
            Usuario,
            Nome_Reserva,
            Quantidade_Pessoas,
            Tipo,
            Funcionario_Responsavel,
            Aprovado
        ) VALUES (
            :id_reserva,
            :usuario,
            :nome_reserva,
            :quantidade_pessoas,
            :tipo,
            :funcionario_responsavel,
            :aprovado
        )
        """

        # Bind parameters
        reserva_params = {
            'id_reserva': new_id_reserva,
            'data_reserva': data['data_reserva'],
            'hora_inicio': data['hora_inicio'],
            'hora_termino': data['hora_termino'],
            'instalacao': data['instalacao'],
            'nro_espaco': data['nro_espaco'],
            'tipo_reserva': 'RESERVA ESPORTIVA'
        }

        reserva_esportiva_params = {
            'id_reserva': new_id_reserva,
            'usuario': data['usuario_id'],
            'nome_reserva': data['nome_reserva'],
            'quantidade_pessoas': data.get('quantidade_pessoas'),
            'tipo': data.get('tipo'),
            'funcionario_responsavel': data['funcionario_responsavel'],
            'aprovado': 'EM ANALISE'
        }

        try:
            # Execute insertion queries
            self.cursor.execute(insert_reserva_sql, reserva_params)
            self.cursor.execute(insert_reserva_esportiva_sql, reserva_esportiva_params)
            self.connection.commit()
        except cx_Oracle.DatabaseError as e:
            error, = e.args
            print("Oracle-Error-Code:", error.code)
            print("Oracle-Error-Message:", error.message)
            self.connection.rollback()
            raise
    
    def insert_maintenance(self, data):
        """
        Inserts maintenance data and its associated reservation into the database.
        :param data: A dictionary containing reservation and maintenance details.
        """
        # Generate a new ID_Reserva
        self.cursor.execute("SELECT NVL(MAX(ID_Reserva), 0) + 1 FROM Reserva")
        new_id_reserva = self.cursor.fetchone()[0]

        # Prepare SQL for Reserva
        insert_reserva_sql = """
        INSERT INTO Reserva (
            ID_Reserva,
            Data_Reserva,
            Hora_Inicio,
            Hora_Termino,
            Instalacao,
            Nro_Espaco,
            Tipo_Reserva
        ) VALUES (
            :id_reserva,
            TO_DATE(:data_reserva, 'DD/MM/YYYY'),
            TO_TIMESTAMP(:hora_inicio, 'HH24:MI'),
            TO_TIMESTAMP(:hora_termino, 'HH24:MI'),
            :instalacao,
            :nro_espaco,
            :tipo_reserva
        )
        """

        # Prepare SQL for Manutencao
        insert_manutencao_sql = """
        INSERT INTO Manutencao (
            ID_Reserva,
            Contrato,
            Tipo,
            Status
        ) VALUES (
            :id_reserva,
            :contrato,
            :tipo,
            :status
        )
        """

        # Bind parameters for Reserva
        reserva_params = {
            'id_reserva': new_id_reserva,
            'data_reserva': data['data_reserva'],
            'hora_inicio': data['hora_inicio'],
            'hora_termino': data['hora_termino'],
            'instalacao': data['instalacao'],
            'nro_espaco': data['nro_espaco'],
            'tipo_reserva': 'MANUTENÇÃO'
        }

        # Bind parameters for Manutencao
        manutencao_params = {
            'id_reserva': new_id_reserva,
            'contrato': data['contrato'],
            'tipo': data.get('tipo', None),
            'status': data['status'].upper()  # Ensure the status is uppercase to match the constraint
        }

        try:
            # Insert into Reserva
            self.cursor.execute(insert_reserva_sql, reserva_params)

            # Insert into Manutencao
            self.cursor.execute(insert_manutencao_sql, manutencao_params)

            # Commit the transaction
            self.connection.commit()
            print(f"Manutenção registrada com ID de reserva {new_id_reserva}.")
        except cx_Oracle.DatabaseError as e:
            error, = e.args
            print("Oracle-Error-Code:", error.code)
            print("Oracle-Error-Message:", error.message)
            self.connection.rollback()
            raise


    def close(self):
        self.cursor.close()
        self.connection.close()
