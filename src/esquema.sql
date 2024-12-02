-- script para criação da base de dados

-- tabela Empresa_Manutencao
CREATE TABLE Empresa_Manutencao(
  CNPJ char(18),
  Tipo_Empresa VARCHAR2(50),-- só tem dois tipos aqui, lembrar quais
  Proprietario VARCHAR2(100),
  Orgao_Vinculado VARCHAR2(50),
  Nome_Fantasia VARCHAR2(50),
  CONSTRAINT PK_Empresa_Manutencao PRIMARY KEY (CNPJ)
);

-- tabela Servicos_Empresa
CREATE TABLE Servicos_Empresa(
  Empresa CHAR(18) NOT NULL, -- FK da tabela Empresa_Manutencao(CNPJ)
  Servico VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_Servico_Empresa PRIMARY KEY (Empresa, Servico),
    CONSTRAINT FK_Empresa FOREIGN KEY (Empresa) REFERENCES Empresa_Manutencao(CNPJ)
);

-- tabela Telefone_Empresa
CREATE TABLE Telefones_Empresa(
  Empresa CHAR(18) NOT NULL,
  Telefone NUMBER NOT NULL,
  CONSTRAINT PK_Telefones_Empresa PRIMARY KEY (Empresa, Telefone)
  CONSTRAINT FK_Empresa FOREIGN KEY (Empresa) REFERENCES Empresa_Manutencao(CNPJ)
);
