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

