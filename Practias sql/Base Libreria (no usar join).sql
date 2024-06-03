create database libreria;
use libreria;

CREATE TABLE Lector
(
    ciL INT NOT NULL PRIMARY KEY,
    Nombre VARCHAR(60) NOT NULL,
    Direccion VARCHAR(60) NOT NULL,
    Telefono INT NOT NULL,
    CiAvala INT
);

ALTER TABLE Lector
ADD foreign key (CiAvala) REFERENCES Lector(CiL)
ON update NO ACTION  
ON delete no action;

insert into Lector values(111,'Joaquin Chumacero Yupanqui','Los Totaises',3563030,null);

insert into Lector values(222,'Saturnino Mamani','Av.Cumavi',3558999,111);

insert into Lector values(333,'Patricia Yucra','Barrio Cruz del Sur',7102030,222);

CREATE TABLE Encargado
(
		CiE INT NOT NULL PRIMARY KEY,
        NombreE varchar(60) not null,
        Telefono int not null


);
insert into Encargado values(121,'Patricio Cusicanqui',3561111);

insert into Encargado values(122,'Fabiola Aguilera',7212323);
create table prestamo
(
	NroP int not null primary key,
    Fecha date not null,
	Dias int not null,
    ciLector int not null,
    CiEn int not null,
	foreign key(ciLector) references lector(ciL),
    foreign key(CiEn) references Encargado(ciE),
    Monto int not null

);

insert into prestamo values(1,'2009-01-10',1,222,122,5);
insert into prestamo values(2,'2009-01-11',2,111,121,2);
insert into prestamo values(3,'2009-01-11',3,333,122,5);
insert into prestamo values(4,'2009-01-12',2,333,121,4);

insert into prestamo values(5,'2009-01-13',2,111,122,4);

create table libro
(
	Codigo int not null primary key,
    Titulo varchar(60),
    Año int not null
);
insert INTO libro values(101,'Introduccion a la programacion',2000);
insert INTO libro values(102,'Fundamentos de bases de datos',2005);
insert INTO libro values(103,'Java para principiantes',2000);
insert INTO libro values(104,'Informatica aplicada',2009);
insert INTO libro values(105,'Inforca aplicada',2009);

create table Detalle
(
	NroPr int not null,
    CodLibro int not null,
    primary key(NroPr,CodLibro),
    foreign key(NroPr) references prestamo(NroP),
    foreign key(CodLibro) references Libro(Codigo)
    
);

insert into Detalle values(1,102);
insert into Detalle values(1,103);
insert into Detalle values(2,102);

insert into Detalle values(3,104);
insert into Detalle values(4,103);
insert into Detalle values(4,101);
insert into Detalle values(4,102);
insert into Detalle values(5,104);

select distinct Libro.Titulo , Libro.Año,Encargado.NombreE 
from Libro,Detalle,Encargado,prestamo
where Libro.Codigo=Detalle.CodLibro 
	AND Detalle.NroPr =prestamo.NroP
    and Encargado.CiE=prestamo.CiEn
	and Libro.Año>2000
    and Encargado.NombreE='Patricio Cusicanqui';
    
    SELECT libro.Titulo
FROM libro, Detalle, prestamo, Encargado
WHERE libro.Codigo = Detalle.CodLibro
  AND Detalle.NroPr = prestamo.NroP
  AND prestamo.CiEn = Encargado.CiE
  AND libro.Año > 2000
  AND Encargado.NombreE = 'Patricio Cusicanqui';
  
  SELECT *
FROM Libro
WHERE Codigo NOT IN (
    SELECT CodLibro
    FROM Detalle
    WHERE NroPr IN (
        SELECT NroP
        FROM Prestamo
        WHERE CiEn IN (
            SELECT CiE
            FROM Encargado
            WHERE NombreE IN ('Patricio Cusicanqui', 'Fabiola Aguilera')
        )
    )
);
SELECT Encargado.NombreE, COUNT(DISTINCT Detalle.CodLibro) AS Cantidad_Libros_Prestados
FROM Encargado
JOIN Prestamo ON Encargado.CiE = Prestamo.CiEn
JOIN Detalle ON Prestamo.NroP = Detalle.NroPr
WHERE Prestamo.Dias > 1
GROUP BY Encargado.NombreE;

SELECT Encargado.NombreE, COUNT(DISTINCT Detalle.CodLibro) AS Cantidad_Libros_Prestados
FROM Encargado, Prestamo, Detalle
WHERE Encargado.CiE = Prestamo.CiEn
  AND Prestamo.NroP = Detalle.NroPr
  AND Prestamo.Dias > 1
GROUP BY Encargado.NombreE;

SELECT Encargado.NombreE AS Encargado,
    (SELECT COUNT(*)
    FROM Prestamo
    WHERE Prestamo.CiEn = Encargado.CiE AND Prestamo.Dias > 1) AS Cantidad_Libros_Prestados
FROM Encargado;
SELECT Encargado.NombreE AS Encargado,
    (SELECT COUNT(DISTINCT Detalle.CodLibro)
     FROM Prestamo
     JOIN Detalle ON Prestamo.NroP = Detalle.NroPr
     WHERE Prestamo.CiEn = Encargado.CiE AND Prestamo.Dias > 1
    ) AS Cantidad_Libros_Prestados
FROM Encargado;


SELECT Encargado.NombreE AS 'Encargado', COUNT(Detalle.CodLibro) AS 'Cantidad de Libros Prestados'
FROM Prestamo
JOIN Encargado ON Prestamo.CiEn = Encargado.CiE
JOIN Detalle ON Prestamo.NroP = Detalle.NroPr
WHERE Prestamo.Dias > 1
GROUP BY Encargado.NombreE;
