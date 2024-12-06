-- script para criação da base de dados

-- tabela Empresa_Manutencao
CREATE TABLE Empresa_Manutencao(
  CNPJ CHAR(18) NOT NULL, -- irá armazenar os caracteres não numericos
  Tipo_Empresa VARCHAR2(8), -- valores aceitos: pública e privada
  Proprietario VARCHAR2(100),
  Orgao_Vinculado VARCHAR2(100),
  Nome_Fantasia VARCHAR2(100),
    CONSTRAINT PK_Empresa_Manutencao PRIMARY KEY (CNPJ),
    CONSTRAINT CK_Tipo_Empresa_EM CHECK (
      UPPER(Tipo_Empresa) IN ('PÚBLICA', 'PRIVADA')
    )
);

-- tabela Servicos_Empresa
CREATE TABLE Servicos_Empresa(
  Empresa CHAR(18) NOT NULL, -- FK de Empresa_Manutencao(CNPJ)
  Servico VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_Servico_Empresa PRIMARY KEY (Empresa, Servico),
    CONSTRAINT FK_Empresa_SE FOREIGN KEY (Empresa)
      REFERENCES Empresa_Manutencao(CNPJ)
      ON DELETE CASCADE
);

-- tabela Telefone_Empresa
CREATE TABLE Telefones_Empresa(
  Empresa CHAR(18) NOT NULL, -- FK de Empresa_Manutencao(CNPJ)
  Telefone VARCHAR2(14) NOT NULL,
    CONSTRAINT PK_Telefones_Empresa PRIMARY KEY (Empresa, Telefone),
    CONSTRAINT FK_Empresa_TE FOREIGN KEY (Empresa)
      REFERENCES Empresa_Manutencao(CNPJ)
      ON DELETE CASCADE
);

-- tabela Cidade
CREATE TABLE Cidade(
  Codigo_Municipio CHAR(7) NOT NULL,
  Nome VARCHAR2(100) NOT NULL,
  UF VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_Cidade PRIMARY KEY (Codigo_Municipio)
);

-- tabela Gestor_Esportivo
CREATE TABLE Gestor_Esportivo(
  F_ID NUMBER NOT NULL,
  Cidade CHAR(7) NOT NULL,
  Endereco_Rua VARCHAR2(100),
  Endereco_Numero NUMBER,
  Endereco_Bairro VARCHAR2(100),
  Endereco_CEP CHAR(9),
  RG VARCHAR2(100),
  CPF CHAR(14),
  Nro_Carteira_Trabalho VARCHAR2(100),
  Data_Contratacao DATE, -- formato esperado: dd/mm/yyyy
  Telefone_1 VARCHAR2(14),
  Telefone_2 VARCHAR2(14),
  CONSTRAINT PK_Gestor_Esportivo PRIMARY KEY (F_ID),
  CONSTRAINT SK_Cidade_GE UNIQUE (Cidade),
  CONSTRAINT FK_Cidade_GE FOREIGN KEY (Cidade)
    REFERENCES Cidade(Codigo_Municipio)
    ON DELETE CASCADE
);

-- tabela Contrato
CREATE TABLE Contrato(
  ID_Contrato NUMBER NOT NULL,
  Empresa CHAR(18) NOT NULL,
  Gestor NUMBER NOT NULL,
  Data DATE NOT NULL, -- formato esperado: dd/mm/yyyy
  Orcamento NUMBER NOT NULL,
  Periodo_Contrato VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_Contrato PRIMARY KEY (ID_Contrato),
    CONSTRAINT FK_Empresa_C FOREIGN KEY (Empresa) 
      REFERENCES Empresa_Manutencao(CNPJ),
    CONSTRAINT FK_Gestor_C FOREIGN KEY (Gestor)
      REFERENCES Gestor_Esportivo(F_ID)
);

-- tabela Servicos_Contrato
CREATE TABLE Servicos_Contrato(
  Contrato NUMBER NOT NULL,
  Servico VARCHAR2(100) NOT NULL,
  CONSTRAINT PK_Servicos_Contrato PRIMARY KEY (Contrato, Servico),
  CONSTRAINT FK_Contrato_SC FOREIGN KEY (Contrato)
    REFERENCES Contrato(ID_Contrato)
    ON DELETE CASCADE
);

-- tabela Instalacao_Esportiva
CREATE TABLE Instalacao_Esportiva(
  CNPJ CHAR(18) NOT NULL,
  Nome VARCHAR2(100) NOT NULL,
  Cidade CHAR(7) NOT NULL,
  Endereco_Rua VARCHAR2(100) NOT NULL,
  Endereco_Numero VARCHAR2(100) NOT NULL,
  Endereco_Bairro VARCHAR2(100) NOT NULL,
  Endereco_CEP CHAR(9) NOT NULL,
  CONSTRAINT PK_Instalacao_Esportiva PRIMARY KEY (CNPJ),
  CONSTRAINT FK_Cidade_IE FOREIGN KEY (Cidade)
    REFERENCES Cidade(Codigo_Municipio)
    ON DELETE CASCADE
);

-- tabela Funcionario_Instalacao
CREATE TABLE Funcionario_Instalacao(
  F_ID NUMBER NOT NULL,
  Nome VARCHAR2(100) NOT NULL,
  CPF CHAR(14) NOT NULL,
  RG VARCHAR2(100) NOT NULL,
  Nro_Carteira_Trabalho VARCHAR2(100) NOT NULL,
  Data_Contratacao DATE, -- formato esperado: dd/mm/yyyy
  Instalacao_Esportiva CHAR(18) NOT NULL,
  Telefone1 VARCHAR2(14),
  Telefone2 VARCHAR2(14),
  CONSTRAINT PK_Funcionario_Instalacao PRIMARY KEY (F_ID),
  CONSTRAINT FK_Instalacao_Esportiva_FI FOREIGN KEY (Instalacao_Esportiva)
    REFERENCES Instalacao_Esportiva(CNPJ)
    ON DELETE CASCADE
);

-- tabela Espaco_Esportivo
CREATE TABLE Espaco_Esportivo(
  Instalacao CHAR(18) NOT NULL,
  Nro_Espaco NUMBER NOT NULL,
  Tipo VARCHAR2(100) NOT NULL,
  CONSTRAINT PK_Espaco_Esportivo PRIMARY KEY (Instalacao, Nro_Espaco),
  CONSTRAINT FK_Instalacao_EE FOREIGN KEY (Instalacao)
    REFERENCES Instalacao_Esportiva(CNPJ)
    ON DELETE CASCADE
);

-- tabela Reserva
CREATE TABLE Reserva(
  ID_Reserva NUMBER NOT NULL,
  Data_Reserva DATE NOT NULL, -- formato esperado: dd/mm/yyyy
  Hora_Inicio TIMESTAMP NOT NULL,-- formato esperado: hh:mm
  Hora_Termino TIMESTAMP NOT NULL, -- formato esperado: hh:mm
  Instalacao CHAR(18) NOT NULL,
  Nro_Espaco NUMBER NOT NULL,
  Tipo_Reserva VARCHAR2(17), -- aceita apenas dois valores: reserva esportiva ou manutenção
  CONSTRAINT PK_Reserva PRIMARY KEY (ID_Reserva),
  CONSTRAINT SK_Reserva UNIQUE (Data_Reserva, Hora_Inicio, Instalacao, Nro_Espaco),
  CONSTRAINT FK_Espaco_Esportivo_R FOREIGN KEY (Instalacao, Nro_Espaco)
    REFERENCES Espaco_Esportivo(Instalacao, Nro_Espaco)
    ON DELETE CASCADE, -- NÃO SEI SE ISSO ESTÁ CORRETO!
  CONSTRAINT CK_Tipo_Reserva_R CHECK (
    UPPER(Tipo_Reserva) IN ('RESERVA ESPORTIVA', 'MANUTENÇÃO')
  ),
  CONSTRAINT CK_Hora_Inicio_R CHECK (
    EXTRACT(HOUR FROM Hora_Inicio) BETWEEN 6 AND 20
  ),
  CONSTRAINT CK_Hora_Termino_R CHECK (
    EXTRACT(HOUR FROM Hora_Termino) > 6 OR EXTRACT(HOUR FROM Hora_Termino) = 6 AND EXTRACT(MINUTE FROM Hora_Termino) >= 15
    AND
    EXTRACT(HOUR FROM Hora_Termino) < 21 -- não sei se está certo???
  )
);

-- tabela Manutencao
CREATE TABLE Manutencao(
  ID_Reserva NUMBER NOT NULL,
  Contrato NUMBER NOT NULL,
  Tipo VARCHAR2(100),
  Status VARCHAR2(16) NOT NULL, -- aceita apenas 4 valores: marcada, em andamento, finalizada, cancelada
  CONSTRAINT PK_Manutencao PRIMARY KEY (ID_Reserva),
  CONSTRAINT FK_ID_Reserva_M FOREIGN KEY (ID_Reserva)
    REFERENCES Reserva(ID_Reserva)
    ON DELETE CASCADE,
  CONSTRAINT FK_Contrato_M FOREIGN KEY (Contrato)
    REFERENCES Contrato(ID_Contrato),
  CONSTRAINT CK_Status_M CHECK (
    UPPER(Status) IN ('MARCADA', 'EM ANDAMENTO', 'FINALIZADA', 'CANCELADA')
  )
);

-- tabela Usuario
CREATE TABLE Usuario(
  U_ID NUMBER NOT NULL,
  Nome VARCHAR2(100) NOT NULL,
  Endereco VARCHAR2(300) NOT NULL,
  Tipo VARCHAR2(100) NOT NULL,
  CONSTRAINT PK_Usuario PRIMARY KEY (U_ID)
);

-- tabela Telefones_Usuario
CREATE TABLE Telefones_Usuario(
  U_ID NUMBER NOT NULL,
  Telefone VARCHAR2(14) NOT NULL,
  CONSTRAINT PK_Telefones_Usuario PRIMARY KEY (U_ID, Telefone),
  CONSTRAINT FK_U_ID_TU FOREIGN KEY (U_ID)
    REFERENCES Usuario(U_ID)
    ON DELETE CASCADE
);

-- tabela Pessoa_Juridica
CREATE TABLE Pessoa_Juridica(
  U_ID NUMBER NOT NULL,
  CNPJ CHAR(18) NOT NULL,
  Categoria VARCHAR2(50),
  CONSTRAINT PK_Pessoa_Juridica PRIMARY KEY (U_ID),
  CONSTRAINT SK_CNPJ_PJ UNIQUE (CNPJ),
  CONSTRAINT FK_U_ID_PJ FOREIGN KEY (U_ID)
    REFERENCES Usuario(U_ID)
    ON DELETE CASCADE
);

-- tabela Pessoa_Fisica
CREATE TABLE Pessoa_Fisica(
  U_ID NUMBER NOT NULL,
  CPF CHAR(14) NOT NULL,
  Categoria VARCHAR2(50),
  CONSTRAINT PK_Pessoa_Fisica PRIMARY KEY (U_ID),
  CONSTRAINT SK_CPF_PF UNIQUE (CPF),
  CONSTRAINT FK_U_ID_PF FOREIGN KEY (U_ID)
    REFERENCES Usuario(U_ID)
    ON DELETE CASCADE
);

-- tabela Reserva_Esportiva
CREATE TABLE Reserva_Esportiva(
  ID_Reserva NUMBER NOT NULL,
  Usuario NUMBER NOT NULL,
  Nome_Reserva VARCHAR2(100),
  Quantidade_Pessoas NUMBER,
  Tipo VARCHAR2(50),
  Funcionario_Responsavel NUMBER NOT NULL,
  Aprovado VARCHAR2(10), -- aceita apenas os valores: sim; não; em analise
  CONSTRAINT PK_ID_Reserva PRIMARY KEY (ID_Reserva),
  CONSTRAINT FK_ID_Reserva_RE FOREIGN KEY (ID_Reserva)
    REFERENCES Reserva(ID_Reserva)
    ON DELETE CASCADE,
  CONSTRAINT FK_Funcionario_Responsavel_RE FOREIGN KEY (Funcionario_Responsavel)
    REFERENCES Funcionario_Instalacao(F_ID),
  CONSTRAINT CK_Aprovado_RE CHECK (
    UPPER(Aprovado) IN ('SIM', 'NÃO', 'EM ANALISE')
  )
); 


-- DELETAR TODAS AS TABELAS:
DROP TABLE Reserva_Esportiva CASCADE CONSTRAINTS;
DROP TABLE Pessoa_Fisica CASCADE CONSTRAINTS;
DROP TABLE Pessoa_Juridica CASCADE CONSTRAINTS;
DROP TABLE Telefones_Usuario CASCADE CONSTRAINTS;
DROP TABLE Usuario CASCADE CONSTRAINTS;
DROP TABLE Manutencao CASCADE CONSTRAINTS;
DROP TABLE Reserva CASCADE CONSTRAINTS;
DROP TABLE Espaco_Esportivo CASCADE CONSTRAINTS;
DROP TABLE Funcionario_Instalacao CASCADE CONSTRAINTS;
DROP TABLE Instalacao_Esportiva CASCADE CONSTRAINTS;
DROP TABLE Servicos_Contrato CASCADE CONSTRAINTS;
DROP TABLE Contrato CASCADE CONSTRAINTS;
DROP TABLE Gestor_Esportivo CASCADE CONSTRAINTS;
DROP TABLE Cidade CASCADE CONSTRAINTS;
DROP TABLE Telefones_Empresa CASCADE CONSTRAINTS;
DROP TABLE Servicos_Empresa CASCADE CONSTRAINTS;
DROP TABLE Empresa_Manutencao CASCADE CONSTRAINTS;
