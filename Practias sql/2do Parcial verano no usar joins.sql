create database comercio4;
use comercio4;


CREATE TABLE cliente(

nit int primary key,
nombre varchar(40),
telefono int not null

);


create table factura(
nro int primary key,
fecha date not null,
monto int not null,
nitcliente int not null,
foreign key(nitcliente) references cliente(nit)


);


create table categoria(
id int primary key,
descripcion varchar(20),
idpadre int,
foreign key(idpadre) references categoria(id)

);

create table producto(
codigo varchar(6) primary key,
nombre varchar(50),
precio int ,
idcategoria int ,
foreign key(idcategoria) references categoria(id)
);

create table vende(
nrofactura int,
id int,
cantidad int,
precio int,
codigoproducto varchar(6),
foreign key(nrofactura) references factura(nro),
foreign key(codigoproducto) references producto(codigo)


);


INSERT into cliente(nit,nombre,telefono) values (1111,'Joaquin Chumacero',7102030);
INSERT into cliente(nit,nombre,telefono) values (2222,'Saturnino Mamani',3569811);

INSERT into factura(nro,fecha,monto,nitcliente) values (100,'2022/10/01',26,1111);
INSERT into factura(nro,fecha,monto,nitcliente) values (101,'2022/11/01',55,2222);
INSERT into factura(nro,fecha,monto,nitcliente) values (102,'2022/11/01',65,1111);

INSERT into categoria(id,descripcion,idpadre) values (1,'BEBIDAS',null);
INSERT into categoria(id,descripcion,idpadre) values (2,'ALCOHOLICAS',1);
INSERT into categoria(id,descripcion,idpadre) values (3,'NO ALCOHOLICAS',1);
INSERT into categoria(id,descripcion,idpadre) values (4,'ABARROTES',null);
INSERT into categoria(id,descripcion,idpadre) values (5,'COMESTIBLES',4);
INSERT into categoria(id,descripcion,idpadre) values (6,'LIMPIEZA',4);

INSERT INTO producto(codigo,nombre,precio,idcategoria) values('P001','AZUCAR 1 KG',6,5);
INSERT INTO producto(codigo,nombre,precio,idcategoria) values('P002','ACEITE 1 LTS',11,5);
INSERT INTO producto(codigo,nombre,precio,idcategoria) values('P003','PASTA DENTAL',10,6);
INSERT INTO producto(codigo,nombre,precio,idcategoria) values('P004','JABON',3,6);
INSERT INTO producto(codigo,nombre,precio,idcategoria) values('P005','COCA COLA 2LTS',10,3);
INSERT INTO producto(codigo,nombre,precio,idcategoria) values('P006','CHAMPU',15,6);
INSERT INTO producto(codigo,nombre,precio,idcategoria) values('P007','AZUCAR 5 KG',25,5);


INSERT INTO vende(nrofactura,id,cantidad,precio,codigoproducto) values(100,1,1,6,'P001');
INSERT INTO vende(nrofactura,id,cantidad,precio,codigoproducto) values(100,2,2,10,'P003');
INSERT INTO vende(nrofactura,id,cantidad,precio,codigoproducto) values(101,1,1,10,'P003');
INSERT INTO vende(nrofactura,id,cantidad,precio,codigoproducto) values(101,2,3,10,'P005');
INSERT INTO vende(nrofactura,id,cantidad,precio,codigoproducto) values(101,3,1,15,'P006');
INSERT INTO vende(nrofactura,id,cantidad,precio,codigoproducto) values(102,1,4,8,'P005');

INSERT INTO vende(nrofactura,id,cantidad,precio,codigoproducto) values(102,2,1,25,'P007');
INSERT INTO vende(nrofactura,id,cantidad,precio,codigoproducto) values(102,3,1,8,'P005');





select distinct producto.nombre,sum(vende.cantidad) as cantidadvendida
from producto,categoria,vende
where producto.idcategoria=categoria.ID
and vende.codigoproducto = producto.codigo
and categoria.idpadre in (select ID
from categoria
where categoria.descripcion='ABARROTES')

group by producto.nombre;


select distinct vende.nrofactura ,vende.cantidad*vende.precio as montovendido,producto.nombre
from vende,producto,factura,cliente
where vende.nrofactura=factura.nro and producto.codigo=vende.codigoproducto and producto.nombre='PASTA DENTAL';

SELECT DISTINCT cliente.nombre AS Cliente
FROM cliente
JOIN factura ON cliente.nit = factura.nitcliente
JOIN vende ON factura.nro = vende.nrofactura
JOIN producto ON vende.codigoproducto = producto.codigo
WHERE producto.nombre LIKE 'a%'
  AND vende.cantidad >= 1;

    
select cliente.nombre as cliente

from cliente,vende,producto,factura

where producto.codigo=vende.codigoproducto

		and cliente.nit =factura.nitcliente

		and producto.nombre like 'a%'

	and vende.cantidad>=1

        group by cliente.nombre;



SELECT cliente.nombre AS Cliente
FROM cliente
JOIN factura ON cliente.nit = factura.nitcliente
JOIN vende ON factura.nro = vende.nrofactura
JOIN producto ON vende.codigoproducto = producto.codigo
WHERE producto.nombre LIKE 'a%'
  AND vende.cantidad >= 1
GROUP BY  cliente.nombre;

SELECT SUM(v.cantidad * p.precio) AS monto_total_ventas
FROM vende v, producto p, categoria c
WHERE v.codigoproducto = p.codigo
  AND p.idcategoria = c.id
  AND (c.descripcion = 'ABARROTES' OR c.idpadre = (SELECT id FROM categoria WHERE descripcion = 'ABARROTES'));
  
  