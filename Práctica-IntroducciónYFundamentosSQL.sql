create schema FundamentosSQL

create table FundamentosSQL.compañia_aseguradora (
id_compañia_aseguradora varchar(20) primary key
);

insert into FundamentosSQL.compañia_aseguradora (id_compañia_aseguradora) values ('OrbisSeguros'),('SantanderSeguros'),('ATPSeguros');

--

create table FundamentosSQL.marca (
id_marca varchar(15) primary key
);

insert into FundamentosSQL.marca (id_marca) values ('Honda'),('Peugeot'),('Ford');

--

create table FundamentosSQL.grupo_empresarial_de_la_marca (
id_grupo_empresarial_de_la_marca serial primary key,
nombre varchar(25) not null,
id_marca varchar(15) references FundamentosSQL.marca(id_marca)
);

insert into FundamentosSQL.grupo_empresarial_de_la_marca (nombre,id_marca) values ('GrupoEmpresarialNorte','Honda'),('GrupoEmpresarialSur','Ford'),('GrupoEmpresarialEste','Peugeot');

--

create table FundamentosSQL.moneda (
id_moneda varchar(15) primary key
);

insert into FundamentosSQL.moneda (id_moneda) values ('Peso'),('Euro'),('Dólar');

--

create table FundamentosSQL.vehículo (
id_vehículo serial primary key,
modelo varchar(15) not null,
color varchar(15) not null,
matrícula varchar(15)not null unique,
id_compañia_aseguradora varchar(20) references FundamentosSQL.compañia_aseguradora(id_compañia_aseguradora),
número_de_póliza int not null,
fecha_de_compra date not null,
id_marca varchar(15) references FundamentosSQL.marca(id_marca)
);

insert into FundamentosSQL.vehículo (modelo,color,matrícula,id_compañia_aseguradora,número_de_póliza,fecha_de_compra,id_marca)
values 
('2010','rojo','110LLG','OrbisSeguros',92587423,'2010-03-14','Honda'),
('2015','blanco','040GEH','SantanderSeguros',34215498,'2015-06-14','Ford'),
('2020','azul','897FHJ','ATPSeguros',74422109,'2020-05-27','Peugeot');


--

create table FundamentosSQL.revisión (
id_revisión serial primary key,
matrícula varchar(15) references FundamentosSQL.vehículo(matrícula),
importe float not null,
id_moneda varchar(15) references FundamentosSQL.moneda(id_moneda),
kilometros float not null,
fecha date not null
);

insert into FundamentosSQL.revisión (matrícula,importe,id_moneda,kilometros,fecha)
values 
('110LLG',300.00,'Dólar',8000.08,'2008-03-12'),
('110LLG',400.00,'Dólar',9000.08,'2009-05-12'),
('040GEH',600.05,'Euro',51998.56,'2006-05-13'),
('040GEH',800.05,'Euro',52998.56,'2007-09-13'),
('897FHJ',459.89,'Dólar',10600.06,'2004-11-14'),
('897FHJ',555.89,'Dólar',11600.06,'2005-10-14');


/* Consulta */

select FundamentosSQL.vehículo.modelo,FundamentosSQL.vehículo.id_marca,FundamentosSQL.vehículo.fecha_de_compra,FundamentosSQL.vehículo.matrícula,FundamentosSQL.vehículo.color,FundamentosSQL.vehículo.id_compañia_aseguradora,FundamentosSQL.vehículo.número_de_póliza,sum(FundamentosSQL.revisión.kilometros) as kilometros_totales, FundamentosSQL.grupo_empresarial_de_la_marca.nombre as Grupo
from FundamentosSQL.vehículo inner join FundamentosSQL.revisión on FundamentosSQL.vehículo.matrícula = FundamentosSQL.revisión.matrícula 
inner join FundamentosSQL.grupo_empresarial_de_la_marca on FundamentosSQL.grupo_empresarial_de_la_marca.id_marca = FundamentosSQL.vehículo.id_marca
group by FundamentosSQL.vehículo.modelo,FundamentosSQL.vehículo.id_marca,FundamentosSQL.vehículo.fecha_de_compra,FundamentosSQL.vehículo.matrícula,FundamentosSQL.vehículo.color,FundamentosSQL.vehículo.id_compañia_aseguradora,FundamentosSQL.vehículo.número_de_póliza,FundamentosSQL.grupo_empresarial_de_la_marca.nombre;



