CREATE SCHEMA IF NOT EXISTS dw_eal;
SET search_path=dw_eal;

TRUNCATE TABLE FactExamePratico CASCADE;
DELETE FROM DimAluno;
DELETE FROM DimInstrutor;
DELETE FROM DimVeiculo;
DELETE FROM DimCalendario;

-- Dimensão Aluno
CREATE TABLE IF NOT EXISTS dw_eal.DimAluno (
    SKAluno UUID PRIMARY KEY,
    AlunoID INT,
    AlunoNome VARCHAR,
    AlunoEmail VARCHAR,
    AlunoCelular VARCHAR,
    DataNascimento DATE,
    Bairro VARCHAR,
    Municipio VARCHAR,
    Estado VARCHAR(2)
);

INSERT INTO dw_eal.DimAluno (
    SKAluno,
    AlunoID,
    AlunoNome,
    AlunoEmail,
    AlunoCelular,
    DataNascimento,
    Bairro,
    Municipio,
    Estado
)
SELECT 
    gen_random_uuid() AS SKAluno,
    a.AlunoID,
    a.AlunoNome,
    a.AlunoEmail,
    a.AlunoCelular,
    a.DataNascimento,
    a.Bairro,
    a.Municipio,
    a.Estado
FROM oper_eal.Aluno a;

-- Dimensão Instrutor
CREATE TABLE IF NOT EXISTS dw_eal.DimInstrutor (
    SKInstrutor UUID PRIMARY KEY,
    InstrutorID INT,
    InstrutorNome VARCHAR,
    InstrutorSalario FLOAT
);

INSERT INTO dw_eal.DimInstrutor (
    SKInstrutor,
    InstrutorID,
    InstrutorNome,
    InstrutorSalario
)
SELECT 
    gen_random_uuid() AS SKInstrutor,
    f.FuncID AS InstrutorID,
    f.FuncNome AS InstrutorNome,
    f.Salario AS InstrutorSalario
FROM oper_eal.Funcionario f 
WHERE f.Cargo IN ('Instrutor Teórico', 'Instrutor Prático');

-- Dimensão Veículo
CREATE TABLE IF NOT EXISTS dw_eal.DimVeiculo (
    SKVeiculo UUID PRIMARY KEY,
    VeiculoID INT,
    VeiculoModelo VARCHAR,
    VeiculoTipo VARCHAR
);

INSERT INTO dw_eal.DimVeiculo (
    SKVeiculo,
    VeiculoID,
    VeiculoModelo,
    VeiculoTipo
)
SELECT 
    gen_random_uuid() AS SKVeiculo,
    v.IDVeiculo,
    v.Modelo AS VeiculoModelo,
    v.VeiculoTipo
FROM oper_eal.Veiculo v;

-- Dimensão Calendário  
CREATE TABLE IF NOT EXISTS dw_eal.DimCalendario (
    SKCalendario UUID PRIMARY KEY,
    CalendarioData DATE,
    CalendarioDia INT,
    CalendarioMes INT,
    CalendarioAno INT,
    CalendarioTrimestre INT,
    CalendarioNomeMes VARCHAR,
    CalendarioNomeDiaSemana VARCHAR,
    CalendarioDiaAno INT,
    CalendarioTipoDia VARCHAR
);

INSERT INTO dw_eal.DimCalendario (
    SKCalendario,
    CalendarioData,
    CalendarioDia,
    CalendarioMes,
    CalendarioAno,
    CalendarioTrimestre,
    CalendarioNomeMes,
    CalendarioNomeDiaSemana,
    CalendarioDiaAno,
    CalendarioTipoDia
)
SELECT 
    gen_random_uuid() AS SKCalendario,
    a.AulaData AS CalendarioData,
    EXTRACT(DAY FROM a.AulaData) AS CalendarioDia,
    EXTRACT(MONTH FROM a.AulaData) AS CalendarioMes,
    EXTRACT(YEAR FROM a.AulaData) AS CalendarioAno,
    EXTRACT(QUARTER FROM a.AulaData) AS CalendarioTrimestre,
    TO_CHAR(a.AulaData, 'Month') AS CalendarioNomeMes,
    TO_CHAR(a.AulaData, 'Day') AS CalendarioNomeDiaSemana,
    EXTRACT(DOY FROM a.AulaData) AS CalendarioDiaAno,
    CASE 
        WHEN EXTRACT(DOW FROM a.AulaData) IN (0, 6) THEN 'Fim de Semana'
        ELSE 'Dia de Semana'
    END AS CalendarioTipoDia
FROM oper_eal.Aula a
WHERE NOT EXISTS (
    SELECT 1 FROM dw_eal.DimCalendario dc 
    WHERE dc.CalendarioData = a.AulaData
);

-- Fato Aula Prática
CREATE TABLE IF NOT EXISTS dw_eal.FactAulaPratica (
    SKAulaPratica UUID PRIMARY KEY,
    SKAluno UUID,
    SKInstrutor UUID,
    SKVeiculo UUID,
    SKCalendario UUID,
    DtHrInicio TIMESTAMP,
    DtHrFim TIMESTAMP,
    StatusAula VARCHAR,
    DuracaoAula FLOAT
);

INSERT INTO dw_eal.FactAulaPratica (
    SKAulaPratica,
    SKAluno,
    SKInstrutor,
    SKVeiculo,
    SKCalendario,
    DtHrInicio,
    DtHrFim,
    StatusAula,
    DuracaoAula
)
SELECT
    gen_random_uuid() AS SKAulaPratica,
    da.SKAluno,
    di.SKInstrutor,
    dv.SKVeiculo,
    dc.SKCalendario,
    va.DtHrInicio,
    va.DtHrFim,
    CASE 
        WHEN va.DtHrFim IS NULL THEN 'Agendada'
        WHEN va.DtHrFim::timestamp = va.DtHrInicio::timestamp THEN 'Cancelada'
        ELSE 'Realizada'
    END AS StatusAula,
    CASE 
        WHEN va.DtHrFim IS NOT NULL AND va.DtHrFim::timestamp > va.DtHrInicio::timestamp
        THEN EXTRACT(EPOCH FROM (va.DtHrFim::timestamp - va.DtHrInicio::timestamp)) / 60
        ELSE 0
    END AS DuracaoAula
FROM oper_eal.VeiculoAula va
JOIN oper_eal.AulaPratica ap ON va.AulaID = ap.AulaID
JOIN oper_eal.Aula a ON ap.AulaID = a.AulaID
JOIN dw_eal.DimAluno da ON ap.AlunoID = da.AlunoID
JOIN dw_eal.DimInstrutor di ON a.FuncID = di.InstrutorID
JOIN dw_eal.DimVeiculo dv ON va.IDVeiculo = dv.VeiculoID
JOIN dw_eal.DimCalendario dc ON a.AulaData = dc.CalendarioData;

-- Fato Exame Prático

CREATE TABLE IF NOT EXISTS dw_eal.FactExamePratico (
    SKExamePratico UUID PRIMARY KEY,
    SKAluno UUID NOT NULL,
    SKInstrutor UUID,  
    SKVeiculo UUID,
    SKCalendario UUID,
    DtHrInicio TIMESTAMP,
    DtHrFim TIMESTAMP,
    StatusExame VARCHAR NOT NULL

);

INSERT INTO dw_eal.FactExamePratico(
    SKExamePratico,
    SKAluno,
    SKInstrutor, 
    SKVeiculo,
    SKCalendario,
    DtHrInicio,
    DtHrFim,
    StatusExame
)
SELECT 
    gen_random_uuid() AS SKExamePratico,
    da.SKAluno,
    di.SKInstrutor,
    dv.SKVeiculo,
    dc.SKCalendario,
    ex.DtHrInicio,
    ex.DtHrFim,
    CASE 
        WHEN ex.DtHrFim IS NULL THEN 'Agendada'
        WHEN ex.DtHrFim::timestamp = va.DtHrInicio::timestamp THEN 'Cancelada'
        WHEN rand() < 0.8 THEN 'Reprovado'
        ELSE 'Aprovado'
    END AS StatusExame

FROM oper_eal.ExamePratico ep
JOIN oper_eal.Exame ex on ex.ExameID = ep.ExameID
JOIN dw_eal.DimAluno da on ex.AlunoID = da.AlunoID
JOIN dw_eal.DimInstrutor di on ex.FuncID = di.InstrutorID
JOIN dw_eal.DimVeiculo dv on ep.VeiculoID = dv.VeiculoID
JOIN dw_eal.DimCalendario dc ON ex.DtHrIni::DATE = dc.CalendarioData;




