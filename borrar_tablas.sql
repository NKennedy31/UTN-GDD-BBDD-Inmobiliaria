--Borra las tablas del schema 'GESTIONATE'
--Correr cuantas veces sea necesario (funciona medio como el culo)
--El borrazo es a fuerza bruta, se deshabilitan todas las protecciones para hacerlo asi que
--recomiendo no modificar.
--																		Mateo.
USE [GD2C2023]
GO
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

DECLARE @sql NVARCHAR(max)=''

SELECT @sql += ' Drop table ' + QUOTENAME(TABLE_SCHEMA) + '.'+ QUOTENAME(TABLE_NAME) + '; '
FROM   INFORMATION_SCHEMA.TABLES
WHERE  TABLE_TYPE = 'BASE TABLE'
AND TABLE_SCHEMA = 'GESTIONATE'

Exec Sp_executesql @sql

EXEC sp_msforeachtable "ALTER TABLE ? CHECK CONSTRAINT all"