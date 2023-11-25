USE GD2C2023
GO
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
CREATE FUNCTION cuatrimestre(@fecha as DATE) RETURNS INT AS
BEGIN
	RETURN MONTH(@fecha) / 4 + 1
END
GO

--1
DROP VIEW IF EXISTS duracion_promedio_anuncios_cuatrimestre
GO
CREATE VIEW duracion_promedio_anuncios AS
SELECT OP.detalle tipo_operacion, 
		BAR.nombre barrio, 
		AMB.detalle ambiente, 
		AVG(DATEDIFF(day,AN.fecha_publicacion,AN.fecha_finalizacion)) duracion_promedio_dias FROM GESTIONATE.anuncio AN 
INNER JOIN GESTIONATE.tipo_operacion OP
ON AN.id_tipo_operacion = OP.id_tipo_operacion
INNER JOIN GESTIONATE.inmueble INM
ON AN.id_inmueble = INM.id_inmueble
INNER JOIN GESTIONATE.direccion DIR
ON INM.codigo_direccion = DIR.id_direccion
INNER JOIN GESTIONATE.barrio BAR
ON DIR.codigo_barrio = BAR.id_barrio
INNER JOIN GESTIONATE.ambiente AMB ON
INM.id_ambiente = AMB.id_ambiente
WHERE YEAR(AN.fecha_publicacion) = YEAR(GETDATE())
AND dbo.cuatrimestre(AN.fecha_publicacion) = dbo.cuatrimestre(GETDATE())
GROUP BY OP.detalle, BAR.nombre, BAR.id_barrio, AMB.id_ambiente, AMB.detalle
ORDER BY duracion_promedio_dias DESC, tipo_operacion, barrio, ambiente
GO

--2
DROP VIEW IF EXISTS precio_promedio_anuncios_cuatrimestre
GO
CREATE VIEW precio_promedio_anuncios_cuatrimestre AS
SELECT	YEAR(AN.fecha_publicacion) anio,
		dbo.cuatrimestre(AN.fecha_publicacion) cuatrimestre,
		OP.detalle tipo_operacion,  
		AMB.detalle ambiente, 
		TI.detalle tipo_inmueble,
		dbo.rango_m2(INM.superficie_total) rango_m2,
		CONCAT(AVG(AN.precio),' ', MONEDA.detalle) precio_promedio FROM GESTIONATE.anuncio AN 
INNER JOIN GESTIONATE.tipo_operacion OP
ON AN.id_tipo_operacion = OP.id_tipo_operacion
INNER JOIN GESTIONATE.inmueble INM
ON AN.id_inmueble = INM.id_inmueble
INNER JOIN GESTIONATE.ambiente AMB ON
INM.id_ambiente = AMB.id_ambiente
INNER JOIN GESTIONATE.tipo_inmueble TI ON
INM.id_tipo_inmueble = TI.id_tipo_inmueble
INNER JOIN GESTIONATE.moneda MONEDA ON
AN.id_moneda = MONEDA.id_moneda
GROUP BY OP.detalle, AMB.id_ambiente, AMB.detalle, TI.id_tipo_inmueble, TI.detalle, INM.superficie_total, MONEDA.id_moneda, MONEDA.detalle, YEAR(AN.fecha_publicacion),
dbo.cuatrimestre(AN.fecha_publicacion)
GO

--3 NO LO SE HACER
--4
DROP VIEW IF EXISTS porcentaje_incumplimientos_pagos_alquiler
GO
CREATE VIEW porcentaje_incumplimientos_pagos_alquiler AS
SELECT YEAR(PA.fecha_inicio_periodo) anio, dbo.mes(MONTH(PA.fecha_inicio_periodo)) mes,
100.0 * COUNT(*) / (SELECT COUNT(*) FROM GESTIONATE.pago_alquiler PA2 
WHERE YEAR(PA2.fecha_inicio_periodo) = YEAR(PA.fecha_inicio_periodo)
AND MONTH(PA2.fecha_inicio_periodo) = MONTH(PA.fecha_inicio_periodo)
) porcentaje_incumplimientos
FROM GESTIONATE.pago_alquiler PA 
WHERE PA.fecha_pago > PA.fecha_fin_periodo --tomo que un pago esta vencido si es posterior al termino del periodo
GROUP BY YEAR(PA.fecha_inicio_periodo), MONTH(PA.fecha_inicio_periodo)
/*5) Porcentaje promedio de incremento del valor de los alquileres para los
contratos en curso por mes/año. Se calcula tomando en cuenta el último pago
con respecto al del mes en curso, únicamente de aquellos alquileres que hayan
tenido aumento y están activos.
*/
DROP VIEW IF EXISTS porcentaje_promedio_aumento_alquiler
GO
CREATE VIEW porcentaje_promedio_aumento_alquiler AS
SELECT 1 FROM GESTIONATE.pago_alquiler AL 



