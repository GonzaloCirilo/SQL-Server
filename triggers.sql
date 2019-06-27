USE [cas]
GO

CREATE OR ALTER TRIGGER tr_job_offer_status
ON [job_offer]
FOR INSERT
AS
BEGIN
	DECLARE @insertedId INT
	SET @insertedId = (SELECT id FROM inserted)
	UPDATE job_offer
	SET status_job = 2
	WHERE id = @insertedId
END
GO

INSERT INTO [job_offer] ([name],[description]) VALUES
('convocatoria trigger','programador')
GO

CREATE OR ALTER TRIGGER tr_postular_fecha
ON [user_apply]
FOR INSERT
AS
BEGIN
DECLARE @insertedId INT
	SET @insertedId = (SELECT id FROM inserted)
	UPDATE user_apply
	SET application_date = GETDATE()
	WHERE id = @insertedId
END
GO
INSERT INTO [user_apply] (job_offer_id,[user_id],[application_date]) VALUES
(5,6,GETDATE())
GO