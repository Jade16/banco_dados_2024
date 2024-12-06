-- Inserção de dados na tabela Empresa_Manutencao
INSERT INTO Empresa_Manutencao (CNPJ, Tipo_Empresa, Proprietario, Orgao_Vinculado, Nome_Fantasia)
  VALUES ('12.345.678/0001-90', 'PÚBLICA', 'Governo Estadual', 'Secretaria de Esportes', 'Estádio Cidade');
INSERT INTO Empresa_Manutencao (CNPJ, Tipo_Empresa, Proprietario, Orgao_Vinculado, Nome_Fantasia)
  VALUES ('98.765.432/0001-98', 'PRIVADA', 'João Silva', 'N/A', 'Esportes XYZ');
INSERT INTO Empresa_Manutencao (CNPJ, Tipo_Empresa, Proprietario, Orgao_Vinculado, Nome_Fantasia)
  VALUES ('57.245.785/0001-11', 'PRIVADA', 'Carlos Camargo Rodrigues', 'N/A', 'Luzes Elétricas');
INSERT INTO Empresa_Manutencao (CNPJ, Tipo_Empresa, Proprietario, Orgao_Vinculado, Nome_Fantasia)
  VALUES ('78.325.698/0001-00', 'PRIVADA', 'Joana Josias', 'N/A', 'TIBUM! Piscinas');

-- Inserção de dados na tabela Servicos_Empresa
INSERT INTO Servicos_Empresa (Empresa, Servico)
  VALUES ('12.345.678/0001-90', 'Manutenção de campo');
INSERT INTO Servicos_Empresa (Empresa, Servico)
  VALUES ('98.765.432/0001-98', 'Treinamento de equipes');
INSERT INTO Servicos_Empresa (Empresa, Servico)
  VALUES ('57.245.785/0001-11', 'Troca de lâmpadas');


-- Inserção de dados na tabela Telefones_Empresa
INSERT INTO Telefones_Empresa (Empresa, Telefone)
VALUES ('12.345.678/0001-90', '(11) 987654321');
INSERT INTO Telefones_Empresa (Empresa, Telefone)
VALUES ('98.765.432/0001-98', '(21) 912345678');

-- Inserção de dados na tabela Cidade
INSERT INTO Cidade (Codigo_Municipio, Nome, UF)
VALUES ('1234567', 'São Paulo', 'SP');
INSERT INTO Cidade (Codigo_Municipio, Nome, UF)
VALUES ('7654321', 'Rio de Janeiro', 'RJ');

-- Inserção de dados na tabela Gestor_Esportivo
INSERT INTO Gestor_Esportivo (F_ID, Cidade, Endereco_Rua, Endereco_Numero, Endereco_Bairro, Endereco_CEP, RG, CPF, Nro_Carteira_Trabalho, Data_Contratacao, Telefone_1, Telefone_2)
VALUES (1, '1234567', 'Rua do Estádio', 100, 'Centro', '01000-000', '12.345.678-9', '123.456.789-00', '12345', TO_DATE('01/01/2020', 'DD/MM/YYYY'), '(11) 123456789', '(11) 987654321');
INSERT INTO Gestor_Esportivo (F_ID, Cidade, Endereco_Rua, Endereco_Numero, Endereco_Bairro, Endereco_CEP, RG, CPF, Nro_Carteira_Trabalho, Data_Contratacao, Telefone_1, Telefone_2)
VALUES (2, '7654321', 'Avenida Maracanã', 200, 'Zona Norte', '20500-000', '98.765.432-1', '987.654.321-00', '67890', TO_DATE('15/05/2021', 'DD/MM/YYYY'), '(21) 234567890', '(21) 998765432');

-- Inserção de dados na tabela Contrato
INSERT INTO Contrato (ID_Contrato, Empresa, Gestor, Data, Orcamento, Periodo_Contrato)
VALUES (1, '12.345.678/0001-90', 1, TO_DATE('01/06/2023', 'DD/MM/YYYY'), 50000, '1 ano');
INSERT INTO Contrato (ID_Contrato, Empresa, Gestor, Data, Orcamento, Periodo_Contrato)
VALUES (2, '98.765.432/0001-98', 2, TO_DATE('01/07/2023', 'DD/MM/YYYY'), 30000, '6 meses');

-- Inserção de dados na tabela Servicos_Contrato
INSERT INTO Servicos_Contrato (Contrato, Servico)
VALUES (1, 'Manutenção de campo');
INSERT INTO Servicos_Contrato (Contrato, Servico)
VALUES (2, 'Treinamento de equipes');

-- Inserção de dados na tabela Instalacao_Esportiva
INSERT INTO Instalacao_Esportiva (CNPJ, Nome, Cidade, Endereco_Rua, Endereco_Numero, Endereco_Bairro, Endereco_CEP)
VALUES ('12.345.678/0001-90', 'Estádio Municipal', '1234567', 'Rua do Estádio', '100', 'Centro', '01000-000');
INSERT INTO Instalacao_Esportiva (CNPJ, Nome, Cidade, Endereco_Rua, Endereco_Numero, Endereco_Bairro, Endereco_CEP)
VALUES ('98.765.432/0001-98', 'Arena Futebol', '7654321', 'Avenida Maracanã', '200', 'Zona Norte', '20500-000');

-- Inserção de dados na tabela Funcionario_Instalacao
INSERT INTO Funcionario_Instalacao (F_ID, Nome, CPF, RG, Nro_Carteira_Trabalho, Data_Contratacao, Instalacao_Esportiva, Telefone1, Telefone2)
VALUES (1, 'Carlos Souza', '123.456.789-00', '12.345.678-9', '12345', TO_DATE('01/01/2020', 'DD/MM/YYYY'), '12.345.678/0001-90', '(11) 123456789', '(11) 987654321');
INSERT INTO Funcionario_Instalacao (F_ID, Nome, CPF, RG, Nro_Carteira_Trabalho, Data_Contratacao, Instalacao_Esportiva, Telefone1, Telefone2)
VALUES (2, 'Ana Costa', '987.654.321-00', '98.765.432-1', '67890', TO_DATE('15/05/2021', 'DD/MM/YYYY'), '98.765.432/0001-98', '(21) 234567890', '(21) 998765432');

-- Inserção de dados na tabela Espaco_Esportivo
INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
VALUES ('12.345.678/0001-90', 1, 'Campo de Futebol');
INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
VALUES ('98.765.432/0001-98', 1, 'Quadra de Basquete');

-- Inserção de dados na tabela Reserva
INSERT INTO Reserva (ID_Reserva, Data_Reserva, Hora_Inicio, Hora_Termino, Instalacao, Nro_Espaco, Tipo_Reserva)
VALUES (1, TO_DATE('15/12/2024', 'DD/MM/YYYY'), TO_TIMESTAMP('08:00', 'HH24:MI'), TO_TIMESTAMP('10:00', 'HH24:MI'), '12.345.678/0001-90', 1, 'RESERVA ESPORTIVA');
INSERT INTO Reserva (ID_Reserva, Data_Reserva, Hora_Inicio, Hora_Termino, Instalacao, Nro_Espaco, Tipo_Reserva)
VALUES (2, TO_DATE('16/12/2024', 'DD/MM/YYYY'), TO_TIMESTAMP('14:00', 'HH24:MI'), TO_TIMESTAMP('16:00', 'HH24:MI'), '98.765.432/0001-98', 1, 'MANUTENÇÃO');

-- Inserção de dados na tabela Manutencao
INSERT INTO Manutencao (ID_Reserva, Contrato, Tipo, Status)
VALUES (1, 1, 'Limpeza de campo', 'BUSCANDO EMPRESA');
INSERT INTO Manutencao (ID_Reserva, Contrato, Tipo, Status)
VALUES (2, 2, 'Pintura de quadra', 'APROVADA');

-- Inserção de dados na tabela Usuario
INSERT INTO Usuario (U_ID, Nome, Endereco, Tipo)
VALUES (1, 'Maria Oliveira', 'Rua ABC, 123, São Paulo, SP', 'Físico');
INSERT INTO Usuario (U_ID, Nome, Endereco, Tipo)
VALUES (2, 'Pedro Costa', 'Avenida XYZ, 456, Rio de Janeiro, RJ', 'Jurídico');

-- Inserção de dados na tabela Telefones_Usuario
INSERT INTO Telefones_Usuario (U_ID, Telefone)
VALUES (1, '(11) 912345678');
INSERT INTO Telefones_Usuario (U_ID, Telefone)
VALUES (2, '(21) 987654321');

-- Inserção de dados na tabela Pessoa_Juridica
INSERT INTO Pessoa_Juridica (U_ID, CNPJ, Categoria)
VALUES (2, '98.765.432/0001-98', 'Academia');

-- Inserção de dados na tabela Pessoa_Fisica
INSERT INTO Pessoa_Fisica (U_ID, CPF, Categoria)
VALUES (1, '123.456.789-00', 'Atleta');

-- Inserção de dados na tabela Reserva_Esportiva
INSERT INTO Reserva_Esportiva (ID_Reserva, Usuario, Nome_Reserva, Quantidade_Pessoas, Tipo, Funcionario_Responsavel, Aprovado)
VALUES (1, 1, 'Treinamento de Futebol', 15, 'Futebol', 1, 'SIM');
INSERT INTO Reserva_Esportiva (ID_Reserva, Usuario, Nome_Reserva, Quantidade_Pessoas, Tipo, Funcionario_Responsavel, Aprovado)
VALUES (2, 2, 'Evento Corporativo', 50, 'Futebol', 2, 'EM ANALISE');
