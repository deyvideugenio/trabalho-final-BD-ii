-- ############## Trabalho Final de Banco de Dados 2 ################# --
DROP DATABASE academiaironwork;
-- 1ª parte: Criação do Banco de Dados --
CREATE DATABASE AcademiaIronWork;

USE AcademiaIronWork;

-- INÍCIO DA PARTE DE CRIAÇÃO DE TABELAS

-- Tabela Funcionário sendo criada --
CREATE TABLE Funcionario (
  idFun INT AUTO_INCREMENT PRIMARY KEY
  , NomeFun VARCHAR(100) NOT NULL
  , IdadeFun INT NOT NULL
  , Funcao VARCHAR(100) NOT NULL
  , TipoContrato VARCHAR(255) NOT NULL
  , ContatoFun VARCHAR(20) NOT NULL
  , TipoTreino TEXT NOT NULL
);

-- Tabela Benefício --
CREATE TABLE Beneficio (
  idBen INT AUTO_INCREMENT PRIMARY KEY
  , Tipo VARCHAR(100) NOT NULL
);

-- Tabela gerada no relacionamento n x n do Benefício e Funcionário --
CREATE TABLE BeneficioFunc (
  idFun INT NOT NULL
  , idBen INT NOT NULL
  , FOREIGN KEY (idFun) REFERENCES Funcionario(idFun)
  , FOREIGN KEY (idBen) REFERENCES Beneficio(idBen)
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
  , idParceiro INT
  , NomeAluno VARCHAR(60) NOT NULL
  , IdadeAluno INT NOT NULL
  , ContatoAluno VARCHAR(100) NOT NULL
  , FOREIGN KEY (idParceiro) REFERENCES Parceiro(idParceiro)
);

-- Tabela Endereço --
CREATE TABLE Endereco (
  idFun INT
  , idAluno INT
  , Rua VARCHAR(100) NOT NULL
  , Numero INT NOT NULL
  , Bairro VARCHAR(60) NOT NULL
  , Cidade VARCHAR(30) NOT NULL
  , Estado VARCHAR(20) NOT NULL
  , CEP VARCHAR(20) NOT NULL
  , PRIMARY KEY (Rua, Numero, CEP)  -- Chave primária composta --
  , FOREIGN KEY (idFun) REFERENCES Funcionario(idFun)
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
CREATE TABLE FichaDeCadastro (
  idCadastro INT AUTO_INCREMENT PRIMARY KEY
  , idAluno INT NOT NULL
  , DataCadastro DATE NOT NULL  -- esse atributo é novo --
  , Anamnese TEXT NOT NULL
  , FichaMedica TEXT NOT NULL
  , FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno)
);

-- Tabela Treino --
CREATE TABLE Treino (
  idFicha INT AUTO_INCREMENT PRIMARY KEY
  , idAluno INT NOT NULL
  , idFun INT NOT NULL
  , FichaTreino TEXT NOT NULL
  , DataInicio DATE NOT NULL
  , DataFim DATE NOT NULL
  , ObjetivoTreino TEXT NOT NULL -- atributo novo --
  , FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno), 
    FOREIGN KEY (idFun) REFERENCES Funcionario(idFun)
);

-- Tabela Equipamento --
CREATE TABLE Equipamento (
  idEqui INT AUTO_INCREMENT PRIMARY KEY
  , ModeloEqui VARCHAR(60) NOT NULL
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
  , -- removemos o atributo funcionarioManu VARCHAR(100) NOT NULL, pois era desnecessário --
    FOREIGN KEY (idFun) REFERENCES Funcionario(idFun)
  , FOREIGN KEY (idEqui) REFERENCES Equipamento(idEqui)
);

-- Realizando a consulta nas tabelas criadas, para verificar a construção! --

SELECT * FROM Funcionario;
SELECT * FROM Beneficio;
SELECT * FROM BeneficioFunc;
SELECT * FROM Parceiro;
SELECT * FROM Aluno;
SELECT * FROM Endereco;
SELECT * FROM Pagamento;
SELECT * FROM FichaDeCadastro;
SELECT * FROM Treino;
SELECT * FROM Equipamento;
SELECT * FROM EquiTreino;
SELECT * FROM Manutencao;

-- FIM DA PARTE DA CRIAÇÃO DE TABELAS



-- INÍCIO DA INSERÇÃO DE DADOS NAS TABELAS

-- Inserindo informações à tabela Funcionário --
INSERT INTO Funcionario (NomeFun, IdadeFun, Funcao, TipoContrato, ContatoFun, TipoTreino) VALUES
('Pedro Costa', 42, 'Proprietário', 'PJ', '0123-4567', 'Emagrecimento'),
('Carlos Silva', 34, 'Instrutor', 'CLT', '1234-5678', 'Hipertrofia'),
('Marcos Oliveira', 45, 'Personal Trainer', 'PJ', '3456-7890', 'Treino Funcional'),
('Ana Souza', 28, 'Recepcionista', 'CLT', '2345-6789', 'N/A'),
('Beatriz Santos', 32, 'Nutricionista', 'PJ', '4567-8901', 'N/A'),
('Juliana Almeida', 29, 'Coordenadora', 'CLT', '5678-9012', 'N/A');

SELECT * FROM Funcionario;

-- Inserindo informações à tabela Benefícios --
INSERT INTO Beneficio (Tipo) VALUES
('Vale Transporte'),
('Plano de Saúde'),
('Vale Refeição'),
('Seguro de Vida'),
('Auxílio Educação');

SELECT * FROM Beneficio;

-- Inserindo informações à tabela BeneficioFunc --
INSERT INTO BeneficioFunc (idFun, idBen)
VALUES 
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 1),
(2, 3),
(3, 2),
(3, 5),
(4, 1),
(4, 3),
(5, 2),
(5, 3),
(5, 4),
(6, 1),
(6, 2),
(6, 5);

SELECT * FROM BeneficioFunc;

-- Inserindo informações à tabela Parceiro --
INSERT INTO Parceiro (NomeEmpresa, TipoParceria, TipDescParceria)
VALUES 
('gymEquipment', 'Equipamento', 'Desconto de 15%'),
('FitFood', 'Alimentação', 'Desconto de 20%'),
('SportLife', 'Roupas', 'Desconto de 10%'),
('HealthyLiving', 'Suplementos', 'Desconto de 25%'),
('GymPartner', 'Serviços', 'Desconto de 30%');

SELECT * FROM Parceiro;

-- Inserindo informações à tabela Aluno --
INSERT INTO Aluno (idParceiro, NomeAluno, IdadeAluno, ContatoAluno)
VALUES 
(4, 'João Silva', 20, '(11) 91234-5678'),
(4, 'Maria Oliveira', 25, '(21) 98765-4321'),
(5, 'Pedro Santos', 19, '(31) 87654-1234'),
(4, 'Ana Souza', 31, '(41) 76543-9876'),
(4, 'Carlos Ferreira', 43, '(51) 65432-8765'),
(1, 'Mariana Costa', 60, '(12) 54321-9876'),
(2, 'José Lima', 72, '(22) 23456-7890'),
(2, 'Patrícia Pereira', 21, '(32) 76543-2109'),
(5, 'Lucas Oliveira', 18, '(42) 09876-5432'),
(1, 'Aline Silva', 23, '(52) 89076-1234'),
(4, 'Fernando Santos', 40, '(13) 12345-6789'),
(1, 'Carolina Sousa', 52, '(23) 87654-3210'),
(2, 'Rafaela Ferreira', 21, '(33) 56789-0123'),
(4, 'André Costa', 39, '(43) 54321-8765'),
(3, 'Camila Lima', 23, '(53) 98765-4321'),
(4, 'Gustavo Pereira', 20, '(14) 67890-1234'),
(1, 'Luiza Oliveira', 22, '(24) 43210-9876'),
(2, 'Diego Souza', 21, '(34) 76543-2109'),
(2, 'Beatriz Santos', 49, '(44) 21098-7654'),
(4, 'Marcelo Ferreira', 53, '(54) 87654-3210');

SELECT * FROM Aluno;

-- Inserindo informações à tabela Endereço --
INSERT INTO Endereco (idFun, idAluno, Rua, Numero, Bairro, Cidade, Estado, CEP)
VALUES 
(1, NULL, 'Avenida A', 100, 'Centro', 'Lavras', 'MG', '37200-000'),
(2, NULL, 'Avenida B', 200, 'Centro', 'Lavras', 'MG', '37200-000'),
(3, NULL, 'Rua A', 300, 'Centro', 'Lavras', 'MG', '37200-000'),
(4, NULL, 'Rua A', 400, 'Cruzeiro do Sul', 'Lavras', 'MG', '37200-000'),
(5, NULL, 'Rua B', 500, 'Zona Norte', 'Lavras', 'MG', '37200-000'),
(6, NULL, 'Rua C', 600, 'Zona Norte', 'Lavras', 'MG', '37200-000'),
(NULL, 1, 'Rua A', '100', 'Centro', 'Lavras', 'MG', '37200-000'),
(NULL, 2, 'Avenida D', '200', 'Centro', 'Lavras', 'MG', '37200-000'),
(NULL, 3, 'Rua B', '300', 'Zona Norte', 'Lavras', 'MG', '37200-000'),
(NULL, 4, 'Avenida C', '400', 'Zona Sul', 'Lavras', 'MG', '37200-000'),
(NULL, 5, 'Rua A', '500', 'Centro', 'Lavras', 'MG', '37200-000'),
(NULL, 6, 'Avenida D', '600', 'Centro', 'Lavras', 'MG', '37200-000'),
(NULL, 7, 'Rua B', '700', 'Zona Norte', 'Lavras', 'MG', '37200-000'),
(NULL, 8, 'Avenida C', '800', 'Cruzeiro do Sul', 'Lavras', 'MG', '37200-000'),
(NULL, 9, 'Rua A', '900', 'Centro', 'Lavras', 'MG', '37200-000'),
(NULL, 10, 'Avenida D', '1000', 'Zona Sul', 'Lavras', 'MG', '37200-000'),
(NULL, 11, 'Rua B', '1100', 'Zona Norte', 'Lavras', 'MG', '37200-000'),
(NULL, 12, 'Avenida C', '1200', 'Zona Norte', 'Lavras', 'MG', '37200-000'),
(NULL, 13, 'Rua A', '1300', 'Cruzeiro do Sul', 'Lavras', 'MG', '37200-000'),
(NULL, 14, 'Avenida D', '1400', 'Centro', 'Lavras', 'MG', '37200-000'),
(NULL, 15, 'Rua B', '1500', 'Centro', 'Lavras', 'MG', '37200-000'),
(NULL, 16, 'Avenida C', '1600', 'Zona Norte', 'Lavras', 'MG', '37200-000'),
(NULL, 17, 'Rua A', '1700', 'Zona Sul', 'Lavras', 'MG', '37200-000'),
(NULL, 18, 'Avenida D', '1800', 'Zona Sul', 'Lavras', 'MG', '37200-000'),
(NULL, 19, 'Rua B', '1900', 'Centro', 'Lavras', 'MG', '37200-000'),
(NULL, 20, 'Avenida C', '2000', 'Centro', 'Lavras', 'MG', '37200-000');

SELECT * FROM Endereco ORDER BY idaluno;

-- Inserindo informações à tabela Pagamento --
INSERT INTO Pagamento (idAluno, DataPagamento, PlanoContratado, Valor)
VALUES 
(1, '2024-06-01', 'Mensal', 150.00),
(2, '2024-06-02', 'Trimestral', 400.00),
(3, '2024-06-03', 'Semestral', 750.00),
(4, '2024-06-04', 'Mensal', 150.00),
(5, '2024-06-05', 'Trimestral', 400.00),
(6, '2024-06-06', 'Mensal', 150.00),
(7, '2024-06-07', 'Semestral', 750.00),
(8, '2024-06-08', 'Mensal', 150.00),
(9, '2024-06-09', 'Trimestral', 400.00),
(10, '2024-06-10', 'Semestral', 750.00),
(11, '2024-06-11', 'Mensal', 150.00),
(12, '2024-06-12', 'Trimestral', 400.00),
(13, '2024-06-13', 'Mensal', 150.00),
(14, '2024-06-14', 'Semestral', 750.00),
(15, '2024-06-15', 'Mensal', 150.00),
(16, '2024-06-16', 'Trimestral', 400.00),
(17, '2024-06-17', 'Semestral', 750.00),
(18, '2024-06-18', 'Mensal', 150.00),
(19, '2024-06-19', 'Trimestral', 400.00),
(20, '2024-06-20', 'Mensal', 150.00);

SELECT * FROM Pagamento;

-- Inserindo informações à tabela FichaDeCadastro --
INSERT INTO FichaDeCadastro (idAluno, DataCadastro, Anamnese, FichaMedica)
VALUES 
(1, '2023-05-10', 'Paciente sem histórico de doenças crônicas.', 'Apto para atividades físicas regulares.'),
(2, '2022-09-15', 'Histórico de alergias a determinados alimentos.', 'Necessário acompanhamento odontológico.'),
(3, '2021-07-20', 'Praticante de esportes desde a adolescência.', 'Recomenda-se fisioterapia preventiva.'),
(4, '2020-03-05', 'Tratamento anterior para lesão no joelho esquerdo.', 'Apto para atividades físicas moderadas.'),
(5, '2019-11-18', 'Histórico de hipertensão controlada.', 'Monitorar pressão arterial regularmente.'),
(6, '2018-02-12', 'Sedentarismo e histórico de obesidade na família.', 'Iniciar programa de atividades físicas com orientação.'),
(7, '2017-06-25', 'Doença crônica autoimune em remissão.', 'Avaliação periódica com reumatologista.'),
(8, '2016-10-30', 'Lesão anterior no ombro direito.', 'Evitar esforços repetitivos e adotar técnicas corretas.'),
(9, '2015-04-08', 'Histórico de tabagismo, cessação há 2 anos.', 'Monitorar função pulmonar regularmente.'),
(10, '2014-08-14', 'Sem histórico significativo de doenças.', 'Apto para prática de atividades físicas.'),
(11, '2013-11-21', 'Reabilitação após cirurgia ortopédica.', 'Seguir programa de reabilitação conforme orientação médica.'),
(12, '2012-01-19', 'Histórico de diabetes tipo 2 controlado com medicação.', 'Monitorar glicemia e realizar exercícios regularmente.'),
(13, '2011-03-27', 'Tratamento anterior para lesão na coluna vertebral.', 'Evitar impactos e adotar postura correta.'),
(14, '2010-09-02', 'Praticante de yoga e meditação regularmente.', 'Manter estilo de vida saudável e atividades físicas. Apto para prática de atividades físicas'),
(15, '2009-12-11', 'Histórico de doenças cardiovasculares na família.', 'Monitorar pressão arterial e realizar exames cardiológicos periódicos.'),
(16, '2008-04-30', 'Histórico de cirurgia abdominal há 5 anos.', 'Recomenda-se evitar exercícios abdominais intensos.'),
(17, '2007-08-17', 'História de trauma craniano leve na infância.', 'Monitorar sintomas neurológicos e atividades físicas.'),
(18, '2006-10-23', 'Sem histórico significativo de doenças.', 'Avaliação de saúde geral estável. Apto para prática de atividades físicas.'),
(19, '2005-01-07', 'Lesão anterior no tornozelo direito.', 'Recomenda-se fortalecimento muscular e suporte ortopédico.'),
(20, '2004-03-14', 'Histórico de hipotireoidismo controlado com medicação.', 'Monitorar função tireoidiana e atividades físicas.');

SELECT * FROM FichaDeCadastro;

-- Inserindo informações à tabela Treino --
INSERT INTO Treino (idAluno, idFun, FichaTreino, DataInicio, DataFim, ObjetivoTreino)
VALUES 
(1, 1, 'Treino A', '2024-06-01', DATE_ADD('2024-06-01', INTERVAL 60 DAY), 'Hipertrofia'),
(2, 2, 'Treino B', '2024-06-02', DATE_ADD('2024-06-02', INTERVAL 60 DAY), 'Emagrecimento'),
(3, 3, 'Treino C', '2024-06-03', DATE_ADD('2024-06-03', INTERVAL 60 DAY), 'Treino Funcional'),
(4, 1, 'Treino A', '2024-06-04', DATE_ADD('2024-06-04', INTERVAL 60 DAY), 'Hipertrofia'),
(5, 1, 'Treino A', '2024-06-05', DATE_ADD('2024-06-05', INTERVAL 60 DAY), 'Hipertrofia'),
(6, 1, 'Treino A', '2024-06-06', DATE_ADD('2024-06-06', INTERVAL 60 DAY), 'Hipertrofia'),
(7, 1, 'Treino A', '2024-06-07', DATE_ADD('2024-06-07', INTERVAL 60 DAY), 'Hipertrofia'),
(8, 2, 'Treino B', '2024-06-08', DATE_ADD('2024-06-08', INTERVAL 60 DAY), 'Emagrecimento'),
(9, 1, 'Treino A', '2024-06-09', DATE_ADD('2024-06-09', INTERVAL 60 DAY), 'Hipertrofia'),
(10, 1, 'Treino A', '2024-06-10', DATE_ADD('2024-06-10', INTERVAL 60 DAY), 'Hipertrofia'),
(11, 1, 'Treino A', '2024-06-11', DATE_ADD('2024-06-11', INTERVAL 60 DAY), 'Hipertrofia'),
(12, 3, 'Treino C', '2024-06-12', DATE_ADD('2024-06-12', INTERVAL 60 DAY), 'Treino Funcional'),
(13, 1, 'Treino A', '2024-06-13', DATE_ADD('2024-06-13', INTERVAL 60 DAY), 'Hipertrofia'),
(14, 2, 'Treino B', '2024-06-14', DATE_ADD('2024-06-14', INTERVAL 60 DAY), 'Emagrecimento'),
(15, 1, 'Treino A', '2024-06-15', DATE_ADD('2024-06-15', INTERVAL 60 DAY), 'Hipertrofia'),
(16, 1, 'Treino A', '2024-06-16', DATE_ADD('2024-06-16', INTERVAL 60 DAY), 'Hipertrofia'),
(17, 2, 'Treino B', '2024-06-17', DATE_ADD('2024-06-17', INTERVAL 60 DAY), 'Emagrecimento'),
(18, 3, 'Treino C', '2024-06-18', DATE_ADD('2024-06-18', INTERVAL 60 DAY), 'Treino Funcional'),
(19, 1, 'Treino A', '2024-06-19', DATE_ADD('2024-06-19', INTERVAL 60 DAY), 'Hipertrofia'),
(20, 2, 'Treino B', '2024-06-20', DATE_ADD('2024-06-20', INTERVAL 60 DAY), 'Emagrecimento');

SELECT * FROM Treino;

-- Inserindo informações à tabela Equipamento --
INSERT INTO Equipamento (ModeloEqui)
VALUES 
('Esteira'),
('Corda Naval'),
('Halteres'),
('Barra de Supino'),
('Máquina de Leg Press');

SELECT * FROM Equipamento;

-- Inserindo infrormações à tabela EquiTreino --
INSERT INTO EquiTreino (idFicha, idEqui)
VALUES 
(1, 3),
(1, 4),
(1, 5),
(2, 1),
(2, 2),
(2, 5),
(3, 2),
(3, 3),
(4, 1),
(4, 3),
(4, 4),
(4, 5),
(5, 4),
(5, 5),
(6, 3),
(6, 4),
(6, 5),
(7, 1),
(7, 3),
(7, 4),
(7, 5),
(8, 1),
(8, 2),
(9, 4),
(9, 5),
(10, 3),
(10, 4),
(10, 5),
(11, 1),
(11, 3),
(11, 5),
(12, 1),
(12, 2),
(12, 3),
(13, 2),
(13, 3),
(13, 4),
(13, 5),
(14, 1),
(14, 2),
(15, 4),
(15, 5),
(16, 1),
(16, 3),
(16, 5),
(17, 1),
(17, 2),
(17, 3),
(18, 2),
(19, 1),
(19, 4),
(19, 5),
(20, 1),
(20, 2);

SELECT * FROM EquiTreino;

-- Inserindo informações à tabela Manutenção --
INSERT INTO Manutencao (idFun, idEqui, dataManu)
VALUES 
(1, 1, '2020-06-01'),
(2, 5, '2021-06-15'),
(1, 5, '2021-07-01'),
(1, 4, '2022-07-15'),
(2, 5, '2022-08-01'),
(1, 2, '2022-06-15'),
(1, 3, '2023-07-01'),
(1, 1, '2024-05-15'),
(2, 5, '2024-06-01');

SELECT * FROM Manutencao;

-- FIM DA PARTE DE INSERÇÃO DE DADOS NAS TABELAS



-- INÍCIO DA PARTE DE MANIPULAÇÃO DAS TABELAS E DADOS

-- O código abaixo renomeia a coluna TipoParceria para TipoDeParceria e a coluna TipDescontoParceria para Desconto na tabela Parceiro
ALTER TABLE Parceiro
CHANGE COLUMN TipoParceria TipoDeParceria VARCHAR(100) NOT NULL,
CHANGE COLUMN TipDescParceria Desconto VARCHAR(100) NOT NULL;

SELECT * FROM Parceiro;

-- O código abaixo atualiza os dados da coluna desconto para o valor do desconto somente (sem texto)
UPDATE Parceiro
SET Desconto = CASE Desconto
  WHEN 'Desconto de 10%' THEN 10
  WHEN 'Desconto de 15%' THEN 15
  WHEN 'Desconto de 20%' THEN 20
  WHEN 'Desconto de 25%' THEN 25
  WHEN 'Desconto de 30%' THEN 30
  ELSE Desconto
END
WHERE idParceiro IN (1, 2, 3, 4, 5);

SELECT * FROM Parceiro;

-- O código abaixo altera o tipo de dado da coluna Desconto para INT
ALTER TABLE Parceiro
CHANGE COLUMN Desconto Desconto INT;

SELECT * FROM Parceiro;

-- O código abaixo renomeia a coluna ModeloEqui da tabela Equipamento para NomeEquip
ALTER TABLE Equipamento
CHANGE COLUMN ModeloEqui NomeEquip VARCHAR(60) NOT NULL;

SELECT * FROM Equipamento;

-- O código abaixo atualiza o nome do aluno com idAluno = 1 para 'Chewbacca Tilápio III'
UPDATE Aluno
SET NomeAluno = 'Chewbacca Tilápio III'
WHERE idAluno = 1;

SELECT * FROM Aluno;

-- O código abaixo atualiza o contato do funcionário com idFun = 3 para '6543-7890'
UPDATE Funcionario
SET ContatoFun = '6543-7890'
WHERE idFun = 3;

SELECT * FROM Funcionario;

-- O código abaixo adiciona a coluna Email na tabela Aluno
ALTER TABLE Aluno
ADD COLUMN Email VARCHAR(100) NOT NULL AFTER ContatoAluno;

SELECT * FROM Aluno;

-- O código abaixo adiciona a coluna Turno na tabela Funcionario
ALTER TABLE Funcionario
ADD COLUMN Turno VARCHAR(20) NOT NULL AFTER Funcao;

SELECT * FROM Funcionario;

-- O código abaixo remove a coluna IdadeFun da tabela Funcionario
ALTER TABLE Funcionario
DROP COLUMN IdadeFun;

SELECT * FROM Funcionario;

-- FIM DA PARTE DE MANIPULAÇÃO DAS TABELAS E DADOS



-- INÍCIO DAS CONSULTAS SIMPLES

-- Consulta simples: total de alunos da academia
SELECT COUNT(*) AS 'Total de Alunos' FROM ALUNO;


-- Consulta simples: equipamentos disponíveis na academia
SELECT NomeEquip AS 'Equipamentos disponíveis' FROM Equipamento;


-- Consulta simples: idade média dos alunos da academia
SELECT AVG(idadeAluno) AS 'Idade Média dos Alunos' FROM Aluno;


-- Consulta simples: alunos com idade entre 25 e 50 anos
SELECT * FROM aluno WHERE idadeAluno BETWEEN 25 AND 50;


-- Consulta simples: nome, idade e contato dos alunos com idade superior a 25 anos
SELECT NomeAluno AS 'Nome do Aluno', IdadeAluno AS Idade, ContatoAluno AS 'Telefone' FROM Aluno WHERE IdadeAluno > 25;


-- Consulta simples: nome e função dos funcionários cujo tipo de contrato é CLT
SELECT nomeFun, funcao, tipoContrato FROM Funcionario WHERE tipoContrato = 'CLT';


-- Consulta simples: endereços de ALUNOS em que os bairros contenham a palavra 'sul'
SELECT * FROM Endereco WHERE Bairro LIKE '%sul%' AND idAluno IS NOT NULL;


-- Consulta simples: endereços de FUNCIONÁRIOS em que os bairros contenham a palavra 'norte'
SELECT * FROM Endereco WHERE Bairro LIKE '%norte%' AND idFun IS NOT NULL;


-- Consulta simples: quantos alunos fazem o pagamento mensalmente
SELECT COUNT(*) FROM Pagamento WHERE planoContratado = 'Mensal';


-- Consulta simples: total de manutenções realizadas em 2022
SELECT COUNT(*) AS 'Manutenções em 2022' FROM MANUTENCAO WHERE dataManu LIKE '2022%';


-- Consulta simples utilizando group by: cadastro mais recente
SELECT MAX(dataCadastro) AS 'Cadastro mais recente' FROM fichadecadastro;

-- Consulta simples: planos mais usados
SELECT 
    planoContratado AS Plano,
    COUNT(planoContratado) AS Quantidade
FROM
    Pagamento
GROUP BY planoContratado;


-- Consulta simples utilizando subconsulta: parceiro que oferece o menor desconto dentre os parceiros
SELECT 
    nomeEmpresa AS Empresa, Desconto
FROM
    Parceiro
WHERE
    Desconto = (SELECT 
            MIN(Desconto)
        FROM
            Parceiro);


-- Consulta simples utilizando subconsulta: nome e contato dos alunos que estão associados a parceiros que oferecem desconto de 20% ou mais
SELECT NomeAluno, contatoAluno
FROM Aluno
WHERE idParceiro IN (
    SELECT idParceiro
    FROM Parceiro
    WHERE Desconto > 20
);



-- INÍCIO DAS CONSULTAS COMPLEXAS

-- Consulta complexa: nome e endereço de funcionários em que os bairros contenham a palavra 'norte'
SELECT 
    f.nomeFun AS Nome, e.Rua, e.Numero, e.Bairro, e.Cidade
FROM
    Endereco AS e
        INNER JOIN
    Funcionario AS f ON e.idFun = f.idFun
WHERE
    e.Bairro LIKE '%norte%'
        AND e.idFun IS NOT NULL;


-- Consulta complexa: nome dos alunos que fazem treino de emagrecimento ou treino funcional, ordenados pelo objetivo do treino
SELECT 
    a.nomeAluno, t.objetivoTreino
FROM
    Treino AS t
        INNER JOIN
    Aluno AS a ON a.idAluno = t.idAluno
WHERE
    objetivoTreino IN ('Emagrecimento' , 'Treino Funcional')
ORDER BY objetivoTreino;


-- Consulta complexa: data e o nome do funcionário que fez a manutenção em um determinado equipamento
SELECT 
    NomeFun, dataManu, nomeEquip
FROM
    Manutencao
        INNER JOIN
    Funcionario ON manutencao.idFun = funcionario.idFun
        INNER JOIN
    Equipamento ON manutencao.idEqui = equipamento.idEqui
ORDER BY dataManu;


-- Consulta complexa: nome e data dos 5 primeiros alunos cadastros da academia, partindo do mais antigo
SELECT 
    aluno.nomeAluno, fichadecadastro.datacadastro
FROM
    FichaDeCadastro
        INNER JOIN
    Aluno ON Aluno.idAluno = FichaDeCadastro.idAluno
ORDER BY DataCadastro ASC
LIMIT 5;


-- Consulta complexa: quantidade de alunos por parceiros em ordem decrescente
SELECT 
    p.NomeEmpresa AS Parceiro, COUNT(a.idAluno) AS 'Numero de Alunos'
FROM
    Aluno a
        INNER JOIN
    Parceiro p ON a.idParceiro = p.idParceiro
GROUP BY p.NomeEmpresa ORDER BY COUNT(a.idAluno) DESC;


-- Consulta complexa: nomes e contatos dos alunos cujo plano contratado seja mensal e a data do pagamento seja anterior a '2024-06-10'
SELECT 
    a.nomeAluno,
    a.contatoAluno,
    p.planoContratado,
    p.dataPagamento
FROM
    Pagamento AS p
        INNER JOIN
    Aluno AS a ON a.idAluno = p.idAluno
WHERE
    p.planoContratado = 'Mensal'
        AND dataPagamento < '2024-06-10';


-- Consulta complexa: qual parceria e tipo de parceria cada aluno possui
SELECT 
    aluno.nomeAluno,
    Parceiro.NomeEmpresa,
    Parceiro.TipoDeParceria
FROM
    Aluno
        INNER JOIN
    Parceiro
WHERE
    aluno.idparceiro = parceiro.idparceiro;


-- Consulta complexa: quais os alunos de cada instrutor ordenados por instrutor
SELECT 
    f.nomefun AS Instrutor, a.nomealuno AS Aluno
FROM
    Treino AS t
        INNER JOIN
    Aluno AS a ON a.idAluno = t.idAluno
        INNER JOIN
    Funcionario AS f ON t.idFun = f.idFun ORDER BY instrutor;


-- Consulta complexa usando subconsultas e UNION: aluno mais novo e aluno mais velho
SELECT 
    nomeAluno, idadeAluno
FROM
    (SELECT 
        nomeAluno, idadeAluno
    FROM
        Aluno
    ORDER BY idadeAluno ASC
    LIMIT 1) AS aluno_mais_novo 
UNION ALL SELECT 
    nomeAluno, idadeAluno
FROM
    (SELECT 
        nomeAluno, idadeAluno
    FROM
        Aluno
    ORDER BY idadeAluno DESC
    LIMIT 1) AS aluno_mais_velho;
    

-- Consulta complexa: nome dos alunos que estão "aptos" para atividade física
SELECT 
    a.idAluno, a.nomeAluno, fc.fichaMedica
FROM
    FICHADECADASTRO AS fc
        INNER JOIN
    Aluno AS a ON fc.idAluno = a.idAluno
WHERE
    fc.fichaMedica LIKE '%apto%';


-- Consulta complexa: nome do aluno, objetivo do treino e equipamentos usados no treino (exibidos na mesma linha), agrupada por aluno e objetivo do treino
SELECT 
    a.idAluno,
    a.nomeAluno AS 'Nome Aluno',
    t.objetivoTreino AS 'Objetivo do Treino',
    GROUP_CONCAT(e.nomeEquip
        SEPARATOR ', ') AS 'Equipamento'
FROM
    Aluno AS a
        INNER JOIN
    Treino AS t ON a.idAluno = t.idAluno
        INNER JOIN
    EquiTreino AS et ON t.idFicha = et.idFicha
        INNER JOIN
    Equipamento AS e ON e.idEqui = et.idEqui
GROUP BY a.idAluno , t.objetivoTreino;

    
-- Consulta complexa: equipamento mais usado na academia
SELECT 
    et.idEqui,
    e.nomeEquip AS Equipamento,
    (SELECT 
            COUNT(*)
        FROM
            equiTreino
        WHERE
            idEqui = et.idEqui) AS Total_Utilizacoes
FROM
    equiTreino AS et
        INNER JOIN
    Equipamento AS e ON et.idEqui = e.idEqui
ORDER BY Total_Utilizacoes DESC
LIMIT 1;


-- Consulta complexa: nome do instrutor, sua função, nome do aluno, tipo de treino associado ao aluno, o objetivo do treino e equipamentos usados no treino
SELECT 
    f.NomeFun,
    f.Funcao,
    a.NomeAluno,
    t.FichaTreino,
    t.objetivoTreino,
    GROUP_CONCAT(e.nomeEquip
        SEPARATOR ', ') AS 'Equipamento'
FROM
    Funcionario f
        INNER JOIN
    Treino t ON f.idFun = t.idFun
        INNER JOIN
    Aluno a ON t.idAluno = a.idAluno
        INNER JOIN
    EquiTreino et ON t.idFicha = et.idFicha
        INNER JOIN
    Equipamento e ON et.idEqui = e.idEqui
GROUP BY f.nomeFun , f.funcao , a.nomeAluno , t.fichaTreino, t.objetivoTreino;

-- FIM DA PARTE DAS CONSULTAS



-- INÍCIO DAS VIEWS

-- View de consulta complexa: nomes e contatos dos alunos cujo plano contratado seja mensal e a data do pagamento seja anterior a '2024-06-10'
CREATE VIEW view_nomeAluno_contato_planoMensal_pg20240610 AS
    SELECT 
        a.nomeAluno,
        a.contatoAluno,
        p.planoContratado,
        p.dataPagamento
    FROM
        Pagamento AS p
            INNER JOIN
        Aluno AS a ON a.idAluno = p.idAluno
    WHERE
        p.planoContratado = 'Mensal'
            AND dataPagamento < '2024-06-10';

-- Testando view_nomeAluno_contato_planoMensal_pg20240610:
SELECT * FROM view_nomeAluno_contato_planoMensal_pg20240610;


-- View de consulta complexa: nome do aluno, objetivo do treino e equipamentos usados no treino (exibidos na mesma linha), agrupada por aluno e objetivo do treino
CREATE VIEW view_nomeAluno_objetivotreino_equip AS
    SELECT 
        a.idAluno,
        a.nomeAluno AS 'Nome Aluno',
        t.objetivoTreino AS 'Objetivo do Treino',
        GROUP_CONCAT(e.nomeEquip
            SEPARATOR ', ') AS 'Equipamento'
    FROM
        Aluno AS a
            INNER JOIN
        Treino AS t ON a.idAluno = t.idAluno
            INNER JOIN
        EquiTreino AS et ON t.idFicha = et.idFicha
            INNER JOIN
        Equipamento AS e ON e.idEqui = et.idEqui
    GROUP BY a.idAluno , t.objetivoTreino;

-- Testando view_nomeAluno_objetivotreino_equip
SELECT * FROM view_nomeAluno_objetivotreino_equip;

-- View de consulta complexa: nome do instrutor, sua função, nome do aluno, tipo de treino associado ao aluno, equipamentos usados no treino e o objetivo do treino
CREATE VIEW view_nomeInstrutor_funcao_nomeAluno_treino_equip_objetivo AS
SELECT 
    f.NomeFun,
    f.Funcao,
    a.NomeAluno,
    t.FichaTreino,
    GROUP_CONCAT(e.nomeEquip
        SEPARATOR ', ') AS 'Equipamento',
    t.objetivoTreino
FROM
    Funcionario f
        INNER JOIN
    Treino t ON f.idFun = t.idFun
        INNER JOIN
    Aluno a ON t.idAluno = a.idAluno
        INNER JOIN
    EquiTreino et ON t.idFicha = et.idFicha
        INNER JOIN
    Equipamento e ON et.idEqui = e.idEqui
GROUP BY f.nomeFun , f.funcao , a.nomeAluno , t.fichaTreino, t.objetivoTreino;

-- Testanto view_nomeInstrutor_funcao_nomeAluno_treino_equip_objetivo:
SELECT * FROM view_nomeInstrutor_funcao_nomeAluno_treino_equip_objetivo;

-- FIM DAS VIEWS



-- INÍCIO DOS TRIGGERS

-- Este trigger é disparado sempre que um novo funcionário é adicionado à tabela Funcionario. Ele atribui ao novo funcionário dois benefícios padrão: Vale Transporte e Vale Refeição
DELIMITER //
CREATE TRIGGER adicionarBeneficiosPadrao AFTER INSERT ON Funcionario FOR EACH ROW
BEGIN
-- Inserindo benefício 'Vale Transporte' (idBen = 1)
INSERT INTO BeneficioFunc (idBen, idFun) VALUES (1, NEW.idFun);
-- Inserindo benefício 'Vale Refeição' (idBen = 3)
INSERT INTO BeneficioFunc (idBen, idFun) VALUES (3, NEW.idFun);
END;
//
DELIMITER ;

-- Testando trigger 'adicionarBeneficiosPadrao'
INSERT INTO Funcionario (NomeFun, Funcao, Turno, TipoContrato, ContatoFun, TipoTreino) VALUES
('Lucas Oliveira', 'Instrutor', 'Tarde', 'CLT', '1122-3344', 'Emagrecimento'),
('William Lopes', 'Instrutor', 'Manhã', 'CLT', '5566-7788', 'Hipertrofia');

-- Consulta que mostra o benefício de cada funcionário (note que Lucas Oliveira e William Lopes foram inseridos com os benefícios padrão)
SELECT 
    f.nomeFun,
    GROUP_CONCAT(b.tipo
        SEPARATOR ', ') AS 'Benefício'
FROM
    Funcionario AS f
        INNER JOIN
    beneficioFunc AS bf ON f.idFun = bf.idFun
        INNER JOIN
    beneficio AS b ON b.idBen = bf.idBen
GROUP BY nomeFun
ORDER BY nomeFun;

-- Verificando a tabela aluno --
SELECT * FROM aluno;


-- Trigger para criação de email para alunos
-- Primeiro vamos criar os emails para os alunos já existentes

UPDATE Aluno
SET email = CONCAT(
    LOWER(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(NomeAluno, ' ', ''),
                                'á', 'a'
                            ),
                            'é', 'e'
                        ),
                        'í', 'i'
                    ),
                    'ê', 'e'
                ),
                'õ', 'o'
            ),
            'ã', 'a'
        )
    ),
    '@ironwork.com'
)
WHERE idAluno > 0;

-- Verificando os emails criados
SELECT * FROM aluno;


-- Criando o trigger que gera emails para os próximos alunos cadastrados
DELIMITER //

CREATE TRIGGER gerarEmail
BEFORE INSERT ON Aluno
FOR EACH ROW
BEGIN
    DECLARE nome_aluno VARCHAR(60);
    DECLARE email_aluno VARCHAR(100);

    -- Obtém o nome do aluno a partir da nova inserção e formata
    SET nome_aluno = NEW.NomeAluno;

    -- Gera o email com o domínio @ironwork.com
    SET email_aluno = CONCAT(
        LOWER(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(nome_aluno, ' ', ''),
                                    'á', 'a'
                                ),
                                'é', 'e'
                            ),
                            'í', 'i'
                        ),
                        'ê', 'e'
                    ),
                    'õ', 'o'
                ),
                'ã', 'a'
            )
        ),
        '@ironwork.com'
    );

    -- Insere o email gerado na nova linha a ser inserida
    SET NEW.email = email_aluno;
END //

DELIMITER ;


-- Testando o trigger gerarEmail
INSERT INTO Aluno (IdParceiro, NomeAluno, IdadeAluno, ContatoAluno)
VALUES 
(1, 'João Paulo', 30, '(35) 9111111111');


-- Verificando se o trigger foi disparado corretamente
SELECT * FROM aluno;
