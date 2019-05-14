USE [cas]
GO

CREATE FUNCTION fn_number_of_applicants(
@@jobOfferId int)
RETURNS INT
AS
BEGIN
	DECLARE @count INT
	SET @count = (SELECT COUNT(jo.id) FROM [job_offer] jo JOIN user_apply ua ON jo.id = ua.job_offer_id WHERE jo.id = @@jobOfferId GROUP BY jo.id)
	RETURN @count
END	
GO

CREATE FUNCTION fn_n_of_hours(
@@userId INT)
RETURNS INT
AS
BEGIN
	DECLARE @nHours INT
	SET @nHours = (SELECT SUM(c.completed_hours) FROM users u JOIN course c ON u.id = c.[user_id] WHERE u.id = @@userId GROUP BY u.id)
	RETURN @nHours
END
GO

CREATE FUNCTION fn_n_knowledge(
@@userId INT)
RETURNS INT
AS
BEGIN
	RETURN 0
END