create table Planetas (
	IdPlaneta int not null, /* Tipo de variável pode ser bigint (opcional, talvez desnecessário devido ao uso maior de armazenamento)
	ao invés de int */
	Nome varchar (50) not null, /* Tipo de variável e a quantidade de caracteres pode ser nvarchar e max respectivamente (opcional, 
	talvez desnecessário devido ao uso maior de armazenamento) ao invés de varchar e 50 */
	Rotacao float not null,
	Orbita float not null,
	Diametro float not null,
	Clima varchar (50) not null,
	Populacao int not null
)
go

alter table Planetas add constraint PK_Planetas primary key (IdPlaneta);

declare @test int = 0;
select @test
go

create table Pilotos (
	IdPiloto int not null,
	Nome varchar (200) not null,
	AnoNascimento varchar (10) not null,
	IdPlaneta int null,
)
go

alter table Pilotos add constraint PK_Pilotos primary key (IdPiloto);
go
alter table Pilotos add constraint FK_Pilotos_Planetas foreign key (IdPlaneta) references Planetas (idPlaneta);

create table PilotosNaves (
	IdPiloto int not null,
	IdNave int not null,
	FlagAutorizado bit not null,
)
go

alter table PilotoNaves add constraint PK_PilotosNaves primary key (IdPiloto,IdNave);
go
alter table PilotoNaves add constraint FK_PilotosNaves_Pilotos foreign key (IdPiloto) references Pilotos (IdPiloto);
go
alter table PilotoNaves add constraint FK_PilotosNaves_Naves foreign key (IdNave) references Naves (IdNave);
go
alter table PilotoNaves add constraint DF_PilotosNaves_FlagAutorizado default (1) for FlagAutorizado; 

create table HistoricoViagens (
	IdNave int not null,
	IdPiloto int not null,
	DtSaida datetime not null,
	DtChegada datetime null,
)
go

alter table HistoricoViagens add constraint FK_HistoricoViagens_PilotosNaves foreign key (IdPiloto,IdNave) references PilotosNaves (IdPiloto,IdNave);
go
alter table HistoricoViagens check constraint FK_HistoricoViagens_Pilotosnaves;
go

select * from Planetas
select * from Pilotos
select * from Naves
select * from PilotosNaves
select * from HistoricoViagens

/* 
select * from Pilotos where ltrim(Nome) = ' Darth Vader' -> ltrim remove espaços à esquerda da string entre ''. rtrim à direita.
select * from Pilotos where Nome like 'Dar%' -> like faz a pesquisa pela string, que inicie ao menos com os caracteres antes de % (se este caracter
estiver no início, o comando executa o oposto. 
*/

insert HistoricoViagens (IdNave,IdPiloto,DtSaida) values (1,1,GetDate())

select *
from HistoricoViagens t1
inner join Pilotos t2
on t1.IdPiloto = t2.IdPiloto
inner join Naves t3
on t1.IdNave = t3.IdNave

select case 
	when count (DtSaida) <> count (DtChegada) then 1 
	else 0
	end Viajando,
	count (DtSaida),
	count (DtChegada)
from HistoricoViagens
where IdPiloto = 14

/*select 
	t1.IdPiloto,
	t1.Nome,
	t1.AnoNascimento,
	t2.IdPlaneta,
	t2.Nome NomePlaneta,
	t2.Rotacao,
	t2.Orbita,
	t2.Diametro,
	t2.Clima,
	t2.Populacao,
	from Pilotos t1 inner join Planetas t2 on t1.IdPlaneta = t2.IdPlaneta where IdPiloto = 2*/
