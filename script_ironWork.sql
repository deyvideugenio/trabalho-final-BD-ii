-- ############## Trabalho Final de Banco de Dados 2 ################# --

-- 1ª parte: Criação do Banco de Dados --
CREATE DATABASE AcademiaIronWork;

USE AcademiaIronWork;

-- Criando as tabelas do nosso Banco de Dados da Academia Iron Work --
-- Tabela Funcionário sendo criada --
CREATE TABLE Funcionario (
  idFun INT AUTO_INCREMENT PRIMARY KEY,
  NomeFun VARCHAR(100) NOT NULL,
  IdadeFun INT NOT NULL,
  Funcao VARCHAR(100) NOT NULL,
  TipoContrato VARCHAR(255) NOT NULL,
  ContatoFun VARCHAR(20) NOT NULL,
  MontagemTreino TEXT NOT NULL -- o tipo Text vai ser para amarzenar mais informação em formato de texto --
);

-- Tabela Benefício --
CREATE TABLE Beneficio (
  idBen INT AUTO_INCREMENT PRIMARY KEY,
  Tipo VARCHAR(100) NOT NULL
);

-- Tabela gerada no relacionamento n x n do Benefício e Funcionário --
CREATE TABLE BeneficioFunc (
  idBen INT NOT NULL,
  idFun INT NOT NULL,
  FOREIGN KEY (idBen) REFERENCES Beneficio(idBen),
  FOREIGN KEY (idFun) REFERENCES Funcionario(idFun)
);

-- Tabela Parceiro --
CREATE TABLE Parceiro (
  idParceiro INT AUTO_INCREMENT PRIMARY KEY,
  NomeEmpresa VARCHAR(60) NOT NULL,
  TipoParceria VARCHAR(100) NOT NULL,
  TipDescParceria VARCHAR(100) NOT NULL
);

-- Tabela Aluno --
CREATE TABLE Aluno (
  idAluno INT AUTO_INCREMENT PRIMARY KEY,
  idParceiro INT NOT NULL,
  NomeAluno VARCHAR(60) NOT NULL,
  IdadeAluno INT NOT NULL,
  ContatoAluno VARCHAR(100) NOT NULL,
  FOREIGN KEY (idParceiro) REFERENCES Parceiro(idParceiro)
);

-- Tabela Endereço --
CREATE TABLE Endereco (
    Rua VARCHAR(100) NOT NULL,
    Numero INT NOT NULL,
    CEP VARCHAR(20) NOT NULL,
    idFun INT NOT NULL,
    idAluno INT NOT NULL,
    Bairro VARCHAR(60) NOT NULL,
    Cidade VARCHAR(30) NOT NULL,
    Estado VARCHAR(20) NOT NULL,
    PRIMARY KEY (Rua, Numero, CEP), -- Chave primária composta --
    FOREIGN KEY (idFun) REFERENCES Funcionario(idFun),
    FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno)
);


-- Tabela Pagamento --
CREATE TABLE Pagamento (
  idPagamento INT AUTO_INCREMENT PRIMARY KEY,
  idAluno INT NOT NULL,
  DataPagamento DATE NOT NULL,
  PlanoContratado VARCHAR(60) NOT NULL,
  Valor DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno)
);

-- Tabela Ficha de Cadastro --
CREATE TABLE FichadeCadastro (
  idCadastro INT AUTO_INCREMENT PRIMARY KEY,
  idAluno INT NOT NULL,
  DataCadastro DATE NOT NULL, -- esse atributo é novo --
  Anamnese TEXT NOT NULL,
  FichaMedica TEXT NOT NULL,
  FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno)
);

-- Tabela Treino --
CREATE TABLE Treino (
  idFicha INT AUTO_INCREMENT PRIMARY KEY,
  idAluno INT NOT NULL,
FichaTreino TEXT NOT NULL,
  DataInicio DATE NOT NULL,
  DataFim DATE NOT NULL,
  ObjetivoTreino TEXT NOT NULL, -- atributo novo --
  FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno)
);

-- Tabela Equipamento --
-- troquei atributo ModeloEqui para NomeEqui, acho que faz mais sentido --
CREATE TABLE Equipamento (
  idEqui INT AUTO_INCREMENT PRIMARY KEY,
  NomeEqui VARCHAR(60) NOT NULL
);

-- Tabela Treino_Equipamento --
CREATE TABLE EquiTreino (
  idFicha INT NOT NULL,
  idEqui INT NOT NULL,
  FOREIGN KEY (idFicha) REFERENCES Treino(idFicha),
  FOREIGN KEY (idEqui) REFERENCES Equipamento(idEqui)
);

-- Tabela Manutenção --
CREATE TABLE Manutencao (
  idServ INT AUTO_INCREMENT PRIMARY KEY,
  idFun INT NOT NULL,
  idEqui INT NOT NULL,
  dataManu DATE NOT NULL,
  -- funcionarioManu VARCHAR(100) NOT NULL, esse atributo é desnecessário --
  FOREIGN KEY (idFun) REFERENCES Funcionario(idFun),
  FOREIGN KEY (idEqui) REFERENCES Equipamento(idEqui)
);
