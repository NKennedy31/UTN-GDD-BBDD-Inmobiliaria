DROP TABLE IF EXISTS dim_tiempo
GO
CREATE TABLE dim_tiempo( 
id_tiempo DECIMAL(18,0) PRIMARY KEY,
anio INT,
cuatrimestre INT,
mes INT
)
GO
DROP TABLE IF EXISTS dim_ubicacion
GO
CREATE TABLE dim_ubicacion( 
id_ubicacion DECIMAL(18,0) PRIMARY KEY,
provincia VARCHAR(100),
barrio VARCHAR(100),
localidad VARCHAR(100)
)
GO
DROP TABLE IF EXISTS dim_sucursal
GO
CREATE TABLE dim_sucursal( 
id_sucursal DECIMAL(18,0) PRIMARY KEY,
nombre VARCHAR(100),
telefono VARCHAR(100),
detalle VARCHAR(100)
)
GO
DROP TABLE IF EXISTS dim_rango_etario
GO
CREATE TABLE dim_rango_etario( 
id_rango_etario DECIMAL(18,0) PRIMARY KEY,
descripcion VARCHAR(100)
)
GO
DROP TABLE IF EXISTS dim_tipo_inmueble
GO
CREATE TABLE dim_tipo_inmueble( 
id_tipo_inmueble DECIMAL(18,0) PRIMARY KEY,
descripcion VARCHAR(100)
)
GO
DROP TABLE IF EXISTS dim_ambiente
GO
CREATE TABLE dim_ambiente( 
id_ambiente DECIMAL(18,0) PRIMARY KEY,
descripcion VARCHAR(100)
)
GO
DROP TABLE IF EXISTS dim_rango_m2
GO
CREATE TABLE dim_rango_m2( 
id_rango_m2 DECIMAL(18,0) PRIMARY KEY,
descripcion VARCHAR(100)
)
GO
DROP TABLE IF EXISTS dim_tipo_operacion
GO
CREATE TABLE dim_tipo_operacion( 
id_tipo_operacion DECIMAL(18,0) PRIMARY KEY,
descripcion VARCHAR(100)
)
GO
DROP TABLE IF EXISTS dim_tipo_moneda
GO
CREATE TABLE dim_tipo_moneda( 
id_tipo_moneda DECIMAL(18,0) PRIMARY KEY,
descripcion VARCHAR(100)
)
GO
DROP TABLE IF EXISTS hecho
CREATE TABLE hecho(
id_tiempo DECIMAL(18,0) FOREIGN KEY REFERENCES dim_tiempo,
id_ubicacion DECIMAL(18,0) FOREIGN KEY REFERENCES dim_ubicacion,
id_sucursal DECIMAL(18,0) FOREIGN KEY REFERENCES dim_sucursal,
id_rango_etario DECIMAL(18,0) FOREIGN KEY REFERENCES dim_rango_etario,
id_tipo_inmueble DECIMAL(18,0) FOREIGN KEY REFERENCES dim_tipo_inmueble,
id_ambiente DECIMAL(18,0) FOREIGN KEY REFERENCES dim_ambiente,
id_rango_m2 DECIMAL(18,0) FOREIGN KEY REFERENCES dim_rango_m2,
id_tipo_operacion DECIMAL(18,0) FOREIGN KEY REFERENCES dim_tipo_operacion,
id_tipo_moneda DECIMAL(18,0) FOREIGN KEY REFERENCES dim_tipo_moneda,
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
