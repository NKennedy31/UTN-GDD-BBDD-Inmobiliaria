USE GD2C2023
GO
/*
CREACION DE DIMENSIONES Y TABLA DE HECHO
*/
DROP TABLE IF EXISTS GESTIONATE.hecho
GO
DROP TABLE IF EXISTS GESTIONATE.hecho_alquiler
GO
DROP TABLE IF EXISTS GESTIONATE.dim_tiempo
GO
DROP TABLE IF EXISTS GESTIONATE.hecho_anuncio
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
descripcion_rango_etario VARCHAR(100)
)
GO
DROP TABLE IF EXISTS GESTIONATE.dim_tipo_inmueble
GO
CREATE TABLE GESTIONATE.dim_tipo_inmueble( 
id_tipo_inmueble DECIMAL(18,0) PRIMARY KEY IDENTITY,
descripcion_tipo_inmueble VARCHAR(100)
)
GO
DROP TABLE IF EXISTS GESTIONATE.dim_ambiente
GO
CREATE TABLE GESTIONATE.dim_ambiente( 
id_ambiente DECIMAL(18,0) PRIMARY KEY IDENTITY,
descripcion_ambiente VARCHAR(100)
)
GO
DROP TABLE IF EXISTS GESTIONATE.dim_rango_m2
GO
CREATE TABLE GESTIONATE.dim_rango_m2( 
id_rango_m2 DECIMAL(18,0) PRIMARY KEY IDENTITY,
descripcion_rango_m2 VARCHAR(100)|
)
GO
DROP TABLE IF EXISTS GESTIONATE.dim_tipo_operacion
GO
CREATE TABLE GESTIONATE.dim_tipo_operacion( 
id_tipo_operacion DECIMAL(18,0) PRIMARY KEY IDENTITY,
descripcion_tipo_operacion VARCHAR(100)
)
GO
DROP TABLE IF EXISTS GESTIONATE.dim_tipo_moneda
GO
CREATE TABLE GESTIONATE.dim_tipo_moneda( 
id_tipo_moneda DECIMAL(18,0) PRIMARY KEY IDENTITY,
descripcion_tipo_moneda VARCHAR(100)
)
GO

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
cant_alquileres_dados_de_alta DECIMAL(18,0),
cant_alquileres_activos DECIMAL(18,0),
cant_pagos_alquiler DECIMAL(18,0),
cant_pagos_vencidos_alquiler DECIMAL(18,0),
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
DROP TABLE IF EXISTS GESTIONATE.hecho_alquiler
GO
CREATE TABLE GESTIONATE.hecho_alquiler(
id_tiempo DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_tiempo,
id_ubicacion DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_ubicacion,
id_sucursal DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_sucursal,
id_rango_etario_inquilino DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_rango_etario,
id_rango_etario_agente DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_rango_etario,
id_tipo_inmueble DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_tipo_inmueble,
id_ambiente DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_ambiente,
id_rango_m2 DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_rango_m2,
cant_alquileres_dados_de_alta DECIMAL(18,0),
cant_pagos_alquiler DECIMAL(18,0),
cant_pagos_vencidos_alquiler DECIMAL(18,0),
pagos_alquiler_totales NUMERIC(18,2),
comisiones_total NUMERIC(18,2),
ultimo_pago_activo NUMERIC(18,2)
PRIMARY KEY(
id_tiempo,
id_ubicacion,
id_sucursal,
id_rango_etario_inquilino,
id_rango_etario_agente,
id_tipo_inmueble,
id_ambiente,
id_rango_m2
)
)
GO
DROP TABLE IF EXISTS GESTIONATE.hecho_anuncio
CREATE TABLE GESTIONATE.hecho_anuncio(
id_tiempo DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_tiempo,
id_ubicacion DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_ubicacion,
id_sucursal DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_sucursal,
id_tipo_inmueble DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_tipo_inmueble,
id_rango_etario_comprador DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_rango_etario,
id_rango_etario_agente DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_rango_etario,
id_ambiente DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_ambiente,
id_rango_m2 DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_rango_m2,
id_tipo_operacion DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_tipo_operacion,
id_tipo_moneda DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_tipo_moneda,
dias_totales_anuncio NUMERIC(18,2),
monto_total_anuncio NUMERIC(18,2),
cant_anuncios DECIMAL(18,0)
PRIMARY KEY(
id_tiempo,
id_ubicacion,
id_sucursal,
id_tipo_inmueble,
id_rango_etario_comprador,
id_rango_etario_agente,
id_ambiente,
id_rango_m2,
id_tipo_operacion,
id_tipo_moneda
)
)
GO
DROP TABLE IF EXISTS GESTIONATE.hecho_venta
CREATE TABLE GESTIONATE.hecho_venta(
id_tiempo DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_tiempo,
id_ubicacion DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_ubicacion,
id_sucursal DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_sucursal,
id_tipo_inmueble DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_tipo_inmueble,
id_ambiente DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_ambiente,
id_rango_m2 DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_rango_m2,
id_tipo_moneda DECIMAL(18,0) FOREIGN KEY REFERENCES GESTIONATE.dim_tipo_moneda,
pagos_venta_totales NUMERIC(18,2),
cant_pagos_venta DECIMAL(18,0),
cant_ventas_dadas_de_alta DECIMAL(18,0),
comisiones_total NUMERIC(18,2),
m2_totales NUMERIC(18,2)
PRIMARY KEY(
id_tiempo,
id_ubicacion,
id_sucursal,
id_tipo_inmueble,
id_ambiente,
id_rango_m2,
id_tipo_moneda
)
)
GO
/*
FUNCIONES CONVENIENTES
*/
DROP FUNCTION IF EXISTS GESTIONATE.mes
GO
CREATE FUNCTION GESTIONATE.mes (@mes as INT) RETURNS VARCHAR(20) AS BEGIN
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
DROP FUNCTION IF EXISTS GESTIONATE.rango_etario
GO
CREATE FUNCTION GESTIONATE.rango_etario (@fecha as DATE) RETURNS VARCHAR(10) AS BEGIN
DECLARE @edad INT
SET @edad = FLOOR(DATEDIFF(DAY,@fecha,GETDATE())/365.0)
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
DROP FUNCTION IF EXISTS GESTIONATE.rango_m2
GO
CREATE FUNCTION GESTIONATE.rango_m2 (@m2 as NUMERIC(18,2)) RETURNS VARCHAR(10) AS BEGIN
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
DROP FUNCTION IF EXISTS GESTIONATE.cuatrimestre
GO
CREATE FUNCTION GESTIONATE.cuatrimestre(@fecha as DATE) RETURNS INT AS
BEGIN
	RETURN MONTH(@fecha) / 4 + 1
END
GO
DROP FUNCTION IF EXISTS GESTIONATE.cuatrimestre_mes
GO
CREATE FUNCTION GESTIONATE.cuatrimestre_mes(@mes as INT) RETURNS INT AS
BEGIN
	RETURN CEILING(@mes/4.0)
END
GO
/*
LLENADO DE TABLAS DE DIMENSIONES
*/
DROP PROCEDURE IF EXISTS GESTIONATE.cargar_dimensiones
GO
CREATE PROCEDURE GESTIONATE.cargar_dimensiones AS
BEGIN

DELETE FROM GESTIONATE.dim_tiempo

INSERT INTO GESTIONATE.dim_tiempo (anio,mes,cuatrimestre)
SELECT anios.anio, anios.mes mes, GESTIONATE.cuatrimestre_mes(anios.mes) cuatrimestre FROM 
	(SELECT DISTINCT YEAR(fecha_inicio) AS anio, MONTH(fecha_inicio) AS mes FROM GESTIONATE.alquiler UNION
SELECT DISTINCT YEAR(fecha_fin) AS anio, MONTH(fecha_fin) AS mes FROM GESTIONATE.alquiler UNION
SELECT DISTINCT YEAR(fecha_nacimiento) AS anio, MONTH(fecha_nacimiento) AS mes FROM GESTIONATE.agente UNION
SELECT DISTINCT YEAR(fecha_registro) AS anio, MONTH(fecha_registro) AS mes FROM GESTIONATE.agente UNION
SELECT DISTINCT YEAR(fecha_nacimiento) AS anio, MONTH(fecha_nacimiento) AS mes FROM GESTIONATE.comprador UNION
SELECT DISTINCT YEAR(fecha_registro) AS anio, MONTH(fecha_registro) AS mes FROM GESTIONATE.comprador UNION
SELECT DISTINCT YEAR(fecha_nacimiento) AS anio, MONTH(fecha_nacimiento) AS mes FROM GESTIONATE.inquilino UNION
SELECT DISTINCT YEAR(fecha_registro) AS anio, MONTH(fecha_registro) AS mes FROM GESTIONATE.inquilino UNION
SELECT DISTINCT YEAR(fecha_nacimiento) AS anio, MONTH(fecha_nacimiento) AS mes FROM GESTIONATE.propietario UNION
SELECT DISTINCT YEAR(fecha_registro) AS anio, MONTH(fecha_registro) AS mes FROM GESTIONATE.propietario UNION
SELECT DISTINCT YEAR(fecha_publicacion) AS anio, MONTH(fecha_publicacion) AS mes FROM GESTIONATE.anuncio UNION
SELECT DISTINCT YEAR(fecha_finalizacion) AS anio, MONTH(fecha_finalizacion) AS mes FROM GESTIONATE.anuncio UNION
SELECT DISTINCT YEAR(antiguedad) AS anio, MONTH(antiguedad) AS mes FROM GESTIONATE.inmueble UNION
SELECT DISTINCT YEAR(fecha_pago) AS anio, MONTH(fecha_pago) AS mes FROM GESTIONATE.pago_alquiler UNION
SELECT DISTINCT YEAR(fecha_inicio_periodo) AS anio, MONTH(fecha_inicio_periodo) AS mes FROM GESTIONATE.pago_alquiler UNION
SELECT DISTINCT YEAR(fecha_fin_periodo) AS anio, MONTH(fecha_fin_periodo) AS mes FROM GESTIONATE.pago_alquiler UNION
SELECT DISTINCT YEAR(fecha_venta) AS anio, MONTH(fecha_venta) AS mes FROM GESTIONATE.venta
) anios


DELETE FROM GESTIONATE.dim_ubicacion
INSERT INTO GESTIONATE.dim_ubicacion (provincia,localidad,barrio)
SELECT P.nombre provincia,
L.nombre localidad,
B.nombre barrio
FROM GESTIONATE.direccion D
INNER JOIN GESTIONATE.barrio B ON
D.codigo_barrio = B.id_barrio
INNER JOIN GESTIONATE.localidad L ON
D.codigo_localidad = L.id_localidad
INNER JOIN GESTIONATE.provincia P ON
D.codigo_provincia = P.id_provincia

DELETE FROM GESTIONATE.dim_sucursal
INSERT INTO GESTIONATE.dim_sucursal(nombre,telefono,direccion)
SELECT S.nombre, S.telefono, D.detalle 
FROM GESTIONATE.sucursal S INNER JOIN GESTIONATE.direccion D ON
S.codigo_direccion = D.id_direccion

DELETE FROM GESTIONATE.dim_rango_etario
INSERT INTO GESTIONATE.dim_rango_etario (descripcion_rango_etario)
(SELECT '< 25' rango UNION 
SELECT '25 - 35' rango UNION
SELECT '35 - 50' rango UNION
SELECT '> 50' rango)

DELETE FROM GESTIONATE.dim_tipo_inmueble
INSERT INTO GESTIONATE.dim_tipo_inmueble (descripcion_tipo_inmueble)
SELECT TI.detalle FROM GESTIONATE.tipo_inmueble TI

DELETE FROM GESTIONATE.dim_ambiente
INSERT INTO GESTIONATE.dim_ambiente (descripcion_ambiente)
SELECT A.detalle FROM GESTIONATE.ambiente A

DELETE FROM GESTIONATE.dim_rango_m2
INSERT INTO GESTIONATE.dim_rango_m2 (descripcion_rango_m2)
(SELECT '< 35' rango UNION 
SELECT '35 - 55' rango UNION
SELECT '55 - 75' rango UNION
SELECT '75 - 100' rango UNION
SELECT '> 100' rango)

DELETE FROM GESTIONATE.dim_tipo_operacion
INSERT INTO GESTIONATE.dim_tipo_operacion (descripcion_tipo_operacion)
SELECT TIOP.detalle FROM GESTIONATE.tipo_operacion TIOP

DELETE FROM GESTIONATE.dim_tipo_moneda
INSERT INTO GESTIONATE.dim_tipo_moneda (descripcion_tipo_moneda)
SELECT M.detalle FROM GESTIONATE.moneda M
END
GO
EXEC GESTIONATE.cargar_dimensiones

/*
	Funciones auxiliares
*/

DROP FUNCTION IF EXISTS GESTIONATE.obtener_tiempo_id
GO
CREATE FUNCTION GESTIONATE.obtener_tiempo_id(@fecha DATE) RETURNS INTEGER
AS BEGIN
RETURN (SELECT TOP 1 id_tiempo FROM GESTIONATE.dim_tiempo WHERE anio = YEAR(@fecha) AND mes = MONTH(@fecha))
END
GO

DROP FUNCTION IF EXISTS GESTIONATE.obtener_ubicacion_id
GO
CREATE FUNCTION GESTIONATE.obtener_ubicacion_id(@provincia VARCHAR(100), @localidad VARCHAR(100), @barrio VARCHAR(100)) RETURNS decimal(18,0)
AS BEGIN
DECLARE @id_ubicacion decimal(18,0)
SELECT @id_ubicacion = id_ubicacion FROM GESTIONATE.dim_ubicacion WHERE provincia=@provincia AND localidad=@localidad AND barrio=@barrio
RETURN @id_ubicacion
END
GO

DROP FUNCTION IF EXISTS GESTIONATE.obtener_sucursal_id
GO
CREATE FUNCTION GESTIONATE.obtener_sucursal_id(@nombre VARCHAR(100)) RETURNS INTEGER
AS BEGIN
RETURN (SELECT TOP 1 id_sucursal FROM GESTIONATE.dim_sucursal WHERE nombre=@nombre)
END
GO

DROP FUNCTION IF EXISTS GESTIONATE.obtener_tipo_inmueble_id
GO
CREATE FUNCTION GESTIONATE.obtener_tipo_inmueble_id(@tipo VARCHAR(100)) RETURNS INTEGER
AS BEGIN
RETURN (SELECT TOP 1 id_tipo_inmueble FROM GESTIONATE.dim_tipo_inmueble WHERE descripcion_tipo_inmueble=@tipo)
END
GO

DROP FUNCTION IF EXISTS GESTIONATE.obtener_ambiente_id
GO
CREATE FUNCTION GESTIONATE.obtener_ambiente_id(@detalle VARCHAR(100)) RETURNS INTEGER
AS BEGIN
DECLARE @id_ambiente decimal(18,0)
SELECT @id_ambiente =  id_ambiente FROM GESTIONATE.dim_ambiente WHERE descripcion_ambiente=@detalle
RETURN @id_ambiente
END
GO

DROP FUNCTION IF EXISTS GESTIONATE.obtener_rango_m2_id
GO
CREATE FUNCTION GESTIONATE.obtener_rango_m2_id(@metros NUMERIC(18,2)) RETURNS INTEGER
AS BEGIN
RETURN (SELECT TOP 1 id_rango_m2 FROM GESTIONATE.dim_rango_m2 WHERE descripcion_rango_m2= GESTIONATE.rango_m2(@metros))
END
GO

DROP FUNCTION IF EXISTS GESTIONATE.obtener_rango_etario_id
GO
CREATE FUNCTION GESTIONATE.obtener_rango_etario_id(@fecha DATE) RETURNS INTEGER
AS BEGIN
RETURN (SELECT TOP 1 id_rango_etario  FROM GESTIONATE.dim_rango_etario WHERE descripcion_rango_etario= GESTIONATE.rango_etario(@fecha))
END
GO

DROP FUNCTION IF EXISTS GESTIONATE.obtener_tipo_operacion_id
GO
CREATE FUNCTION GESTIONATE.obtener_tipo_operacion_id(@detalle VARCHAR(100)) RETURNS INTEGER
AS BEGIN
RETURN (SELECT TOP 1 id_tipo_operacion FROM GESTIONATE.dim_tipo_operacion WHERE descripcion_tipo_operacion=@detalle)
END
GO

DROP FUNCTION IF EXISTS GESTIONATE.obtener_tipo_moneda_id
GO
CREATE FUNCTION GESTIONATE.obtener_tipo_moneda_id(@detalle VARCHAR(100)) RETURNS INTEGER
AS BEGIN
RETURN (SELECT TOP 1 id_tipo_moneda FROM GESTIONATE.dim_tipo_moneda WHERE descripcion_tipo_moneda=@detalle)
END
GO

DROP FUNCTION IF EXISTS GESTIONATE.obtener_tiempo_anterior
GO
CREATE FUNCTION GESTIONATE.obtener_tiempo_anterior(@tiempo_id DECIMAL(18,0)) RETURNS DECIMAL(18,0)
AS BEGIN
RETURN (SELECT TOP 1 DT.id_tiempo FROM GESTIONATE.dim_tiempo DT
		WHERE (DT.anio = (SELECT anio FROM GESTIONATE.dim_tiempo WHERE id_tiempo = @tiempo_id)
		AND DT.mes = (SELECT mes FROM GESTIONATE.dim_tiempo WHERE id_tiempo = @tiempo_id) - 1)
		OR (DT.anio = (SELECT anio FROM GESTIONATE.dim_tiempo WHERE id_tiempo = @tiempo_id) -1
		              AND DT.mes = 12)
ORDER BY DT.anio DESC, DT.mes DESC)
END
GO

/*
	Llenado Hechos
*/

INSERT INTO GESTIONATE.hecho_anuncio (id_tiempo, id_ubicacion, id_sucursal, id_tipo_inmueble, id_ambiente, id_rango_m2,
id_tipo_operacion, id_tipo_moneda, dias_totales_anuncio, monto_total_anuncio, cant_anuncios)
SELECT
GESTIONATE.obtener_tiempo_id(A.fecha_publicacion),
GESTIONATE.obtener_ubicacion_id(P.nombre, L.nombre, B.nombre),
GESTIONATE.obtener_sucursal_id(S.nombre),
GESTIONATE.obtener_tipo_inmueble_id(TI.detalle),
GESTIONATE.obtener_ambiente_id(AMB.detalle),
GESTIONATE.obtener_rango_m2_id(I.superficie_total),
GESTIONATE.obtener_tipo_operacion_id(TI_OP.detalle),
GESTIONATE.obtener_tipo_moneda_id(M.detalle),
SUM(DATEDIFF(DAY, A.fecha_publicacion, A.fecha_finalizacion)) dias_totales_anuncio,
SUM(A.precio) monto_total_anuncio,
COUNT(DISTINCT A.id_anuncio) cant_anuncios


FROM GESTIONATE.anuncio A
INNER JOIN GESTIONATE.inmueble I ON
A.id_inmueble = I.id_inmueble
INNER JOIN GESTIONATE.tipo_inmueble TI ON
I.id_tipo_inmueble = TI.id_tipo_inmueble
INNER JOIN GESTIONATE.ambiente AMB ON
I.id_ambiente = AMB.id_ambiente
INNER JOIN GESTIONATE.direccion D ON
I.codigo_direccion = D.id_direccion
INNER JOIN GESTIONATE.barrio B ON
D.codigo_barrio = B.id_barrio
INNER JOIN GESTIONATE.localidad L ON
D.codigo_localidad = L.id_localidad
INNER JOIN GESTIONATE.provincia P ON
D.codigo_provincia = P.id_provincia
INNER JOIN GESTIONATE.agente AG ON
A.id_agente = AG.id_agente
INNER JOIN GESTIONATE.sucursal S ON
AG.codigo_sucursal = S.id_sucursal
INNER JOIN GESTIONATE.tipo_operacion TI_OP ON
A.id_tipo_operacion = TI_OP.id_tipo_operacion
INNER JOIN GESTIONATE.moneda M ON
A.id_moneda = M.id_moneda
GROUP BY GESTIONATE.obtener_tiempo_id(A.fecha_publicacion), P.nombre, L.nombre, B.nombre, S.nombre, TI.detalle, AMB.detalle,GESTIONATE.obtener_rango_m2_id(I.superficie_total), TI_OP.detalle, M.detalle


/*
cant_alquileres_dados_de_alta DECIMAL(18,0),
cant_alquileres_activos DECIMAL(18,0),
cant_pagos_alquiler DECIMAL(18,0),
cant_pagos_vencidos_alquiler DECIMAL(18,0),
pagos_alquiler_totales NUMERIC(18,2),
comisiones_total NUMERIC(18,2),
ultimo_pago NUMERIC(18,2)
*/

DELETE FROM GESTIONATE.hecho_alquiler WHERE 1=1
INSERT INTO GESTIONATE.hecho_alquiler (id_tiempo, id_ubicacion, id_sucursal, id_tipo_inmueble, id_ambiente, id_rango_m2,id_rango_etario_agente,id_rango_etario_inquilino,
cant_alquileres_dados_de_alta, cant_pagos_alquiler, cant_pagos_vencidos_alquiler, pagos_alquiler_totales, comisiones_total, ultimo_pago_activo)
SELECT
    GESTIONATE.obtener_tiempo_id(ALQ.fecha_inicio),
    GESTIONATE.obtener_ubicacion_id(P.nombre, L.nombre, B.nombre),
    GESTIONATE.obtener_sucursal_id(S.nombre),
    GESTIONATE.obtener_tipo_inmueble_id(TI.detalle),
    GESTIONATE.obtener_ambiente_id(AMB.detalle),
    GESTIONATE.obtener_rango_m2_id(I.superficie_total),
    GESTIONATE.obtener_rango_etario_id(AG.fecha_nacimiento),
    GESTIONATE.obtener_rango_etario_id(INQ.fecha_nacimiento),
    COUNT(DISTINCT ALQ.id_alquiler) AS cant_alquileres_dados_de_alta,
    COUNT(DISTINCT PAG_ALQ.id_pago) AS cant_pagos_alquiler,
    SUM(CASE WHEN PAG_ALQ.fecha_pago > PAG_ALQ.fecha_fin_periodo THEN 1 ELSE 0 END) AS cant_pagos_vencidos_alquiler,
    SUM(PAG_ALQ.importe) AS pagos_alquiler_totales,
    SUM(ALQ.comision) AS comisiones_total,
    MAX(PAG_ALQ2.importe) AS ultimo_pago_activo
FROM
    GESTIONATE.alquiler ALQ
INNER JOIN GESTIONATE.inmueble I ON ALQ.id_inmueble = I.id_inmueble
INNER JOIN GESTIONATE.tipo_inmueble TI ON I.id_tipo_inmueble = TI.id_tipo_inmueble
INNER JOIN GESTIONATE.ambiente AMB ON I.id_ambiente = AMB.id_ambiente
INNER JOIN GESTIONATE.direccion D ON I.codigo_direccion = D.id_direccion
INNER JOIN GESTIONATE.barrio B ON D.codigo_barrio = B.id_barrio
INNER JOIN GESTIONATE.localidad L ON D.codigo_localidad = L.id_localidad
INNER JOIN GESTIONATE.provincia P ON D.codigo_provincia = P.id_provincia
INNER JOIN GESTIONATE.sucursal S ON ALQ.id_sucursal = S.id_sucursal
INNER JOIN GESTIONATE.inquilino INQ ON ALQ.id_inquilino = INQ.id_inquilino
INNER JOIN GESTIONATE.agente AG ON ALQ.id_agente = AG.id_agente
INNER JOIN GESTIONATE.pago_alquiler PAG_ALQ ON ALQ.id_alquiler = PAG_ALQ.id_alquiler
INNER JOIN GESTIONATE.estado_alquiler EST_ALQ ON ALQ.id_estado_alquiler = EST_ALQ.id_estado_alquiler
LEFT JOIN GESTIONATE.pago_alquiler PAG_ALQ2 ON ALQ.id_alquiler = PAG_ALQ2.id_alquiler
AND PAG_ALQ2.fecha_pago = (SELECT MAX(PAG_ALQ3.fecha_pago) FROM GESTIONATE.pago_alquiler PAG_ALQ3
WHERE  PAG_ALQ3.id_alquiler = PAG_ALQ2.id_alquiler
AND GESTIONATE.obtener_tiempo_id(PAG_ALQ3.fecha_pago) = GESTIONATE.obtener_tiempo_id(ALQ.fecha_inicio)
)
AND EST_ALQ.detalle = 'Activo'
GROUP BY
    GESTIONATE.obtener_tiempo_id(ALQ.fecha_inicio), P.nombre, L.nombre, B.nombre, S.nombre, TI.detalle,
    AMB.detalle, GESTIONATE.obtener_rango_m2_id(I.superficie_total),
    GESTIONATE.obtener_rango_etario_id(INQ.fecha_nacimiento),
    GESTIONATE.obtener_rango_etario_id(AG.fecha_nacimiento);



/*
	Creacion Vistas
*/

/*
    DURACION PROMEDIO ANUNCIO
*/

DROP VIEW IF EXISTS GESTIONATE.duracion_promedio_anuncio
GO
CREATE VIEW GESTIONATE.duracion_promedio_anuncio AS
SELECT DT.anio,DT.cuatrimestre, TI_OP.descripcion_tipo_operacion tipo_operacion,
U.barrio, AMB.descripcion_ambiente ambiente,
1.0*SUM(HA.dias_totales_anuncio)/SUM(HA.cant_anuncios) duracion_promedio_dias FROM GESTIONATE.hecho_anuncio HA 
INNER JOIN GESTIONATE.dim_tiempo DT ON HA.id_tiempo = DT.id_tiempo
INNER JOIN GESTIONATE.dim_tipo_operacion TI_OP ON HA.id_tipo_operacion = TI_OP.id_tipo_operacion
INNER JOIN GESTIONATE.dim_ubicacion U ON HA.id_ubicacion = U.id_ubicacion
INNER JOIN GESTIONATE.dim_ambiente AMB ON HA.id_ambiente = AMB.id_ambiente
GROUP BY TI_OP.descripcion_tipo_operacion, DT.cuatrimestre, DT.anio, U.barrio, AMB.descripcion_ambiente
GO
SELECT * FROM GESTIONATE.duracion_promedio_anuncio ORDER BY 1,2,3,4,5

/*
    PRECIO PROMEDIO ANUNCIO
*/

DROP VIEW IF EXISTS GESTIONATE.precio_promedio_anuncio
GO
CREATE VIEW GESTIONATE.precio_promedio_anuncio AS
SELECT DT.anio,DT.cuatrimestre, TI_OP.descripcion_tipo_operacion tipo_operacion, TI_IN.descripcion_tipo_inmueble tipo_inmueble,
RM2.descripcion_rango_m2 rango_m2, AMB.descripcion_ambiente ambiente,
1.0*SUM(HA.monto_total_anuncio)/SUM(HA.cant_anuncios) precio_promedio,
M.descripcion_tipo_moneda moneda
FROM GESTIONATE.hecho_anuncio HA 
INNER JOIN GESTIONATE.dim_tiempo DT ON HA.id_tiempo = DT.id_tiempo
INNER JOIN GESTIONATE.dim_tipo_operacion TI_OP ON HA.id_tipo_operacion = TI_OP.id_tipo_operacion
INNER JOIN GESTIONATE.dim_tipo_inmueble TI_IN ON HA.id_tipo_inmueble = TI_IN.id_tipo_inmueble
INNER JOIN GESTIONATE.dim_ambiente AMB ON HA.id_ambiente = AMB.id_ambiente
INNER JOIN GESTIONATE.dim_rango_m2 RM2 ON HA.id_rango_m2 = RM2.id_rango_m2
INNER JOIN GESTIONATE.dim_tipo_moneda M ON HA.id_tipo_moneda = M.id_tipo_moneda
GROUP BY TI_OP.descripcion_tipo_operacion, DT.cuatrimestre, DT.anio, TI_IN.descripcion_tipo_inmueble,
         RM2.descripcion_rango_m2, AMB.descripcion_ambiente, M.descripcion_tipo_moneda

GO
SELECT * FROM GESTIONATE.precio_promedio_anuncio ORDER BY 1,2,3,4,5,6,7,8

/*
    BARRIOS MAS ELEGIDOS
*/

DROP VIEW IF EXISTS GESTIONATE.barrios_mas_elegidos
GO
CREATE VIEW GESTIONATE.barrios_mas_elegidos AS
WITH    numeros AS
        (
        SELECT  1 AS num
        UNION ALL
        SELECT  num + 1
        FROM    numeros
        WHERE   num < 5
        )
SELECT numeros.num n,DT.anio anio, DT.cuatrimestre cuatrimestre,
RE.descripcion_rango_etario rango_etario,
(SELECT TOP 1 top_barrios.barrio FROM (SELECT TOP (numeros.num) U2.barrio barrio, COUNT(*) cant_alquileres_dados_de_alta
FROM GESTIONATE.hecho_alquiler HALQ2
INNER JOIN GESTIONATE.dim_ubicacion U2 ON
HALQ2.id_ubicacion = U2.id_ubicacion
INNER JOIN GESTIONATE.dim_tiempo DT2 ON HALQ2.id_tiempo = DT2.id_tiempo
WHERE DT2.anio = DT.anio
  AND DT2.cuatrimestre = DT.cuatrimestre
AND HALQ2.id_rango_etario_inquilino = RE.id_rango_etario
GROUP BY U2.barrio
ORDER BY cant_alquileres_dados_de_alta DESC
) AS top_barrios ORDER BY cant_alquileres_dados_de_alta ASC )
    barrio,
(SELECT TOP 1 top_barrios.cant_alquileres_dados_de_alta FROM (SELECT TOP (numeros.num) U2.barrio barrio, COUNT(*) cant_alquileres_dados_de_alta
FROM GESTIONATE.hecho_alquiler HALQ2
INNER JOIN GESTIONATE.dim_ubicacion U2 ON
HALQ2.id_ubicacion = U2.id_ubicacion
INNER JOIN GESTIONATE.dim_tiempo DT2 ON HALQ2.id_tiempo = DT2.id_tiempo
WHERE DT2.anio = DT.anio
AND DT2.cuatrimestre = DT.cuatrimestre
AND HALQ2.id_rango_etario_inquilino = RE.id_rango_etario
GROUP BY U2.barrio
ORDER BY cant_alquileres_dados_de_alta DESC
) AS top_barrios ORDER BY cant_alquileres_dados_de_alta ASC )
    cant_alquileres_dados_de_alta
FROM GESTIONATE.hecho_alquiler HALQ
INNER JOIN GESTIONATE.dim_ubicacion U ON HALQ.id_ubicacion = U.id_ubicacion
INNER JOIN GESTIONATE.dim_tiempo DT ON HALQ.id_tiempo = DT.id_tiempo
INNER JOIN GESTIONATE.dim_rango_etario RE ON HALQ.id_rango_etario_inquilino = RE.id_rango_etario
CROSS JOIN numeros
GROUP BY  numeros.num, DT.anio, DT.cuatrimestre, RE.descripcion_rango_etario, RE.id_rango_etario
GO

/*
    PORCENTAJE INCUMPLIMIENTO PAGOS ALQUILER
*/

DROP VIEW IF EXISTS GESTIONATE.porcentaje_incumplimiento_pagos_alquiler
GO
CREATE VIEW GESTIONATE.porcentaje_incumplimiento_pagos_alquiler AS
SELECT DT.anio, DT.mes,
100.0 * SUM(HALQ.cant_pagos_vencidos_alquiler)/SUM(HALQ.cant_pagos_alquiler) porcentaje_incumplimientos FROM GESTIONATE.hecho_alquiler HALQ
INNER JOIN GESTIONATE.dim_tiempo DT ON HALQ.id_tiempo = DT.id_tiempo
GROUP BY DT.anio, DT.mes
GO

/*
    PORCENTAJE INCREMENTO PAGOS ALQUILER
*/

DROP VIEW IF EXISTS GESTIONATE.porcentaje_incremento_alquiler
GO
CREATE VIEW GESTIONATE.porcentaje_incremento_alquiler AS
SELECT DT.anio, DT.mes, 
100.0 * (SUM(HALQ.ultimo_pago_activo)/SUM(HALQ2.ultimo_pago_activo) - 1) incremento_alquiler
FROM GESTIONATE.hecho_alquiler HALQ
INNER JOIN GESTIONATE.dim_tiempo DT ON HALQ.id_tiempo = DT.id_tiempo
INNER JOIN GESTIONATE.dim_tiempo DT2 ON DT2.id_tiempo = GESTIONATE.obtener_tiempo_anterior(DT.id_tiempo)
INNER JOIN GESTIONATE.hecho_alquiler HALQ2 ON HALQ2.id_tiempo = DT2.id_tiempo
GROUP BY DT.anio, DT.mes
GO

DROP VIEW IF EXISTS GESTIONATE.precio_promedio_m2
GO
CREATE VIEW GESTIONATE.precio_promedio_m2 AS
SELECT DT.anio, DT.cuatrimestre, TI_IN.descripcion_tipo_inmueble tipo_inmueble,
SUM(HV.pagos_venta_totales) / SUM(HV.m2_totales) precio_promedio_m2
FROM GESTIONATE.hecho_venta HV
INNER JOIN GESTIONATE.dim_tiempo DT ON HV.id_tiempo = DT.id_tiempo
INNER JOIN GESTIONATE.dim_tipo_inmueble TI_IN ON HV.id_tipo_inmueble = TI_IN.id_tipo_inmueble
GROUP BY DT.anio, DT.cuatrimestre, TI_IN.descripcion_tipo_inmueble
GO

DROP VIEW IF EXISTS GESTIONATE.valor_promedio_comision
GO
CREATE VIEW GESTIONATE.valor_promedio_comision AS

(SELECT DT.anio, DT.mes, 'Venta' tipo_operacion, S.nombre, SUM(HV.comisiones_total)/SUM(HV.cant_ventas_dadas_de_alta) promedio_comision
 FROM GESTIONATE.hecho_venta HV
INNER JOIN GESTIONATE.dim_tiempo DT ON HV.id_tiempo = DT.id_tiempo
INNER JOIN GESTIONATE.dim_sucursal S ON HV.id_sucursal = S.id_sucursal
 GROUP BY DT.anio, DT.mes, S.nombre
)
UNION
(SELECT DT.anio, DT.mes, 'Alquiler' tipo_operacion, S.nombre, SUM(HA.comisiones_total)/SUM(HA.cant_alquileres_dados_de_alta) promedio_comision
 FROM GESTIONATE.hecho_alquiler HA
INNER JOIN GESTIONATE.dim_tiempo DT ON HA.id_tiempo = DT.id_tiempo
INNER JOIN GESTIONATE.dim_sucursal S ON HA.id_sucursal = S.id_sucursal
    GROUP BY DT.anio, DT.mes, S.nombre
)
GO


DROP VIEW IF EXISTS GESTIONATE.porcentaje_operaciones_concretadas
GO
CREATE VIEW GESTIONATE.porcentaje_operaciones_concretadas AS
SELECT DT.anio FROM GESTIONATE.hecho_anuncio HA
INNER JOIN GESTIONATE.dim_tiempo DT ON HA.id_tiempo = DT.id_tiempo

GROUP BY DT.anio

GO