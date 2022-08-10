-- Procedimientos Almacenados
-- Peña Tejada, Pabel Sebastian
-- 08/08/2022

--PA para la TEscuela

USE BDUniversidad
GO

IF OBJECT_ID('spListarEscuela') IS NOT NULL DROP PROC spListarEscuela
GO

CREATE PROC spListarEscuela
AS
BEGIN
	SELECT CodEscuela,Escuela,Facultad FROM TEscuela
END

EXEC spListarEscuela
GO

IF OBJECT_ID('spAgregarEscuela') IS NOT NULL DROP PROC spAgregarEscuela
GO

CREATE PROC spAgregarEscuela
@CODESCUELA CHAR(3),
@ESCUELA VARCHAR(50),
@FACULTAD VARCHAR(50)
AS
BEGIN
	--CODESCUELA NO PUEDE SER DUPLICADO
	IF NOT EXISTS (SELECT CodEscuela from TEscuela where CodEscuela=@CODESCUELA)
		--ESCUELA NO PUEDE SER DUPLICADA
		IF NOT EXISTS (SELECT Escuela from TEscuela where Escuela=@ESCUELA)
		BEGIN
			INSERT INTO TEscuela VALUES(@CODESCUELA,@ESCUELA,@FACULTAD)
			SELECT CODERROR=0, MENSAJE='Se insertó correctamente la escuela'
		END
		ELSE SELECT CODERROR=1, MENSAJE='ERROR: Escuela duplicada'
	ELSE SELECT CODERROR=1, MENSAJE='ERROR: CodEscuela duplicado'
	--
END

EXEC spListarEscuela
EXEC spAgregarEscuela 'E06','MEDICINA','SALUD'
GO

IF OBJECT_ID('spEliminarEscuela') IS NOT NULL DROP PROC spEliminarEscuela
GO

CREATE PROC spEliminarEscuela
@CODESCUELA CHAR(3)
AS
BEGIN
	DELETE FROM TEscuela where CodEscuela=@CODESCUELA
END

EXEC spListarEscuela
EXEC spEliminarEscuela 'E06'
GO


IF OBJECT_ID('spActualizarEscuela') IS NOT NULL DROP PROC spActualizarEscuela
GO

CREATE PROC spActualizarEscuela
@CODESCUELA CHAR(3),
@ESCUELA VARCHAR(50),
@FACULTAD VARCHAR(50)
AS
BEGIN
	--ESCUELA NO PUEDE SER DUPLICADA
	IF NOT EXISTS (SELECT Escuela from TEscuela where Escuela=@ESCUELA)
	BEGIN
		UPDATE TEscuela SET Escuela=@ESCUELA,Facultad=@FACULTAD WHERE CodEscuela=@CODESCUELA
		SELECT CODERROR=0, MENSAJE='Se actualizó correctamente la escuela'
	END
	ELSE SELECT CODERROR=1, MENSAJE='ERROR: Escuela duplicada'
END

EXEC spListarEscuela
EXEC spActualizarEscuela 'E06','DERECHO','CH'
GO

IF OBJECT_ID('spBuscarEscuela') IS NOT NULL DROP PROC spBuscarEscuela
GO

CREATE PROC spBuscarEscuela
@CODESCUELA CHAR(3)
AS
BEGIN
	SELECT CodEscuela,Escuela,Facultad FROM TEscuela WHERE CodEscuela=@CODESCUELA
END

EXEC spListarEscuela
EXEC spBuscarEscuela 'E03'
GO

-------------------------------------------------------------------------------

IF OBJECT_ID('spListarAlumno') IS NOT NULL DROP PROC spListarAlumno
GO

CREATE PROC spListarAlumno
AS
BEGIN
	SELECT CodAlumno,Apellidos,Nombres,LugarNac,FechaNac,CodEscuela FROM TAlumno
END

EXEC spListarAlumno
GO

IF OBJECT_ID('spAgregarAlumno') IS NOT NULL DROP PROC spAgregarAlumno
GO

CREATE PROC spAgregarAlumno
@CODALUMNO CHAR(5),
@APELLIDOS VARCHAR(50),
@NOMBRES VARCHAR(50),
@LUGARNAC VARCHAR(50),
@FECHANAC DATETIME,
@CODESCUELA CHAR(3)
AS
BEGIN
	--CODESCUELA NO PUEDE SER DUPLICADO
	IF NOT EXISTS (SELECT CodAlumno from TAlumno where CodAlumno=@CODALUMNO)
		BEGIN
			INSERT INTO TALumno VALUES(@CODALUMNO,@APELLIDOS,@NOMBRES,@LUGARNAC,@FECHANAC,@CODESCUELA)
			SELECT CODERROR=0, MENSAJE='Se insertó correctamente el alumno'
		END
	ELSE SELECT CODERROR=1, MENSAJE='ERROR: CodAlumno duplicado'
	--
END

EXEC spListarAlumno
EXEC spAgregarAlumno 'A0001','LOPEZ HERNANDEZ','JUAN','AREQUIPA','12-mar-2013','E01'
GO

IF OBJECT_ID('spEliminarAlumno') IS NOT NULL DROP PROC spEliminarAlumno
GO

CREATE PROC spEliminarAlumno
@CODALUMNO CHAR(5)
AS
BEGIN
	DELETE FROM TAlumno where CodAlumno=@CODALUMNO
END

EXEC spListarAlumno
EXEC spEliminarAlumno 'A0001'
GO


IF OBJECT_ID('spActualizarAlumno') IS NOT NULL DROP PROC spActualizarAlumno
GO

CREATE PROC spActualizarAlumno
@CODALUMNO CHAR(5),
@APELLIDOS VARCHAR(50),
@NOMBRES VARCHAR(50),
@LUGARNAC VARCHAR(50),
@FECHANAC DATETIME,
@CODESCUELA CHAR(3)
AS
BEGIN
	UPDATE TAlumno SET 
	Apellidos=@APELLIDOS,Nombres=@NOMBRES,LugarNac=@LUGARNAC,FechaNac=@FECHANAC,CodEscuela=@CODESCUELA WHERE
		CodAlumno=@CODALUMNO
	SELECT CODERROR=0, MENSAJE='Se actualizó correctamente el alumno'
END

EXEC spListarAlumno
EXEC spActualizarAlumno 'A0001','PEREZ GARCIA','JOSE','CUSCO','12-mar-2001','E02'
GO

IF OBJECT_ID('spBuscarAlumno') IS NOT NULL DROP PROC spBuscarAlumno
GO

CREATE PROC spBuscarAlumno
@CODALUMNO CHAR(5)
AS
BEGIN
	SELECT CodAlumno,Apellidos,Nombres,LugarNac,FechaNac,CodEscuela FROM TAlumno WHERE CodAlumno=@CODALUMNO
END

EXEC spListarAlumno
EXEC spBuscarAlumno 'A0001'
GO


