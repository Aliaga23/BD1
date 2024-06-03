create database formacion3;
use formacion3;
create table Tema(
	ID int not null,
	Descrp varchar(50) not null,
	primary key (ID)	
);
insert into tema values(201,'Procedimientos And Funciones');
insert into tema values(202,'Cambas (Lienzo)');
insert into tema values(203,'Herencia Proc. And Func.');
insert into tema values(204,'Java Movil and 2D');
insert into tema values(205,'Poblacion de BD');
insert into tema values(206,'Consultas en BD');
insert into Tema values(207,'Doc. and Consultas en BD');
select * from tema;

create table Empleado(
	CI int not null,
    Nombre varchar(50) not null,
    sexo char not null,
    primary key (CI)    
);

	insert into Empleado values(111,'Joaquin Chumacero','m');
	insert into Empleado values(222,'Juan Topo','m');
	insert into Empleado values(333,'Ned Flanders','m');
	insert into Empleado values(432,'Rafa Gorgori','m');
	insert into Empleado values(315,'Esmiders Ticona','m');
	/*Alumnos De Java Basico Doc. Joaquin Chumacero*/
	insert into Empleado values(444,'Bob Patiño','m');
	insert into Empleado values(555,'Maria Prisma','f');
	insert into Empleado values(666,'March Bubie','f');
	insert into Empleado values(777,'Mongomery Berns','m');
	/*Alumnos De SQL Basico*/
	insert into Empleado values(888,'Homero J. Simpsons','m');
	insert into Empleado values(123,'Milhouse Miami','m');
	insert into Empleado values(124,'Lisa Montenegro','f');
	insert into Empleado values(125,'Bar Yucra','m');
	/*Otros alumnos*/
	insert into Empleado values(562,'Saturnino Mamani','m');
	insert into Empleado values(523,'Carla Fernandez','f');
	
	Select * from empleado;

create table Curso(
	Cod int not null,
	titulo varchar(25) not null,
	NroHrs int not null,
	CodPreq int,
	IDtema int not null,
	primary key (cod),	
	foreign key (IDtema) references Tema (ID)
);

select * from curso;

insert into Curso values(981,'Delphi Basico',25,null,201);
insert into Curso values(982,'Delphi Avanzado',25,981,202);
insert into Curso values(983,'Java Basico',30,null,203);
insert into Curso values(984,'Java Avanzado',35,983,204);
insert into Curso values(985,'SQL Basico',30,984,205);
insert into Curso values(986,'SQL Avanzado',35,985,206);
insert into Curso values(987,'Disparadores',25,986,207);

select * from curso;

create table Edicion(
	ID int not null,
	FechaI datetime not null,
	FechaF datetime not null,
	CIdoc int not null,
	CODcurso int not null,
	primary key (ID),
	foreign key (CIdoc) references empleado(CI),
	foreign key (CodCurso) references Curso(COD)
);

insert into Edicion values(751,'2011/03/01','2011/03/31',111,983);
insert into Edicion values(752,'2011/04/15','2011/5/16',222,985);
insert into Edicion values(753,'2011/03/01','2011/03/31',333,981);
insert into Edicion values(758,'2011/03/01','2011/03/31',124,983);
	
insert into Edicion values(754,'2011/04/01','2011/04/30',432,982);
insert into Edicion values(755,'2011/03/01','2011/03/31',315,984);
insert into Edicion values(756,'2011/05/01','2011/05/31',432,986);
insert into Edicion values(757,'2011/03/01','2011/03/31',315,987);

select * from edicion;

create table Nota(
	IDedicion int not null,
	CIalum int not null,
	NotaF int not null,
	primary key (IDedicion,CIalum),
	foreign key (IDedicion) references Edicion(ID),
	foreign key (CIalum) references Empleado(CI)
);

insert into Nota values(751,444,51);
insert into Nota values(751,555,38);
insert into Nota values(751,666,95);
insert into Nota values(751,777,75);

insert into Nota values(752,888,55);
insert into Nota values(752,123,27);
insert into Nota values(752,124,78);
insert into Nota values(752,125,83);

insert into Nota values(753,888,45);
insert into Nota values(753,123,90);
insert into Nota values(753,124,55);
insert into Nota values(753,666,75);

insert into Nota values(754,444,70);

insert into Nota values(754,555,100);

Select * from nota;
SELECT empleado.ci , empleado.nombre
from empleado,edicion
where edicion.CIdoc= empleado.ci and empleado.sexo='m'
group by  empleado.ci,empleado.nombre 
having count(edicion.CIdoc)>1 ;

SELECT Curso.titulo AS Curso, count(Empleado.CI) AS CantidadAprobados
FROM Empleado, Nota, Edicion, Curso
WHERE 	Empleado.CI=Nota.CIalum 
	AND Nota.IDedicion = Edicion.ID
    AND Edicion.CODcurso = Curso.Cod
    AND Empleado.sexo = 'm'
    AND Nota.NotaF >= 51
GROUP BY Curso.titulo;

SELECT Curso.Cod ,Curso.titulo AS Curso
FROM Empleado, Edicion, Curso, Tema
WHERE Empleado.CI = Edicion.CIdoc
    AND Edicion.CODcurso = Curso.Cod
    AND Curso.IDtema = Tema.ID
    AND Empleado.Nombre = 'Ned Flanders'
    AND Tema.Descrp = 'Procedimientos And Funciones';




