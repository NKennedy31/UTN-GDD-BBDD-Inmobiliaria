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
	id_provincia CHAR(10) PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
);
GO

CREATE TABLE GESTIONATE.localidad(
	id_localidad CHAR(10) PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	id_provincia CHAR(10) REFERENCES GESTIONATE.provincia,
);
GO

CREATE TABLE GESTIONATE.barrio(
	id_barrio CHAR(10) PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	id_localidad CHAR(10) REFERENCES GESTIONATE.localidad,
);
GO

CREATE TABLE GESTIONATE.direccion(
	id_direccion CHAR(10) PRIMARY KEY,
	calle VARCHAR(100) NOT NULL,
	numero NUMERIC(18,0) NOT NULL,
	piso CHAR(10) NOT NULL,
	departamento CHAR(10) NOT NULL,
	id_barrio CHAR(10) REFERENCES GESTIONATE.barrio,
	id_localidad CHAR(10) REFERENCES GESTIONATE.localidad,
	id_provincia CHAR(10) REFERENCES GESTIONATE.provincia
);
GO
---------------------------------------------------------------
---------------------------------------------------------------
CREATE TABLE GESTIONATE.sucursal(
	id_sucursal CHAR(10) PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	direccion CHAR(10) REFERENCES GESTIONATE.direccion,
	telefono VARCHAR(100) NOT NULL,
);
GO

CREATE TABLE GESTIONATE.agente(
	id_agente CHAR(10) PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	numero_doc VARCHAR(100) NOT NULL,
	tipo_doc CHAR(3) NOT NULL,
	telefono VARCHAR(100) NOT NULL,
	mail VARCHAR(100) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	fecha_registro DATETIME NOT NULL,
	id_sucursal CHAR(10) REFERENCES GESTIONATE.sucursal
);
GO

CREATE TABLE GESTIONATE.tipo_inmueble(
	id_tipo_inmueble CHAR(3) PRIMARY KEY,
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.ambiente(
	id_ambiente CHAR(10) PRIMARY KEY,
	cantidad_ambientes VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.propietario(
	id_propietario CHAR(10) PRIMARY KEY,
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
	id_orientacion CHAR(3) PRIMARY KEY,
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.disposicion(
	id_disposicion CHAR(3) PRIMARY KEY,
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.estado_inmueble(
	id_estado_inmueble CHAR(3) PRIMARY KEY,
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.inmueble(
	id_inmueble CHAR(10) PRIMARY KEY,
	--id_anucio CHAR(10) REFERENCES GESTIONATE.anuncio, HAY QUE REVISAR ESTO
	id_tipo_tipo_inmueble CHAR(3) REFERENCES GESTIONATE.tipo_inmueble,
	descripcion VARCHAR(100),
	id_propietario CHAR(10) REFERENCES GESTIONATE.propietario,
	id_direccion CHAR(10) REFERENCES GESTIONATE.direccion,
	id_ambiente CHAR(10) REFERENCES GESTIONATE.ambiente,
	superficie_total NUMERIC(18,2),
	id_disposicion CHAR(3) REFERENCES GESTIONATE.disposicion,
	id_orientacion CHAR(3) REFERENCES GESTIONATE.orientacion,
	id_estado_inmueble CHAR(3) REFERENCES GESTIONATE.estado_inmueble,
	antiguedad DATE,
	expensas NUMERIC(18,2)
);
GO

CREATE TABLE GESTIONATE.caracteristica(
	id_caracteristica CHAR(3) PRIMARY KEY,
	detalle VARCHAR(100)
);
GO

CREATE TABLE GESTIONATE.caracteristica_x_inmueble(
	id_inmueble CHAR(10) REFERENCES GESTIONATE.inmueble,
	id_caracteristica CHAR(3) REFERENCES GESTIONATE.caracteristica
);
GO

CREATE TABLE GESTIONATE.moneda(
	id_moneda CHAR(3) PRIMARY KEY,
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.tipo_periodo(
	id_tipo_periodo CHAR(3) PRIMARY KEY,
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.tipo_operacion(
	id_tipo_operacion CHAR(3) PRIMARY KEY,
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.estado_anuncio(
	id_estado_anuncio CHAR(3) PRIMARY KEY,
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.anuncio(
	id_anuncio CHAR(10) PRIMARY KEY,
	id_agente CHAR(10) REFERENCES GESTIONATE.agente,
	id_tipo_operacion CHAR(3) REFERENCES GESTIONATE.tipo_operacion,
	id_inmueble CHAR(10) REFERENCES GESTIONATE.inmueble,
	precio NUMERIC(18,2) NOT NULL,
	id_moneda CHAR(3) REFERENCES GESTIONATE.moneda,
	id_tipo_periodo CHAR(3) REFERENCES GESTIONATE.tipo_periodo,
	id_estado_anuncio CHAR(3) REFERENCES GESTIONATE.estado_anuncio,
	fecha_publicacion DATETIME NOT NULL,
	fecha_finalizacion DATETIME NOT NULL,
	costo_publicacion NUMERIC(18,2) NOT NULL
);
GO

CREATE TABLE GESTIONATE.estado_alquiler(
	id_estado_alquiler CHAR(3) PRIMARY KEY,
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.inquilino(
	id_inquilino CHAR(10) PRIMARY KEY,
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
	id_alquiler CHAR(10) PRIMARY KEY,
	id_anuncio CHAR(10) REFERENCES GESTIONATE.anuncio,
	id_inquilino CHAR(10) REFERENCES GESTIONATE.inquilino,
	fecha_inicio DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
	duracion NUMERIC(18,2) NOT NULL,
	deposito NUMERIC(18,2) NOT NULL,
	comision NUMERIC(18,2) NOT NULL,
	gastos_averiguaciones NUMERIC(18,2) NOT NULL,
	id_estado_alquiler CHAR(3) REFERENCES GESTIONATE.estado_alquiler,
	id_agente CHAR(10) REFERENCES GESTIONATE.agente,
	id_inmueble CHAR(10) REFERENCES GESTIONATE.inmueble,
	id_tipo_periodo CHAR(3) REFERENCES GESTIONATE.tipo_periodo,
	id_sucursal CHAR(10) REFERENCES GESTIONATE.sucursal
);
GO

CREATE TABLE GESTIONATE.medio_de_pago(
	id_medio_de_pago CHAR(3) PRIMARY KEY,
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.pago_venta(
	id_pago CHAR(10) PRIMARY KEY,
	importe NUMERIC(18,2),
	cotizacion NUMERIC(18,2),
	id_moneda CHAR(3) REFERENCES GESTIONATE.moneda,
	id_medio_de_pago CHAR(3) REFERENCES GESTIONATE.medio_de_pago
);
GO

CREATE TABLE GESTIONATE.comprador(
	id_comprador CHAR(10) PRIMARY KEY,
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
	id_venta CHAR(10) PRIMARY KEY,
	id_anuncio CHAR(10) REFERENCES GESTIONATE.anuncio,
	id_agente CHAR(10) REFERENCES GESTIONATE.agente,
	id_comprador CHAR(10) REFERENCES GESTIONATE.comprador,
	fecha_venta DATETIME,
	precio_venta NUMERIC(18,2),
	id_moneda CHAR(3) REFERENCES GESTIONATE.moneda,
	id_pago CHAR(10) REFERENCES GESTIONATE.pago_venta, --revisar
	comision_inmobiliaria NUMERIC(18,2),
);
GO

CREATE TABLE GESTIONATE.pago_venta_x_venta(
	id_venta CHAR(10) REFERENCES GESTIONATE.venta,
	id_pago CHAR(10) REFERENCES GESTIONATE.pago_venta
);
GO

CREATE TABLE GESTIONATE.pago_alquiler(
    id_pago CHAR(10) PRIMARY KEY,
	id_alquiler CHAR(10) REFERENCES GESTIONATE.alquiler,
	id_inquilino CHAR(10) REFERENCES GESTIONATE.inquilino,
	fecha_pago DATETIME,
	nro_periodo_pago NUMERIC(18,0) NOT NULL,
	descrip_periodo VARCHAR(100),
	fecha_inicio_periodo DATETIME,
	fecha_fin_periodo DATETIME,
	importe NUMERIC(18,2),
	id_medio_de_pago CHAR(3) REFERENCES GESTIONATE.medio_de_pago,
	CHECK(fecha_inicio_periodo < fecha_fin_periodo)
);
GO

CREATE TABLE GESTIONATE.importe_periodo(
    id_alquiler CHAR(10) REFERENCES GESTIONATE.alquiler,
	periodo_inicio NUMERIC(18,0),
	periodo_fin NUMERIC(18,0),
	precio NUMERIC(18,2),
	PRIMARY KEY(id_alquiler,periodo_inicio),
	CHECK(periodo_inicio < periodo_fin)
);
GO
