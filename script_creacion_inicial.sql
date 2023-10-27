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

-- OBTENER_PROPIETARIO --> Retorna el ID de un fabricante dado un nombre.
CREATE FUNCTION GESTIONATE.OBTENER_PROPIETARIO(@dni NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_propietario DECIMAL(18,0);

	SELECT @id_propietario = id_propietario FROM GESTIONATE.propietario WHERE numero_doc = @dni;

	RETURN @id_propietario;
END
GO

-- OBTENER_ANUNCIO --> Retorna el ID de un anuncio dado un codigo.
CREATE FUNCTION GESTIONATE.OBTENER_ANUNCIO(@codigo NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_anuncio DECIMAL(18,0);

	SELECT @id_anuncio = id_anuncio FROM GESTIONATE.anuncio WHERE codigo_anuncio = @codigo;

	RETURN @id_anuncio;
END
GO

-- OBTENER_INQUILINO --> Retorna el ID de un inquilino dado un numero de documento.
CREATE FUNCTION GESTIONATE.OBTENER_INQUILINO(@dni NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_inquilino DECIMAL(18,0);

	SELECT @id_inquilino = id_inquilino FROM GESTIONATE.inquilino WHERE numero_doc = @dni;

	RETURN @id_inquilino;
END
GO

 -- OBTENER_AGENTE --> Retorna el ID de un agente dado un numero de documento.

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

CREATE FUNCTION GESTIONATE.OBTENER_ESTADO_ALQUILER(@detalle NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id_estado DECIMAL(18,0);

	SELECT @id_estado = id_estado_alquiler FROM GESTIONATE.estado_alquiler WHERE detalle = @detalle;

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

CREATE FUNCTION GESTIONATE.OBTENER_LOCALIDAD(@nombre NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id DECIMAL(18,0);

	SELECT @id = id_localidad FROM GESTIONATE.localidad WHERE nombre = @nombre;

	RETURN @id;
	
END
GO

CREATE FUNCTION GESTIONATE.OBTENER_PROVINCIA(@nombre NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id DECIMAL(18,0);

	SELECT @id = id_provincia FROM GESTIONATE.provincia WHERE nombre = @nombre;

	RETURN @id;
	
END
GO

CREATE FUNCTION GESTIONATE.OBTENER_BARRIO(@nombre NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id DECIMAL(18,0);

	SELECT @id = id_barrio FROM GESTIONATE.barrio WHERE nombre = @nombre;

	RETURN @id;
	
END
GO

CREATE FUNCTION GESTIONATE.OBTENER_ALQUILER(@codigo_alquiler NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id DECIMAL(18,0);

	SELECT @id = id_alquiler FROM GESTIONATE.alquiler WHERE codigo_alquiler = @codigo_alquiler;

	RETURN @id;
	
END
GO

CREATE FUNCTION GESTIONATE.OBTENER_MEDIO_DE_PAGO(@detalle NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

	DECLARE @id DECIMAL(18,0);

	SELECT @id = id_medio_de_pago FROM GESTIONATE.medio_de_pago WHERE detalle = @detalle;

	RETURN @id;
	
END
GO

CREATE FUNCTION GESTIONATE.OBTENER_COMPRADOR(@dni NVARCHAR(255)) RETURNS DECIMAL(18,0) AS
BEGIN

    DECLARE @id_comprador DECIMAL(18,0);

    SELECT @id_comprador = id_comprador FROM GESTIONATE.comprador WHERE numero_doc = @dni;

    RETURN @id_comprador;
END
GO





-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 4--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- En esta sección se declaran las Stored Procedures para luego poder realizar la migración
-- Una Stored Procedure por cada tabla.
-- El nombre de la Stored Procedure especifica qué tabla se está migrando
-- Toda tabla cuya Primary Key es Identity, debe tener en su migración la sentencia que permite inserción de identities.

-- PROVINCIA
CREATE PROCEDURE GESTIONATE.migrar_provincia AS
BEGIN
		INSERT INTO GESTIONATE.provincia (nombre)
			SELECT DISTINCT INMUEBLE_PROVINCIA FROM gd_esquema.Maestra WHERE INMUEBLE_PROVINCIA IS NOT NULL
			UNION
			SELECT DISTINCT SUCURSAL_PROVINCIA FROM gd_esquema.Maestra WHERE SUCURSAL_PROVINCIA IS NOT NULL
END
GO

-- LOCALIDAD
CREATE PROCEDURE GESTIONATE.migrar_localidad AS
BEGIN
	    INSERT INTO GESTIONATE.localidad (nombre, codigo_provincia)
			SELECT DISTINCT INMUEBLE_LOCALIDAD, INMUEBLE_PROVINCIA FROM gd_esquema.Maestra WHERE INMUEBLE_LOCALIDAD IS NOT NULL
			UNION
			SELECT DISTINCT SUCURSAL_LOCALIDAD, SUCURSAL_PROVINCIA FROM gd_esquema.Maestra WHERE SUCURSAL_LOCALIDAD IS NOT NULL
END
GO 

-- BARRIO
CREATE PROCEDURE GESTIONATE.migrar_barrio AS
BEGIN
	INSERT INTO GESTIONATE.barrio (nombre, codigo_localidad)
		SELECT DISTINCT INMUEBLE_BARRIO, INMUEBLE_LOCALIDAD FROM gd_esquema.Maestra WHERE INMUEBLE_BARRIO IS NOT NULL
END
GO

-- DIRECCION
CREATE PROCEDURE GESTIONATE.migrar_direccion AS
BEGIN
	INSERT INTO GESTIONATE.direccion (detalle)
		SELECT DISTINCT SUCURSAL_DIRECCION FROM gd_esquema.Maestra WHERE SUCURSAL_DIRECCION IS NOT NULL
		UNION
		SELECT DISTINCT INMUEBLE_DIRECCION FROM gd_esquema.Maestra WHERE INMUEBLE_DIRECCION IS NOT NULL
END
GO

-- SUCURSAL
CREATE PROCEDURE GESTIONATE.migrar_sucursal AS
BEGIN
	INSERT INTO GESTIONATE.sucursal (codigo_sucursal, nombre, codigo_direccion, telefono)
	SELECT DISTINCT SUCURSAL_CODIGO, SUCURSAL_NOMBRE, SUCURSAL_DIRECCION, SUCURSAL_TELEFONO FROM gd_esquema.Maestra WHERE SUCURSAL_CODIGO IS NOT NULL
END
GO

-- AGENTE
CREATE PROCEDURE GESTIONATE.migrar_agente AS
BEGIN
		INSERT INTO GESTIONATE.agente (nombre, apellido, numero_doc, fecha_registro, fecha_nacimiento, telefono, mail)
		SELECT DISTINCT AGENTE_NOMBRE, AGENTE_APELLIDO, AGENTE_DNI, AGENTE_FECHA_REGISTRO, AGENTE_FECHA_NAC, AGENTE_TELEFONO, AGENTE_MAIL FROM gd_esquema.Maestra WHERE AGENTE_DNI IS NOT NULL
END
GO

-- TIPO_INMUEBLE
CREATE PROCEDURE GESTIONATE.migrar_tipo_inmueble AS
BEGIN
	INSERT INTO GESTIONATE.tipo_inmueble(detalle)
	SELECT DISTINCT INMUEBLE_TIPO_INMUEBLE FROM gd_esquema.Maestra WHERE INMUEBLE_TIPO_INMUEBLE IS NOT NULL
END
GO

-- AMBIENTE
CREATE PROCEDURE GESTIONATE.migrar_ambiente AS
BEGIN
	INSERT INTO GESTIONATE.ambiente (detalle)
	SELECT DISTINCT INMUEBLE_CANT_AMBIENTES FROM gd_esquema.Maestra WHERE INMUEBLE_CANT_AMBIENTES IS NOT NULL
END
GO

-- PROPIETARIO
CREATE PROCEDURE GESTIONATE.migrar_propietario AS
BEGIN
	INSERT INTO GESTIONATE.propietario(nombre, apellido, numero_doc, fecha_registro, fecha_nacimiento, telefono, mail)
	SELECT DISTINCT PROPIETARIO_NOMBRE, PROPIETARIO_APELLIDO, PROPIETARIO_DNI, PROPIETARIO_FECHA_REGISTRO, PROPIETARIO_FECHA_NAC, PROPIETARIO_TELEFONO, PROPIETARIO_MAIL FROM gd_esquema.Maestra WHERE PROPIETARIO_DNI IS NOT NULL
END
GO

-- ORIENTACION
CREATE PROCEDURE GESTIONATE.migrar_orientacion AS
BEGIN
	INSERT INTO GESTIONATE.orientacion(detalle)
	SELECT DISTINCT INMUEBLE_ORIENTACION FROM gd_esquema.Maestra WHERE INMUEBLE_ORIENTACION IS NOT NULL
END
GO

-- DISPOSICION
CREATE PROCEDURE GESTIONATE.migrar_disposicion AS
BEGIN
	INSERT INTO GESTIONATE.disposicion(detalle)
	SELECT DISTINCT INMUEBLE_DISPOSICION FROM gd_esquema.Maestra WHERE INMUEBLE_DISPOSICION IS NOT NULL
END
GO

-- ESTADO_INMUEBLE
CREATE PROCEDURE GESTIONATE.migrar_estado_inmueble AS
BEGIN
	INSERT INTO GESTIONATE.estado_inmueble(detalle)
	SELECT DISTINCT INMUEBLE_ESTADO FROM gd_esquema.Maestra WHERE INMUEBLE_ESTADO IS NOT NULL
END
GO

-- INMUEBLE
CREATE PROCEDURE GESTIONATE.migrar_inmueble AS
BEGIN
	INSERT INTO GESTIONATE.inmueble(codigo_inmueble, nombre, id_tipo_inmueble, descripcion, id_propietario, codigo_direccion, id_ambiente, superficie_total, id_disposicion, id_orientacion, id_estado_inmueble, antiguedad, expensas)
	SELECT DISTINCT INMUEBLE_CODIGO, INMUEBLE_NOMBRE, INMUEBLE_TIPO_INMUEBLE, INMUEBLE_DESCRIPCION, GESTIONATE.OBTENER_PROPIETARIO(PROPIETARIO_DNI), INMUEBLE_DIRECCION, INMUEBLE_CANT_AMBIENTES, INMUEBLE_SUPERFICIETOTAL, INMUEBLE_DISPOSICION, INMUEBLE_ORIENTACION, INMUEBLE_ESTADO, INMUEBLE_ANTIGUEDAD, INMUEBLE_EXPESAS FROM gd_esquema.Maestra WHERE PROPIETARIO_DNI IS NOT NULL
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

-- ALQUILER
CREATE PROCEDURE GESTIONATE.migrar_alquiler AS
BEGIN
	INSERT INTO GESTIONATE.alquiler(codigo_alquiler, id_anuncio, id_inquilino, fecha_inicio, fecha_fin, duracion, deposito, comision, gastos_averiguaciones, id_estado_alquiler, id_agente, id_inmueble, id_tipo_periodo, id_sucursal)
	SELECT DISTINCT ALQUILER_CODIGO, GESTIONATE.OBTENER_ANUNCIO(ANUNCIO_CODIGO), GESTIONATE.OBTENER_INQUILINO(INQUILINO_DNI), ALQUILER_FECHA_INICIO, ALQUILER_FECHA_FIN, ALQUILER_CANT_PERIODOS, ALQUILER_DEPOSITO, ALQUILER_COMISION, ALQUILER_GASTOS_AVERIGUA, GESTIONATE.OBTENER_ESTADO_ALQUILER(ALQUILER_ESTADO), GESTIONATE.OBTENER_AGENTE(AGENTE_DNI), GESTIONATE.OBTENER_INMUEBLE(INMUEBLE_CODIGO), GESTIONATE.OBTENER_TIPO_PERIODO(ANUNCIO_TIPO_PERIODO), GESTIONATE.OBTENER_SUCURSAL(SUCURSAL_CODIGO) FROM gd_esquema.Maestra WHERE ALQUILER_CODIGO IS NOT NULL
END
GO

-- MEDIO_DE_PAGO
CREATE PROCEDURE GESTIONATE.migrar_medio_de_pago AS
BEGIN
	INSERT INTO GESTIONATE.medio_de_pago(detalle)
	SELECT DISTINCT PAGO_ALQUILER_MEDIO_PAGO FROM gd_esquema.Maestra WHERE PAGO_ALQUILER_MEDIO_PAGO IS NOT NULL
	UNION
	SELECT DISTINCT PAGO_VENTA_MEDIO_PAGO FROM gd_esquema.Maestra WHERE PAGO_VENTA_MEDIO_PAGO IS NOT NULL
END
GO

-- PAGO_VENTA
CREATE PROCEDURE GESTIONATE.migrar_pago_venta AS
BEGIN
    INSERT INTO [GESTIONATE].pago_venta
               (importe,cotizacion,id_moneda,id_medio_de_pago)
               SELECT PAGO_VENTA_IMPORTE, PAGO_VENTA_COTIZACION, GESTIONATE.OBTENER_MONEDA(PAGO_VENTA_MONEDA),GESTIONATE.OBTENER_MEDIO_PAGO(PAGO_VENTA_MEDIO_PAGO)
               FROM gd_esquema.Maestra
               WHERE VENTA_CODIGO IS NOT NULL AND 
               (PAGO_VENTA_IMPORTE IS NOT NULL OR PAGO_VENTA_COTIZACION IS NOT NULL OR
               PAGO_VENTA_MEDIO_PAGO IS NOT NULL OR PAGO_VENTA_MONEDA IS NOT NULL)

END
GO

-- COMPRADOR	
CREATE PROCEDURE GESTIONATE.migrar_comprador AS
BEGIN
	INSERT INTO GESTIONATE.comprador(nombre, apellido, numero_doc, tipo_doc, telefono, mail, fecha_nacimiento, fecha_registro)
	SELECT DISTINCT COMPRADOR_NOMBRE, COMPRADOR_APELLIDO, COMPRADOR_DNI, 'DNI', COMPRADOR_TELEFONO, COMPRADOR_MAIL, COMPRADOR_FECHA_NAC, COMPRADOR_FECHA_REGISTRO FROM gd_esquema.Maestra WHERE COMPRADOR_DNI IS NOT NULL;
END
GO

-- VENTA
CREATE PROCEDURE GESTIONATE.migrar_venta AS
BEGIN
    INSERT INTO [GESTIONATE].[venta]
               ([codigo_venta],[id_anuncio],[id_agente],[id_comprador],[fecha_venta],[precio_venta],[id_moneda],[comision_inmobiliaria])
               SELECT DISTINCT VENTA_CODIGO, GESTIONATE.OBTENER_ANUNCIO(ANUNCIO_CODIGO), GESTIONATE.OBTENER_AGENTE(AGENTE_DNI), GESTIONATE.OBTENER_COMPRADOR(COMPRADOR_DNI), VENTA_FECHA, VENTA_PRECIO_VENTA, GESTIONATE.OBTENER_MONEDA(VENTA_MONEDA),VENTA_COMISION FROM gd_esquema.Maestra m
               WHERE VENTA_CODIGO IS NOT NULL;
END
GO

-- PAGO_ALQUILER
CREATE PROCEDURE GESTIONATE.migrar_pago_alquiler AS
BEGIN
	INSERT INTO GESTIONATE.pago_alquiler(id_alquiler, id_inquilino, fecha_pago, nro_periodo_pago, descrip_periodo, fecha_inicio_periodo, fecha_fin_periodo, importe, id_medio_de_pago)
	SELECT GESTIONATE.OBTENER_ALQUILER(ALQUILER_CODIGO), GESTIONATE.OBTENER_INQUILINO(INQUILINO_DNI), PAGO_ALQUILER_FECHA, PAGO_ALQUILER_NRO_PERIODO, PAGO_ALQUILER_DESC, PAGO_ALQUILER_FEC_INI, PAGO_ALQUILER_FEC_FIN, PAGO_ALQUILER_IMPORTE, GESTIONATE.OBTENER_MEDIO_DE_PAGO(PAGO_ALQUILER_MEDIO_PAGO) FROM gd_esquema.Maestra WHERE PAGO_ALQUILER_CODIGO IS NOT NULL;
END

-- IMPORTE_PERIODO
CREATE PROCEDURE GESTIONATE.migrar_importe_periodo AS
BEGIN
    INSERT INTO GESTIONATE.importe_periodo (id_alquiler, periodo_inicio, periodo_fin, precio)
    SELECT a.id_alquiler, m.DETALLE_ALQ_NRO_PERIODO_INI, m.DETALLE_ALQ_NRO_PERIODO_FIN, m.DETALLE_ALQ_PRECIO
  FROM [GD2C2023].[gd_esquema].[Maestra] m
  LEFT JOIN GESTIONATE.alquiler a ON m.ALQUILER_CODIGO = a.codigo_alquiler
  WHERE ALQUILER_CODIGO IS NOT NULL
END