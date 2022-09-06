IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WriteToFile]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[WriteToFile]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==================================================
-- Name: WriteToFile
-- Description: Writes the passed in text to the specified file
-- Code Source: http://stackoverflow.com/a/37890783
-- --------------------------------------------------
-- Tables/Views: 
-- --------------------------------------------------
-- Procedures:	sp_OACreate
--				sp_OAMethod
--				sp_OADestroy
-- --------------------------------------------------
-- Rev  Date        By					Description
-- 000  2015-12-03  Daniel Manbeck		(dmanbeck@cssi.com)
--
-- ==================================================

CREATE PROCEDURE [dbo].[WriteToFile]
	@File AS VARCHAR(2000)
	, @Text AS VARCHAR(MAX)
AS
BEGIN 
	DECLARE @OLE AS INT;
	DECLARE @FileID AS INT;
	DECLARE @Folder AS VARCHAR(2000)
	DECLARE @openTextError AS INT;
	DECLARE @folderExists AS INT;
	DECLARE @writeLineError AS INT;
	
	SET @File = REPLACE(@File,'\','/') 

	SET @Folder = LEFT(@File, LEN(@File) - CHARINDEX('/',REVERSE(@File)))

	EXEC master.dbo.xp_fileexist @Folder, @folderExists OUT; 
	IF @folderExists = 0 EXEC master.sys.xp_create_subdir @Folder;

	EXECUTE sp_OACreate 'Scripting.FileSystemObject', @OLE OUT;

	-- open the file
	EXECUTE @openTextError = sp_OAMethod @OLE, 'OpenTextFile', @FileID OUT, @File, 2, 1;

	-- write content to the file
	EXECUTE @writeLineError = sp_OAMethod @FileID, 'WriteLine', NULL, @Text;

	-- clean up
	EXECUTE sp_OADestroy @FileID;
	EXECUTE sp_OADestroy @OLE;

	IF @openTextError <> 0 
	BEGIN
		DECLARE @openTextHex AS VARCHAR(1000) = '0x' + CONVERT(VARCHAR(1000), CONVERT(VARBINARY(8), @openTextError), 2);
		RAISERROR('Error %s opening file.', 16, 1, @openTextHex)
		RETURN
	END

	IF @writeLineError <> 0
	BEGIN
		DECLARE @writeLineHex AS VARCHAR(1000) = '0x' + CONVERT(VARCHAR(1000), CONVERT(VARBINARY(8), @writeLineError), 2);
		RAISERROR('Error %s writing line.', 16, 1, @writeLineHex)
		RETURN
	END
END 
GO