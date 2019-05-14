USE [cas]
GO

CREATE OR ALTER PROCEDURE sp_sunedu(
@@conv_id INT
)
AS
BEGIN
	SELECT COUNT(d.id) AS 'Titulos en sunedu', u.username, u.[name], u.id FROM job_offer jo 
	JOIN user_apply ua ON jo.id = ua.job_offer_id 
	JOIN users u ON ua.[user_id] = u.id
	JOIN degree d ON d.[user_id] = u.id
	WHERE d.from_sunedu = 1 AND  @@conv_id= jo.id
	GROUP BY  u.username, u.[name], u.id
END
GO
exec sp_sunedu 2
GO