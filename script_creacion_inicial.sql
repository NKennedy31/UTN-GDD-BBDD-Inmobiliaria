USE [GD2C2023]
GO

-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 1--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- En esta sección se borrarán los objetos previamente creados
-- Esto es debido a que durante el desarrollo puede ser que se ejecute este script repetidas veces
-- Sin borrar los objetos antiguos SQL Server no permitirá la ejecución y por tal motivo se realiza esta primera sección
-- Esta sección no incide de manera relevante en la performance de la ejecución.


-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 2--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- Esta sección consiste en la creeación del Esquema, Tablas y sus respectivos Constraints

-- CREACION DEL ESQUEMA

-- SCHEMA
--CREATE SCHEMA [GESTIONATE]
--GO

-- CREACION DE TABLAS DEL ESQUEMA

--------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 3--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- En esta sección se declaran las funciones necesarias para la migración.

-- OBTENER_ID_PROPIETARIO --> Retorna el ID de un fabricante dado un nombre.
CREATE FUNCTION GESTIONATE.OBTENER_ID_PROPIETARIO(@dni NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_propietario DECIMAL(18,0);

	SELECT @id_propietario = id_propietario FROM GESTIONATE.propietario WHERE numero_doc = @dni;

	RETURN @id_propietario;
END
GO

-- OBTENER_ID_ANUNCIO --> Retorna el ID de un anuncio dado un codigo.
CREATE FUNCTION GESTIONATE.OBTENER_ID_ANUNCIO(@codigo NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_anuncio DECIMAL(18,0);

	SELECT @id_anuncio = id_anuncio FROM GESTIONATE.anuncio WHERE codigo_anuncio = @codigo;

	RETURN @id_anuncio;
END
GO

-- OBTENER_ID_INQUILINO --> Retorna el ID de un inquilino dado un numero de documento.
CREATE FUNCTION GESTIONATE.OBTENER_ID_INQUILINO(@dni NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_inquilino DECIMAL(18,0);

	SELECT @id_inquilino = id_inquilino FROM GESTIONATE.inquilino WHERE numero_doc = @dni;

	RETURN @id_inquilino;
END
GO

/* OBTENER_DURACION --> Se registra la cantidad de períodos por los cuales se
alquila el inmueble. Por ejemplo, 36 (meses), 2 (semanas), 1 (quincena)
El tipo de periodo al cual corresponde la duración (meses, semanas, quincena,
etc) es el mismo que se especifica en el anuncio*/

CREATE FUNCTION GESTIONATE.OBTENER_DURACION(@dni NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_inquilino DECIMAL(18,0);

	SELECT @id_inquilino = id_inquilino FROM GESTIONATE.inquilino WHERE numero_doc = @dni;

	RETURN @id_inquilino;
END
GO

 -- OBTENER_ID_AGENTE --> Retorna el ID de un agente dado un numero de documento.

CREATE FUNCTION GESTIONATE.OBTENER_AGENTE(@dni NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_agente DECIMAL(18,0);

	SELECT @id_agente = id_agente FROM GESTIONATE.agente WHERE numero_doc = @dni;

	RETURN @id_agente;
END
GO

-- OBTENER_INMUEBLE --> Retorna el ID de un inmueble dado un codigo_inmueble

CREATE FUNCTION GESTIONATE.OBTENER_INMUEBLE(@codigo NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_inmueble DECIMAL(18,0);

	SELECT @id_inmueble = id_inmueble FROM GESTIONATE.inmueble WHERE codigo_inmueble = @codigo;

	RETURN @id_inmueble;
END
GO

-- OBTENER_SUCURSAL --> Retorna el ID de una sucursal dado un codigo_sucursal

CREATE FUNCTION GESTIONATE.OBTENER_SUCURSAL(@codigo NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_sucursal DECIMAL(18,0);

	SELECT @id_sucursal = id_sucursal FROM GESTIONATE.sucursal WHERE codigo_sucursal = @codigo;

	RETURN @id_sucursal;
END
GO

CREATE FUNCTION GESTIONATE.OBTENER_TIPO_PERIODO(@detalle NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_tipo_periodo DECIMAL(18,0);

	SELECT @id_tipo_periodo = id_tipo_periodo FROM GESTIONATE.tipo_periodo WHERE detalle = @detalle;

	RETURN @id_tipo_periodo;
	
END
GO

CREATE FUNCTION GESTIONATE.OBTENER_MONEDA(@detalle NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_moneda DECIMAL(18,0);

	SELECT @id_moneda = id_moneda FROM GESTIONATE.moneda WHERE detalle = @detalle;

	RETURN @id_moneda;
	
END
GO

CREATE FUNCTION GESTIONATE.OBTENER_ESTADO_ANUNCIO(@detalle NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_estado DECIMAL(18,0);

	SELECT @id_estado = id_estado_anuncio FROM GESTIONATE.estado_anuncio WHERE detalle = @detalle;

	RETURN @id_estado;
	
END
GO

CREATE FUNCTION GESTIONATE.OBTENER_TIPO_OPERACION(@detalle NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_tipo DECIMAL(18,0);

	SELECT @id_tipo = id_tipo_operacion FROM GESTIONATE.tipo_operacion WHERE detalle = @detalle;

	RETURN @id_tipo;
	
END
GO

CREATE FUNCTION GESTIONATE.OBTENER_CARACTERISTICA(@detalle NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_tipo DECIMAL(18,0);

	SELECT @id_tipo = id_caracteristica FROM GESTIONATE.caracteristica WHERE detalle = @detalle;

	RETURN @id_tipo;
	
END
GO



-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 4--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- En esta sección se declaran las Stored Procedures para luego poder realizar la migración
-- Una Stored Procedure por cada tabla.
-- El nombre de la Stored Procedure especifica qué tabla se está migrando
-- Toda tabla cuya Primary Key es Identity, debe tener en su migración la sentencia que permite inserción de identities.

CREATE PROCEDURE GESTIONATE.migrar_provincia AS
BEGIN
    SET IDENTITY_INSERT GESTIONATE.provincia ON
		INSERT INTO GESTIONATE.provincia (id_provincia)
			SELECT DISTINCT INMUEBLE_PROVINCIA FROM gd_esquema.Maestra WHERE INMUEBLE_PROVINCIA IS NOT NULL
			UNION
			SELECT DISTINCT SUCURSAL_PROVINCIA FROM gd_esquema.Maestra WHERE SUCURSAL_PROVINCIA IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.provincia OFF
END
GO

CREATE PROCEDURE GESTIONATE.migrar_localidad AS
BEGIN
    SET IDENTITY_INSERT GESTIONATE.localidad ON
	    INSERT INTO GESTIONATE.localidad (id_localidad)
			SELECT DISTINCT INMUEBLE_LOCALIDAD FROM gd_esquema.Maestra WHERE INMUEBLE_LOCALIDAD IS NOT NULL
			UNION
			SELECT DISTINCT SUCURSAL_LOCALIDAD FROM gd_esquema.Maestra WHERE SUCURSAL_LOCALIDAD IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.localidad OFF
END
GO 

CREATE PROCEDURE GESTIONATE.migrar_barrio AS
BEGIN
	INSERT INTO GESTIONATE.barrio (id_barrio)
		SELECT DISTINCT INMUEBLE_BARRIO FROM gd_esquema.Maestra
		WHERE INMUEBLE_BARRIO IS NOT NULL
END
GO

CREATE PROCEDURE GESTIONATE.migrar_direccion AS
BEGIN
	INSERT INTO GESTIONATE.direccion (id_direccion)
		SELECT DISTINCT SUCURSAL_DIRECCION FROM gd_esquema.Maestra WHERE SUCURSAL_DIRECCION IS NOT NULL
		UNION
		SELECT DISTINCT INMUEBLE_DIRECCION FROM gd_esquema.Maestra WHERE INMUEBLE_DIRECCION IS NOT NULL
END
GO

CREATE PROCEDURE GESTIONATE.migrar_sucursal AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.sucursal ON
	INSERT INTO GESTIONATE.sucursal (codigo_sucursal, nombre, codigo_direccion, telefono)
		SELECT DISTINCT SUCURSAL_CODIGO, SUCURSAL_NOMBRE, SUCURSAL_DIRECCION, SUCURSAL_TELEFONO FROM gd_esquema.Maestra WHERE SUCURSAL_DIRECCION IS NOT NULL
		SET IDENTITY_INSERT GESTIONATE.sucursal OFF
END
GO

CREATE PROCEDURE GESTIONATE.migrar_agente AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.agente ON
		INSERT INTO GESTIONATE.agente (nombre, apellido, numero_doc, fecha_registro, fecha_nacimiento, telefono, mail)
		SELECT DISTINCT AGENTE_NOMBRE, AGENTE_APELLIDO, AGENTE_DNI, AGENTE_FECHA_REGISTRO, AGENTE_FECHA_NAC, AGENTE_TELEFONO, AGENTE_MAIL FROM gd_esquema.Maestra WHERE AGENTE_DNI IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.sucursal OFF
END
GO

CREATE PROCEDURE GESTIONATE.migrar_tipo_inmueble AS --REVISAR MIGRACION: NOSE SI INMUEBLE_TIPO_INMUEBLE es el id_tipo_inmueble
BEGIN
	SET IDENTITY_INSERT GESTIONATE.tipo_inmueble ON
	INSERT INTO GESTIONATE.tipo_inmueble (id_tipo_inmueble)
		SELECT DISTINCT INMUEBLE_TIPO_INMUEBLE FROM gd_esquema.Maestra WHERE INMUEBLE_TIPO_INMUEBLE IS NOT NULL
		SET IDENTITY_INSERT GESTIONATE.sucursal OFF
END
GO

CREATE PROCEDURE GESTIONATE.migrar_ambiente AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.ambiente ON
		INSERT INTO GESTIONATE.tipo_inmueble (id_tipo_inmueble)
		SELECT DISTINCT INMUEBLE_CANT_AMBIENTES FROM gd_esquema.Maestra WHERE INMUEBLE_CANT_AMBIENTES IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.ambiente OFF
END
GO

CREATE PROCEDURE GESTIONATE.migrar_propietario AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.propietario ON
		INSERT INTO GESTIONATE.propietario(nombre, apellido, numero_doc, fecha_registro, fecha_nacimiento, telefono, mail)
		SELECT DISTINCT PROPIETARIO_NOMBRE, PROPIETARIO_APELLIDO, PROPIETARIO_DNI, PROPIETARIO_FECHA_REGISTRO, PROPIETARIO_FECHA_NAC, PROPIETARIO_TELEFONO, PROPIETARIO_MAIL FROM gd_esquema.Maestra WHERE PROPIETARIO_DNI IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.ambiente OFF
END
GO

CREATE PROCEDURE GESTIONATE.migrar_orientacion AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.orientacion ON
		INSERT INTO GESTIONATE.orientacion(detalle)
		SELECT DISTINCT INMUEBLE_ORIENTACION FROM gd_esquema.Maestra WHERE INMUEBLE_ORIENTACION IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.orientacion OFF
END
GO

CREATE PROCEDURE GESTIONATE.migrar_disposicion AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.orientacion ON
		INSERT INTO GESTIONATE.disposicion(detalle)
		SELECT DISTINCT INMUEBLE_DISPOSICION FROM gd_esquema.Maestra WHERE INMUEBLE_DISPOSICION IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.disposicion OFF
END
GO

-- ESTADO_INMUEBLE
CREATE PROCEDURE GESTIONATE.migrar_estado_inmueble AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.estado_inmueble ON
		INSERT INTO GESTIONATE.disposicion(detalle)
		SELECT DISTINCT INMUEBLE_ESTADO FROM gd_esquema.Maestra WHERE INMUEBLE_ESTADO IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.estado_inmueble OFF
END
GO

-- INMUEBLE
CREATE PROCEDURE GESTIONATE.migrar_inmueble AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.inmueble ON
		INSERT INTO GESTIONATE.inmueble(codigo_inmueble, nombre, id_tipo_inmueble, descripcion, id_propietario, codigo_direccion, id_ambiente, superficie_total, id_disposicion, id_orientacion, id_estado_inmueble, antiguedad, expensas)
		SELECT DISTINCT INMUEBLE_CODIGO, INMUEBLE_NOMBRE, INMUEBLE_TIPO_INMUEBLE, INMUEBLE_DESCRIPCION, GESTIONATE.OBTENER_ID_PROPIETARIO(PROPIETARIO_DNI), INMUEBLE_DIRECCION, INMUEBLE_CANT_AMBIENTES, INMUEBLE_SUPERFICIETOTAL, INMUEBLE_DISPOSICION, INMUEBLE_ORIENTACION, INMUEBLE_ESTADO, INMUEBLE_ANTIGUEDAD, INMUEBLE_EXPESAS FROM gd_esquema.Maestra WHERE PROPIETARIO_DNI IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.inmueble OFF
END
GO

-- CARACTERISTICA
CREATE PROCEDURE GESTIONATE.migrar_caracteristica AS
BEGIN
	INSERT INTO GESTIONATE.caracteristica(detalle) VALUES ('WIFI');
	INSERT INTO GESTIONATE.caracteristica(detalle) VALUES ('CABLE');
	INSERT INTO GESTIONATE.caracteristica(detalle) VALUES ('CALEFACCION');
	INSERT INTO GESTIONATE.caracteristica(detalle) VALUES ('GAS');
END
GO

-- CARACTERISTICA_X_INMUEBLE
CREATE PROCEDURE GESTIONATE.migrar_caracteristica_x_inmueble AS
BEGIN
	DECLARE cursorCaracteristicas CURSOR FOR
	SELECT DISTINCT INMUEBLE_CODIGO, INMUEBLE_CARACTERISTICA_CABLE, INMUEBLE_CARACTERISTICA_GAS, INMUEBLE_CARACTERISTICA_WIFI, INMUEBLE_CARACTERISTICA_CALEFACCION FROM gd_esquema.Maestra WHERE INMUEBLE_CODIGO IS NOT NULL ORDER BY INMUEBLE_CODIGO;

	DECLARE @inmueble_codigo NUMERIC(18,0), @cable NUMERIC(18,0), @gas NUMERIC(18,0), @wifi NUMERIC(18,0), @calefaccion NUMERIC(18,0), @id_inmueble NUMERIC(18,0),
			@id_cable NUMERIC(18,0), @id_wifi NUMERIC(18,0), @id_calefaccion NUMERIC(18,0), @id_gas NUMERIC(18,0);
			
	SET @id_cable = GESTIONATE.OBTENER_CARACTERISTICA(@cable);
	SET @id_wifi = GESTIONATE.OBTENER_CARACTERISTICA(@wifi);
	SET @id_calefaccion = GESTIONATE.OBTENER_CARACTERISTICA(@calefaccion);
	SET @id_gas = GESTIONATE.OBTENER_CARACTERISTICA(@gas);

	OPEN cursorCaracteristicas;
	FETCH NEXT FROM cursorCaracteristicas INTO @inmueble_codigo, @cable, @gas, @wifi, @calefaccion;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @id_inmueble = GESTIONATE.OBTENER_INMUEBLE(@inmueble_codigo);
		
		IF @gas=1
		BEGIN
			INSERT INTO GESTIONATE.caracteristica_x_inmueble(id_inmueble, id_caracteristica) VALUES (@id_inmueble, @id_gas)
		END

		IF @calefaccion=1
		BEGIN
			INSERT INTO GESTIONATE.caracteristica_x_inmueble(id_inmueble, id_caracteristica) VALUES (@id_inmueble, @id_calefaccion)
		END

		IF @wifi=1
		BEGIN
			INSERT INTO GESTIONATE.caracteristica_x_inmueble(id_inmueble, id_caracteristica) VALUES (@id_inmueble, @id_wifi)
		END

		IF @cable=1
		BEGIN
			INSERT INTO GESTIONATE.caracteristica_x_inmueble(id_inmueble, id_caracteristica) VALUES (@id_inmueble, @id_cable)
		END

		FETCH NEXT FROM cursorCaracteristicas INTO @inmueble_codigo, @cable, @gas, @wifi, @calefaccion;
	END

	CLOSE cursorCaracteristicas;
	DEALLOCATE cursorCaracteristicas;
	
END
GO

-- MONEDA
CREATE PROCEDURE GESTIONATE.migrar_moneda AS
BEGIN
	INSERT INTO GESTIONATE.moneda(detalle)
	SELECT DISTINCT ANUNCIO_MONEDA FROM gd_esquema.Maestra WHERE ANUNCIO_MONEDA IS NOT NULL
END
GO

-- TIPO_PERIODO
CREATE PROCEDURE GESTIONATE.migrar_tipo_periodo AS
BEGIN
	INSERT INTO GESTIONATE.tipo_periodo(detalle)
	SELECT DISTINCT ANUNCIO_TIPO_PERIODO FROM gd_esquema.Maestra WHERE ANUNCIO_TIPO_PERIODO IS NOT NULL
END
GO

-- TIPO_OPERACION
CREATE PROCEDURE GESTIONATE.migrar_tipo_operacion AS
BEGIN
	INSERT INTO GESTIONATE.tipo_operacion(detalle)
	SELECT DISTINCT ANUNCIO_TIPO_OPERACION FROM gd_esquema.Maestra
END
GO

-- ESTADO_ANUNCIO
CREATE PROCEDURE GESTIONATE.migrar_estado_anuncio AS
BEGIN
	INSERT INTO GESTIONATE.estado_anuncio(detalle)
	SELECT DISTINCT ANUNCIO_ESTADO FROM gd_esquema.Maestra
END
GO

-- ANUNCIO
CREATE PROCEDURE GESTIONATE.migrar_anuncio AS
BEGIN
	INSERT INTO GESTIONATE.anuncio(codigo_anuncio, id_agente, id_tipo_operacion, id_inmueble, precio, id_moneda, id_tipo_periodo, id_estado_anuncio, fecha_publicacion, fecha_finalizacion, costo_publicacion)
	SELECT DISTINCT ANUNCIO_CODIGO, GESTIONATE.OBTENER_AGENTE(AGENTE_DNI), GESTIONATE.OBTENER_TIPO_OPERACION(ANUNCIO_TIPO_OPERACION),
	GESTIONATE.OBTENER_INMUEBLE(INMUEBLE_CODIGO), ANUNCIO_PRECIO_PUBLICADO, GESTIONATE.OBTENER_MONEDA(ANUNCIO_MONEDA),
	GESTIONATE.OBTENER_TIPO_PERIODO(ANUNCIO_TIPO_PERIODO), GESTIONATE.OBTENER_ESTADO_ANUNCIO(ANUNCIO_ESTADO),
	ANUNCIO_FECHA_PUBLICACION, ANUNCIO_FECHA_FINALIZACION, ANUNCIO_COSTO_ANUNCIO FROM gd_esquema.Maestra WHERE ANUNCIO_CODIGO IS NOT NULL ORDER BY ANUNCIO_CODIGO;
END
GO

-- ESTADO_ALQUILER
CREATE PROCEDURE GESTIONATE.migrar_estado_alquiler AS
BEGIN
	INSERT INTO GESTIONATE.estado_alquiler(detalle)
	SELECT DISTINCT ALQUILER_ESTADO FROM gd_esquema.Maestra
END
GO

-- INQUILINO
CREATE PROCEDURE GESTIONATE.migrar_inquilino AS
BEGIN	
	INSERT INTO GESTIONATE.inquilino(nombre, apellido, numero_doc, telefono, mail, fecha_nacimiento, fecha_registro, tipo_doc)
	SELECT DISTINCT INQUILINO_NOMBRE, INQUILINO_APELLIDO, INQUILINO_DNI, INQUILINO_TELEFONO, INQUILINO_MAIL, INQUILINO_FECHA_NAC, INQUILINO_FECHA_REGISTRO, 'DNI' FROM gd_esquema.Maestra WHERE INQUILINO_DNI IS NOT NULL ORDER BY INQUILINO_DNI;
END
GO

/*CREATE TABLE GESTIONATE.inquilino(
	id_inquilino DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100),
	apellido VARCHAR(100),
	numero_doc VARCHAR(100) UNIQUE,
	tipo_doc CHAR(3),
	telefono VARCHAR(50),
	mail VARCHAR(100),
	fecha_nacimiento DATE,
	fecha_registro DATETIME,
	CHECK (fecha_nacimiento < fecha_registro)
);
GO*/

/*CREATE TABLE GESTIONATE.alquiler(
	id_alquiler DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	codigo_alquiler VARCHAR(100),
	id_anuncio DECIMAL(18,0) REFERENCES GESTIONATE.anuncio,
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
GO*/

-- ALQUILER
CREATE PROCEDURE GESTIONATE.migrar_alquiler AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.alquiler ON
		INSERT INTO GESTIONATE.alquiler(codigo_alquiler, id_anuncio, fecha_inicio, fecha_fin, duracion, deposito, comision, gastos_averiguaciones, id_estado_alquiler, id_agente, id_inmueble, id_tipo_periodo, id_sucursal)
		SELECT DISTINCT ALQUILER_CODIGO, GESTIONATE.OBTENER_ID_ANUNCIO(ANUNCIO_CODIGO), GESTIONATE.OBTENER_ID_INQUILINO(INQUILINO_DNI), ALQUILER_FECHA_INICIO, ALQUILER_FECHA_FIN, obtenerDuracion, ALQUILER_DEPOSITO, ALQUILER_COMISION, ALQUILER_GASTOS_AVERIGUA, ALQUILER_ESTADO, GESTIONATE.OBTENER_AGENTE(AGENTE_DNI), GESTIONATE.OBTENER_INMUEBLE(INMUEBLE_CODIGO), obtenerTipoPeriodo, GESTIONATE.OBTENER_SUCURSAL(SUCURSAL_CODIGO) FROM gd_esquema.Maestra WHERE PROPIETARIO_DNI IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.alquiler OFF
END
GO

/*CREATE TABLE GESTIONATE.medio_de_pago(
	id_medio_de_pago DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);
GO*/

/*CREATE TABLE GESTIONATE.pago_venta(
	id_pago DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	importe NUMERIC(18,2),
	cotizacion NUMERIC(18,2),
	id_moneda DECIMAL(18,0) REFERENCES GESTIONATE.moneda,
	id_medio_de_pago DECIMAL(18,0) REFERENCES GESTIONATE.medio_de_pago
);
GO*/

/*CREATE TABLE GESTIONATE.comprador(
	id_comprador DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100),
	apellido VARCHAR(100),
	numero_doc VARCHAR(100) UNIQUE,
	tipo_doc CHAR(3),
	telefono VARCHAR(100),
	mail VARCHAR(100),
	fecha_nacimiento DATE,
	fecha_registro DATETIME,
	CHECK(fecha_nacimiento < fecha_registro)
);
GO*/

/*CREATE TABLE GESTIONATE.venta(
	id_venta DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	id_anuncio DECIMAL(18,0) REFERENCES GESTIONATE.anuncio,
	id_agente DECIMAL(18,0) REFERENCES GESTIONATE.agente,
	id_comprador DECIMAL(18,0) REFERENCES GESTIONATE.comprador,
	fecha_venta DATETIME,
	precio_venta NUMERIC(18,2),
	id_moneda DECIMAL(18,0) REFERENCES GESTIONATE.moneda,
	id_pago DECIMAL(18,0) REFERENCES GESTIONATE.pago_venta, --revisar
	comision_inmobiliaria NUMERIC(18,2),
);
GO*/

/*CREATE TABLE GESTIONATE.pago_venta_x_venta(
	id_venta DECIMAL(18,0) REFERENCES GESTIONATE.venta,
	id_pago DECIMAL(18,0) REFERENCES GESTIONATE.pago_venta
);
GO*/

/*CREATE TABLE GESTIONATE.pago_alquiler(
    id_pago DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	id_alquiler DECIMAL(18,0) REFERENCES GESTIONATE.alquiler,
	id_inquilino DECIMAL(18,0) REFERENCES GESTIONATE.inquilino,
	fecha_pago DATETIME,
	nro_periodo_pago NUMERIC(18,0) NOT NULL,
	descrip_periodo VARCHAR(100),
	fecha_inicio_periodo DATETIME,
	fecha_fin_periodo DATETIME,
	importe NUMERIC(18,2),
	id_medio_de_pago DECIMAL(18,0) REFERENCES GESTIONATE.medio_de_pago,
	CHECK(fecha_inicio_periodo < fecha_fin_periodo)
);
GO*/

-- IMPORTE_PERIODO
CREATE PROCEDURE GESTIONATE.migrar_importe_periodo AS
BEGIN
    INSERT INTO GESTIONATE.importe_periodo (id_alquiler, periodo_inicio, periodo_fin, precio)
    SELECT a.id_alquiler, m.DETALLE_ALQ_NRO_PERIODO_INI, m.DETALLE_ALQ_NRO_PERIODO_FIN, m.DETALLE_ALQ_PRECIO
  FROM [GD2C2023].[gd_esquema].[Maestra] m
  LEFT JOIN GESTIONATE.alquiler a ON m.ALQUILER_CODIGO = a.codigo_alquiler
  WHERE ALQUILER_CODIGO IS NOT NULL
END