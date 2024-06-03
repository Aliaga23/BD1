CREATE DATABASE TIENDAVERANO;
USE TIENDAVERANO;

CREATE TABLE CLIENTETIENDA(
CI INTEGER NOT NULL PRIMARY KEY,
NOMBRE VARCHAR(30) NOT NULL
);
CREATE TABLE PRODUCTO(
CODIGO VARCHAR(4) NOT NULL PRIMARY KEY,
NOMBRE VARCHAR(40) NOT NULL,
PRECIO FLOAT NOT NULL

);
CREATE TABLE NOTAVENTA(
NRO INTEGER NOT NULL PRIMARY KEY,
FECHA DATE NOT NULL,
TOTAL FLOAT NOT NULL,
CICLIENTE INTEGER NOT NULL,
FOREIGN KEY(CICLIENTE) REFERENCES CLIENTETIENDA(CI)
ON UPDATE CASCADE
ON DELETE CASCADE
);

CREATE TABLE VENDE(
NROV INTEGER NOT NULL,
CODIGOP VARCHAR(4) NOT NULL,
CANTIDAD INTEGER NOT NULL,
PRECIO FLOAT NOT NULL,
PRIMARY KEY(NROV,CODIGOP),
FOREIGN KEY(NROV) REFERENCES NOTAVENTA(NRO)
ON UPDATE CASCADE
ON DELETE CASCADE,
FOREIGN KEY(CODIGOP) REFERENCES PRODUCTO(CODIGO)
ON UPDATE CASCADE
ON DELETE CASCADE
);

INSERT INTO CLIENTETIENDA VALUES(111,'JOAQUIN CHUMACERO');
INSERT INTO CLIENTETIENDA VALUES(222,'SATURNINO MAMANI');
INSERT INTO CLIENTETIENDA VALUES(333,'FABIOLA MENDEZ');

INSERT INTO PRODUCTO VALUES('P001','ACEITE 1 LTS',15);
INSERT INTO PRODUCTO VALUES('P002','COCA COLA 2 LTS',10);
INSERT INTO PRODUCTO VALUES('P003','AZUCAR 1 KG',6);
INSERT INTO PRODUCTO VALUES('P004','PAPEL HIGIENICO 6 ROLLOS',10);
INSERT INTO PRODUCTO VALUES('P005','ARROZ 1 KG',7);
INSERT INTO PRODUCTO VALUES('P006','COCA COLA 3 LTS',15);

INSERT INTO NOTAVENTA VALUES(100,'2024/01/10',70,111);
INSERT INTO NOTAVENTA VALUES(101,'2024/01/13',100,222);
INSERT INTO NOTAVENTA VALUES(102,'2024/01/13',120,111);
INSERT INTO NOTAVENTA VALUES(103,'2024/01/15',50,333);
INSERT INTO NOTAVENTA VALUES(104,'2024/01/19',20,222);

INSERT INTO VENDE VALUES(100,'P002',5,10);
INSERT INTO VENDE VALUES(100,'P004',2,10);
INSERT INTO VENDE VALUES(101,'P006',4,15);
INSERT INTO VENDE VALUES(101,'P003',5,5);
INSERT INTO VENDE VALUES(101,'P001',1,15);
INSERT INTO VENDE VALUES(102,'P004',12,10);
INSERT INTO VENDE VALUES(103,'P002',2,10);
INSERT INTO VENDE VALUES(103,'P001',2,15);
INSERT INTO VENDE VALUES(104,'P003',4,5);


SELECT *
FROM NOTAVENTA
WHERE TOTAL >50;

SELECT NRO,FECHA,TOTAL
FROM CLIENTETIENDA,NOTAVENTA
WHERE CI= CICLIENTE AND NOMBRE = 'JOAQUIN CHUMACERO';

SELECT SUM(TOTAL) AS MONTO_TOTAL
FROM NOTAVENTA,CLIENTETIENDA
WHERE CI=CICLIENTE AND NOMBRE= 'JOAQUIN CHUMACERO';

SELECT COUNT(*) AS CANTIDAD_NOTAS
FROM NOTAVENTA,CLIENTETIENDA
WHERE CI=CICLIENTE AND NOMBRE= 'JOAQUIN CHUMACERO';
/* MOSTRAR TODAS LAS NOTAS DE VENTA Y SU NUMERO DONDE SE VENDIO ACEITE */

SELECT NRO,FECHA,TOTAL
FROM NOTAVENTA,PRODUCTO,VENDE
WHERE NRO = NROV AND CODIGO = CODIGOP AND PRODUCTO.NOMBRE = 'ACEITE 1 LTS' ;

/* MOSTRAR LA CANTIDAD DE COCA COLA DE 2 LTS VENDIDAS */
SELECT SUM(CANTIDAD) AS TOTAL
FROM VENDE,NOTAVENTA,PRODUCTO
WHERE NRO= NROV AND CODIGOP = CODIGO AND PRODUCTO.NOMBRE = 'COCA COLA 2 LTS';

/*MOSTRAR TODOS LOS PRODUCTOS QUE TIENEN UNIDAD DE MEDIDA EN LTS */
SELECT *
FROM PRODUCTO
WHERE NOMBRE LIKE '%LTS%';


/* MOSTRAR TODOS LOS PRODUCTOS COMPRADOS POR JOAQUIN CHUMACERO*/
SELECT PRODUCTO.NOMBRE,PRODUCTO.PRECIO,CANTIDAD
FROM VENDE,PRODUCTO,NOTAVENTA,CLIENTETIENDA
WHERE NROV = NRO AND CODIGOP = CODIGO AND CI = CICLIENTE AND CLIENTETIENDA.NOMBRE = 'JOAQUIN CHUMACERO';

/* MOSTRAR TODOS LOS PRODUCTOS QUE NO FUERON VENDIDOS*/
SELECT *
FROM PRODUCTO
WHERE CODIGO NOT IN (SELECT CODIGOP FROM VENDE);