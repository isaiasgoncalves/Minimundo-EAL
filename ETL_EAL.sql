DROP SCHEMA IF EXISTS dw_eal CASCADE;
CREATE SCHEMA IF NOT EXISTS dw_eal;
SET search_path=dw_eal;

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
    Estado VARCHAR(2),
    Logradouro VARCHAR
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
    Estado,
    Logradouro
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
    a.Estado,
    a.Logradouro
FROM oper_eal.Aluno a;

-- Dimensão Funcionário (mais abrangente que Instrutor)
CREATE TABLE IF NOT EXISTS dw_eal.DimFuncionario (
    SKFuncionario UUID PRIMARY KEY,
    FuncionarioID INT,
    FuncionarioNome VARCHAR,
    Cargo VARCHAR,
    SalarioBase FLOAT
);

INSERT INTO dw_eal.DimFuncionario (
    SKFuncionario,
    FuncionarioID,
    FuncionarioNome,
    Cargo,
    SalarioBase
)
SELECT 
    gen_random_uuid() AS SKFuncionario,
    f.FuncID AS FuncionarioID,
    f.FuncNome AS FuncionarioNome,
    f.Cargo,
    f.Salario AS SalarioBase
FROM oper_eal.Funcionario f;

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
    ex.DtHrInicio AS CalendarioData,
    EXTRACT(DAY FROM ex.DtHrInicio) AS CalendarioDia,
    EXTRACT(MONTH FROM ex.DtHrInicio) AS CalendarioMes,
    EXTRACT(YEAR FROM ex.DtHrInicio) AS CalendarioAno,
    EXTRACT(QUARTER FROM ex.DtHrInicio) AS CalendarioTrimestre,
    TO_CHAR(ex.DtHrInicio, 'Month') AS CalendarioNomeMes,
    TO_CHAR(ex.DtHrInicio, 'Day') AS CalendarioNomeDiaSemana,
    EXTRACT(DOY FROM ex.DtHrInicio) AS CalendarioDiaAno,
    CASE 
        WHEN EXTRACT(DOW FROM ex.DtHrInicio) IN (0, 6) THEN 'Fim de Semana'
        ELSE 'Dia de Semana'
    END AS CalendarioTipoDia
FROM oper_eal.Exame ex
WHERE NOT EXISTS (
    SELECT 1 FROM dw_eal.DimCalendario dc 
    WHERE dc.CalendarioData = ex.DtHrInicio
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
    ap.TransacaoData AS CalendarioData,
    EXTRACT(DAY FROM ap.TransacaoData) AS CalendarioDia,
    EXTRACT(MONTH FROM ap.TransacaoData) AS CalendarioMes,
    EXTRACT(YEAR FROM ap.TransacaoData) AS CalendarioAno,
    EXTRACT(QUARTER FROM ap.TransacaoData) AS CalendarioTrimestre,
    TO_CHAR(ap.TransacaoData, 'Month') AS CalendarioNomeMes,
    TO_CHAR(ap.TransacaoData, 'Day') AS CalendarioNomeDiaSemana,
    EXTRACT(DOY FROM ap.TransacaoData) AS CalendarioDiaAno,
    CASE 
        WHEN EXTRACT(DOW FROM ap.TransacaoData) IN (0, 6) THEN 'Fim de Semana'
        ELSE 'Dia de Semana'
    END AS CalendarioTipoDia
FROM oper_eal.AlunoPaga ap
WHERE NOT EXISTS (
    SELECT 1 FROM dw_eal.DimCalendario dc 
    WHERE dc.CalendarioData = ap.TransacaoData
);

INSERT INTO dw_eal.DimCalendario (SKCalendario, CalendarioData, CalendarioDia, CalendarioMes, CalendarioAno, CalendarioTrimestre, CalendarioNomeMes, CalendarioNomeDiaSemana, CalendarioDiaAno, CalendarioTipoDia)
SELECT 
    gen_random_uuid(),
    '2025-09-30'::DATE,
    30, 9, 2025, 3,
    'September', 'Tuesday', 273,
    'Dia de Semana'
WHERE NOT EXISTS (
    SELECT 1 FROM dw_eal.DimCalendario WHERE CalendarioData = '2025-09-30'
);

-- Dimensão Serviço
CREATE TABLE IF NOT EXISTS dw_eal.DimServico (
    SKServico UUID PRIMARY KEY,
    ServicoID INT,
    ServicoTipo VARCHAR,
    ServicoValor FLOAT
);

INSERT INTO dw_eal.DimServico (
    SKServico,
    ServicoID,
    ServicoTipo,
    ServicoValor
)
SELECT
    gen_random_uuid() AS SKServico,
    s.ServicoID,
    s.ServicoTipo,
    s.ServicoValor
FROM oper_eal.ServicoAutoEsc s;


-- Dimensão Sala
CREATE TABLE IF NOT EXISTS dw_eal.DimSala (
    SKSala UUID PRIMARY KEY,
    SalaID INT,
    CapacidadeMax INT
);

INSERT INTO dw_eal.DimSala (SKSala, SalaID, CapacidadeMax)
SELECT
    gen_random_uuid() AS SKSala,
    s.IDSala AS SalaID,
    s.CapacidadeMax
FROM oper_eal.Sala s;


-- - Dimensão Tema
CREATE TABLE IF NOT EXISTS dw_eal.DimTema (
    SKTema UUID PRIMARY KEY,
    TemaID INT,
    TemaNome VARCHAR,
    CargaHorariaPrevista INT
);

INSERT INTO dw_eal.DimTema (SKTema, TemaID, TemaNome, CargaHorariaPrevista)
SELECT
    gen_random_uuid() AS SKTema,
    t.TemaID,
    t.TemaNome,
    t.QuantidadeAula AS CargaHorariaPrevista
FROM oper_eal.Tema t;

-- Fato Aula Prática
CREATE TABLE IF NOT EXISTS dw_eal.FactAulaPratica (
    SKAluno UUID,
    SKInstrutor UUID,
    SKVeiculo UUID,
    SKCalendario UUID,
    DtHrInicio TIMESTAMP,
    DtHrFim TIMESTAMP,
    StatusAula VARCHAR,
    DuracaoAula FLOAT,
    PRIMARY KEY (SKAluno, SKInstrutor, SKVeiculo, SKCalendario)
);

INSERT INTO dw_eal.FactAulaPratica (
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

-- Fato Exame Teórico
CREATE TABLE IF NOT EXISTS dw_eal.FactExameTeorico (
    SKExameTeorico UUID PRIMARY KEY, 
    SKAluno UUID,
    SKInstrutor UUID,
    SKSala UUID,
    SKCalendario UUID,
    ExameID INT,
    DtHrInicio TIMESTAMP,
    DtHrFim TIMESTAMP,
    StatusExame VARCHAR,
    Nota NUMERIC(5, 2)
);

INSERT INTO dw_eal.FactExameTeorico (SKExameTeorico, SKAluno, SKInstrutor, SKSala, SKCalendario, ExameID, DtHrInicio, DtHrFim, StatusExame, Nota)
SELECT 
    gen_random_uuid(), da.SKAluno, di.SKInstrutor, ds.SKSala, dc.SKCalendario, 
    ex.ExameID, ex.DtHrInicio, ex.DtHrFim,
    CASE 
        WHEN ex.Status = 'Agendado' THEN 'Agendado'
        WHEN ex.Nota IS NULL THEN ex.Status 
        WHEN ex.Nota >= 70 THEN 'Aprovado'
        ELSE 'Reprovado'
    END AS StatusExame,
    ex.Nota
FROM oper_eal.ExameTeorica et
JOIN oper_eal.Exame ex ON et.ExameID = ex.ExameID
JOIN dw_eal.DimAluno da ON ex.AlunoID = da.AlunoID
JOIN dw_eal.DimInstrutor di ON ex.FuncID = di.InstrutorID
JOIN dw_eal.DimSala ds ON et.IDSala = ds.SalaID
JOIN dw_eal.DimCalendario dc ON ex.DtHrInicio::DATE = dc.CalendarioData;

-- Fato Exame Prático
CREATE TABLE IF NOT EXISTS dw_eal.FactExamePratico (
    SKAluno UUID NOT NULL,
    SKInstrutor UUID,  
    SKVeiculo UUID,
    SKCalendario UUID,
    DtHrInicio TIMESTAMP,
    DtHrFim TIMESTAMP,
    StatusExame VARCHAR NOT NULL,
    PRIMARY KEY (SKAluno, SKInstrutor, SKVeiculo, SKCalendario)
);

INSERT INTO dw_eal.FactExamePratico(
    SKAluno,
    SKInstrutor, 
    SKVeiculo,
    SKCalendario,
    DtHrInicio,
    DtHrFim,
    StatusExame
)
SELECT 
    da.SKAluno,
    di.SKInstrutor,
    dv.SKVeiculo,
    dc.SKCalendario,
    ex.DtHrInicio,
    ex.DtHrFim,
    CASE 
        WHEN ex.DtHrFim IS NULL THEN 'Agendada'
        WHEN ex.DtHrFim::timestamp = ex.DtHrInicio::timestamp THEN 'Cancelada'
        WHEN random() < 0.8 THEN 'Reprovado'
        ELSE 'Aprovado'
    END AS StatusExame
FROM oper_eal.ExamePratico ep
JOIN oper_eal.Exame ex on ex.ExameID = ep.ExameID
JOIN dw_eal.DimAluno da on ex.AlunoID = da.AlunoID
JOIN dw_eal.DimInstrutor di on ex.FuncID = di.InstrutorID
JOIN dw_eal.DimVeiculo dv on ep.IDVeiculo = dv.VeiculoID
JOIN dw_eal.DimCalendario dc ON ex.DtHrInicio::DATE = dc.CalendarioData;

-- Fato Despesa
CREATE TABLE IF NOT EXISTS dw_eal.FactDespesa (
    SKFuncionario UUID,
    SKCalendario UUID,
    ValorDespesa FLOAT,
    PRIMARY KEY (SKFuncionario, SKCalendario),
    FOREIGN KEY (SKFuncionario) REFERENCES dw_eal.DimFuncionario(SKFuncionario),
    FOREIGN KEY (SKCalendario) REFERENCES dw_eal.DimCalendario(SKCalendario)
);

INSERT INTO dw_eal.FactDespesa (
    SKFuncionario,
    SKCalendario,
    ValorDespesa
)
SELECT
    df.SKFuncionario,
    dc.SKCalendario,
    df.SalarioBase AS ValorDespesa
FROM dw_eal.DimFuncionario df
CROSS JOIN dw_eal.DimCalendario dc
WHERE dc.CalendarioData = '2025-09-30';

-- Fato Receita
CREATE TABLE IF NOT EXISTS dw_eal.FactReceita (
    SKAluno UUID,
    SKServico UUID,
    SKCalendario UUID,
    Quantidade INT,
    ValorPago FLOAT,
    PRIMARY KEY (SKAluno, SKServico, SKCalendario)
);

INSERT INTO dw_eal.FactReceita(
    SKAluno,
    SKServico,
    SKCalendario,
    Quantidade,
    ValorPago
)
SELECT 
    da.SKAluno,
    ds.SKServico,
    dc.SKCalendario,
    ap.Quantidade,
    (ap.Quantidade * ds.ServicoValor) AS ValorPago
FROM oper_eal.AlunoPaga ap
JOIN dw_eal.DimAluno da ON ap.AlunoID = da.AlunoID
JOIN dw_eal.DimServico ds ON ap.ServicoID = ds.ServicoID
JOIN dw_eal.DimCalendario dc ON ap.TransacaoData::DATE = dc.CalendarioData


-- Fato Aula Teórica
CREATE TABLE IF NOT EXISTS dw_eal.FactAulaTeorica (
    SKAluno UUID,
    SKInstrutor UUID,
    SKSala UUID,
    SKTema UUID,
    SKCalendario UUID,
    QtdPresenca INT,
    QtdAulasMinistradas INT,
    PRIMARY KEY (SKAluno, SKInstrutor, SKSala, SKTema, SKCalendario)
);

INSERT INTO dw_eal.FactAulaTeorica (SKAluno, SKInstrutor, SKSala, SKTema, SKCalendario, QtdPresenca, QtdAulasMinistradas)
SELECT
    da.SKAluno, di.SKInstrutor, ds.SKSala, dt.SKTema, dc.SKCalendario,
    ata.PresencaAluno AS QtdPresenca,
    1 AS QtdAulasMinistradas
FROM oper_eal.AulaTAluno ata
JOIN oper_eal.AulaTeorica att ON ata.AulaID = att.AulaID
JOIN oper_eal.Aula a ON att.AulaID = a.AulaID
JOIN oper_eal.AulaTSala ats ON a.AulaID = ats.AulaID
JOIN dw_eal.DimAluno da ON ata.AlunoID = da.AlunoID
JOIN dw_eal.DimInstrutor di ON a.FuncID = di.InstrutorID
JOIN dw_eal.DimSala ds ON ats.IDSala = ds.SalaID
JOIN dw_eal.DimTema dt ON att.TemaID = dt.TemaID
JOIN dw_eal.DimCalendario dc ON a.AulaData = dc.CalendarioData;
