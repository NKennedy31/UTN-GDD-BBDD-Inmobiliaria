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
	detalle VARCHAR(100) NOT NULL,
	codigo_barrio DECIMAL(18,0) REFERENCES GESTIONATE.barrio,
	codigo_localidad DECIMAL(18,0) REFERENCES GESTIONATE.localidad,
	codigo_provincia DECIMAL(18,0) REFERENCES GESTIONATE.provincia
);
GO

CREATE TABLE GESTIONATE.sucursal(
	id_sucursal DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	codigo_sucursal VARCHAR(100),
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
	id_anuncio DECIMAL(18,0),
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
	id_tipo_periodo DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.tipo_operacion(
	id_tipo_operacion DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
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

ALTER TABLE GESTIONATE.inmueble
ADD CONSTRAINT Inmueble_FK_Anuncio
FOREIGN KEY (id_anuncio)
REFERENCES GESTIONATE.anuncio(id_anuncio);

CREATE TABLE GESTIONATE.estado_alquiler(
	id_estado_alquiler DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	detalle VARCHAR(100) NOT NULL
);
GO

CREATE TABLE GESTIONATE.inquilino(
	id_inquilino DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(100),
	apellido VARCHAR(100),
	numero_doc VARCHAR(100),
	tipo_doc CHAR(3),
	telefono VARCHAR(50),
	mail VARCHAR(100),
	fecha_nacimiento DATE,
	fecha_registro DATETIME
);
GO

CREATE TABLE GESTIONATE.alquiler(
	id_alquiler DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	codigo_alquiler DECIMAL(18,0),
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
    codigo_venta DECIMAL(18,0),
    id_anuncio DECIMAL(18,0) REFERENCES GESTIONATE.anuncio,
    id_agente DECIMAL(18,0) REFERENCES GESTIONATE.agente,
    id_comprador DECIMAL(18,0) REFERENCES GESTIONATE.comprador,
    fecha_venta DATETIME,
    precio_venta NUMERIC(18,2),
    id_moneda DECIMAL(18,0) REFERENCES GESTIONATE.moneda,
    comision_inmobiliaria NUMERIC(18,2),
);
GO

CREATE TABLE GESTIONATE.pago_venta(
	id_pago DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	id_venta DECIMAL(18,0) REFERENCES GESTIONATE.venta,
	importe NUMERIC(18,2),
	cotizacion NUMERIC(18,2),
	id_moneda DECIMAL(18,0) REFERENCES GESTIONATE.moneda,
	id_medio_de_pago DECIMAL(18,0) REFERENCES GESTIONATE.medio_de_pago
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