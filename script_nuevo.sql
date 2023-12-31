USE [GD2C2023]
GO

DROP SCHEMA IF EXISTS [GESTIONATE]
GO
CREATE SCHEMA [GESTIONATE]
GO

DECLARE @t AS DATETIME = GETDATE()


-- !!!!!!!!!!!!!!!!!! --
-- Creacion de TABLAS --
-- 　　　　　　　　　 --
PRINT('Comenzando migracion...')
PRINT('Creando Tablas...')
CREATE TABLE GESTIONATE.provincia(
	id_provincia DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL,
);


CREATE TABLE GESTIONATE.localidad(
	id_localidad DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL,
	codigo_provincia DECIMAL(18,0) REFERENCES GESTIONATE.provincia,
);


CREATE TABLE GESTIONATE.barrio(
	id_barrio DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1), 
	nombre VARCHAR(100) NOT NULL,
	codigo_localidad DECIMAL(18,0) REFERENCES GESTIONATE.localidad,
);


CREATE TABLE GESTIONATE.direccion(
	id_direccion DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL,
	codigo_barrio DECIMAL(18,0) REFERENCES GESTIONATE.barrio,
	codigo_localidad DECIMAL(18,0) REFERENCES GESTIONATE.localidad,
	codigo_provincia DECIMAL(18,0) REFERENCES GESTIONATE.provincia
);


CREATE TABLE GESTIONATE.sucursal(
	id_sucursal DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL,
	codigo_direccion DECIMAL(18,0) REFERENCES GESTIONATE.direccion,
	telefono VARCHAR(100) NOT NULL,
);


CREATE TABLE GESTIONATE.agente(
	id_agente DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	numero_doc numeric(18,0) NOT NULL,
	tipo_doc CHAR(3) NOT NULL,
	telefono VARCHAR(100) NOT NULL,
	mail VARCHAR(100) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	fecha_registro DATETIME NOT NULL,
	codigo_sucursal DECIMAL(18,0) REFERENCES GESTIONATE.sucursal
);


CREATE TABLE GESTIONATE.tipo_inmueble(
	id_tipo_inmueble DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);


CREATE TABLE GESTIONATE.ambiente(
	id_ambiente DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);


CREATE TABLE GESTIONATE.propietario(
	id_propietario DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100),
	apellido VARCHAR(100),
	numero_doc numeric(18,0),
	tipo_doc CHAR(3),
	telefono VARCHAR(100),
	mail VARCHAR(100),
	fecha_nacimiento DATE,
	fecha_registro DATETIME,
);


CREATE TABLE GESTIONATE.orientacion(
	id_orientacion DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);


CREATE TABLE GESTIONATE.disposicion(
	id_disposicion DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);


CREATE TABLE GESTIONATE.estado_inmueble(
	id_estado_inmueble DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);


CREATE TABLE GESTIONATE.inmueble(
	id_inmueble DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100),
	id_tipo_inmueble DECIMAL(18,0) REFERENCES GESTIONATE.tipo_inmueble,
	descripcion VARCHAR(100),
	id_propietario DECIMAL(18,0) REFERENCES GESTIONATE.propietario,
	codigo_direccion DECIMAL(18,0) REFERENCES GESTIONATE.direccion,
	id_ambiente DECIMAL(18,0) REFERENCES GESTIONATE.ambiente,
	superficie_total NUMERIC(18,2),
	id_disposicion DECIMAL(18,0) REFERENCES GESTIONATE.disposicion,
	id_orientacion DECIMAL(18,0) REFERENCES GESTIONATE.orientacion,
	id_estado_inmueble DECIMAL(18,0) REFERENCES GESTIONATE.estado_inmueble,
	antiguedad DATE,
	expensas NUMERIC(18,2)
);


CREATE TABLE GESTIONATE.caracteristica(
	id_caracteristica DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100)
);


CREATE TABLE GESTIONATE.caracteristica_x_inmueble(
	id_inmueble DECIMAL(18,0) REFERENCES GESTIONATE.inmueble,
	id_caracteristica DECIMAL(18,0) REFERENCES GESTIONATE.caracteristica
);


CREATE TABLE GESTIONATE.moneda(
	id_moneda DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);


CREATE TABLE GESTIONATE.tipo_periodo(
	id_tipo_periodo DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);


CREATE TABLE GESTIONATE.tipo_operacion(
	id_tipo_operacion DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);


CREATE TABLE GESTIONATE.estado_anuncio(
	id_estado_anuncio DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);


CREATE TABLE GESTIONATE.anuncio(
	id_anuncio DECIMAL(19,0) PRIMARY KEY IDENTITY(1,1),
	id_agente DECIMAL(18,0) REFERENCES GESTIONATE.agente,
	id_tipo_operacion DECIMAL(18,0) REFERENCES GESTIONATE.tipo_operacion,
	id_inmueble DECIMAL(18,0) REFERENCES GESTIONATE.inmueble,
	precio NUMERIC(18,2) NOT NULL,
	id_moneda DECIMAL(18,0) REFERENCES GESTIONATE.moneda,
	id_tipo_periodo DECIMAL(18,0) REFERENCES GESTIONATE.tipo_periodo,
	id_estado_anuncio DECIMAL(18,0) REFERENCES GESTIONATE.estado_anuncio,
	fecha_publicacion DATETIME NOT NULL,
	fecha_finalizacion DATETIME NOT NULL,
	costo_publicacion NUMERIC(18,2) NOT NULL
);

CREATE TABLE GESTIONATE.estado_alquiler(
	id_estado_alquiler DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);


CREATE TABLE GESTIONATE.inquilino(
	id_inquilino DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100),
	apellido VARCHAR(100),
	numero_doc numeric(18,0),
	tipo_doc CHAR(3),
	telefono VARCHAR(50),
	mail VARCHAR(100),
	fecha_nacimiento DATE,
	fecha_registro DATETIME
);


CREATE TABLE GESTIONATE.alquiler(
	id_alquiler DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	id_anuncio DECIMAL(19,0) REFERENCES GESTIONATE.anuncio,
	id_inquilino DECIMAL(18,0) REFERENCES GESTIONATE.inquilino,
	fecha_inicio DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
	duracion NUMERIC(18,2) NOT NULL,
	deposito NUMERIC(18,2) NOT NULL,
	comision NUMERIC(18,2) NOT NULL,
	gastos_averiguaciones NUMERIC(18,2) NOT NULL,
	id_estado_alquiler DECIMAL(18,0) REFERENCES GESTIONATE.estado_alquiler,
	id_agente DECIMAL(18,0) REFERENCES GESTIONATE.agente,
	id_inmueble DECIMAL(18,0) REFERENCES GESTIONATE.inmueble,
	id_tipo_periodo DECIMAL(18,0) REFERENCES GESTIONATE.tipo_periodo,
	id_sucursal DECIMAL(18,0) REFERENCES GESTIONATE.sucursal
);


CREATE TABLE GESTIONATE.medio_de_pago(
	id_medio_de_pago DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);


CREATE TABLE GESTIONATE.comprador(
	id_comprador DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100),
	apellido VARCHAR(100),
	numero_doc numeric(18,0),
	tipo_doc CHAR(3),
	telefono VARCHAR(100),
	mail VARCHAR(100),
	fecha_nacimiento DATE,
	fecha_registro DATETIME
);


CREATE TABLE GESTIONATE.venta(
    id_venta DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
    id_anuncio DECIMAL(19,0) REFERENCES GESTIONATE.anuncio,
    id_agente DECIMAL(18,0) REFERENCES GESTIONATE.agente,
    id_comprador DECIMAL(18,0) REFERENCES GESTIONATE.comprador,
    fecha_venta DATETIME,
    precio_venta NUMERIC(18,2),
    id_moneda DECIMAL(18,0) REFERENCES GESTIONATE.moneda,
    comision_inmobiliaria NUMERIC(18,2),
);


CREATE TABLE GESTIONATE.pago_venta(
	id_pago DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	id_venta DECIMAL(18,0) REFERENCES GESTIONATE.venta,
	importe NUMERIC(18,2),
	cotizacion NUMERIC(18,2),
	id_moneda DECIMAL(18,0) REFERENCES GESTIONATE.moneda,
	id_medio_de_pago DECIMAL(18,0) REFERENCES GESTIONATE.medio_de_pago
);

CREATE TABLE GESTIONATE.pago_alquiler(
    id_pago DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	id_alquiler DECIMAL(18,0) REFERENCES GESTIONATE.alquiler,
	id_inquilino DECIMAL(18,0) REFERENCES GESTIONATE.inquilino,
	fecha_pago DATETIME,
	nro_periodo_pago NUMERIC(18,0) NOT NULL,
	descrip_periodo VARCHAR(100),
	fecha_inicio_periodo DATETIME,
	fecha_fin_periodo DATETIME,
	importe NUMERIC(18,2),
	id_medio_de_pago DECIMAL(18,0) REFERENCES GESTIONATE.medio_de_pago
);

CREATE TABLE GESTIONATE.importe_periodo(
    id_alquiler DECIMAL(18,0) REFERENCES GESTIONATE.alquiler,
	periodo_inicio NUMERIC(18,0),
	periodo_fin NUMERIC(18,0),
	precio NUMERIC(18,2),
	PRIMARY KEY(id_alquiler,periodo_inicio)
);


PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
GO
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --
-- Creacion de FUNCIONES de utilidad para los procedures --
-- 　　　　　　　　　　　　　　　　　　　　　　　　　　� --

DROP FUNCTION IF EXISTS GESTIONATE.OBTENER_MONEDA
GO
CREATE FUNCTION GESTIONATE.OBTENER_MONEDA(@detalle NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN
	DECLARE @id_moneda DECIMAL(18,0);
	SELECT @id_moneda = id_moneda FROM GESTIONATE.moneda WHERE detalle = @detalle;
	RETURN @id_moneda;	
END
GO

DROP FUNCTION IF EXISTS GESTIONATE.OBTENER_CARACTERISTICA
GO
CREATE FUNCTION GESTIONATE.OBTENER_CARACTERISTICA(@detalle NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN
	DECLARE @id_tipo DECIMAL(18,0);
	SELECT @id_tipo = id_caracteristica FROM GESTIONATE.caracteristica WHERE detalle = @detalle;
	RETURN @id_tipo;	
END
GO

DROP FUNCTION IF EXISTS GESTIONATE.OBTENER_LOCALIDAD
GO
CREATE FUNCTION GESTIONATE.OBTENER_LOCALIDAD(@nombre NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN
	DECLARE @id DECIMAL(18,0);
	SELECT @id = id_localidad FROM GESTIONATE.localidad WHERE nombre = @nombre;
	RETURN @id;	
END
GO

DROP FUNCTION IF EXISTS GESTIONATE.OBTENER_PROVINCIA
GO
CREATE FUNCTION GESTIONATE.OBTENER_PROVINCIA(@nombre NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN
	DECLARE @id DECIMAL(18,0);
	SELECT @id = id_provincia FROM GESTIONATE.provincia WHERE nombre = @nombre;
	RETURN @id;	
END
GO

DROP FUNCTION IF EXISTS GESTIONATE.OBTENER_BARRIO
GO
CREATE FUNCTION GESTIONATE.OBTENER_BARRIO(@nombre NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN
	DECLARE @id DECIMAL(18,0);
	SELECT @id = id_barrio FROM GESTIONATE.barrio WHERE nombre = @nombre;
	RETURN @id;	
END
GO

DROP FUNCTION IF EXISTS GESTIONATE.OBTENER_ANTIGUEDAD
GO
CREATE FUNCTION GESTIONATE.OBTENER_ANTIGUEDAD(@antiguedad_en_anios numeric(18,0)) RETURNS DATE AS
BEGIN
    RETURN DATEADD(year, -@antiguedad_en_anios, GETDATE())
END
GO

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --
-- Creacion de PROCEDURES para la MIGRACION --
-- 　　　　　　　　　　　　　　　　　　　　 --

-- PROVINCIA
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_provincia
GO
CREATE PROCEDURE GESTIONATE.migrar_provincia AS
BEGIN
		INSERT INTO GESTIONATE.provincia (nombre)
			SELECT DISTINCT INMUEBLE_PROVINCIA FROM gd_esquema.Maestra WHERE INMUEBLE_PROVINCIA IS NOT NULL
			UNION
			SELECT DISTINCT SUCURSAL_PROVINCIA FROM gd_esquema.Maestra WHERE SUCURSAL_PROVINCIA IS NOT NULL
END
GO

-- LOCALIDAD
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_localidad
GO
CREATE PROCEDURE GESTIONATE.migrar_localidad AS
BEGIN
	    INSERT INTO GESTIONATE.localidad (nombre, codigo_provincia)
			SELECT DISTINCT INMUEBLE_LOCALIDAD, (SELECT id_provincia FROM GESTIONATE.provincia WHERE nombre=INMUEBLE_PROVINCIA) FROM gd_esquema.Maestra WHERE INMUEBLE_LOCALIDAD IS NOT NULL
			UNION
			SELECT DISTINCT SUCURSAL_LOCALIDAD, (SELECT id_provincia FROM GESTIONATE.provincia WHERE nombre=SUCURSAL_PROVINCIA) FROM gd_esquema.Maestra WHERE SUCURSAL_LOCALIDAD IS NOT NULL
END
GO 

-- BARRIO
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_barrio
GO
CREATE PROCEDURE GESTIONATE.migrar_barrio AS
BEGIN
	INSERT INTO GESTIONATE.barrio (nombre, codigo_localidad)
		SELECT DISTINCT INMUEBLE_BARRIO, GESTIONATE.OBTENER_LOCALIDAD(INMUEBLE_LOCALIDAD) FROM gd_esquema.Maestra WHERE INMUEBLE_BARRIO IS NOT NULL
END
GO

-- DIRECCION
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_direccion
GO
CREATE PROCEDURE GESTIONATE.migrar_direccion AS
BEGIN
	INSERT INTO GESTIONATE.direccion (detalle, codigo_localidad, codigo_provincia, codigo_barrio)
		SELECT u.d, GESTIONATE.OBTENER_LOCALIDAD(u.l), GESTIONATE.OBTENER_PROVINCIA(u.p), GESTIONATE.OBTENER_BARRIO(u.b) FROM
		(SELECT DISTINCT SUCURSAL_DIRECCION d ,SUCURSAL_LOCALIDAD l, SUCURSAL_PROVINCIA p, NULL b FROM gd_esquema.Maestra WHERE SUCURSAL_DIRECCION IS NOT NULL
        UNION
        SELECT DISTINCT INMUEBLE_DIRECCION d, INMUEBLE_LOCALIDAD l, INMUEBLE_PROVINCIA p, INMUEBLE_BARRIO b FROM gd_esquema.Maestra WHERE INMUEBLE_DIRECCION IS NOT NULL) u
		
END
GO

-- SUCURSAL
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_sucursal
GO
CREATE PROCEDURE GESTIONATE.migrar_sucursal AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.sucursal ON
		INSERT INTO GESTIONATE.sucursal (id_sucursal, nombre, codigo_direccion, telefono)
		SELECT DISTINCT SUCURSAL_CODIGO, SUCURSAL_NOMBRE, (SELECT id_direccion FROM GESTIONATE.direccion WHERE detalle=SUCURSAL_DIRECCION), SUCURSAL_TELEFONO FROM gd_esquema.Maestra WHERE SUCURSAL_CODIGO IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.sucursal OFF
END
GO

-- AGENTE
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_agente
GO
CREATE PROCEDURE GESTIONATE.migrar_agente AS
BEGIN
		INSERT INTO GESTIONATE.agente (nombre, apellido, numero_doc, tipo_doc, fecha_registro, fecha_nacimiento, telefono, mail, codigo_sucursal)
		SELECT DISTINCT AGENTE_NOMBRE, AGENTE_APELLIDO, AGENTE_DNI, 'DNI', AGENTE_FECHA_REGISTRO, AGENTE_FECHA_NAC, AGENTE_TELEFONO, AGENTE_MAIL, SUCURSAL_CODIGO FROM gd_esquema.Maestra WHERE AGENTE_DNI IS NOT NULL
END
GO

-- TIPO_INMUEBLE
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_tipo_inmueble
GO
CREATE PROCEDURE GESTIONATE.migrar_tipo_inmueble AS
BEGIN
	INSERT INTO GESTIONATE.tipo_inmueble(detalle)
	SELECT DISTINCT INMUEBLE_TIPO_INMUEBLE FROM gd_esquema.Maestra WHERE INMUEBLE_TIPO_INMUEBLE IS NOT NULL
END
GO

-- AMBIENTE
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_ambiente
GO
CREATE PROCEDURE GESTIONATE.migrar_ambiente AS
BEGIN
	INSERT INTO GESTIONATE.ambiente(detalle)
	SELECT DISTINCT INMUEBLE_CANT_AMBIENTES FROM gd_esquema.Maestra WHERE INMUEBLE_CANT_AMBIENTES IS NOT NULL
END
GO

-- PROPIETARIO
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_propietario
GO
CREATE PROCEDURE GESTIONATE.migrar_propietario AS
BEGIN
	INSERT INTO GESTIONATE.propietario(nombre, apellido, numero_doc, tipo_doc, fecha_registro, fecha_nacimiento, telefono, mail)
	SELECT DISTINCT PROPIETARIO_NOMBRE, PROPIETARIO_APELLIDO, PROPIETARIO_DNI, 'DNI', PROPIETARIO_FECHA_REGISTRO, PROPIETARIO_FECHA_NAC, PROPIETARIO_TELEFONO, PROPIETARIO_MAIL FROM gd_esquema.Maestra WHERE PROPIETARIO_DNI IS NOT NULL
END
GO

-- ORIENTACION
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_orientacion
GO
CREATE PROCEDURE GESTIONATE.migrar_orientacion AS
BEGIN
	INSERT INTO GESTIONATE.orientacion(detalle)
	SELECT DISTINCT INMUEBLE_ORIENTACION FROM gd_esquema.Maestra WHERE INMUEBLE_ORIENTACION IS NOT NULL
END
GO

-- DISPOSICION
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_disposicion
GO
CREATE PROCEDURE GESTIONATE.migrar_disposicion AS
BEGIN
	INSERT INTO GESTIONATE.disposicion(detalle)
	SELECT DISTINCT INMUEBLE_DISPOSICION FROM gd_esquema.Maestra WHERE INMUEBLE_DISPOSICION IS NOT NULL
END
GO

-- ESTADO_INMUEBLE
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_estado_inmueble
GO
CREATE PROCEDURE GESTIONATE.migrar_estado_inmueble AS
BEGIN
	INSERT INTO GESTIONATE.estado_inmueble(detalle)
	SELECT DISTINCT INMUEBLE_ESTADO FROM gd_esquema.Maestra WHERE INMUEBLE_ESTADO IS NOT NULL
END
GO

-- INMUEBLE
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_inmueble
GO
CREATE PROCEDURE GESTIONATE.migrar_inmueble AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.inmueble ON
		INSERT INTO GESTIONATE.inmueble(id_inmueble, nombre, id_tipo_inmueble, descripcion, id_propietario, codigo_direccion, id_ambiente, superficie_total, id_disposicion, id_orientacion, id_estado_inmueble, antiguedad, expensas)
		SELECT DISTINCT INMUEBLE_CODIGO, INMUEBLE_NOMBRE,
		(SELECT id_tipo_inmueble FROM GESTIONATE.tipo_inmueble WHERE detalle=INMUEBLE_TIPO_INMUEBLE), INMUEBLE_DESCRIPCION,
		(SELECT TOP 1 id_propietario FROM GESTIONATE.propietario WHERE numero_doc=PROPIETARIO_DNI),
		(SELECT TOP 1 id_direccion FROM GESTIONATE.direccion WHERE detalle=INMUEBLE_DIRECCION),
		(SELECT id_ambiente FROM GESTIONATE.ambiente WHERE detalle=INMUEBLE_CANT_AMBIENTES), INMUEBLE_SUPERFICIETOTAL,
		(SELECT id_disposicion FROM GESTIONATE.disposicion WHERE detalle=INMUEBLE_DISPOSICION),
		(SELECT id_orientacion FROM GESTIONATE.orientacion WHERE detalle=INMUEBLE_ORIENTACION),
		(SELECT id_estado_inmueble FROM GESTIONATE.estado_inmueble WHERE detalle=INMUEBLE_ESTADO),
		GESTIONATE.OBTENER_ANTIGUEDAD(INMUEBLE_ANTIGUEDAD), INMUEBLE_EXPESAS FROM gd_esquema.Maestra WHERE INMUEBLE_CODIGO IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.inmueble OFF
END
GO

-- CARACTERISTICA
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_caracteristica
GO
CREATE PROCEDURE GESTIONATE.migrar_caracteristica AS
BEGIN
	INSERT INTO GESTIONATE.caracteristica(detalle) VALUES ('WIFI');
	INSERT INTO GESTIONATE.caracteristica(detalle) VALUES ('CABLE');
	INSERT INTO GESTIONATE.caracteristica(detalle) VALUES ('CALEFACCION');
	INSERT INTO GESTIONATE.caracteristica(detalle) VALUES ('GAS');
END
GO

-- CARACTERISTICA_X_INMUEBLE
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_caracteristica_x_inmueble
GO
CREATE PROCEDURE GESTIONATE.migrar_caracteristica_x_inmueble AS
BEGIN
	DECLARE cursorCaracteristicas CURSOR FOR
	SELECT DISTINCT INMUEBLE_CODIGO, INMUEBLE_CARACTERISTICA_CABLE, INMUEBLE_CARACTERISTICA_GAS, INMUEBLE_CARACTERISTICA_WIFI, INMUEBLE_CARACTERISTICA_CALEFACCION FROM gd_esquema.Maestra WHERE INMUEBLE_CODIGO IS NOT NULL;

	DECLARE @inmueble_codigo NUMERIC(18,0), @cable NUMERIC(18,0), @gas NUMERIC(18,0), @wifi NUMERIC(18,0), @calefaccion NUMERIC(18,0), @id_cable NUMERIC(18,0), @id_wifi NUMERIC(18,0), @id_calefaccion NUMERIC(18,0), @id_gas NUMERIC(18,0);
			
	SET @id_cable = GESTIONATE.OBTENER_CARACTERISTICA('CABLE');
	SET @id_wifi = GESTIONATE.OBTENER_CARACTERISTICA('WIFI');
	SET @id_calefaccion = GESTIONATE.OBTENER_CARACTERISTICA('CALEFACCION');
	SET @id_gas = GESTIONATE.OBTENER_CARACTERISTICA('GAS');

	OPEN cursorCaracteristicas;
	FETCH NEXT FROM cursorCaracteristicas INTO @inmueble_codigo, @cable, @gas, @wifi, @calefaccion;
	BEGIN TRANSACTION t_caracteristica
	WHILE @@FETCH_STATUS = 0
	BEGIN		
		IF @gas=1
			BEGIN
				INSERT INTO GESTIONATE.caracteristica_x_inmueble(id_inmueble, id_caracteristica) VALUES (@inmueble_codigo, @id_gas)
			END
		IF @calefaccion=1
			BEGIN
				INSERT INTO GESTIONATE.caracteristica_x_inmueble(id_inmueble, id_caracteristica) VALUES (@inmueble_codigo, @id_calefaccion)
			END
		IF @wifi=1
			BEGIN
				INSERT INTO GESTIONATE.caracteristica_x_inmueble(id_inmueble, id_caracteristica) VALUES (@inmueble_codigo, @id_wifi)
			END
		IF @cable=1
			BEGIN
				INSERT INTO GESTIONATE.caracteristica_x_inmueble(id_inmueble, id_caracteristica) VALUES (@inmueble_codigo, @id_cable)
			END

		FETCH NEXT FROM cursorCaracteristicas INTO @inmueble_codigo, @cable, @gas, @wifi, @calefaccion;
	END
	COMMIT TRANSACTION t_caracteristica
	CLOSE cursorCaracteristicas;
	DEALLOCATE cursorCaracteristicas;	
END
GO

-- MONEDA
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_moneda
GO
CREATE PROCEDURE GESTIONATE.migrar_moneda AS
BEGIN
	INSERT INTO GESTIONATE.moneda(detalle)
	SELECT DISTINCT ANUNCIO_MONEDA FROM gd_esquema.Maestra WHERE ANUNCIO_MONEDA IS NOT NULL
END
GO

-- TIPO_PERIODO
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_tipo_periodo
GO
CREATE PROCEDURE GESTIONATE.migrar_tipo_periodo AS
BEGIN
	INSERT INTO GESTIONATE.tipo_periodo(detalle)
	SELECT DISTINCT ANUNCIO_TIPO_PERIODO FROM gd_esquema.Maestra WHERE ANUNCIO_TIPO_PERIODO IS NOT NULL
END
GO

-- TIPO_OPERACION
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_tipo_operacion
GO
CREATE PROCEDURE GESTIONATE.migrar_tipo_operacion AS
BEGIN
	INSERT INTO GESTIONATE.tipo_operacion(detalle)
	SELECT DISTINCT ANUNCIO_TIPO_OPERACION FROM gd_esquema.Maestra WHERE ANUNCIO_TIPO_OPERACION IS NOT NULL
END
GO

-- ESTADO_ANUNCIO
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_estado_anuncio
GO
CREATE PROCEDURE GESTIONATE.migrar_estado_anuncio AS
BEGIN
	INSERT INTO GESTIONATE.estado_anuncio(detalle)
	SELECT DISTINCT ANUNCIO_ESTADO FROM gd_esquema.Maestra WHERE ANUNCIO_ESTADO IS NOT NULL
END
GO

-- ANUNCIO
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_anuncio
GO
CREATE PROCEDURE GESTIONATE.migrar_anuncio AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.anuncio ON
		INSERT INTO GESTIONATE.anuncio(id_anuncio, id_agente, id_tipo_operacion, id_inmueble, precio, id_moneda, id_tipo_periodo, id_estado_anuncio, fecha_publicacion, fecha_finalizacion, costo_publicacion)
		SELECT DISTINCT ANUNCIO_CODIGO,
		(SELECT id_agente FROM GESTIONATE.agente WHERE numero_doc=AGENTE_DNI),
		(SELECT id_tipo_operacion FROM GESTIONATE.tipo_operacion WHERE detalle=ANUNCIO_TIPO_OPERACION),
		INMUEBLE_CODIGO, ANUNCIO_PRECIO_PUBLICADO, GESTIONATE.OBTENER_MONEDA(ANUNCIO_MONEDA),
		(SELECT id_tipo_periodo FROM GESTIONATE.tipo_periodo WHERE detalle=ANUNCIO_TIPO_PERIODO),
		(SELECT id_estado_anuncio FROM GESTIONATE.estado_anuncio WHERE detalle=ANUNCIO_ESTADO),
		ANUNCIO_FECHA_PUBLICACION, ANUNCIO_FECHA_FINALIZACION, ANUNCIO_COSTO_ANUNCIO FROM gd_esquema.Maestra WHERE ANUNCIO_CODIGO IS NOT NULL AND INMUEBLE_CODIGO IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.anuncio OFF
END
GO

-- ESTADO_ALQUILER
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_estado_alquiler
GO
CREATE PROCEDURE GESTIONATE.migrar_estado_alquiler AS
BEGIN
	INSERT INTO GESTIONATE.estado_alquiler(detalle)
	SELECT DISTINCT ALQUILER_ESTADO FROM gd_esquema.Maestra WHERE ALQUILER_ESTADO IS NOT NULL
END
GO

-- INQUILINO
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_inquilino
GO
CREATE PROCEDURE GESTIONATE.migrar_inquilino AS
BEGIN	
	INSERT INTO GESTIONATE.inquilino(nombre, apellido, numero_doc, tipo_doc, telefono, mail, fecha_nacimiento, fecha_registro)
	SELECT DISTINCT INQUILINO_NOMBRE, INQUILINO_APELLIDO, INQUILINO_DNI, 'DNI', INQUILINO_TELEFONO, INQUILINO_MAIL, INQUILINO_FECHA_NAC, INQUILINO_FECHA_REGISTRO FROM gd_esquema.Maestra WHERE INQUILINO_DNI IS NOT NULL;
END
GO

-- ALQUILER
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_alquiler
GO
CREATE PROCEDURE GESTIONATE.migrar_alquiler AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.alquiler ON
		INSERT INTO GESTIONATE.alquiler(id_alquiler, id_anuncio, id_inquilino, fecha_inicio, fecha_fin, duracion, deposito, comision, gastos_averiguaciones, id_estado_alquiler, id_agente, id_inmueble, id_tipo_periodo, id_sucursal)
		SELECT DISTINCT ALQUILER_CODIGO, ANUNCIO_CODIGO, 
		(SELECT TOP 1 id_inquilino FROM GESTIONATE.inquilino WHERE numero_doc=INQUILINO_DNI), ALQUILER_FECHA_INICIO, ALQUILER_FECHA_FIN, ALQUILER_CANT_PERIODOS, ALQUILER_DEPOSITO, ALQUILER_COMISION, ALQUILER_GASTOS_AVERIGUA,
		(SELECT id_estado_alquiler FROM GESTIONATE.estado_alquiler WHERE detalle=ALQUILER_ESTADO),
		(SELECT TOP 1 id_agente FROM GESTIONATE.anuncio WHERE id_anuncio=ANUNCIO_CODIGO), 
		(SELECT id_inmueble FROM GESTIONATE.anuncio WHERE id_anuncio=ANUNCIO_CODIGO), 
		(SELECT id_tipo_periodo FROM GESTIONATE.anuncio WHERE id_anuncio=ANUNCIO_CODIGO), SUCURSAL_CODIGO FROM gd_esquema.Maestra WHERE ALQUILER_CODIGO IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.alquiler OFF
END
GO

-- MEDIO_DE_PAGO
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_medio_de_pago
GO
CREATE PROCEDURE GESTIONATE.migrar_medio_de_pago AS
BEGIN
	INSERT INTO GESTIONATE.medio_de_pago(detalle)
	SELECT DISTINCT PAGO_ALQUILER_MEDIO_PAGO FROM gd_esquema.Maestra WHERE PAGO_ALQUILER_MEDIO_PAGO IS NOT NULL
	UNION
	SELECT DISTINCT PAGO_VENTA_MEDIO_PAGO FROM gd_esquema.Maestra WHERE PAGO_VENTA_MEDIO_PAGO IS NOT NULL
END
GO

-- PAGO_VENTA
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_pago_venta
GO
CREATE PROCEDURE GESTIONATE.migrar_pago_venta AS
BEGIN
    INSERT INTO [GESTIONATE].pago_venta
               (id_venta,importe,cotizacion,id_moneda,id_medio_de_pago)
               SELECT VENTA_CODIGO, PAGO_VENTA_IMPORTE, PAGO_VENTA_COTIZACION, GESTIONATE.OBTENER_MONEDA(PAGO_VENTA_MONEDA),
			   (SELECT id_medio_de_pago FROM GESTIONATE.medio_de_pago WHERE detalle=PAGO_VENTA_MEDIO_PAGO)
               FROM gd_esquema.Maestra
               WHERE VENTA_CODIGO IS NOT NULL AND 
               (PAGO_VENTA_IMPORTE IS NOT NULL OR PAGO_VENTA_COTIZACION IS NOT NULL OR
               PAGO_VENTA_MEDIO_PAGO IS NOT NULL OR PAGO_VENTA_MONEDA IS NOT NULL)
END
GO

-- COMPRADOR	
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_comprador
GO
CREATE PROCEDURE GESTIONATE.migrar_comprador AS
BEGIN
	INSERT INTO GESTIONATE.comprador(nombre, apellido, numero_doc, tipo_doc, telefono, mail, fecha_nacimiento, fecha_registro)
	SELECT DISTINCT COMPRADOR_NOMBRE, COMPRADOR_APELLIDO, COMPRADOR_DNI, 'DNI', COMPRADOR_TELEFONO, COMPRADOR_MAIL, COMPRADOR_FECHA_NAC, COMPRADOR_FECHA_REGISTRO FROM gd_esquema.Maestra WHERE COMPRADOR_DNI IS NOT NULL
END
GO

-- VENTA
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_venta
GO
CREATE PROCEDURE GESTIONATE.migrar_venta AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.venta ON
		INSERT INTO [GESTIONATE].[venta]
				   ([id_venta],[id_anuncio],[id_agente],[id_comprador],[fecha_venta],[precio_venta],[id_moneda],[comision_inmobiliaria])
				   SELECT DISTINCT VENTA_CODIGO, ANUNCIO_CODIGO,
				   (SELECT id_agente FROM GESTIONATE.anuncio WHERE id_anuncio=ANUNCIO_CODIGO), 
				   (SELECT id_comprador FROM GESTIONATE.comprador WHERE numero_doc=COMPRADOR_DNI), VENTA_FECHA, VENTA_PRECIO_VENTA, GESTIONATE.OBTENER_MONEDA(VENTA_MONEDA),VENTA_COMISION FROM gd_esquema.Maestra m
				   WHERE VENTA_CODIGO IS NOT NULL;
	SET IDENTITY_INSERT GESTIONATE.venta OFF
END
GO

-- PAGO_ALQUILER
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_pago_alquiler
GO
CREATE PROCEDURE GESTIONATE.migrar_pago_alquiler AS
BEGIN
	INSERT INTO GESTIONATE.pago_alquiler(id_alquiler, id_inquilino, fecha_pago, nro_periodo_pago, descrip_periodo, fecha_inicio_periodo, fecha_fin_periodo, importe, id_medio_de_pago)
	SELECT ALQUILER_CODIGO, 
	(SELECT TOP 1 id_inquilino FROM GESTIONATE.inquilino WHERE numero_doc=INQUILINO_DNI), 
	PAGO_ALQUILER_FECHA, PAGO_ALQUILER_NRO_PERIODO, PAGO_ALQUILER_DESC, PAGO_ALQUILER_FEC_INI, PAGO_ALQUILER_FEC_FIN, PAGO_ALQUILER_IMPORTE,
	(SELECT id_medio_de_pago FROM GESTIONATE.medio_de_pago WHERE detalle=PAGO_ALQUILER_MEDIO_PAGO) FROM gd_esquema.Maestra WHERE PAGO_ALQUILER_CODIGO IS NOT NULL;
END
GO

-- IMPORTE_PERIODO
DROP PROCEDURE IF EXISTS GESTIONATE.migrar_importe_periodo
GO
CREATE PROCEDURE GESTIONATE.migrar_importe_periodo AS
BEGIN
    INSERT INTO GESTIONATE.importe_periodo (id_alquiler, periodo_inicio, periodo_fin, precio)
    SELECT DISTINCT ALQUILER_CODIGO, DETALLE_ALQ_NRO_PERIODO_INI, DETALLE_ALQ_NRO_PERIODO_FIN, DETALLE_ALQ_PRECIO
  FROM [GD2C2023].[gd_esquema].[Maestra] WHERE ALQUILER_CODIGO IS NOT NULL AND DETALLE_ALQ_NRO_PERIODO_INI IS NOT NULL
END
GO

-- !!!!!!!!!!!!!!!!!!! --
-- Creacion de INDICES --
-- 　　　　　　　　　� --

DECLARE @t AS DATETIME = GETDATE()
PRINT('Creando �ndices...')
CREATE INDEX ind_provincia ON GESTIONATE.provincia (nombre);
CREATE INDEX ind_localidad ON GESTIONATE.localidad (nombre);
CREATE INDEX ind_barrio ON GESTIONATE.barrio (nombre);
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
GO


-- !!!!!!!!!!!!!!!!!!!!!!! --
-- EJECUCION de PROCEDURES --
-- 　　　　　　　　　　　� --

DECLARE @t AS DATETIME = GETDATE()
PRINT('Migrando provincias...')
EXEC GESTIONATE.migrar_provincia
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando localidades...')
EXEC GESTIONATE.migrar_localidad
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando barrios...')
EXEC GESTIONATE.migrar_barrio
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando direcciones...')
EXEC GESTIONATE.migrar_direccion
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando sucursales...')
EXEC GESTIONATE.migrar_sucursal
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando agentes...')
EXEC GESTIONATE.migrar_agente
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando tipos de inmueble...')
EXEC GESTIONATE.migrar_tipo_inmueble
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando ambientes...')
EXEC GESTIONATE.migrar_ambiente
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando propietarios...')
EXEC GESTIONATE.migrar_propietario
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando orientaciones...')
EXEC GESTIONATE.migrar_orientacion
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando dispocisiones...')
EXEC GESTIONATE.migrar_disposicion
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando estados de inmueble...')
EXEC GESTIONATE.migrar_estado_inmueble
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando inmuebles...')
EXEC GESTIONATE.migrar_inmueble
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando caracteristicas...')
EXEC GESTIONATE.migrar_caracteristica
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando caracteristicas por inmueble...')
EXEC GESTIONATE.migrar_caracteristica_x_inmueble
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando monedas...')
EXEC GESTIONATE.migrar_moneda
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando tipos de periodo...')
EXEC GESTIONATE.migrar_tipo_periodo
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando tipos de operacion...')
EXEC GESTIONATE.migrar_tipo_operacion
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando estados de anuncio...')
EXEC GESTIONATE.migrar_estado_anuncio
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando anuncios...')
EXEC GESTIONATE.migrar_anuncio
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando estados de alquiler...')
EXEC GESTIONATE.migrar_estado_alquiler
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando inquilinos...')
EXEC GESTIONATE.migrar_inquilino
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando alquileres...')
EXEC GESTIONATE.migrar_alquiler
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando medios de pago...')
EXEC GESTIONATE.migrar_medio_de_pago
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando compradores...')
EXEC GESTIONATE.migrar_comprador
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando ventas...')
EXEC GESTIONATE.migrar_venta
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando pagos de venta...')
EXEC GESTIONATE.migrar_pago_venta
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando pagos de alquiler...')
EXEC GESTIONATE.migrar_pago_alquiler
PRINT(CONCAT('Listo! ',DATEDIFF(millisecond,@t,GETDATE()),'ms'))
SET @t = GETDATE()
PRINT('Migrando importes de periodo...')
EXEC GESTIONATE.migrar_importe_periodo

GO