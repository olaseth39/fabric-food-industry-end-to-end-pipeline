CREATE OR ALTER PROCEDURE edw.DynamicWarehouseLoad
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    -- 1. Dynamically build all the DROP and CREATE statements into one string
    SELECT @SQL = STRING_AGG(
        'IF OBJECT_ID(''edw.[' + TABLE_NAME + ']'', ''U'') IS NOT NULL DROP TABLE edw.[' + TABLE_NAME + ']; ' +
        'CREATE TABLE edw.[' + TABLE_NAME + '] AS SELECT * FROM LH_Silver.[' + TABLE_SCHEMA + '].[' + TABLE_NAME + '];',
        ' '
    )
    FROM LH_Silver.information_schema.tables 
    WHERE TABLE_TYPE = 'BASE TABLE';

    -- 2. Print the script so you can see what it's doing (optional)
    PRINT @SQL;

    -- 3. Execute the generated script all at once
    EXEC sp_executesql @SQL;
END;
