-- ############## Trabalho Final de Banco de Dados 2 ################# --

-- 1ª parte: Criação do Banco de Dados --
CREATE DATABASE AcademiaIronWork;

USE AcademiaIronWork;

-- Criando as tabelas do nosso Banco de Dados da Academia Iron Work --
-- Tabela Funcionário sendo criada --
CREATE TABLE Funcionario (
  idFun INT AUTO_INCREMENT PRIMARY KEY
  , NomeFun VARCHAR(100) NOT NULL
  , IdadeFun INT NOT NULL
  , Funcao VARCHAR(100) NOT NULL
  , TipoContrato VARCHAR(255) NOT NULL
  , ContatoFun VARCHAR(20) NOT NULL
  , MontagemTreino TEXT NOT NULL -- o tipo Text vai ser para amarzenar mais informação em formato de texto --
);

-- Tabela Benefício --
CREATE TABLE Beneficio (
  idBen INT AUTO_INCREMENT PRIMARY KEY
  , Tipo VARCHAR(100) NOT NULL
);

-- Tabela gerada no relacionamento n x n do Benefício e Funcionário --
CREATE TABLE BeneficioFunc (
  idBen INT NOT NULL
  , idFun INT NOT NULL
  , FOREIGN KEY (idBen) REFERENCES Beneficio(idBen)
  , FOREIGN KEY (idFun) REFERENCES Funcionario(idFun)
);

-- Tabela Parceiro --
CREATE TABLE Parceiro (
  idParceiro INT AUTO_INCREMENT PRIMARY KEY
  , NomeEmpresa VARCHAR(60) NOT NULL
  , TipoParceria VARCHAR(100) NOT NULL
  , TipDescParceria VARCHAR(100) NOT NULL
);

-- Tabela Aluno --
CREATE TABLE Aluno (
  idAluno INT AUTO_INCREMENT PRIMARY KEY
  , idParceiro INT NOT NULL
  , NomeAluno VARCHAR(60) NOT NULL
  , IdadeAluno INT NOT NULL
  , ContatoAluno VARCHAR(100) NOT NULL
  , FOREIGN KEY (idParceiro) REFERENCES Parceiro(idParceiro)
);

-- Tabela Endereço --
CREATE TABLE Endereco (
  Rua VARCHAR(100) NOT NULL
  , Numero INT NOT NULL
  , CEP VARCHAR(20) NOT NULL
  , idFun INT NOT NULL
  , idAluno INT NOT NULL
  , Bairro VARCHAR(60) NOT NULL
  , Cidade VARCHAR(30) NOT NULL
  , Estado VARCHAR(20) NOT NULL
  , PRIMARY KEY (Rua, Numero, CEP)
  , -- Chave primária composta --
    FOREIGN KEY (idFun) REFERENCES Funcionario(idFun)
  , FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno)
);


-- Tabela Pagamento --
CREATE TABLE Pagamento (
  idPagamento INT AUTO_INCREMENT PRIMARY KEY
  , idAluno INT NOT NULL
  , DataPagamento DATE NOT NULL
  , PlanoContratado VARCHAR(60) NOT NULL
  , Valor DECIMAL(10, 2) NOT NULL
  , FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno)
);

-- Tabela Ficha de Cadastro --
CREATE TABLE FichadeCadastro (
  idCadastro INT AUTO_INCREMENT PRIMARY KEY
  , idAluno INT NOT NULL
  , DataCadastro DATE NOT NULL
  , -- esse atributo é novo --
    Anamnese TEXT NOT NULL
  , FichaMedica TEXT NOT NULL
  , FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno)
);

-- Tabela Treino --
CREATE TABLE Treino (
  idFicha INT AUTO_INCREMENT PRIMARY KEY
  , idAluno INT NOT NULL
  , FichaTreino TEXT NOT NULL
  , DataInicio DATE NOT NULL
  , DataFim DATE NOT NULL
  , ObjetivoTreino TEXT NOT NULL
  , -- atributo novo --
    FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno)
);

-- Tabela Equipamento --
-- troquei atributo ModeloEqui para NomeEqui, acho que faz mais sentido --
CREATE TABLE Equipamento (
  idEqui INT AUTO_INCREMENT PRIMARY KEY
  , NomeEqui VARCHAR(60) NOT NULL
);

-- Tabela Treino_Equipamento --
CREATE TABLE EquiTreino (
  idFicha INT NOT NULL
  , idEqui INT NOT NULL
  , FOREIGN KEY (idFicha) REFERENCES Treino(idFicha)
  , FOREIGN KEY (idEqui) REFERENCES Equipamento(idEqui)
);

-- Tabela Manutenção --
CREATE TABLE Manutencao (
  idServ INT AUTO_INCREMENT PRIMARY KEY
  , idFun INT NOT NULL
  , idEqui INT NOT NULL
  , dataManu DATE NOT NULL
  , -- funcionarioManu VARCHAR(100) NOT NULL, esse atributo é desnecessário --
    FOREIGN KEY (idFun) REFERENCES Funcionario(idFun)
  , FOREIGN KEY (idEqui) REFERENCES Equipamento(idEqui)
);


-- Inserir informações funcionarios --
INSERT INTO
  Funcionario (
    NomeFun
    , IdadeFun
    , Funcao
    , TipoContrato
    , ContatoFun
    , MontagemTreino
  )
VALUES
  (
    'Carlos Silva'
    , 34
    , 'Instrutor'
    , 'CLT'
    , '1234-5678'
    , 'Treino de hipertrofia para iniciantes.'
  )
  , (
    'Ana Souza'
    , 28
    , 'Recepcionista'
    , 'CLT'
    , '2345-6789'
    , 'N/A'
  )
  , (
    'Marcos Oliveira'
    , 45
    , 'Personal Trainer'
    , 'PJ'
    , '3456-7890'
    , 'Treino funcional avançado.'
  )
  , (
    'Beatriz Santos'
    , 32
    , 'Nutricionista'
    , 'PJ'
    , '4567-8901'
    , 'Elaboração de planos nutricionais.'
  )
  , (
    'Juliana Almeida'
    , 29
    , 'Coordenadora'
    , 'CLT'
    , '5678-9012'
    , 'Supervisão geral e ajustes de treinos.'
  );

-- Inserir informações Benefícios --
INSERT INTO
  Beneficio (Tipo)
VALUES
  ('Vale Transporte')
  , ('Plano de Saúde')
  , ('Vale Refeição')
  , ('Seguro de Vida')
  , ('Auxílio Educação');

-- Inserir informações Benefícios dos funcionários --
INSERT INTO
  BeneficioFunc (idBen, idFun)
VALUES
  (1, 1)
  , (2, 1)
  , (3, 2)
  , (4, 3)
  , (5, 4)
  , (1, 5);

-- Inserir informações Parceiros --
INSERT INTO
  Parceiro (NomeEmpresa, TipoParceria, TipDescParceria)
VALUES
  ('gymEquipment', 'Equipamento', 'Desconto de 15%')
  , ('FitFood', 'Alimentação', 'Desconto de 20%')
  , ('SportLife', 'Roupas', 'Desconto de 10%')
  , ('HealthyLiving', 'Suplementos', 'Desconto de 25%')
  , ('GymPartner', 'Serviços', 'Desconto de 30%');

-- Inserir informações Alunos --
INSERT INTO
  Aluno (idParceiro, NomeAluno, IdadeAluno, ContatoAluno)
VALUES
  (1, 'Roberto Carlos', 85, '111111111')
  , (2, 'Fernanda Costa', 30, '222222222')
  , (3, 'Ricardo Pereira', 27, '333333333')
  , (4, 'Amanda Ferreira', 25, '444444444')
  , (5, 'Lucas Martins', 28, '555555555');

-- Inserir informações Endereços --
INSERT INTO
  Endereco (
    Rua
    , Numero
    , CEP
    , idFun
    , idAluno
    , Bairro
    , Cidade
    , Estado
  )
VALUES
  (
    'Rua ABC'
    , 100
    , '12345-678'
    , 1
    , 1
    , 'Centro'
    , 'São Paulo'
    , 'SP'
  )
  , (
    'Rua BCD'
    , 200
    , '23456-789'
    , 2
    , 2
    , 'Jardim'
    , 'Rio de Janeiro'
    , 'RJ'
  )
  , (
    'Rua CDE'
    , 300
    , '34567-890'
    , 3
    , 3
    , 'Vila'
    , 'Belo Horizonte'
    , 'MG'
  )
  , (
    'Rua DEF'
    , 400
    , '45678-901'
    , 4
    , 4
    , 'Zona Sul'
    , 'Curitiba'
    , 'PR'
  )
  , (
    'Rua EFG'
    , 500
    , '56789-012'
    , 5
    , 5
    , 'Zona Norte'
    , 'Porto Alegre'
    , 'RS'
  );

-- Inserir informações Pagamentos --
INSERT INTO
  Pagamento (idAluno, DataPagamento, PlanoContratado, Valor)
VALUES
  (1, '2024-01-15', 'Mensal', 150.00)
  , (2, '2024-02-10', 'Trimestral', 400.00)
  , (3, '2024-03-05', 'Mensal', 150.00)
  , (4, '2024-04-20', 'Semestral', 750.00)
  , (5, '2024-05-25', 'Mensal', 150.00);

-- Inserir informações Ficha de cadastros --
INSERT INTO
  FichadeCadastro (idAluno, DataCadastro, Anamnese, FichaMedica)
VALUES
  (
    1
    , '2024-01-01'
    , 'Histórico de lesões no joelho.'
    , 'Sem problemas cardíacos.'
  )
  , (
    2
    , '2024-02-01'
    , 'Alergia a lactose.'
    , 'Histórico de pressão alta.'
  )
  , (
    3
    , '2024-03-01'
    , 'Diabetes controlada.'
    , 'Histórico de colesterol alto.'
  )
  , (
    4
    , '2024-04-01'
    , 'Problemas respiratórios.'
    , 'Histórico de asma.'
  )
  , (
    5
    , '2024-05-01'
    , 'Hérnia de disco.'
    , 'Histórico de problemas na coluna.'
  );

-- Inserir informações Treinos --
INSERT INTO
  Treino (
    idAluno
    , FichaTreino
    , DataInicio
    , DataFim
    , ObjetivoTreino
  )
VALUES
  (
    1
    , 'Treino A'
    , '2024-01-05'
    , '2024-03-05'
    , 'Ganhar massa muscular.'
  )
  , (
    2
    , 'Treino B'
    , '2024-02-10'
    , '2024-04-10'
    , 'Perder peso.'
  )
  , (
    3
    , 'Treino C'
    , '2024-03-15'
    , '2024-05-15'
    , 'Melhorar resistência cardiovascular.'
  )
  , (
    4
    , 'Treino D'
    , '2024-04-20'
    , '2024-06-20'
    , 'Fortalecer membros inferiores.'
  )
  , (
    5
    , 'Treino E'
    , '2024-05-25'
    , '2024-07-25'
    , 'Aumentar flexibilidade.'
  );

-- Inserir informações Equipamentos --
INSERT INTO
  Equipamento (NomeEqui)
VALUES
  ('Esteira')
  , ('Bicicleta Ergométrica')
  , ('Halteres')
  , ('Barra de Supino')
  , ('Máquina de Leg Press');

-- Inserir informações Equipamentos de treinos --
INSERT INTO
  EquiTreino (idFicha, idEqui)
VALUES
  (1, 1)
  , (1, 3)
  , (2, 2)
  , (2, 4)
  , (3, 5)
  , (3, 1)
  , (4, 3)
  , (4, 5)
  , (5, 2)
  , (5, 4);

-- Inserir informações Munutenção --
INSERT INTO
  Manutencao (idFun, idEqui, dataManu)
VALUES
  (1, 1, '2024-06-01')
  , (2, 2, '2024-06-15')
  , (3, 3, '2024-07-01')
  , (4, 4, '2024-07-15')
  , (5, 5, '2024-08-01');