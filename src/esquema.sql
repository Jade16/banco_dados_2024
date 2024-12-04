-- script para criação da base de dados

-- COISAS QUE AINDA PRECISAM SER FEITAS
-- TRATAMENTO DE LETRAS MAIÚSCULAS E MINÚSCULAS

-- tabela Empresa_Manutencao
CREATE TABLE Empresa_Manutencao(
  CNPJ CHAR(18) NOT NULL, -- reservado 18 espacos pois estou contando com o armazenamento dos caracteres não numericos também
  Tipo_Empresa VARCHAR2(7), -- existem apenas 2 valores: pública e privada
  Proprietario VARCHAR2(100),
  Orgao_Vinculado VARCHAR2(100),
  Nome_Fantasia VARCHAR2(100),
    CONSTRAINT PK_Empresa_Manutencao PRIMARY KEY (CNPJ),
    CONSTRAINT CK_Tipo_Empresa_EM CHECK (UPPER(Tipo_Empresa) IN ('PÚBLICA', 'PRIVADA')
);

-- tabela Servicos_Empresa
CREATE TABLE Servicos_Empresa(
  Empresa CHAR(18) NOT NULL, -- FK de Empresa_Manutencao(CNPJ)
  Servico VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_Servico_Empresa PRIMARY KEY (Empresa, Servico),
    CONSTRAINT FK_Empresa_SE FOREIGN KEY (Empresa)
      REFERENCES Empresa_Manutencao(CNPJ)
);

-- tabela Telefone_Empresa
CREATE TABLE Telefones_Empresa(
  Empresa CHAR(18) NOT NULL, -- FK de Empresa_Manutencao(CNPJ) 
  Telefone NUMBER NOT NULL,
    CONSTRAINT PK_Telefones_Empresa PRIMARY KEY (Empresa, Telefone),
    CONSTRAINT FK_Empresa_TE FOREIGN KEY (Empresa)
      REFERENCES Empresa_Manutencao(CNPJ)
);

-- tabela Cidade
CREATE TABLE Cidade(
  Codigo_Municipio CHAR(7) NOT NULL, -- o codigo do municipio é sempre numerico, mas esse numero não tem sgnificado de contagem e sim de identificação, por isso estou usando o tipo char. E o código dos municipios brasileiros tem sempre 7 caracteres
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
  Nro_Carteira_Trabalho VARCHAR2(100), -- estou usando varchar2 porque, mesmo que o numero seja patronizado, existe uma versão que contem série e outra não, por isso vamos deixar um espaço variavel para esse armazenamento
  Data_Contratacao DATE,
  Telefone_1 VARCHAR2(14),
  Telefone_2 VARCHAR2(14),
  CONSTRAINT PK_Gestor_Esportivo PRIMARY KEY (F_ID),
  CONSTRAINT SK_Cidade_GE UNIQUE (Cidade),
  CONSTRAINT FK_Cidade_GE FOREIGN KEY (Cidade)
    REFERENCES Cidade(Codigo_Municipio)
);

-- tabela Contrato
CREATE TABLE Contrato(
  ID_Contrato NUMBER NOT NULL,
  Empresa CHAR(18) NOT NULL,
  Gestor NUMBER NOT NULL,
  Data DATE NOT NULL,
  Orcamento NUMBER NOT NULL,
  Periodo_Contrato VARCHAR2(50),
    CONSTRAINT PK_Contrato PRIMARY KEY (ID_Contrato),
    CONSTRAINT FK_Empresa_C FOREIGN KEY (Empresa) 
      REFERENCES Empresa_Manutencao(CNPJ),
    CONSTRAINT FK_Gestor_C FOREIGN KEY (Gestor)
      REFERENCES Gestor_Esportivo(F_ID)
);

-- tabela Servicos_Contrato
CREATE TABLE Servicos_Contrato(
  Contrato NUMBER,
  Servido VARCHAR2(100),
  CONSTRAINT PK_Servicos_Contrato PRIMARY KEY (Contrato, Servico)
  CONSTRAINT FK_Contrato_SC FOREIGN KEY (Contrato)
    REFERENCES Contrato(ID_Contrato)
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
  CONSTRAINT PK_Instalacao_Esportiva PRIMARY KEK (CNPJ)
);

-- tabela Funcionario_Instalacao
CREATE TABLE Funcionario_Instalacao(
  F_ID NUMBER NOT NULL,
  Nome VARCHAR2(100) NOT NULL,
  CPF CHAR(14) NOT NULL,
  RG VARCHAR2(100) NOT NULL,
  Nro_Carteira_Trabalho VARCHAR2(100) NOT NULL,
  Data_Contratacao DATE,
  Instalacao_Esportiva CHAR(18) NOT NULL,
  Telefone1 VARCHAR2(14),
  Telefone2 VARCHAR2(14),
  CONSTRAINT PK_Funcionario_Instalacao PRIMARY KEY (F_ID),
  CONSTRAINT FK_Instalacao_Esportiva_FI FOREIGN KEY (Instalacao_Esportiva)
    REFERENCES Instalacao_Esportiva(CNPJ)
);

-- tabela Espaco_Esportivo
CREATE TABLE Espaco_Esportivo(
  Instalacao CHAR(18) NOT NULL,
  Nro_Espaco NUMBER NOT NULL,
  Tipo VARCHAR2(100) NOT NULL,
  CONSTRAINT PK_Espaco_Esportivo PRIMARY KEY (Instalacao, Nro_Espaco),
  CONSTRAINT FK_Instalacao_EE FOREIGN KEY (Instalacao)
    REFERENCES Instalacao_Esportiva(CNPJ)
);

-- tabela Reserva
CREATE TABLE Reserva(
  ID_Reserva NUMBER NOT NULL,
  Data_Reserva DATE NOT NULL,
  Hora_Inicio DATE NOT NULL,-- tipo hora
  Hora_Termino DATE NOT NULL, -- tipo hora 
  Instalacao CHAR(18) NOT NULL,
  Nro_Espaco NUMBER NOT NULL,
  Tipo_Reserva VARCHAR2(17), -- Tem apenas dois valores: reserva esportiva ou manutenção
  CONSTRAINT PK_Reserva PRIMARY KEY (ID_Reserva),
  CONSTRAINT FK_Espaco_Esportivo_R FOREIGN KEY (Instalacao, Nro_Espaco)
    REFERENCES Espaco_Esportivo(Instalacao, Nro_Espaco),
  CONSTRAINT SK_Reserva UNIQUE (Data_Reserva, Hora_Inicio, Instalacao, Nro_Espaco)
):

-- tabela Manutencao
CREATE TABLE Manutencao(
  ID_Reserva NUMBER NOT NULL,
  Contrato NUMBER NOT NULL,
  Tipo VARCHAR2(100),
  Status VARCHAR2(50) NOT NULL, -- definir valores especificos para esse atributo?? 
  CONSTRAINT PK_Manutencao PRIMARY KEY (ID_Reserva),
  CONSTRAINT FK_ID_Reserva_M FOREIGN KEY (ID_Reserva)
    REFERENCES Reserva(ID_Reserva),
  CONSTRAINT FK_Contrato_M FOREIGN KEY (Contrato)
    REFERENCES Contrato(ID_Contrato)
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
  Telefone NUMBER NOT NULL,
  CONSTRAINT PK_Telefones_Usuario PRIMARY KEY (U_ID, Telefone),
  CONSTRAINT FK_U_ID_TU FOREIGN KEY (U_ID)
    REFERENCES Usuario(U_ID)
);

-- tabela Pessoa_Juridica
CREATE TABLE Pessoa_Juridica(
  U_ID NUMBER NOT NULL,
  CNPJ CHAR(18) NOT NULL,
  Categoria VARCHAR2(50),
  CONSTRAINT PK_Pessoa_Juridica PRIMARY KEY (U_ID),
  CONSTRAINT FK_U_ID_PJ FOREIGN KEY (U_ID)
    REFERENCES Usuario(U_ID),
  CONSTRAINT SK_CNPJ_PJ UNIQUE (CNPJ)
);

-- tabela Pessoa_Fisica
CREATE TABLE Pessoa_Fisica(
  U_ID NUMBER NOT NULL,
  CPF CHAR(14) NOT NULL,
  Categoria VARCHAR2(50),
  CONSTRAINT PK_Pessoa_Fisica PRIMARY KEY (U_ID),
  CONSTRAINT FK_U_ID_PF FOREIGN KEY (U_ID)
    REFERENCES Usuario(U_ID),
  CONSTRAINT SK_CPF_PF UNIQUE (CPF)
);

-- tabela Reserva_Esportiva
CREATE TABLE Reserva_Esportiva(
  ID_Reserva NUMBER NOT NULL,
  Usuario NUMBER NOT NULL,
  Nome_Reserva VARCHAR2(100),
  Quantidade_Pessoas NUMBER,
  Tipo VARCHAR2(50),
  Funcionario_Responsavel NUMBER NOT NULL,
  Aprovado VARCHAR2(3), -- atributo com apenas 2 opções?? ou com 3 opções
); 
