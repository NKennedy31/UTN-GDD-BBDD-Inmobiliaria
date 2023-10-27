--Borra las tablas del schema 'GESTIONATE'
--Correr cuantas veces sea necesario (funciona medio como el culo)
--El borrazo es a fuerza bruta, se deshabilitan todas las protecciones para hacerlo asi que
--recomiendo no modificar.
--																		Mateo.
USE [GD2C2023]
GO
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_NAME = 'Inmueble_FK_Anuncio')
BEGIN
    ALTER TABLE GESTIONATE.inmueble
    DROP CONSTRAINT Inmueble_FK_Anuncio;
END

DECLARE @sql NVARCHAR(max)=''

SELECT @sql += ' Drop table ' + QUOTENAME(TABLE_SCHEMA) + '.'+ QUOTENAME(TABLE_NAME) + '; '
FROM   INFORMATION_SCHEMA.TABLES
WHERE  TABLE_TYPE = 'BASE TABLE'
AND TABLE_SCHEMA = 'GESTIONATE'

Exec Sp_executesql @sql

EXEC sp_msforeachtable "ALTER TABLE ? CHECK CONSTRAINT all"