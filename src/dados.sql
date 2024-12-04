-- script para inserir dados no banco já criado

-- Populando a tabela Cidade
INSERT INTO Cidade (Codigo_Municipio, Nome, UF) VALUES ('1234567', 'São Paulo', 'SP');
INSERT INTO Cidade (Codigo_Municipio, Nome, UF) VALUES ('7654321', 'Rio de Janeiro', 'RJ');
INSERT INTO Cidade (Codigo_Municipio, Nome, UF) VALUES ('3456789', 'Belo Horizonte', 'MG');

-- Populando a tabela Servicos_Empresa
-- Inserção de um serviço para uma empresa com CNPJ '98.765.432/0001-12'
INSERT INTO Servicos_Empresa (Empresa, Servico)
VALUES ('98.765.432/0001-12', 'Treinamento de Equipe');

-- Inserção de outro serviço para a empresa '98.765.432/0001-12'
INSERT INTO Servicos_Empresa (Empresa, Servico)
VALUES ('98.765.432/0001-12', 'Assessoria Jurídica');

-- Populando a tabela Gestor_Esportivo
INSERT INTO Gestor_Esportivo (F_ID, Cidade, Endereco_Rua, Endereco_Numero, Endereco_Bairro, Endereco_CEP, RG, CPF, Nro_Carteira_Trabalho, Data_Contratacao, Telefone_1, Telefone_2)
VALUES (1, '1234567', 'Rua A', 100, 'Centro', '01010-010', '12.345.678', '123.456.789-00', '12345', TO_DATE('01/01/2020', 'DD/MM/YYYY'), '11-98765-4321', '11-98888-4444');

-- Populando a tabela Contrato
INSERT INTO Contrato (ID_Contrato, Empresa, Gestor, Data, Orcamento, Periodo_Contrato)
VALUES (1, '12.345.678/0001-90', 1, TO_DATE('01/03/2024', 'DD/MM/YYYY'), 50000, '12 meses');

-- Populando a tabela Servicos_Contrato
INSERT INTO Servicos_Contrato (Contrato, Servico) VALUES (1, 'Manutenção de Campo');

-- Populando a tabela Instalacao_Esportiva
INSERT INTO Instalacao_Esportiva (CNPJ, Nome, Cidade, Endereco_Rua, Endereco_Numero, Endereco_Bairro, Endereco_CEP)
VALUES ('98.765.432/0001-01', 'Estádio Municipal', '1234567', 'Av. Principal', '500', 'Centro', '01010-010');

-- Populando a tabela Funcionario_Instalacao
INSERT INTO Funcionario_Instalacao (F_ID, Nome, CPF, RG, Nro_Carteira_Trabalho, Data_Contratacao, Instalacao_Esportiva, Telefone1, Telefone2)
VALUES (1, 'Carlos Silva', '123.456.789-00', 'MG123456', '67890', TO_DATE('01/06/2020', 'DD/MM/YYYY'), '98.765.432/0001-01', '11-99999-8888', '11-98888-7777');

-- Populando a tabela Espaco_Esportivo
INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
VALUES ('98.765.432/0001-01', 1, 'Campo de Futebol');
INSERT INTO Espaco_Esportivo (Instalacao, Nro_Espaco, Tipo)
VALUES ('98.765.432/0001-01', 2, 'Quadra de Vôlei');

-- Populando a tabela Reserva
INSERT INTO Reserva (ID_Reserva, Data_Reserva, Hora_Inicio, Hora_Termino, Instalacao, Nro_Espaco, Tipo_Reserva)
VALUES (1, TO_DATE('10/03/2024', 'DD/MM/YYYY'), TO_TIMESTAMP('08:00', 'HH24:MI'), TO_TIMESTAMP('10:00', 'HH24:MI'), '98.765.432/0001-01', 1, 'RESERVA ESPORTIVA');

-- Populando a tabela Manutencao
INSERT INTO Manutencao (ID_Reserva, Contrato, Tipo, Status)
VALUES (1, 1, 'Limpeza de Campo', 'APROVADA');

-- Populando a tabela Usuario
INSERT INTO Usuario (U_ID, Nome, Endereco, Tipo)
VALUES (1, 'Ana Souza', 'Rua A, 100, São Paulo', 'Administrador');

-- Populando a tabela Telefones_Usuario
INSERT INTO Telefones_Usuario (U_ID, Telefone) VALUES (1, '11-4002-8922');
INSERT INTO Telefones_Usuario (U_ID, Telefone) VALUES (1, '11-99222-3344');

-- Populando a tabela Pessoa_Juridica
INSERT INTO Pessoa_Juridica (U_ID, CNPJ, Categoria)
VALUES (1, '98.765.432/0001-01', 'Prestadora de Serviços');

-- Populando a tabela Pessoa_Fisica
INSERT INTO Pessoa_Fisica (U_ID, CPF, Categoria)
VALUES (1, '123.456.789-00', 'Gestor Esportivo');

-- Populando a tabela Reserva_Esportiva
INSERT INTO Reserva_Esportiva (ID_Reserva, Usuario, Nome_Reserva, Quantidade_Pessoas, Tipo, Funcionario_Responsavel, Aprovado)
VALUES (1, 1, 'Reserva para Torneio', 20, 'Esportivo', 1, 'SIM');
