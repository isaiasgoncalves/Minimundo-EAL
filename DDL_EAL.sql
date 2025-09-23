drop SCHEMA if exists oper_eal cascade;
CREATE SCHEMA oper_eal;

SET SEARCH_PATH TO oper_eal;

CREATE TABLE Aluno
(
  AlunoCPF VARCHAR NOT NULL,
  AlunoSenha VARCHAR NOT NULL,
  AlunoNome VARCHAR NOT NULL,
  AlunoEmail VARCHAR NOT NULL,
  AlunoCelular VARCHAR NOT NULL,
  DataNascimento DATE NOT NULL,
  Logradouro VARCHAR NOT NULL,
  Municipio VARCHAR NOT NULL,
  Bairro VARCHAR NOT NULL,
  Estado VARCHAR(2) NOT NULL,
  AlunoID INT NOT NULL,
  PRIMARY KEY (AlunoID),
  UNIQUE (AlunoCPF),
  UNIQUE (AlunoEmail)
);

CREATE TABLE Funcionario
(
  Salario FLOAT NOT NULL,
  FuncCPF VARCHAR NOT NULL,
  FuncCelular VARCHAR NOT NULL,
  FuncEmail VARCHAR NOT NULL,
  FuncID INT NOT NULL,
  Cargo VARCHAR NOT NULL,
  FuncNome VARCHAR NOT NULL,
  FuncSenha VARCHAR NOT NULL,
  PRIMARY KEY (FuncID),
  UNIQUE (FuncCPF),
  UNIQUE (FuncEmail)
);

CREATE TABLE Aula
(
  AulaData DATE NOT NULL,
  AulaID INT NOT NULL,
  FuncID INT NOT NULL,
  PRIMARY KEY (AulaID),
  FOREIGN KEY (FuncID) REFERENCES Funcionario(FuncID)
);

CREATE TABLE Veiculo
(
  IDVeiculo INT NOT NULL,
  Modelo VARCHAR NOT NULL,
  VeiculoTipo VARCHAR NOT NULL,
  PRIMARY KEY (IDVeiculo)
);

CREATE TABLE Sala
(
  IDSala INT NOT NULL,
  CapacidadeMax INT NOT NULL,
  PRIMARY KEY (IDSala)
);

CREATE TABLE AulaPratica
(
  AulaID INT NOT NULL,
  AlunoID INT NOT NULL,
  PRIMARY KEY (AulaID),
  FOREIGN KEY (AulaID) REFERENCES Aula(AulaID),
  FOREIGN KEY (AlunoID) REFERENCES Aluno(AlunoID)
);

CREATE TABLE Tema
(
  QuantidadeAula INT NOT NULL,
  TemaNome VARCHAR NOT NULL,
  TemaID INT NOT NULL,
  PRIMARY KEY (TemaID)
);

CREATE TABLE AulaTeorica
(
  AulaID INT NOT NULL,
  TemaID INT NOT NULL,
  PRIMARY KEY (AulaID),
  FOREIGN KEY (AulaID) REFERENCES Aula(AulaID),
  FOREIGN KEY (TemaID) REFERENCES Tema(TemaID)
);

CREATE TABLE ServicoAutoEsc
(
  ServicoTipo VARCHAR NOT NULL,
  ServicoValor FLOAT NOT NULL,
  ServicoID INT NOT NULL,
  ServicoDescricao VARCHAR,
  PRIMARY KEY (ServicoID)
);

CREATE TABLE Pagamento
(
  PagtoID INT NOT NULL,
  PagtoValor FLOAT NOT NULL,
  PagtoData DATE NOT NULL,
  FuncID INT NOT NULL,
  PRIMARY KEY (PagtoID),
  FOREIGN KEY (FuncID) REFERENCES Funcionario(FuncID)
);

CREATE TABLE Exame
(
  Status VARCHAR,
  ExameID INT NOT NULL,
<<<<<<< Updated upstream
  DtHrInicio DATE NOT NULL,
  DtHrFim DATE NOT NULL,
=======
  DtHrIni TIMESTAMP NOT NULL,
  DtHrFim TIMESTAMP NOT NULL,
  Nota NUMERIC(5, 2),
>>>>>>> Stashed changes
  AlunoID INT NOT NULL,
  FuncID INT NOT NULL,
  PRIMARY KEY (ExameID),
  FOREIGN KEY (AlunoID) REFERENCES Aluno(AlunoID),
  FOREIGN KEY (FuncID) REFERENCES Funcionario(FuncID)
);

CREATE TABLE ExamePratico
(
  ExameID INT NOT NULL,
  IDVeiculo INT NOT NULL,
  PRIMARY KEY (ExameID),
  FOREIGN KEY (ExameID) REFERENCES Exame(ExameID),
  FOREIGN KEY (IDVeiculo) REFERENCES Veiculo(IDVeiculo)
);

CREATE TABLE ExameTeorica
(
  ExameID INT NOT NULL,
  IDSala INT NOT NULL,
  PRIMARY KEY (ExameID),
  FOREIGN KEY (ExameID) REFERENCES Exame(ExameID),
  FOREIGN KEY (IDSala) REFERENCES Sala(IDSala)
);

CREATE TABLE AulaTSala
(
  DtHrInicio TIMESTAMP NOT NULL,
  DtHrFim TIMESTAMP NOT NULL,
  AulaID INT NOT NULL,
  IDSala INT NOT NULL,
  PRIMARY KEY (AulaID, IDSala),
  FOREIGN KEY (AulaID) REFERENCES AulaTeorica(AulaID),
  FOREIGN KEY (IDSala) REFERENCES Sala(IDSala)
);

CREATE TABLE VeiculoAula
(
  DtHrInicio TIMESTAMP NOT NULL,
<<<<<<< Updated upstream
  DtHrFim TIMESTAMP,
=======
  DtHrFim TIMESTAMP NOT NULL,
>>>>>>> Stashed changes
  AulaID INT NOT NULL,
  IDVeiculo INT NOT NULL,
  PRIMARY KEY (AulaID, IDVeiculo),
  FOREIGN KEY (AulaID) REFERENCES AulaPratica(AulaID),
  FOREIGN KEY (IDVeiculo) REFERENCES Veiculo(IDVeiculo)
);

CREATE TABLE AulaTAluno
(
  PresencaAluno INT NOT NULL,
  AulaID INT NOT NULL,
  AlunoID INT NOT NULL,
  PRIMARY KEY (AulaID, AlunoID),
  FOREIGN KEY (AulaID) REFERENCES AulaTeorica(AulaID),
  FOREIGN KEY (AlunoID) REFERENCES Aluno(AlunoID)
);

CREATE TABLE AlunoPaga
(
  TransacaoData DATE NOT NULL,
  Quantidade INT NOT NULL,
  AlunoID INT NOT NULL,
  ServicoID INT NOT NULL,
  PRIMARY KEY (AlunoID, ServicoID),
  FOREIGN KEY (AlunoID) REFERENCES Aluno(AlunoID),
  FOREIGN KEY (ServicoID) REFERENCES ServicoAutoEsc(ServicoID)
);