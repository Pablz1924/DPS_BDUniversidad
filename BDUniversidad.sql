-- Base de datos de ejemplo
-- Peña Tejada, Pabel Sebastian
-- 08/08/2022

USE MASTER
GO

IF DB_ID('BDUniversidad') IS NOT NULL DROP DATABASE BDUniversidad
GO

CREATE DATABASE BDUniversidad
GO

USE BDUniversidad
GO

-- Crear tablas
IF OBJECT_ID('TEscuela') IS NOT NULL DROP TABLE TEscuela
GO

CREATE TABLE TEscuela
(
	CodEscuela CHAR(3) PRIMARY KEY,
	Escuela VARCHAR(50),
	Facultad VARCHAR(50)
)
GO

IF OBJECT_ID('TAlumno') IS NOT NULL DROP TABLE TAlumno
GO

CREATE TABLE TAlumno
(
	CodAlumno CHAR(5) PRIMARY KEY,
	Apellidos VARCHAR(50),
	Nombres VARCHAR(50),
	LugarNac VARCHAR(50),
	FechaNac DATETIME,
	CodEscuela CHAR(3) FOREIGN KEY (CodEscuela) REFERENCES TEscuela
)
GO

-- Inserción de datos
INSERT INTO TEscuela VALUES ('E01','SISTEMAS','INGENERIA')
INSERT INTO TEscuela VALUES ('E02','CIVIL','INGENERIA')
INSERT INTO TEscuela VALUES ('E03','INDUSTRIAL','INGENERIA')
INSERT INTO TEscuela VALUES ('E04','AMBIENTAL','INGENERIA')
INSERT INTO TEscuela VALUES ('E05','ARQUITECTURA','INGENERIA')
GO
SELECT * FROM TEscuela

--INSERT INTO TAlumno VALUES ('','','','','')