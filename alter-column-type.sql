IF EXISTS(SELECT name FROM SYSOBJECTS WHERE name = '__TableName__' AND xtype='U')
BEGIN
  DECLARE @name VARCHAR(100) = (
    SELECT TOP 1 name
    FROM SYSOBJECTS
    WHERE name LIKE 'DF\_\_%' ESCAPE '\' AND xtype='D' AND id=(SELECT TOP 1 cdefault FROM SYSCOLUMNS WHERE id=OBJECT_ID('__TableName__') AND name='__ColumnName__')
  );

  IF(@name IS NOT NULL)
  BEGIN
    EXEC('ALTER TABLE [DBO].[__TableName__] DROP CONSTRAINT ' + @name);
    EXEC('ALTER TABLE [DBO].[__TableName__] ALTER COLUMN [__ColumnName__] TEXT NULL');
  END;
  ELSE
  BEGIN
    ALTER TABLE [DBO].[__TableName__] ALTER COLUMN [__ColumnName__] TEXT NULL;
  END;
END;

-- 将__TableName__和__ColumnName__替换你的表名和字段名