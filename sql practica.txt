create database comercio;
use comercio;
create table cliente
(
nit int primary key not null,
nombre varchar(50) not null,
telefono varchar(8) not null
);
insert into cliente values(1111,'Joaquin Chumacero','7102030');
insert into cliente values(2222,'Saturnino Mamani','3569811');
create table factura
(
nro int primary key not null,
fecha date not null,
monto int not null,
nitcliente int not null,
foreign key (nitcliente)references cliente(nit)
on update cascade
on delete cascade
);
insert into factura values(100,'2022/01/10',26,1111);
insert into factura values(101,'2022/01/11',55,2222);
insert into factura values(102,'2022/01/11',65,1111);
create table producto
(
codigo varchar(4) primary key not null,
nombre varchar(50) not null,
precio int not null
);
insert into producto values('P001','AZUCAR 1 KG',6);
insert into producto values('P002','ACEITE 1 LTS',11);
insert into producto values('P003','PASTA DENTAL',10);
insert into producto values('P004','JABON',3);
insert into producto values('P005','COCO COLA 2 LTS',10);
insert into producto values('P006','CHAMPU',15);
insert into producto values('P007','AZUCAR 5 KG',25);
create table vende
(
nrofactura int not null,
id int not null,
cantidad int not null,
precio int not null,
codigoproducto varchar(4) not null,
primary key(nrofactura,id),
foreign key (nrofactura)references factura(nro)
on update cascade
on delete cascade,
foreign key (codigoproducto)references producto(codigo)
on update cascade
on delete cascade
);
insert into vende values(100,1,1,6,'P001');

insert into vende values(100,2,2,10,'P003');
insert into vende values(100,4,2,10,'P003');

insert into vende values(101,1,1,10,'P003');
insert into vende values(101,2,3,10,'P005');
insert into vende values(101,3,1,15,'P006');
insert into vende values(102,1,4,8,'P005');
insert into vende values(102,2,1,25,'P007');

insert into vende values(100,3,1,11,'P002');

insert into vende values(102,3,1,8,'P005');


select producto.nombre, producto.precio, cliente.nombre
from producto,vende,factura,cliente
where codigo=codigoproducto and nrofactura=nro and nitcliente=nit and producto.nombre like 'a%'
and producto.precio>5 and cliente.nombre='joaquin chumacero';

SELECT producto.nombre,producto.precio,cliente.nombre,producto.codigo
from producto,vende,factura,cliente
where cliente.nombre like 'h%';

SELECT factura.nro,producto.nombre,vende.cantidad as 'monto comprado'
FROM producto,factura,vende,cliente
where  factura.nro=nro and producto.nombre ='PASTA DENTAL' and vende.cantidad;

SELECT producto.nombre
FROM producto,vende
where codigo=codigoproducto group by codigoproducto having count(codigoproducto) >0;
 
 SELECT * FROM vende;
 SELECT factura.nro,producto.nombre,sum(vende.cantidad*vende.precio) as 'monto comprado'
 FROM factura,vende,producto
 where codigo=codigoproducto and nrofactura=nro and producto.nombre='PASTA DENTAL' group by nrofactura;
