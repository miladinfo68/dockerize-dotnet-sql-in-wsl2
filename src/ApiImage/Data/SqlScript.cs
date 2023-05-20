namespace ApiImage.Data;

public static class SqlScript
{
    public const string CREATE_DATABASE_IF_NOT_EXIST = @"
    USE master
    GO

    IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'miladdb')
    BEGIN
    CREATE DATABASE [miladdb]
    END

    GO
    USE [miladdb]
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
            INSERT INTO [dbo].[Users](Name) VALUES (N'Mahdi Jalali')
        END
    END";
}