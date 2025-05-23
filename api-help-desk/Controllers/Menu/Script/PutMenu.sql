DECLARE
    @id UNIQUEIDENTIFIER = @id_parameter,
    @name NVARCHAR(100) = @name_parameter,                      
    @task_id UNIQUEIDENTIFIER = @task_id_parameter;

DECLARE @outputTable TABLE (
    id UNIQUEIDENTIFIER,
    name NVARCHAR(100)
);

MERGE INTO [security].menu AS target
USING (SELECT @id AS id) AS source
ON target.id = source.id
WHEN MATCHED THEN
    UPDATE SET 
        target.[name] = @name,           
        target.task_id = @task_id
    OUTPUT inserted.id, inserted.name INTO @outputTable;

/*Devolver el registro actualizado o insertado*/
SELECT 
    O.id AS menu_id, 
    O.name AS menu_name,         
    0 AS hashtag
FROM @outputTable AS O    