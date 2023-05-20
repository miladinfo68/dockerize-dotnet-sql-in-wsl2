USE master
GO

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'TestDb')
BEGIN
  CREATE DATABASE [TestDb]
END

GO
USE [TestDb]
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Users' and xtype='U')
BEGIN
    CREATE TABLE dbo.Users (
        Id INT PRIMARY KEY IDENTITY (1, 1),
        Name VARCHAR(100)
    );
END;

GO

IF EXISTS (SELECT * FROM sysobjects WHERE name='Users' and xtype='U')
BEGIN
	IF((SELECT COUNT(1) FROM [dbo].[Users])=0)
	BEGIN
		INSERT INTO [dbo].[Users](Name) VALUES 
    (N'Mahdi Jalali'),
    (N'Ali Hassani'),
    (N'Erfan Omidi')
	END
END

GO