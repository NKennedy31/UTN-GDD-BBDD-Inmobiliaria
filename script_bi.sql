USE GD2C2023
GO
/*
CREACION DE DIMENSIONES Y TABLA DE HECHO
*/
DROP TABLE IF EXISTS GESTIONATE.dim_tiempo
GO
CREATE TABLE GESTIONATE.dim_tiempo( 
id_tiempo DECIMAL(18,0) PRIMARY KEY IDENTITY,
anio INT,
cuatrimestre INT,
mes INT
)
GO
DROP TABLE IF EXISTS GESTIONATE.dim_ubicacion
GO
CREATE TABLE GESTIONATE.dim_ubicacion( 
id_ubicacion DECIMAL(18,0) PRIMARY KEY IDENTITY,
provincia VARCHAR(100),
localidad VARCHAR(100),
barrio VARCHAR(100)
)
GO
DROP TABLE IF EXISTS GESTIONATE.dim_sucursal
GO
CREATE TABLE GESTIONATE.dim_sucursal( 
id_sucursal DECIMAL(18,0) PRIMARY KEY IDENTITY,
nombre VARCHAR(100),
telefono VARCHAR(100),
direccion VARCHAR(100)
)
GO
DROP TABLE IF EXISTS GESTIONATE.dim_rango_etario
GO
CREATE TABLE GESTIONATE.dim_rango_etario( 
id_rango_etario DECIMAL(18,0) PRIMARY KEY IDENTITY,
descripcion VARCHAR(100)
)
GO
DROP TABLE IF EXISTS GESTIONATE.dim_tipo_inmueble
GO
CREATE TABLE GESTIONATE.dim_tipo_inmueble( 
id_tipo_inmueble DECIMAL(18,0) PRIMARY KEY IDENTITY,
descripcion VARCHAR(100)
)
GO
DROP TABLE IF EXISTS GESTIONATE.dim_ambiente
GO
CREATE TABLE GESTIONATE.dim_ambiente( 
id_ambiente DECIMAL(18,0) PRIMARY KEY IDENTITY,
descripcion VARCHAR(100)
)
GO
DROP TABLE IF EXISTS GESTIONATE.dim_rango_m2
GO
CREATE TABLE GESTIONATE.dim_rango_m2( 
id_rango_m2 DECIMAL(18,0) PRIMARY KEY IDENTITY,
descripcion VARCHAR(100)
)
GO
DROP TABLE IF EXISTS GESTIONATE.dim_tipo_operacion
GO
CREATE TABLE GESTIONATE.dim_tipo_operacion( 
id_tipo_operacion DECIMAL(18,0) PRIMARY KEY IDENTITY,
descripcion VARCHAR(100)
)
GO
DROP TABLE IF EXISTS GESTIONATE.dim_tipo_moneda
GO
CREATE TABLE GESTIONATE.dim_tipo_moneda( 
id_tipo_moneda DECIMAL(18,0) PRIMARY KEY IDENTITY,
descripcion VARCHAR(100)
)
GO
DROP TABLE IF EXISTS GESTIONATE.hecho
CREATE TABLE GESTIONATE.hecho(
id_tiempo DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_tiempo,
id_ubicacion DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_ubicacion,
id_sucursal DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_sucursal,
id_rango_etario DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_rango_etario,
id_tipo_inmueble DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_tipo_inmueble,
id_ambiente DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_ambiente,
id_rango_m2 DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_rango_m2,
id_tipo_operacion DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_tipo_operacion,
id_tipo_moneda DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_tipo_moneda,
dias_totales_anuncio NUMERIC(18,2),
monto_total_anuncio NUMERIC(18,2),
cant_anuncios DECIMAL(18,0),
cant_alquileres_dados_de_alta DECIMAL(18,0),
cant_alquileres_activos DECIMAL(18,0),
cant_pagos DECIMAL(18,0),
cant_pagos_vencidos DECIMAL(18,0),
pagos_alquiler_totales NUMERIC(18,2),
pagos_venta_totales NUMERIC(18,2),
cant_pagos_venta DECIMAL(18,0),
cant_ventas_dadas_de_alta DECIMAL(18,0),
pagos_cierre_totales NUMERIC(18,2),
cant_pagos_cierre NUMERIC(18,2)
PRIMARY KEY(
id_tiempo,
id_ubicacion,
id_sucursal,
id_rango_etario,
id_tipo_inmueble,
id_ambiente,
id_rango_m2,
id_tipo_operacion,
id_tipo_moneda
)
)
GO
/*
LLENADO DE TABLAS DE DIMENSIONES
*/
CREATE PROCEDURE cargar_dimensiones AS
BEGIN

DELETE FROM GESTIONATE.dim_tiempo

DECLARE @primer_anio INT
DECLARE @ultimo_anio INT

SET @primer_anio = 1900
SET @ultimo_anio = 4000

SELECT meses.mes INTO #meses FROM
(SELECT 1 AS mes UNION
SELECT 2 AS mes UNION
SELECT 3 AS mes UNION
SELECT 4 AS mes UNION
SELECT 5 AS mes UNION
SELECT 6 AS mes UNION
SELECT 7 AS mes UNION
SELECT 8 AS mes UNION
SELECT 9 AS mes UNION
SELECT 10 AS mes UNION
SELECT 11 AS mes UNION
SELECT 12 AS mes) AS meses

SELECT cuatris.nro INTO #cuatrisS FROM
(SELECT 1 AS nro UNION
SELECT 2 AS nro UNION
SELECT 3 AS nro) AS cuatris

WHILE @primer_anio <= @ultimo_anio
BEGIN
	INSERT INTO GESTIONATE.dim_tiempo (anio,cuatrimestre,mes)
	SELECT @primer_anio anio, #cuatris.nro cuatrimestre, #meses.mes mes FROM #meses
	CROSS JOIN #cuatris
	SET @primer_anio = @primer_anio + 1
END


DELETE FROM GESTIONATE.dim_ubicacion
INSERT INTO GESTIONATE.dim_ubicacion (provincia,localidad,barrio)
SELECT P.nombre provincia,
L.nombre localidad,
B.nombre barrio
FROM GESTIONATE.provincia P 
INNER JOIN GESTIONATE.localidad L ON
P.id_provincia = L.codigo_provincia
INNER JOIN GESTIONATE.barrio B ON
L.id_localidad = B.codigo_localidad

DELETE FROM GESTIONATE.dim_sucursal
INSERT INTO GESTIONATE.dim_sucursal(nombre,telefono,direccion)
SELECT S.nombre, S.telefono, D.detalle 
FROM GESTIONATE.sucursal S INNER JOIN GESTIONATE.direccion D ON
S.codigo_direccion = D.id_direccion

DELETE FROM GESTIONATE.dim_rango_etario
INSERT INTO GESTIONATE.dim_rango_etario (descripcion)
(SELECT '< 25' rango UNION 
SELECT '25-35' rango UNION
SELECT '35-50' rango UNION
SELECT '> 50' rango)

DELETE FROM GESTIONATE.dim_tipo_inmueble
INSERT INTO GESTIONATE.dim_tipo_inmueble (descripcion)
SELECT TI.detalle FROM GESTIONATE.tipo_inmueble TI

DELETE FROM GESTIONATE.dim_ambiente
INSERT INTO GESTIONATE.dim_ambiente (descripcion)
SELECT A.detalle FROM GESTIONATE.ambiente A

DELETE FROM GESTIONATE.dim_rango_m2
INSERT INTO GESTIONATE.dim_rango_m2 (descripcion)
(SELECT '< 35' rango UNION 
SELECT '35-55' rango UNION
SELECT '55-75' rango UNION
SELECT '75-100' rango UNION
SELECT '> 100' rango)

DELETE FROM GESTIONATE.dim_tipo_operacion
INSERT INTO GESTIONATE.dim_tipo_operacion (descripcion)
SELECT TIOP.detalle FROM GESTIONATE.tipo_operacion TIOP

DELETE FROM GESTIONATE.dim_tipo_moneda
INSERT INTO GESTIONATE.dim_tipo_moneda (descripcion)
SELECT M.detalle FROM GESTIONATE.moneda M
END
GO
EXEC dbo.cargar_dimensiones
/*
FUNCIONES CONVENIENTES
*/
DROP FUNCTION IF EXISTS dbo.mes
GO
CREATE FUNCTION mes (@mes as INT) RETURNS VARCHAR(20) AS BEGIN
	RETURN CASE @mes
			WHEN 1 THEN 'Enero'
			WHEN 2 THEN 'Febrero'
			WHEN 3 THEN 'Marzo'
			WHEN 4 THEN 'Abril'
			WHEN 5 THEN 'Mayo'
			WHEN 6 THEN 'Junio'
			WHEN 7 THEN 'Julio'
			WHEN 8 THEN 'Agosto'
			WHEN 9 THEN 'Septiembre'
			WHEN 10 THEN 'Octubre'
			WHEN 11 THEN 'Noviembre'
			WHEN 12 THEN 'Diciembre'
			ELSE ''
			END
END
GO
DROP FUNCTION IF EXISTS dbo.rango_etario
GO
CREATE FUNCTION rango_etario (@edad as INT) RETURNS VARCHAR(10) AS BEGIN
IF @edad < 25
	RETURN '< 25'
ELSE IF @edad BETWEEN 25 AND 35
	RETURN '25 - 35'
ELSE IF @edad BETWEEN 35 AND 50
	RETURN '35 - 50'
ELSE IF @edad > 50
	RETURN '> 50'
RETURN ''
END
GO
DROP FUNCTION IF EXISTS dbo.rango_m2
GO
CREATE FUNCTION rango_m2 (@m2 as NUMERIC(18,2)) RETURNS VARCHAR(10) AS BEGIN
IF @m2 < 35
	RETURN '< 35'
ELSE IF @m2 BETWEEN 35 AND 55
	RETURN '35 - 55'
ELSE IF @m2 BETWEEN 55 AND 75
	RETURN '55 - 75'
ELSE IF @m2 BETWEEN 75 AND 100
	RETURN '75 - 100'
ELSE IF @m2 > 100
	RETURN '> 100'
RETURN ''
END
GO
DROP FUNCTION IF EXISTS dbo.cuatrimestre
GO
CREATE FUNCTION cuatrimestre(@fecha as DATE) RETURNS INT AS
BEGIN
	RETURN MONTH(@fecha) / 4 + 1
END
GO