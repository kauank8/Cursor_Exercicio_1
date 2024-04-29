Create database Cursor_ex1
go
use Cursor_ex1

Go
-- Criar tabela Curso
CREATE TABLE Curso (
    Codigo INT PRIMARY KEY,
    Nome VARCHAR(100),
    Duracao INT
);

Go
-- Inserir dados na tabela Curso
INSERT INTO Curso (Codigo, Nome, Duracao) VALUES
(48, 'An�lise e Desenvolvimento de Sistemas', 2880),
(51, 'Log�stica', 2880),
(67, 'Pol�meros', 2880),
(73, 'Com�rcio Exterior', 2600),
(94, 'Gest�o Empresarial', 2600);

Go
-- Criar tabela Disciplinas
CREATE TABLE Disciplinas (
    Codigo VARCHAR(10) PRIMARY KEY,
    Nome VARCHAR(100),
    Carga_Horaria INT
);

go
-- Inserir dados na tabela Disciplinas
INSERT INTO Disciplinas (Codigo, Nome, Carga_Horaria) VALUES
('ALG001', 'Algoritmos', 80),
('ADM001', 'Administra��o', 80),
('LHW010', 'Laborat�rio de Hardware', 40),
('LPO001', 'Pesquisa Operacional', 80),
('FIS003', 'F�sica I', 80),
('FIS007', 'F�sico Qu�mica', 80),
('CMX001', 'Com�rcio Exterior', 80),
('MKT002', 'Fundamentos de Marketing', 80),
('INF001', 'Inform�tica', 40),
('ASI001', 'Sistemas de Informa��o', 80);

Go
-- Criar tabela Disciplina_Curso
CREATE TABLE Disciplina_Curso (
    Codigo_Disciplina VARCHAR(10),
    Codigo_Curso INT
);

Go
-- Inserir dados na tabela Disciplina_Curso
INSERT INTO Disciplina_Curso (Codigo_Disciplina, Codigo_Curso) VALUES
('ALG001', 48),
('ADM001', 48),
('ADM001', 51),
('ADM001', 73),
('ADM001', 94),
('LHW010', 48),
('LPO001', 51),
('FIS003', 67),
('FIS007', 67),
('CMX001', 51),
('CMX001', 73),
('MKT002', 51),
('MKT002', 94),
('INF001', 51),
('INF001', 73),
('ASI001', 48),
('ASI001', 94);

Go

Create Function fn_mostraDisciplina(@codigo_curso int)
returns @tabela table(
codigo_disciplina varchar(10),
nome_disciplina varchar(100),
carga_horario_disciplina int,
nome_curso varchar(100)
)
Begin
	Declare @codigo varchar(10),
			@nome_disciplina varchar(100),
			@carga_horaria_disciplina int,
			@nome_curso varchar(100),
			@consulta_codigo_curso int
	
	Declare c cursor for
		select d.Codigo, d.Nome, d.Carga_Horaria, c.Nome, dc.Codigo_Curso From Disciplinas d, Curso c, Disciplina_Curso dc 
		where d.Codigo = dc.Codigo_Disciplina and c.Codigo = dc.Codigo_Curso and dc.Codigo_Curso = @codigo_curso
	Open c
	Fetch next from c
		Into @codigo, @nome_disciplina, @carga_horaria_disciplina, @nome_curso, @consulta_codigo_curso
	While @@FETCH_STATUS = 0
	Begin
		If(@consulta_codigo_curso = @codigo_curso) Begin
			Insert into @tabela Values(@codigo, @nome_disciplina, @carga_horaria_disciplina, @nome_curso)
		End

		Fetch next from c
		Into @codigo, @nome_disciplina, @carga_horaria_disciplina, @nome_curso, @consulta_codigo_curso
	End
	Close C
	Deallocate c
	return
End

Select * from fn_mostraDisciplina(48)


