DECLARE @ConstraintName nvarchar(200);

SELECT @ConstraintName = Name
FROM SYS.DEFAULT_CONSTRAINTS
WHERE PARENT_OBJECT_ID = OBJECT_ID('__TableName__')
  AND PARENT_COLUMN_ID = (
    SELECT column_id
    FROM SYS.COLUMNS
    WHERE NAME = N'__ColumnName__'
      AND object_id = OBJECT_ID(N'__TableName__')
  );
IF @ConstraintName IS NOT NULL
BEGIN
  EXEC('ALTER TABLE __TableName__ DROP CONSTRAINT ' + @ConstraintName);
END

-- PS：将__TableName__和__ColumnName__替换你的表名和字段名