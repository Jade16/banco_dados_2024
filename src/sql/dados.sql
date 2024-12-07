-- Inserção de dados na tabela Empresa_Manutencao
INSERT INTO Empresa_Manutencao (CNPJ, Tipo_Empresa, Proprietario, Orgao_Vinculado, Nome_Fantasia)
  VALUES ('79.444.789/0001-48', 'PÚBLICA', 'Governo Estadual', 'Secretaria de Esportes', 'Estádio Cidade');
INSERT INTO Empresa_Manutencao (CNPJ, Tipo_Empresa, Proprietario, Orgao_Vinculado, Nome_Fantasia)
  VALUES ('91.556.987/0001-49', 'PRIVADA', 'João Silva', 'N/A', 'Esportes XYZ');
INSERT INTO Empresa_Manutencao (CNPJ, Tipo_Empresa, Proprietario, Orgao_Vinculado, Nome_Fantasia)
  VALUES ('57.245.785/0001-11', 'PRIVADA', 'Carlos Camargo Rodrigues', 'N/A', 'Luzes Elétricas');
INSERT INTO Empresa_Manutencao (CNPJ, Tipo_Empresa, Proprietario, Orgao_Vinculado, Nome_Fantasia)
  VALUES ('78.325.698/0001-00', 'PRIVADA', 'Joana Josias', 'N/A', 'TIBUM! Piscinas');

-- Inserção de dados na tabela Servicos_Empresa
INSERT INTO Servicos_Empresa (Empresa, Servico)
  VALUES ('79.444.789/0001-48', 'Manutenção de campo');
INSERT INTO Servicos_Empresa (Empresa, Servico)
  VALUES ('91.556.987/0001-49', 'Treinamento de equipes');
INSERT INTO Servicos_Empresa (Empresa, Servico)
  VALUES ('57.245.785/0001-11', 'Troca de lâmpadas');
INSERT INTO Servicos_Empresa (Empresa, Servico)
  VALUES ('57.245.785/0001-11', 'Manutenção da rede elétrica');
INSERT INTO Servicos_Empresa (Empresa, Servico)
  VALUES ('78.325.698/0001-00', 'Manutenção de piscina');

-- Inserção de dados na tabela Telefones_Empresa
INSERT INTO Telefones_Empresa (Empresa, Telefone)
  VALUES ('79.444.789/0001-48', '(11) 987654321');
INSERT INTO Telefones_Empresa (Empresa, Telefone)
  VALUES ('91.556.987/0001-49', '(21) 912345678');
INSERT INTO Telefones_Empresa (Empresa, Telefone)
  VALUES ('57.245.785/0001-11', '(16) 36089897');
INSERT INTO Telefones_Empresa (Empresa, Telefone)
  VALUES ('78.325.698/0001-00', '(19) 988657485');
INSERT INTO Telefones_Empresa (Empresa, Telefone)
  VALUES ('78.325.698/0001-00', '(19) 35897542');


-- Inserção de dados na tabela Cidade
INSERT INTO Cidade (Codigo_Municipio, Nome, UF)
  VALUES ('1234567', 'São Paulo', 'SP');
INSERT INTO Cidade (Codigo_Municipio, Nome, UF)
  VALUES ('7654321', 'Rio de Janeiro', 'RJ');
INSERT INTO Cidade (Codigo_Municipio, Nome, UF)
  VALUES ('3543907', 'Rio Claro', 'SP');
INSERT INTO Cidade (Codigo_Municipio, Nome, UF)
  VALUES ('3548906', 'São Carlos', 'SP');

-- Inserção de dados na tabela Gestor_Esportivo
INSERT INTO Gestor_Esportivo (F_ID, Cidade, Endereco_Rua, Endereco_Numero, Endereco_Bairro, Endereco_CEP, RG, CPF, Nro_Carteira_Trabalho, Data_Contratacao, Telefone_1, Telefone_2)
  VALUES (1, '1234567', 'Rua do Estádio', 100, 'Centro', '01000-000', '12.345.678-9', '123.456.789-00', '12345', TO_DATE('01/01/2020', 'DD/MM/YYYY'), '(11) 123456789', '(11) 987654321');
INSERT INTO Gestor_Esportivo (F_ID, Cidade, Endereco_Rua, Endereco_Numero, Endereco_Bairro, Endereco_CEP, RG, CPF, Nro_Carteira_Trabalho, Data_Contratacao, Telefone_1, Telefone_2)
  VALUES (2, '7654321', 'Avenida Maracanã', 200, 'Zona Norte', '20500-000', '98.765.432-1', '987.654.321-00', '67890', TO_DATE('15/05/2021', 'DD/MM/YYYY'), '(21) 234567890', '(21) 998765432');
INSERT INTO Gestor_Esportivo (F_ID, Cidade, Endereco_Rua, Endereco_Numero, Endereco_Bairro, Endereco_CEP, RG, CPF, Nro_Carteira_Trabalho, Data_Contratacao, Telefone_1, Telefone_2)
  VALUES (3, '3543907', 'Avenida 1A', 1560, 'Cidade Nova', '13506-537', '60.754.955-A5', '154.265.956-35', '875642', TO_DATE('10/08/2022', 'DD/MM/YYYY'), '(19) 975486235', '(19) 36587985');
INSERT INTO Gestor_Esportivo (F_ID, Cidade, Endereco_Rua, Endereco_Numero, Endereco_Bairro, Endereco_CEP, RG, CPF, Nro_Carteira_Trabalho, Data_Contratacao, Telefone_1, Telefone_2)
  VALUES (4, '3548906', 'Rua Miguel Petroni', 50, 'Jardim Bandeirantes', '13562-190', '68.524.789-9', '235.468.751-96', '983265', TO_DATE('20/02/2018', 'DD/MM/YYYY'), '(16)987564123', '(16) 998715623');

-- Inserção de dados na tabela Contrato
INSERT INTO Contrato (ID_Contrato, Empresa, Gestor, Data, Orcamento, Periodo_Contrato)
  VALUES (1, '79.444.789/0001-48', 1, TO_DATE('01/06/2023', 'DD/MM/YYYY'), 50000, '1 ano');
INSERT INTO Contrato (ID_Contrato, Empresa, Gestor, Data, Orcamento, Periodo_Contrato)
  VALUES (2, '91.556.987/0001-49', 2, TO_DATE('01/07/2023', 'DD/MM/YYYY'), 30000, '6 meses');
INSERT INTO Contrato (ID_Contrato, Empresa, Gestor, Data, Orcamento, Periodo_Contrato)
  VALUES (3, '57.245.785/0001-11', 4, TO_DATE('01/03/2021', 'DD/MM/YYYY'), 400000, '4 anos');
INSERT INTO Contrato (ID_Contrato, Empresa, Gestor, Data, Orcamento, Periodo_Contrato)
  VALUES (4, '78.325.698/0001-00', 3, TO_DATE('01/05/2024', 'DD/MM/YYYY'), 90000, '1 ano');


-- Inserção de dados na tabela Servicos_Contrato
INSERT INTO Servicos_Contrato (Contrato, Servico)
  VALUES (1, 'Manutenção de campo');
INSERT INTO Servicos_Contrato (Contrato, Servico)
  VALUES (2, 'Treinamento de equipes');
INSERT INTO Servicos_Contrato (Contrato, Servico)
  VALUES (3, 'Manutenção da rede elétrica');
INSERT INTO Servicos_Contrato (Contrato, Servico)
  VALUES (3, 'Fornecimento e troca de lâmpadas');
INSERT INTO Servicos_Contrato (Contrato, Servico)
  VALUES (4, 'Manutenção e limpeza das piscinas');

-- Inserção de dados na tabela Instalacao_Esportiva
INSERT INTO Instalacao_Esportiva (CNPJ, Nome, Cidade, Endereco_Rua, Endereco_Numero, Endereco_Bairro, Endereco_CEP)
  VALUES ('12.345.678/0001-90', 'Estádio Municipal', '1234567', 'Rua do Estádio', '100', 'Centro', '01000-000');
INSERT INTO Instalacao_Esportiva (CNPJ, Nome, Cidade, Endereco_Rua, Endereco_Numero, Endereco_Bairro, Endereco_CEP)
  VALUES ('98.765.432/0001-98', 'Arena Futebol', '7654321', 'Avenida Maracanã', '200', 'Zona Norte', '20500-000');
INSERT INTO Instalacao_Esportiva (CNPJ, Nome, Cidade, Endereco_Rua, Endereco_Numero, Endereco_Bairro, Endereco_CEP)
  VALUES ('65.123.456/0001-33', 'Lazer e Esportes', '3543907', 'Rua 1B', '200', 'Centro', '13784-000');
INSERT INTO Instalacao_Esportiva (CNPJ, Nome, Cidade, Endereco_Rua, Endereco_Numero, Endereco_Bairro, Endereco_CEP)
  VALUES ('32.654.987/0001-89', 'Clube Esporte Vida', '3548906', 'Av. São Carlos', '1000', 'Vila Bela', '13568-975');

-- Inserção de dados na tabela Funcionario_Instalacao
INSERT INTO Funcionario_Instalacao (F_ID, Nome, CPF, RG, Nro_Carteira_Trabalho, Data_Contratacao, Instalacao_Esportiva, Telefone1, Telefone2)
  VALUES (1, 'Carlos Souza', '123.456.789-00', '12.345.678-9', '12345', TO_DATE('01/01/2020', 'DD/MM/YYYY'), '12.345.678/0001-90', '(11) 123456789', '(11) 987654321');
INSERT INTO Funcionario_Instalacao (F_ID, Nome, CPF, RG, Nro_Carteira_Trabalho, Data_Contratacao, Instalacao_Esportiva, Telefone1, Telefone2)
  VALUES (2, 'Ana Costa', '987.654.321-00', '98.765.432-1', '67890', TO_DATE('15/05/2021', 'DD/MM/YYYY'), '98.765.432/0001-98', '(21) 234567890', '(21) 998765432');
INSERT INTO Funcionario_Instalacao (F_ID, Nome, CPF, RG, Nro_Carteira_Trabalho, Data_Contratacao, Instalacao_Esportiva, Telefone1, Telefone2)
  VALUES (3, 'Carolina Amaral de Andrade', '895.564.231-00', '45.789.456-B', '456123', TO_DATE('10/01/2017', 'DD/MM/YYYY'), '65.123.456/0001-33', '(19)999885566', '(19) 30629584');
INSERT INTO Funcionario_Instalacao (F_ID, Nome, CPF, RG, Nro_Carteira_Trabalho, Data_Contratacao, Instalacao_Esportiva, Telefone1, Telefone2)
  VALUES (4, 'José Carlos dos Santos', '741.852.963-88', '89.456.89A-F', '852369', TO_DATE('15/11/2022', 'DD/MM/YYYY'), '32.654.987/0001-89', '(16) 965874578', '(16) 65983265');

-- Inserção de dados na tabela Espaco_Esportivo
INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
  VALUES ('12.345.678/0001-90', 1, 'Campo de Futebol');
INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
  VALUES ('98.765.432/0001-98', 1, 'Quadra de Basquete');
INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
  VALUES ('65.123.456/0001-33', 1, 'Quadra de Volêi');
INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
  VALUES ('65.123.456/0001-33', 2, 'Quadra de Futsal');
INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
  VALUES ('65.123.456/0001-33', 3, 'Piscina Olímpica');

INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
  VALUES ('12.345.678/0001-90', 2, 'Quadra de Basquete');
INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
  VALUES ('12.345.678/0001-90', 3, 'Quadra de Tenis');
INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
  VALUES ('98.765.432/0001-98', 2, 'Quadra de Futebol de Campo');
INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
  VALUES ('98.765.432/0001-98', 3, 'Piscina Olímpica');
INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
  VALUES ('12.345.678/0001-90', 4, 'Piscina Infantil');
INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
  VALUES ('65.123.456/0001-33', 4, 'Quadra Poliesportiva');  

-- Inserção de dados na tabela Reserva
INSERT INTO Reserva (ID_Reserva, Data_Reserva, Hora_Inicio, Hora_Termino, Instalacao, Nro_Espaco, Tipo_Reserva)
  VALUES (1, TO_DATE('15/12/2024', 'DD/MM/YYYY'), TO_TIMESTAMP('08:00', 'HH24:MI'), TO_TIMESTAMP('10:00', 'HH24:MI'), '12.345.678/0001-90', 1, 'RESERVA ESPORTIVA');
INSERT INTO Reserva (ID_Reserva, Data_Reserva, Hora_Inicio, Hora_Termino, Instalacao, Nro_Espaco, Tipo_Reserva)
  VALUES (2, TO_DATE('16/12/2024', 'DD/MM/YYYY'), TO_TIMESTAMP('14:00', 'HH24:MI'), TO_TIMESTAMP('16:00', 'HH24:MI'), '98.765.432/0001-98', 1, 'MANUTENÇÃO');
INSERT INTO Reserva (ID_Reserva, Data_Reserva, Hora_Inicio, Hora_Termino, Instalacao, Nro_Espaco, Tipo_Reserva)
  VALUES (3, TO_DATE('20/01/2023', 'DD/MM/YYYY'), TO_TIMESTAMP('08:00', 'HH24:MI'), TO_TIMESTAMP('12:00', 'HH24:MI'), '98.765.432/0001-98', 3, 'MANUTENÇÃO');
INSERT INTO Reserva (ID_Reserva, Data_Reserva, Hora_Inicio, Hora_Termino, Instalacao, Nro_Espaco, Tipo_Reserva)
  VALUES (4, TO_DATE('16/02/2025', 'DD/MM/YYYY'), TO_TIMESTAMP('13:00', 'HH24:MI'), TO_TIMESTAMP('15:00', 'HH24:MI'), '12.345.678/0001-90', 4, 'RESERVA ESPORTIVA');
INSERT INTO Reserva (ID_Reserva, Data_Reserva, Hora_Inicio, Hora_Termino, Instalacao, Nro_Espaco, Tipo_Reserva)
  VALUES (5, TO_DATE('15/12/2024', 'DD/MM/YYYY'), TO_TIMESTAMP('14:00', 'HH24:MI'), TO_TIMESTAMP('16:00', 'HH24:MI'), '65.123.456/0001-33', 1, 'RESERVA ESPORTIVA');
INSERT INTO Reserva (ID_Reserva, Data_Reserva, Hora_Inicio, Hora_Termino, Instalacao, Nro_Espaco, Tipo_Reserva)
  VALUES (6, TO_DATE('10/11/2024', 'DD/MM/YYYY'), TO_TIMESTAMP('18:00', 'HH24:MI'), TO_TIMESTAMP('19:00', 'HH24:MI'), '65.123.456/0001-33', 1, 'MANUTENÇÃO');
INSERT INTO Reserva (ID_Reserva, Data_Reserva, Hora_Inicio, Hora_Termino, Instalacao, Nro_Espaco, Tipo_Reserva)
  VALUES (7, TO_DATE('30/01/2024', 'DD/MM/YYYY'), TO_TIMESTAMP('14:00', 'HH24:MI'), TO_TIMESTAMP('18:00', 'HH24:MI'), '65.123.456/0001-33', 3, 'RESERVA ESPORTIVA');
INSERT INTO Reserva (ID_Reserva, Data_Reserva, Hora_Inicio, Hora_Termino, Instalacao, Nro_Espaco, Tipo_Reserva)
  VALUES (8, TO_DATE('16/02/2024', 'DD/MM/YYYY'), TO_TIMESTAMP('13:00', 'HH24:MI'), TO_TIMESTAMP('15:00', 'HH24:MI'), '65.123.456/0001-33', 3, 'MANUTENÇÃO');

-- Inserção de dados na tabela Manutencao
INSERT INTO Manutencao (ID_Reserva, Contrato, Tipo, Status)
  VALUES (2, 1, 'Limpeza de campo', 'FINALIZADA');
INSERT INTO Manutencao (ID_Reserva, Contrato, Tipo, Status)
  VALUES (3, 2, 'Pintura de quadra', 'MARCADA');
INSERT INTO Manutencao (ID_Reserva, Contrato, Tipo, Status)
  VALUES (6, 4, 'Troca de lâmpadas', 'CANCELADA');
INSERT INTO Manutencao (ID_Reserva, Contrato, Tipo, Status)
  VALUES (8, 3, 'Limpeza de Piscina', 'EM ANDAMENTO');


-- Inserção de dados na tabela Usuario
INSERT INTO Usuario (U_ID, Nome, Endereco, Tipo)
  VALUES (1, 'Maria Oliveira', 'Rua ABC, 123, São Paulo, SP', 'Físico');
INSERT INTO Usuario (U_ID, Nome, Endereco, Tipo)
  VALUES (2, 'Pedro Costa', 'Avenida XYZ, 456, Rio de Janeiro, RJ', 'Jurídico');
INSERT INTO Usuario (U_ID, Nome, Endereco, Tipo)
  VALUES (3, 'Eduarda Esmeralda Costa da Silva', 'Avenida João José, 325, São Carlos, SP', 'Físico');
INSERT INTO Usuario (U_ID, Nome, Endereco, Tipo)
  VALUES (4, 'Pedro Andrade de Souza', 'Rua 10, Rio Claro, SP', 'Jurídico');

-- Inserção de dados na tabela Telefones_Usuario
INSERT INTO Telefones_Usuario (U_ID, Telefone)
  VALUES (1, '(11) 912345678');
INSERT INTO Telefones_Usuario (U_ID, Telefone)
  VALUES (2, '(21) 987654321');
INSERT INTO Telefones_Usuario (U_ID, Telefone)
  VALUES (2, '(21) 912379858');
INSERT INTO Telefones_Usuario (U_ID, Telefone)
  VALUES (3, '(16) 987657895');
INSERT INTO Telefones_Usuario (U_ID, Telefone)
  VALUES (3, '(16) 36521489');
INSERT INTO Telefones_Usuario (U_ID, Telefone)
  VALUES (4, '(19) 912986578');
INSERT INTO Telefones_Usuario (U_ID, Telefone)
  VALUES (4, '(19) 995364321');
INSERT INTO Telefones_Usuario (U_ID, Telefone)
  VALUES (4, '(19) 914589584');

-- Inserção de dados na tabela Pessoa_Juridica
INSERT INTO Pessoa_Juridica (U_ID, CNPJ, Categoria)
  VALUES (2, '98.765.432/0001-98', 'Academia');
INSERT INTO Pessoa_Juridica (U_ID, CNPJ, Categoria)
  VALUES (4, '12.456.487/0001-65', 'Fisioterapeuta');


-- Inserção de dados na tabela Pessoa_Fisica
INSERT INTO Pessoa_Fisica (U_ID, CPF, Categoria)
  VALUES (1, '123.456.789-00', 'Atleta');
INSERT INTO Pessoa_Fisica (U_ID, CPF, Categoria)
  VALUES (3, '852.741.963-95', 'Atleta');

-- Inserção de dados na tabela Reserva_Esportiva
INSERT INTO Reserva_Esportiva (ID_Reserva, Usuario, Nome_Reserva, Quantidade_Pessoas, Tipo, Funcionario_Responsavel, Aprovado)
  VALUES (1, 1, 'Treinamento de Futebol', 15, 'Futebol', 1, 'SIM');
INSERT INTO Reserva_Esportiva (ID_Reserva, Usuario, Nome_Reserva, Quantidade_Pessoas, Tipo, Funcionario_Responsavel, Aprovado)
  VALUES (4, 2, 'Evento Corporativo', 50, 'Futebol', 2, 'EM ANALISE'); -- rever aqui
INSERT INTO Reserva_Esportiva (ID_Reserva, Usuario, Nome_Reserva, Quantidade_Pessoas, Tipo, Funcionario_Responsavel, Aprovado)
  VALUES (5, 3, 'Aula de Volêi', 12, 'Volêi', 3, 'SIM');
INSERT INTO Reserva_Esportiva (ID_Reserva, Usuario, Nome_Reserva, Quantidade_Pessoas, Tipo, Funcionario_Responsavel, Aprovado)
  VALUES (7, 4, 'Confraternização', 45, 'Confraternização da Empresa', 3, 'SIM');

COMMIT;
