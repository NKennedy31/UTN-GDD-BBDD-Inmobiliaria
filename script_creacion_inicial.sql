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
--------------------------------------------------------------
CREATE TABLE GESTIONATE.provincia(
	id_provincia DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL,
);
GO

CREATE TABLE GESTIONATE.localidad(
	id_localidad DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL,
	codigo_provincia DECIMAL(18,0) REFERENCES GESTIONATE.provincia,
);
GO

CREATE TABLE GESTIONATE.barrio(
	id_barrio DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1), 
	nombre VARCHAR(100) NOT NULL,
	codigo_localidad DECIMAL(18,0) REFERENCES GESTIONATE.localidad,
);
GO

CREATE TABLE GESTIONATE.direccion(
	id_direccion DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	calle VARCHAR(100) NOT NULL,
	numero NUMERIC(18,0) NOT NULL,
	piso CHAR(10) NOT NULL,
	departamento CHAR(10) NOT NULL,
	codigo_barrio DECIMAL(18,0) REFERENCES GESTIONATE.barrio,
	codigo_localidad DECIMAL(18,0) REFERENCES GESTIONATE.localidad,
	codigo_provincia DECIMAL(18,0) REFERENCES GESTIONATE.provincia
);
GO
---------------------------------------------------------------
---------------------------------------------------------------
CREATE TABLE GESTIONATE.sucursal(
	codigo_sucursal DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL,
	codigo_direccion DECIMAL(18,0) REFERENCES GESTIONATE.direccion,
	telefono VARCHAR(100) NOT NULL,
);
GO

CREATE TABLE GESTIONATE.agente(
	id_agente DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	numero_doc VARCHAR(100) NOT NULL,
	tipo_doc CHAR(3) NOT NULL,
	telefono VARCHAR(100) NOT NULL,
	mail VARCHAR(100) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	fecha_registro DATETIME NOT NULL,
	codigo_sucursal DECIMAL(18,0) REFERENCES GESTIONATE.sucursal
);
GO

CREATE TABLE GESTIONATE.tipo_inmueble(
	id_tipo_inmueble DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.ambiente(
	id_ambiente DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	cantidad_ambientes VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.propietario(
	id_propietario DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100),
	apellido VARCHAR(100),
	numero_doc VARCHAR(100),
	tipo_doc CHAR(3),
	telefono VARCHAR(100),
	mail VARCHAR(100),
	fecha_nacimiento DATE,
	fecha_registro DATETIME,
);
GO

CREATE TABLE GESTIONATE.orientacion(
	id_orientacion DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);
GO


CREATE TABLE GESTIONATE.disposicion(
	id_disposicion DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);
GO


CREATE TABLE GESTIONATE.estado_inmueble(
	id_estado_inmueble DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);
GO


CREATE TABLE GESTIONATE.inmueble(
	id_inmueble DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	--id_anucio CHAR(10) REFERENCES GESTIONATE.anuncio, HAY QUE REVISAR ESTO
	codigo_inmueble VARCHAR(100),
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
GO

CREATE TABLE GESTIONATE.caracteristica(
	id_caracteristica DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100)
);
GO

CREATE TABLE GESTIONATE.caracteristica_x_inmueble(
	id_inmueble DECIMAL(18,0) REFERENCES GESTIONATE.inmueble,
	id_caracteristica DECIMAL(18,0) REFERENCES GESTIONATE.caracteristica
);
GO

CREATE TABLE GESTIONATE.moneda(
	id_moneda DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.tipo_periodo(
	id_tipo_periodo DECIMAL(18,0) PRIMARY KEY,
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.tipo_operacion(
	id_tipo_operacion DECIMAL(18,0) PRIMARY KEY,
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.estado_anuncio(
	id_estado_anuncio DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.anuncio(
	id_anuncio DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	codigo_anuncio VARCHAR(100),
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
GO

CREATE TABLE GESTIONATE.estado_alquiler(
	id_estado_alquiler DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.inquilino(
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
GO

CREATE TABLE GESTIONATE.alquiler(
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
GO

CREATE TABLE GESTIONATE.medio_de_pago(
	id_medio_de_pago DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.pago_venta(
	id_pago DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	importe NUMERIC(18,2),
	cotizacion NUMERIC(18,2),
	id_moneda DECIMAL(18,0) REFERENCES GESTIONATE.moneda,
	id_medio_de_pago DECIMAL(18,0) REFERENCES GESTIONATE.medio_de_pago
);
GO

CREATE TABLE GESTIONATE.comprador(
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
GO

CREATE TABLE GESTIONATE.venta(
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
GO

CREATE TABLE GESTIONATE.pago_venta_x_venta(
	id_venta DECIMAL(18,0) REFERENCES GESTIONATE.venta,
	id_pago DECIMAL(18,0) REFERENCES GESTIONATE.pago_venta
);
GO

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
	id_medio_de_pago DECIMAL(18,0) REFERENCES GESTIONATE.medio_de_pago,
	CHECK(fecha_inicio_periodo < fecha_fin_periodo)
);
GO

CREATE TABLE GESTIONATE.importe_periodo(
    id_alquiler DECIMAL(18,0) REFERENCES GESTIONATE.alquiler,
	periodo_inicio NUMERIC(18,0),
	periodo_fin NUMERIC(18,0),
	precio NUMERIC(18,2),
	PRIMARY KEY(id_alquiler,periodo_inicio),
	CHECK(periodo_inicio < periodo_fin)
);
GO

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
obtenerAnuncio, obtenerInquilino, ALQUILER_FECHA_INICIO, ALQUILER_FECHA_FIN, obtenerDuracion, ALQUILER_DEPOSITO, ALQUILER_COMISION, ALQUILER_GASTOS_AVERIGUA, ALQUILER_ESTADO, obtenerAgente, obtenerInmueble, obtenerTipoPeriodo, obtenerSucursal



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

CREATE PROCEDURE GESTIONATE.migrar_estado_inmueble AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.estado_inmueble ON
		INSERT INTO GESTIONATE.disposicion(detalle)
		SELECT DISTINCT INMUEBLE_ESTADO FROM gd_esquema.Maestra WHERE INMUEBLE_ESTADO IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.estado_inmueble OFF
END
GO

CREATE PROCEDURE GESTIONATE.migrar_inmueble AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.inmueble ON
		INSERT INTO GESTIONATE.inmueble(codigo_inmueble, nombre, id_tipo_inmueble, descripcion, id_propietario, codigo_direccion, id_ambiente, superficie_total, id_disposicion, id_orientacion, id_estado_inmueble, antiguedad, expensas)
		SELECT DISTINCT INMUEBLE_CODIGO, INMUEBLE_NOMBRE, INMUEBLE_TIPO_INMUEBLE, INMUEBLE_DESCRIPCION, GESTIONATE.OBTENER_ID_PROPIETARIO(PROPIETARIO_DNI), INMUEBLE_DIRECCION, INMUEBLE_CANT_AMBIENTES, INMUEBLE_SUPERFICIETOTAL, INMUEBLE_DISPOSICION, INMUEBLE_ORIENTACION, INMUEBLE_ESTADO, INMUEBLE_ANTIGUEDAD, INMUEBLE_EXPESAS FROM gd_esquema.Maestra WHERE PROPIETARIO_DNI IS NOT NULL
	SET IDENTITY_INSERT GESTIONATE.inmueble OFF
END
GO

CREATE TABLE GESTIONATE.caracteristica(
	id_caracteristica DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100)
);
GO

CREATE TABLE GESTIONATE.caracteristica_x_inmueble(
	id_inmueble DECIMAL(18,0) REFERENCES GESTIONATE.inmueble,
	id_caracteristica DECIMAL(18,0) REFERENCES GESTIONATE.caracteristica
);
GO

CREATE TABLE GESTIONATE.moneda(
	id_moneda DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.tipo_periodo(
	id_tipo_periodo DECIMAL(18,0) PRIMARY KEY,
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.tipo_operacion(
	id_tipo_operacion DECIMAL(18,0) PRIMARY KEY,
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.estado_anuncio(
	id_estado_anuncio DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);
GO

/*CREATE TABLE GESTIONATE.anuncio(
	id_anuncio DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	codigo_anuncio VARCHAR(100),
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
GO*/

CREATE TABLE GESTIONATE.estado_alquiler(
	id_estado_alquiler DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.inquilino(
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
GO

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

CREATE PROCEDURE GESTIONATE.migrar_alquiler AS
BEGIN
	SET IDENTITY_INSERT GESTIONATE.alquiler ON
		INSERT INTO GESTIONATE.alquiler(codigo_alquiler, id_anuncio, fecha_inicio, fecha_fin, duracion, deposito, comision, gastos_averiguaciones, id_estado_alquiler, id_agente, id_inmueble, id_tipo_periodo, id_sucursal)
		SELECT DISTINCT ALQUILER_CODIGO, obtenerAnuncio, obtenerInquilino, ALQUILER_FECHA_INICIO, ALQUILER_FECHA_FIN, obtenerDuracion, ALQUILER_DEPOSITO, ALQUILER_COMISION, ALQUILER_GASTOS_AVERIGUA, ALQUILER_ESTADO, obtenerAgente, obtenerInmueble, obtenerTipoPeriodo, obtenerSucursal FROM gd_esquema.Maestra WHERE PROPIETARIO_DNI IS NOT NULL
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

/*CREATE TABLE GESTIONATE.importe_periodo(
    id_alquiler DECIMAL(18,0) REFERENCES GESTIONATE.alquiler,
	periodo_inicio NUMERIC(18,0),
	periodo_fin NUMERIC(18,0),
	precio NUMERIC(18,2),
	PRIMARY KEY(id_alquiler,periodo_inicio),
	CHECK(periodo_inicio < periodo_fin)
);
GO*/
