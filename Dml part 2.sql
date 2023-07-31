CREATE DATABASE  IF NOT EXISTS `actividades`;
USE `actividades`;


DROP TABLE IF EXISTS `almacenes`;
CREATE TABLE `almacenes` (
  `CODIGO` int NOT NULL,
  `LUGAR` varchar(255) NOT NULL,
  `CAPACIDAD` int NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `almacenes` VALUES (1,'Valencia',3),(2,'Barcelona',4),(3,'Bilbao',7),(4,'Los Angeles',2),(5,'San Francisco',8);


DROP TABLE IF EXISTS `fabricantes`;
CREATE TABLE `fabricantes` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `fabricantes` VALUES (1,'Sony'),(2,'Creative Labs'),(3,'Hewlett-Packard'),(4,'Iomega'),(5,'Fujitsu'),(6,'Winchester');


DROP TABLE IF EXISTS `articulos`;
CREATE TABLE `articulos` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `PRECIO` decimal(10,0) NOT NULL,
  `FABRICANTE` int NOT NULL,
  PRIMARY KEY (`CODIGO`),
  KEY `FABRICANTE` (`FABRICANTE`),
  CONSTRAINT `articulos_ibfk_1` FOREIGN KEY (`FABRICANTE`) REFERENCES `fabricantes` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `articulos` VALUES (1,'Hard drive',240,5),(2,'Memory',120,6),(3,'ZIP drive',150,4),(4,'Floppy disk',5,6),(5,'Monitor',240,1),(6,'DVD drive',180,2),(7,'CD drive',90,2),(8,'Printer',270,3),(9,'Toner cartridge',66,3),(10,'DVD burner',180,2);


DROP TABLE IF EXISTS `cajas`;
CREATE TABLE `cajas` (
  `NUMREFERENCIA` varchar(255) NOT NULL,
  `CONTENIDO` varchar(255) NOT NULL,
  `VALOR` double NOT NULL,
  `ALMACEN` int NOT NULL,
  PRIMARY KEY (`NUMREFERENCIA`),
  KEY `ALMACEN` (`ALMACEN`),
  CONSTRAINT `cajas_ibfk_1` FOREIGN KEY (`ALMACEN`) REFERENCES `almacenes` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `cajas` VALUES ('0MN7','Rocks',180,3),('4H8P','Rocks',250,1),('4RT3','Scissors',190,4),('7G3H','Rocks',200,1),('8JN6','Papers',75,1),('8Y6U','Papers',50,3),('9J6F','Papers',175,2),('LL08','Rocks',140,4),('P0H6','Scissors',125,1),('P2T6','Scissors',150,2),('TU55','Papers',90,5);


DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE `departamentos` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `PRESUPUESTO` decimal(10,0) NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `departamentos` VALUES (14,'IT',65000),(37,'Accounting',15000),(59,'Human Resources',240000),(77,'Research',55000);


DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `DNI` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `APELLIDOS` varchar(255) NOT NULL,
  `DEPARTAMENTO` int NOT NULL,
  PRIMARY KEY (`DNI`),
  KEY `DEPARTAMENTO` (`DEPARTAMENTO`),
  CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`DEPARTAMENTO`) REFERENCES `departamentos` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `empleados` VALUES (123234877,'Michael','Rogers',14),(152934485,'Anand','Manikutty',14),(222364883,'Carol','Smith',37),(326587417,'Joe','Stevens',37),(332154719,'Mary-Anne','Foster',14),(332569843,'George','O\'Donnell',77),(546523478,'John','Doe',59),(631231482,'David','Smith',77),(654873219,'Zacary','Efron',59),(745685214,'Eric','Goldsmith',59),(845657233,'Luis','López',14),(845657245,'Elizabeth','Doe',14),(845657246,'Kumar','Swamy',14),(845657266,'Jose','Pérez',77);


DROP TABLE IF EXISTS `peliculas`;
CREATE TABLE `peliculas` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `CALIFICACIONEDAD` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `peliculas` VALUES (1,'Citizen Kane','PG'),(2,'Singin\' in the Rain','G'),(3,'The Wizard of Oz','G'),(4,'The Quiet Man',NULL),(5,'North by Northwest',NULL),(6,'The Last Tango in Paris','NC-17'),(7,'Some Like it Hot','PG-13'),(8,'A Night at the Opera',NULL),(9,'Citizen King','G');


DROP TABLE IF EXISTS `salas`;
CREATE TABLE `salas` (
  `CODIGO` int NOT NULL,
  `NOMBRE` varchar(255) NOT NULL,
  `PELICULA` int DEFAULT NULL,
  PRIMARY KEY (`CODIGO`),
  KEY `PELICULA` (`PELICULA`),
  CONSTRAINT `salas_ibfk_1` FOREIGN KEY (`PELICULA`) REFERENCES `peliculas` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `salas` VALUES (1,'Odeon',5),(2,'Imperial',1),(3,'Majestic',NULL),(4,'Royale',6),(5,'Paraiso',3),(6,'Nickelodeon',NULL);




/* 1.1 */

SELECT NOMBRE FROM articulos;

/* 1.2 */

SELECT NOMBRE, PRECIO FROM articulos;

/* 1.3 */

SELECT NOMBRE FROM articulos WHERE PRECIO < 200;

/* 1.4 */

SELECT * FROM articulos WHERE PRECIO BETWEEN 60 AND 120;

/* 1.5 */

SELECT NOMBRE, PRECIO * 166.386 AS PrecioPtas FROM articulos;

/* 1.6 */

SELECT AVG(PRECIO) FROM articulos;

/* 1.7 */

SELECT AVG(PRECIO) FROM articulos WHERE FABRICANTE = 2;

/* 1.8 */

SELECT COUNT(*) FROM articulos WHERE PRECIO >= 180;

/* 1.9 */

SELECT NOMBRE, PRECIO
FROM articulos
WHERE PRECIO >= 180
ORDER BY PRECIO DESC, NOMBRE;

/* 1.10 */

SELECT *
FROM articulos, fabricantes
WHERE articulos.FABRICANTE = fabricantes.CODIGO;

/* 1.11 */

SELECT articulos.Nombre, PRECIO, fabricantes.NOMBRE
FROM articulos, fabricantes
WHERE articulos.FABRICANTE = fabricantes.CODIGO;

/* 1.12 */

SELECT AVG(PRECIO), FABRICANTE
FROM articulos
GROUP BY FABRICANTE;

/* 1.13 */

SELECT AVG(PRECIO), fabricantes.NOMBRE
FROM articulos, fabricantes
WHERE articulos.FABRICANTE = fabricantes.CODIGO
GROUP BY fabricantes.NOMBRE;

/* 1.14 */

SELECT AVG(PRECIO), fabricantes.NOMBRE
FROM articulos, fabricantes
WHERE articulos.Fabricante = fabricantes.CODIGO
GROUP BY fabricantes.NOMBRE
HAVING AVG(PRECIO) >= 150;

/* 1.15 */

SELECT NOMBRE, PRECIO
FROM articulos
WHERE PRECIO = (SELECT MIN(PRECIO) FROM articulos);

/* 1.16 */

SELECT A.NOMBRE, A.PRECIO, F.NOMBRE
FROM articulos A, fabricantes F
WHERE A.FABRICANTE = F.CODIGO
AND A.PRECIO = (
 SELECT MAX(A2.PRECIO)
 FROM articulos A2
 WHERE A2.FABRICANTE = F.CODIGO);

/* 1.17 */

INSERT INTO articulos (CODIGO, NOMBRE, PRECIO ,FABRICANTE)
VALUES (20,'Altavoces', 70, 2);

/* 1.18 */

UPDATE articulos SET NOMBRE = 'Impresora Laser' WHERE CODIGO = 8; 

/* 1.19 */

UPDATE articulos SET PRECIO = PRECIO * 0.9;

/* 1.20 */

UPDATE articulos SET PRECIO = PRECIO - 10 WHERE PRECIO >= 120;

/* 2.1 */

SELECT Apellidos FROM empleados;

/* 2.2 */

SELECT DISTINCT Apellidos FROM empleados;

/* 2.3 */

SELECT * FROM empleados WHERE apellidos = 'López';

/* 2.4 */

SELECT *
FROM empleados
WHERE apellidos IN ('López', 'Pérez');

/* 2.5 */

SELECT * FROM empleados WHERE departamento = 14;

/* 2.6 */

SELECT *
FROM empleados
WHERE departamento IN (37,77);

/* 2.7 */

SELECT * FROM empleados WHERE apellidos LIKE 'P%';

/* 2.8 */

SELECT SUM(presupuesto) FROM departamentos;

/* 2.9 */

SELECT departamento, COUNT(*)
FROM empleados
GROUP BY departamento;

/* 2.10 */

SELECT *
FROM empleados, departamentos
WHERE empleados.departamento = departamentos.codigo;

/* 2.11 */

SELECT E.nombre, apellidos, D.nombre, presupuesto
FROM empleados E, departamentos D
WHERE E.departamento = D.codigo;

/* 2.12 */

SELECT empleados.nombre, apellidos
FROM empleados, departamentos
WHERE empleados.departamento = departamentos.codigo
AND departamentos.presupuesto > 60000;

/* 2.13 */

SELECT *
FROM departamentos
WHERE Presupuesto > (
SELECT AVG(Presupuesto) FROM departamentos );

/* 2.14 */

SELECT Nombre
FROM departamentos
WHERE Codigo IN (
 SELECT Departamento
 FROM empleados
 GROUP BY Departamento
 HAVING COUNT(*) > 2 );

/* 2.15 */

INSERT INTO departamentos
VALUES ( 11 , 'Calidad' , 40000);

INSERT INTO empleados
VALUES ('89267109', 'Esther', 'Vázquez', 11);

/* 2.16 */

UPDATE departamentos SET presupuesto = presupuesto * 0.9;

/* 2.17 */

UPDATE empleados SET departamento = 14 WHERE departamento = 77;

/* 2.18 */

DELETE FROM empleados WHERE departamento = 14;

/* 2.19 */

DELETE FROM empleados
WHERE departamento IN (
SELECT Codigo FROM departamentos WHERE presupuesto >= 60000);

/* 2.20 */

DELETE FROM empleados;

/* 3.1 */

SELECT * FROM almacenes;

/* 3.2 */

SELECT * FROM cajas WHERE Valor > 150;

/* 3.3 */

SELECT DISTINCT contenido FROM cajas;

/* 3.4 */

SELECT AVG(valor) FROM cajas;

/* 3.5 */

SELECT almacen, AVG(valor) FROM cajas GROUP BY almacen;

/* 3.6 */

SELECT almacen, AVG(valor)
FROM cajas
GROUP BY almacen
HAVING AVG(valor) > 150;

/* 3.7 */

SELECT NumReferencia, lugar
FROM almacenes, cajas
WHERE almacenes.codigo = cajas.Almacen;

/* 3.8 */

SELECT almacen, COUNT(*)
FROM cajas
GROUP BY almacen;

/* 3.9 */

SELECT codigo
FROM almacenes
WHERE capacidad < (
SELECT COUNT(*) FROM cajas WHERE almacen = codigo);

/* 3.10 */

SELECT NumReferencia
FROM cajas WHERE almacen IN (
SELECT codigo FROM almacenes WHERE Lugar = 'Bilbao');

/* 3.11 */

INSERT INTO almacenes(lugar, capacidad) VALUES('Barcelona', 3);

/* 3.12 */

INSERT INTO cajas VALUES('H5RT', 'Papel', 200, 2);

/* 3.13 */

UPDATE cajas SET valor = valor * 0.85;

/* 3.14 */

UPDATE cajas SET valor = valor * 0.80
WHERE valor > (SELECT avg_valor FROM (
SELECT AVG(valor) AS avg_valor FROM cajas) AS promedio);

/* 3.15 */

DELETE FROM cajas WHERE valor < 100;

/* 3.16 */

DELETE FROM cajas WHERE almacen IN (
  SELECT codigo FROM (
    SELECT a.codigo FROM almacenes AS a
    WHERE a.capacidad < (
    SELECT COUNT(*) FROM cajas AS c WHERE c.almacen = a.codigo))
    AS subquery
);

/* 4.1 */

SELECT nombre FROM peliculas;

/* 4.2 */

SELECT DISTINCT CalificacionEdad FROM peliculas;

/* 4.3 */

SELECT * FROM peliculas WHERE CalificacionEdad IS NULL;

/* 4.4 */

SELECT * FROM salas WHERE pelicula IS NULL;

/* 4.5 */

SELECT *
FROM salas LEFT JOIN peliculas ON salas.pelicula = peliculas.codigo;
 
/* 4.6 */

SELECT *
FROM salas RIGHT JOIN peliculas ON salas.pelicula = peliculas.codigo;

/* 4.7 */

SELECT peliculas.nombre
FROM salas RIGHT JOIN peliculas ON salas.pelicula = peliculas.codigo
WHERE salas.pelicula IS NULL;

/* 4.8 */

INSERT INTO peliculas (codigo, nombre, CalificacionEdad)
VALUES (24, 'Uno, Dos, Tres', 7);

/* 4.9 */

UPDATE peliculas SET CalificacionEdad=13
WHERE CalificacionEdad IS NULL;

/* 4.10 */

DELETE FROM salas
WHERE pelicula IN (
SELECT codigo FROM peliculas WHERE CalificacionEdad = 'PG');
