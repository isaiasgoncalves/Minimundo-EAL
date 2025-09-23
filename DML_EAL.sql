INSERT INTO oper_eal.Veiculo (IDVeiculo, Modelo, VeiculoTipo) VALUES
(1, 'Volkswagen Gol 2023', 'B'),
(2, 'Chevrolet Onix 2024', 'B'),
(3, 'Honda CG 160', 'A'),
(4, 'Mercedes-Benz Accelo', 'C'),
(5, 'Volkswagen 15.190', 'D');

INSERT INTO oper_eal.Sala (IDSala, CapacidadeMax) VALUES
(1, 30),
(2, 30),
(3, 30);

INSERT INTO oper_eal.Tema (TemaID, TemaNome, QuantidadeAula) VALUES
(1, 'Legislação de Trânsito', 18),
(2, 'Direção Defensiva', 16),
(3, 'Primeiros Socorros', 4),
(4, 'Meio Ambiente e Cidadania', 4),
(5, 'Mecânica Básica', 3);

INSERT INTO oper_eal.ServicoAutoEsc (ServicoID, ServicoTipo, ServicoValor, ServicoDescricao) VALUES
(1, 'Pacote Inicial Categoria B', 1500.00, 'Pacote completo para primeira habilitação categoria B'),
(2, 'Pacote Adição Categoria A', 1200.00, 'Adição da categoria A para habilitados'),
(3, 'Aula Prática Avulsa', 160.00, 'Aula de reposição ou extra para categoria B'),
(4, 'Aula Teórica Avulsa', 50.00, 'Aula de reposição para curso teórico'),
(5, 'Reciclagem CNH', 450.00, 'Curso de reciclagem para condutores com CNH suspensa'),
(6, 'Pacote Adição Categoria D', 2800.00, 'Adição de categoria D para habilitados em C'),
(7, 'Curso Direção Defensiva Corporativo', 2500.00, 'Pacote para empresas - 1 turma de até 15 funcionários');

INSERT INTO oper_eal.Funcionario (FuncID, FuncNome, Cargo, Salario, FuncCPF, FuncEmail, FuncCelular, FuncSenha) VALUES
(1, 'Carlos Eduardo Mendes', 'Gerente Administrativo', 6000.00, '11122233344', 'carlos.mendes@oper_eal.com', '21988887777', 'hashed_pass'),
(2, 'Estevão Lima', 'Sócio-Operacional', 4500.00, '22233344455', 'estevao.lima@oper_eal.com', '21988886666', 'hashed_pass'),
(3, 'Amanda Lima', 'Sócia-Financeira', 4500.00, '33344455566', 'amanda.lima@oper_eal.com', '21988885555', 'hashed_pass'),
(4, 'Lara Lima', 'Sócia-Marketing', 4500.00, '44455566677', 'lara.lima@oper_eal.com', '21988884444', 'hashed_pass'),
(5, 'Beatriz Costa', 'Instrutor Teórico', 3200.00, '55566677788', 'beatriz.costa@oper_eal.com', '21977771111', 'hashed_pass'),
(6, 'Ricardo Souza', 'Instrutor Teórico', 3200.00, '66677788899', 'ricardo.souza@oper_eal.com', '21977772222', 'hashed_pass'),
(7, 'Marcos Oliveira', 'Instrutor Prático', 3800.00, '77788899900', 'marcos.oliveira@oper_eal.com', '21966661111', 'hashed_pass'),
(8, 'Juliana Santos', 'Instrutor Prático', 3800.00, '88899900011', 'juliana.santos@oper_eal.com', '21966662222', 'hashed_pass'),
(9, 'Felipe Almeida', 'Atendente', 2100.00, '99900011122', 'felipe.almeida@oper_eal.com', '21955551111', 'hashed_pass'),
(10, 'Vanessa Dias', 'Profissional de TI', 5000.00, '12312312312', 'vanessa.dias@oper_eal.com', '21944441111', 'hashed_pass');

INSERT INTO oper_eal.Aluno (AlunoID, AlunoCPF, AlunoNome, AlunoEmail, AlunoCelular, DataNascimento, Logradouro, Bairro, Municipio, Estado, AlunoSenha) VALUES
(101, '11122233301', 'Sofia Martins', 'sofia.martins@example.com', '21988776655', '2005-04-15', 'Rua das Laranjeiras', 'Laranjeiras', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(102, '22233344402', 'Lucas Pereira', 'lucas.pereira@example.com', '21999887766', '2004-08-22', 'Avenida Atlântica', 'Copacabana', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(103, '33344455503', 'Isabella Ferreira', 'isabella.f@example.com', '21987654321', '2006-01-10', 'Rua Barata Ribeiro', 'Copacabana', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(104, '44455566604', 'Yuri Saporito', 'y.saporito@email.com', '21976541234', '2003-11-05', 'Rua das Laranjeiras', 'Laranjeiras', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(105, '55566677705', 'Júlia Alves', 'julia.alves@example.com', '21988991122', '2005-07-19', 'Avenida das Américas', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(106, '66677788806', 'Guilherme Souza', 'gui.souza@example.com', '21991234567', '2002-03-30', 'Rua Visconde de Pirajá', 'Ipanema', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(107, '77788899907', 'Laura Costa', 'laura.costa@example.com', '21992345678', '2004-09-14', 'Rua Dias da Cruz', 'Méier', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(108, '88899900008', 'Pedro Santos', 'pedro.santos@example.com', '21993456789', '2005-02-28', 'Rua do Catete', 'Catete', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(109, '99900011109', 'Beatriz Oliveira', 'beatriz.o@example.com', '21994567890', '2006-05-25', 'Praia de Botafogo', 'Botafogo', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(110, '11100022210', 'Davi Ribeiro', 'davi.ribeiro@example.com', '21995678901', '2003-08-11', 'Avenida Venceslau Brás', 'Botafogo', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(111, '12312312311', 'Maria Clara Lima', 'mariaclara.l@example.com', '21981112233', '2004-12-01', 'Rua Real Grandeza', 'Botafogo', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(112, '23423423412', 'João Gabriel Gomes', 'joaog.gomes@example.com', '21982223344', '2005-06-18', 'Rua Voluntários da Pátria', 'Botafogo', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(113, '34534534513', 'Ana Luiza Barbosa', 'analu.b@example.com', '21983334455', '2002-10-23', 'Rua Haddock Lobo', 'Tijuca', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(114, '45645645614', 'Miguel Fernandes', 'miguel.f@example.com', '21984445566', '2006-02-08', 'Avenida Maracanã', 'Maracanã', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(115, '56756756715', 'Helena Melo', 'helena.melo@example.com', '21985556677', '2005-09-03', 'Rua São Francisco Xavier', 'Tijuca', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(116, '67867867816', 'Arthur Carvalho', 'arthur.c@example.com', '21986667788', '2003-05-12', 'Rua General Roca', 'Tijuca', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(117, '78978978917', 'Alice Castro', 'alice.castro@example.com', '21987778899', '2004-07-29', 'Avenida Lúcio Costa', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(118, '89089089018', 'Bernardo de Freitas', 'b.freitas@email.com', '21988889900', '2002-01-17', 'Avenida Sernambetiba', 'Recreio dos Bandeirantes', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(119, '90190190119', 'Valentina Rocha', 'valentina.r@example.com', '21989990011', '2005-11-30', 'Estrada dos Bandeirantes', 'Jacarepaguá', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(120, '12345678920', 'Ravi Moreira', 'ravi.moreira@example.com', '21990001122', '2004-02-20', 'Rua Araguaia', 'Freguesia', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(121, '23456789021', 'Elisa Azevedo', 'elisa.azevedo@example.com', '21991112233', '2006-03-09', 'Rua Geminiano de Góis', 'Freguesia', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(122, '34567890122', 'Enzo Nunes', 'enzo.nunes@example.com', '21992223344', '2003-04-27', 'Rua Tirol', 'Freguesia', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(123, '45678901223', 'Maria Eduarda Cunha', 'duda.cunha@example.com', '21993334455', '2005-10-13', 'Avenida Geremário Dantas', 'Tanque', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(124, '56789012324', 'Theo Correia', 'theo.correia@example.com', '21994445566', '2002-08-01', 'Rua Cândido Benício', 'Campinho', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(125, '67890123425', 'Lívia Dias', 'livia.dias@example.com', '21995556677', '2004-06-24', 'Estrada Intendente Magalhães', 'Vila Valqueire', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(151, '44455566699', 'José Guedes Gasparelo', 'hallowring@fromsoftware.com', '21976541299', '2003-11-05', 'Rua das Laranjeiras', 'Laranjeiras', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(152, '44556677899', 'Julio César Chaves', 'juliaobd@fgv.br', '21982343399', '2005-08-31', 'Rua Cruz Lima', 'Flamengo', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(126, '78901234526', 'Benjamin Jesus', 'ben.jesus@example.com', '21996667788', '2003-01-04', 'Rua das Dálias', 'Vila Valqueire', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(127, '89012345627', 'Esther Cardoso', 'esther.c@example.com', '21997778899', '2005-05-16', 'Rua Carolina Machado', 'Madureira', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(128, '90123456728', 'Isaac Mendes', 'isaac.mendes@example.com', '21998889900', '2002-09-09', 'Avenida Ministro Edgard Romero', 'Madureira', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(129, '11223344529', 'Manuela Almeida', 'manu.almeida@example.com', '21999990011', '2004-11-18', 'Rua João Vicente', 'Bento Ribeiro', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(130, '22334455630', 'Lorenzo Lopes', 'lorenzo.l@example.com', '21980001122', '2006-04-07', 'Rua Carolina Amado', 'Oswaldo Cruz', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(131, '33445566731', 'Cecília Gonçalves', 'cecilia.g@example.com', '21981232233', '2003-07-21', 'Rua Ana Teles', 'Campinho', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(132, '44556677832', 'Eduardo Wager', 'e.wager@email.com', '21982343344', '2005-08-31', 'Rua Cruz Lima', 'Flamengo', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(133, '55667788933', 'Heloísa Brandão', 'helo.brandao@example.com', '21983454455', '2002-02-14', 'Rua Gustavo Riedel', 'Engenho de Dentro', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(134, '66778899034', 'Samuel Ramos', 'samuel.ramos@example.com', '21984565566', '2004-01-26', 'Rua Adolfo Bergamini', 'Engenho de Dentro', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(135, '77889900135', 'Maya Reis', 'maya.reis@example.com', '21985676677', '2003-09-19', 'Rua Arquias Cordeiro', 'Engenho de Dentro', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(136, '88990011236', 'Gael Viana', 'gael.viana@example.com', '21986787788', '2005-12-29', 'Rua Doutor Leal', 'Engenho Novo', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(137, '99001122337', 'Liz Fogaça', 'liz.fogaca@example.com', '21987898899', '2002-06-02', 'Rua Barão do Bom Retiro', 'Engenho Novo', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(138, '10102020338', 'Anthony Silveira', 'anthony.s@example.com', '21988909900', '2004-10-08', 'Rua Vinte e Quatro de Maio', 'Riachuelo', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(139, '20203030439', 'Antonella Barros', 'antonella.b@example.com', '21989010011', '2003-03-23', 'Avenida Marechal Rondon', 'Sampaio', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(140, '30304040540', 'Davi Lucca Pires', 'davilucca.p@example.com', '21990121122', '2006-06-11', 'Rua São Luiz Gonzaga', 'São Cristóvão', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(141, '40405050641', 'Sophia Caldeira', 'sophia.c@example.com', '21991232233', '2005-03-01', 'Campo de São Cristóvão', 'São Cristóvão', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(142, '50506060742', 'Francisco Moura', 'francisco.m@example.com', '21992343344', '2002-07-06', 'Rua da Abolição', 'Abolição', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(143, '60607070843', 'Emanuelly Freitas', 'emanuelly.f@example.com', '21993454455', '2004-05-13', 'Rua Glaziou', 'Abolição', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(144, '70708080944', 'Ryan Nogueira', 'ryan.n@example.com', '21994565566', '2003-12-15', 'Rua da Pátria', 'Piedade', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(145, '80809090145', 'Isabelly Siqueira', 'isabelly.s@example.com', '21995676677', '2005-01-07', 'Rua Clarimundo de Melo', 'Piedade', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(146, '90901010246', 'Erick Campos', 'erick.campos@example.com', '21996787788', '2002-11-21', 'Rua Goias', 'Quintino Bocaiuva', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(147, '12123434547', 'Luciano Castro', 'l.castro@email.com', '21997898899', '2004-04-04', 'Rua Cupertino', 'Quintino Bocaiuva', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(148, '23234545648', 'Henry Nascimento', 'henry.n@example.com', '21998909900', '2003-02-18', 'Rua Assis Carneiro', 'Cascadura', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(149, '34345656749', 'Ayla Farias', 'ayla.farias@example.com', '21999010011', '2005-07-27', 'Rua Sidônio Paes', 'Cascadura', 'Rio de Janeiro', 'RJ', 'hashed_pass'),
(150, '45456767850', 'Enrico Neves', 'enrico.neves@example.com', '21980121122', '2002-12-03', 'Rua Iguape', 'Cascadura', 'Rio de Janeiro', 'RJ', 'hashed_pass');

-- DADOS TRANSACIONAIS E RELACIONAIS
INSERT INTO oper_eal.AlunoPaga (AlunoID, ServicoID, Quantidade, TransacaoData) VALUES
(101, 1, 1, '2025-08-20'),
(102, 2, 1, '2025-08-21'),
(105, 5, 1, '2025-08-22'),
(115, 6, 1, '2025-08-23'),
(120, 3, 2, '2025-08-24'),
(132, 1, 1, '2025-08-25'),
(147, 2, 1, '2025-08-26'),
(151, 1, 1, '2025-08-27'),
(152, 5, 1, '2025-08-28');

INSERT INTO oper_eal.Aula (AulaID, AulaData, FuncID) VALUES
(5001, '2025-09-01', 5),
(5002, '2025-09-01', 7),
(5003, '2025-09-02', 6),
(5004, '2025-09-02', 8),
(5005, '2025-09-03', 5),
(5006, '2025-09-03', 7),
(5007, '2025-09-04', 6),
(5008, '2025-09-04', 8),
(5009, '2025-09-05', 5),
(5010, '2025-09-05', 7);

INSERT INTO oper_eal.AulaTeorica (AulaID, TemaID) VALUES
(5001, 1),
(5003, 2),
(5005, 3),
(5007, 4),
(5009, 5);

INSERT INTO oper_eal.AulaPratica (AulaID, AlunoID) VALUES
(5002, 101),
(5004, 102),
(5006, 132),
(5008, 147),
(5010, 151);

INSERT INTO oper_eal.AulaTAluno (AulaID, AlunoID, PresencaAluno) VALUES
(5001, 101, 1),
(5001, 104, 1),
(5001, 108, 1),
(5001, 112, 0),
(5001, 132, 1),
(5003, 101, 1),
(5003, 104, 0),
(5003, 108, 1),
(5003, 112, 1),
(5003, 132, 1),
(5005, 115, 1),
(5005, 120, 1),
(5005, 140, 1),
(5007, 115, 1),
(5007, 120, 0),
(5007, 140, 1),
(5009, 151, 1),
(5009, 152, 1);

INSERT INTO oper_eal.AulaTSala (AulaID, IDSala, DtHrInicio, DtHrFim) VALUES
(5001, 1, '2025-09-01', '2025-09-01'),
(5003, 2, '2025-09-02', '2025-09-02'),
(5005, 3, '2025-09-03', '2025-09-03'),
(5007, 1, '2025-09-04', '2025-09-04'),
(5009, 2, '2025-09-05', '2025-09-05');

INSERT INTO oper_eal.VeiculoAula (AulaID, IDVeiculo, DtHrInicio, DtHrFim) VALUES
(5002, 1, '2025-09-01 09:00:00', '2025-09-01 10:00:00'),
(5004, 3, '2025-09-02 11:00:00', '2025-09-02 12:00:00'),
(5006, 2, '2025-09-03 14:00:00', '2025-09-03 14:00:00'),
(5008, 3, '2025-09-04 15:00:00', '2025-09-04 15:00:00'),
(5010, 1, '2025-09-05 16:00:00', NULL);


<<<<<<< Updated upstream
INSERT INTO oper_eal.Exame (ExameID, Status, DtHrInicio, DtHrFim, AlunoID, FuncID) VALUES
(201, 'Aprovado', '2025-09-15 10:00:00', '2025-09-15 11:00:00', 101, 7),
(202, 'Reprovado', '2025-09-16 14:00:00', '2025-09-16 15:00:00', 102, 8),
(203, 'Agendado', '2025-09-22 09:00:00', '2025-09-22 10:00:00', 103, 7),
(204, 'Aprovado', '2025-09-18 19:00:00', '2025-09-18 21:00:00', 104, 2);
=======
INSERT INTO EAL.Exame (ExameID, Status, Nota, DtHrIni, DtHrFim, AlunoID, FuncID) VALUES
(201, 'Aprovado', 85.0, '2025-09-15 10:00:00', '2025-09-15 11:00:00', 101, 7),
(202, 'Reprovado', 45.5, '2025-09-16 14:00:00', '2025-09-16 15:00:00', 102, 8),
(203, 'Agendado', NULL, '2025-09-22 09:00:00', '2025-09-22 10:00:00', 103, 7),
(204, 'Aprovado', 90.0, '2025-09-18 19:00:00', '2025-09-18 21:00:00', 104, 2),
(205, 'Aprovado', 78.0, '2025-09-19 10:00:00', '2025-09-19 12:00:00', 115, 5),
(206, 'Reprovado', 60.0, '2025-09-20 10:00:00', '2025-09-20 12:00:00', 120, 6);
>>>>>>> Stashed changes


INSERT INTO oper_eal.ExamePratico (ExameID, IDVeiculo) VALUES
(201, 1),
(202, 2),
(203, 1);

<<<<<<< Updated upstream
INSERT INTO oper_eal.Pagamento (PagtoID, PagtoValor, PagtoData, FuncID) VALUES
=======
INSERT INTO EAL.ExameTeorica (ExameID, IDSala) VALUES
(204, 1),
(205, 1),
(206, 2);

INSERT INTO EAL.Pagamento (PagtoID, PagtoValor, PagtoData, FuncID) VALUES
>>>>>>> Stashed changes
(501, 160.00, '2025-08-30', 9),
(502, 450.00, '2025-08-31', 3),
(503, 750.00, '2025-09-01', 9),
(504, 1200.00, '2025-09-02', 9),
(505, 100.00, '2025-09-03', 9);