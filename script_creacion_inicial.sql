USE [GD2C2023]
GO

-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 2--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- Esta sección consiste en la creeación del Esquema, Tablas y sus respectivos Constraints
-- Dado que es posible que eventualmente se quieran crear tablas que referencian tablas que aún no fueron creadas
-- Las Foreign Keys son declaradas posteriormente mediante Alter Tables.


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

CREATE TABLE GESTIONATE.inmueble(
	id_inmueble CHAR(10) PRIMARY KEY,
	--id_anucio CHAR(10) REFERENCES GESTIONATE.anuncio, HAY QUE REVISAR ESTO
	id_tipo_tipo_inmueble CHAR(3) REFERENCES GESTIONATE.tipo_inmueble,
	descripcion VARCHAR(100),
	id_propietario CHAR(10) REFERENCES GESTIONATE.propietario,
	id_direccion CHAR(10) REFERENCES GESTIONATE.direccion,
	ambientes VARCHAR(100),
	superficie_total NUMERIC(18,2),
	id_disposicion CHAR(3) REFERENCES GESTIONATE.disposicion,
	id_orientacion CHAR(3) REFERENCES GESTIONATE.orientacion,
	id_estado_inmueble CHAR(3) REFERENCES GESTIONATE.estado_inmueble,
	antiguedad DATE,
	expensas NUMERIC(18,2)
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
	id_inmueble CHAR(3) REFERENCES GESTIONATE.inmueble,
	precio NUMERIC(18,2) NOT NULL,
	id_moneda CHAR(3) REFERENCES GESTIONATE.moneda,
	id_tipo_periodo CHAR(3) REFERENCES GESTIONATE.tipo_periodo,
	id_estado_anuncio CHAR(3) REFERENCES GESTIONATE.estado_anuncio,
	fecha_publicacion DATETIME NOT NULL,
	fecha_finalizacion DATETIME NOT NULL,
	costo_publicacion NUMERIC(18,2) NOT NULL
);
GO
