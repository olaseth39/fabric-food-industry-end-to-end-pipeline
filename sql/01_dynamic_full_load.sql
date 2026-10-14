CREATE OR ALTER PROCEDURE edw.DynamicWarehouseLoad
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    -- Read the manifest created by the Notebook!
    SELECT @SQL = STRING_AGG(
        'IF OBJECT_ID(''edw.[' + TableName + ']'', ''U'') IS NOT NULL DROP TABLE edw.[' + TableName + ']; ' +
        'CREATE TABLE edw.[' + TableName + '] AS SELECT * FROM LH_Silver.[' + SchemaName + '].[' + TableName + '];',
        ' '
    )
    FROM LH_Silver.metadata.processed_tables;

    -- Execute the generated script
    EXEC sp_executesql @SQL;
END;
