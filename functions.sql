USE [cas]
GO

CREATE OR ALTER FUNCTION fn_number_of_applicants(
@@jobOfferId int)
RETURNS INT
AS
BEGIN
	DECLARE @count INT
	SET @count = (SELECT COUNT(jo.id) FROM job_offer jo JOIN user_apply ua ON jo.id = ua.job_offer_id WHERE jo.id = @@jobOfferId GROUP BY jo.id)
	RETURN @count
END	
GO

SELECT dbo.fn_number_of_applicants(3)
Go

CREATE OR ALTER FUNCTION fn_n_of_hours(
@@userId INT)
RETURNS INT
AS
BEGIN
	DECLARE @nHours INT
	SET @nHours = (SELECT SUM(c.completed_hours) FROM users u JOIN course c ON u.id = c.[user_id] WHERE u.id = @@userId GROUP BY u.id)
	RETURN @nHours
END
GO

SELECT dbo.fn_n_of_hours(2)
GO

CREATE OR ALTER FUNCTION fn_n_knowledge(
@@userId INT)
RETURNS INT
AS
BEGIN
	DECLARE @nKnowledge INT
	SET @nKnowledge = (SELECT COUNT(k.id) FROM users u JOIN knowledge k ON u.id = k.[user_id] WHERE u.id = @@userId GROUP BY u.id)
	RETURN @nKnowledge
END
GO

SELECT dbo.fn_n_knowledge(1)
GO