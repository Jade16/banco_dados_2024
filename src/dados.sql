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


