import cx_Oracle
import platform

class Database:

    def __init__(self):
        try:
            # No Linux, não chame init_oracle_client se o LD_LIBRARY_PATH estiver configurado
            if platform.system() == "Windows" and not cx_Oracle.clientversion():
                cx_Oracle.init_oracle_client(lib_dir=r"C:\\oracle\\instantclient_23_6") # Altere para o diretório do seu Instant Client
        except Exception as e:
            print("Erro ao inicializar o cliente Oracle:", e)
               
        # Update these with your Oracle DB credentials
        self.dsn = cx_Oracle.makedsn(
            host="orclgrad1.icmc.usp.br",
            port=1521,
            service_name="pdb_elaine.icmc.usp.br"
        )
        self.connection = cx_Oracle.connect(
            user="aNUSP",
            password="senha",
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
    
    def search_reservations(self, filters):
        """
        This method searches for reservations based on the given filters.
        :param filters: A dictionary containing filters for the query.
        :return: A list of reservations that match the given filters.
        """

        query = """
        SELECT
            r.ID_Reserva,
            r.Data_Reserva,
            r.Hora_Inicio,
            r.Hora_Termino,
            r.Instalacao,
            r.Nro_Espaco,
            r.Tipo_Reserva,
            i.Nome AS Nome_Instalacao,
            c.Nome AS Nome_Cidade,
            e.Tipo AS Tipo_Espaco
        FROM Reserva r
        JOIN Instalacao_Esportiva i ON r.Instalacao = i.CNPJ
        JOIN Cidade c ON i.Cidade = c.Codigo_Municipio
        JOIN Espaco_Esportivo e ON r.Instalacao = e.Instalacao AND r.Nro_Espaco = e.Nro_Espaco
        WHERE 1=1
        """
        params = {}
        if filters.get('reservation_date'):
            query += " AND r.Data_Reserva = TO_DATE(:reservation_date, 'DD/MM/YYYY')"
            params['reservation_date'] = filters['reservation_date']
        if filters.get('installation'):
            query += " AND r.Instalacao = :installation"
            params['installation'] = filters['installation']
        if filters.get('space'):
            query += " AND r.Nro_Espaco = :space"
            params['space'] = filters['space']

        try:
            self.cursor.execute(query, params)
            return self.cursor.fetchall()
        except cx_Oracle.DatabaseError as e:
            error, = e.args
            print("Oracle-Error-Code:", error.code)
            print("Oracle-Error-Message:", error.message)
            raise
    
    def get_installations(self):
        """
        Get a list of all installations in the database.
        """
        query = "SELECT CNPJ FROM Instalacao_Esportiva"
        self.cursor.execute(query)
        return [row[0] for row in self.cursor.fetchall()]
    
    def get_spaces(self, installation):
        """
        Get a list of all spaces in the given installation.
        """
        query = "SELECT Nro_Espaco, Tipo FROM Espaco_Esportivo WHERE Instalacao = :cnpj"
        self.cursor.execute(query, {'cnpj': installation})
        return [f"{row[0]} - {row[1]}" for row in self.cursor.fetchall()]

    def get_user(self, user_id):
        """
        Get the user ID and name based on the user ID.
        """
        self.cursor.execute("SELECT U_ID, NOME FROM Usuario WHERE U_ID = :u_id", {'u_id': user_id})
        return self.cursor.fetchone()
    
    def get_contracts(self):
        """
        Get a list of all contract IDs in the database.
        """
        self.cursor.execute("SELECT ID_Contrato FROM Contrato")
        return [str(row[0]) for row in self.cursor.fetchall()]

    def close(self):
        self.cursor.close()
        self.connection.close()
