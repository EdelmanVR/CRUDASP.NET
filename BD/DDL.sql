USE [CrudDB]
GO
/****** Object:  Table [dbo].[TblCatAcademicDegree]    Script Date: 6/05/2023 13:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblCatAcademicDegree](
	[IdTblCatAcademicDegree] [int] IDENTITY(1,1) NOT NULL,
	[Academiclevel] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TblCatAcademicDegree] PRIMARY KEY CLUSTERED 
(
	[IdTblCatAcademicDegree] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblCatMaritalStatus]    Script Date: 6/05/2023 13:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblCatMaritalStatus](
	[IdTblCatMaritalStatus] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](200) NOT NULL,
	[RowStatus] [bit] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[TokenCreated] [nvarchar](50) NOT NULL,
	[DateUpdate] [datetime] NULL,
	[TokenUpdate] [nvarchar](50) NULL,
 CONSTRAINT [PK_TblCatMaritalStatus] PRIMARY KEY CLUSTERED 
(
	[IdTblCatMaritalStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblEmployees]    Script Date: 6/05/2023 13:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEmployees](
	[IdTblEmployees] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Surname] [nvarchar](100) NOT NULL,
	[DateofBirth] [date] NOT NULL,
	[TblCatMaritalStatusId] [int] NOT NULL,
	[TblCatAcademicDegreeId] [int] NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_TblEmployees] PRIMARY KEY CLUSTERED 
(
	[IdTblEmployees] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TblCatMaritalStatus] ADD  CONSTRAINT [DF_TblCatMaritalStatus_RowStatus]  DEFAULT ((1)) FOR [RowStatus]
GO
/****** Object:  StoredProcedure [dbo].[SPsw_AddNewEmployee]    Script Date: 6/05/2023 13:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Edelman>
-- Create date: <Create Date>,2023-05-06
-- Description:	<Description, Crear Nuevos registros de empleados o colaboradores de la empresa>
-- =============================================
CREATE PROCEDURE [dbo].[SPsw_AddNewEmployee]
@NameEmployee AS NVARCHAR(100),
@SurName AS NVARCHAR(100),
@DateofBirth AS DATE,
@TblCatMaritalStatusId AS INT,
@TblCatAcademicDegreeId AS INT,
@Address AS NVARCHAR(200)

AS
BEGIN

	BEGIN TRANSACTION
	BEGIN TRY


		INSERT INTO [dbo].[TblEmployees] 
		(
		[Name],
		Surname,
		DateofBirth,
		TblCatMaritalStatusId,
		TblCatAcademicDegreeId,
		[Address]
		)
		VALUES
	   (
		@NameEmployee,
		@SurName,
		@DateofBirth,
		@TblCatMaritalStatusId,
		@TblCatAcademicDegreeId,
		@Address
	   )

	   SELECT 1 [Result]

	COMMIT TRANSACTION

	

		
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		
		SELECT
			0 [Result]
		   ,ERROR_MESSAGE() 'Description'
		   ,ERROR_NUMBER() 'ErrorNumber'
		   ,ERROR_SEVERITY() 'ErrorSeverity'
		   ,ERROR_STATE() 'ErrorState'
		   ,ERROR_PROCEDURE() 'ErrorProcedure'
		   ,ERROR_LINE() 'ErrorLine';

		
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[SPsw_DeleteNewEmployee]    Script Date: 6/05/2023 13:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Edelman>
-- Create date: <Create Date>,2023-05-06
-- Description:	<Description, actualizar  registros de empleados o colaboradores de la empresa>
-- =============================================
CREATE PROCEDURE [dbo].[SPsw_DeleteNewEmployee]
@IdTblEmployees AS INT,
@NameEmployee AS NVARCHAR(100),
@SurName AS NVARCHAR(100),
@DateofBirth AS DATE,
@TblCatMaritalStatusId AS INT,
@TblCatAcademicDegreeId AS INT,
@Address AS NVARCHAR(200)

AS
BEGIN


	BEGIN TRY


		UPDATE [dbo].[TblEmployees] 
		SET
				[Name] = @NameEmployee,
				Surname = @SurName,
				DateofBirth = @DateofBirth,
				TblCatMaritalStatusId = @TblCatMaritalStatusId,
				TblCatAcademicDegreeId = @TblCatAcademicDegreeId, 
				[Address] = @Address
		
	   SELECT 1 [Result]
		
	END TRY
	BEGIN CATCH
		
		
		SELECT
			0 [Result]
		   ,ERROR_MESSAGE() 'Description'
		   ,ERROR_NUMBER() 'ErrorNumber'
		   ,ERROR_SEVERITY() 'ErrorSeverity'
		   ,ERROR_STATE() 'ErrorState'
		   ,ERROR_PROCEDURE() 'ErrorProcedure'
		   ,ERROR_LINE() 'ErrorLine';

		
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[SPsw_GetEmployee]    Script Date: 6/05/2023 13:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Edelman>
-- Create date: <Create Date>,2023-05-06
-- Description:	<Description, obtener  registros de empleados o colaboradores de la empresa>
-- =============================================
CREATE PROCEDURE [dbo].[SPsw_GetEmployee]


AS
BEGIN


	BEGIN TRY

	SELECT IdTblEmployees,
	       [Name],
		   [Surname],
		   [DateofBirth],
		   [TblCatMaritalStatusId],
		   [TblCatAcademicDegreeId],
		   [Address] 
	FROM [dbo].[TblEmployees] WITH(NOLOCK)
		
		
	END TRY
	BEGIN CATCH
		
		
		SELECT
			0 [Result]
		   ,ERROR_MESSAGE() 'Description'
		   ,ERROR_NUMBER() 'ErrorNumber'
		   ,ERROR_SEVERITY() 'ErrorSeverity'
		   ,ERROR_STATE() 'ErrorState'
		   ,ERROR_PROCEDURE() 'ErrorProcedure'
		   ,ERROR_LINE() 'ErrorLine';

		
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[SPsw_UpdateNewEmployee]    Script Date: 6/05/2023 13:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Edelman>
-- Create date: <Create Date>,2023-05-06
-- Description:	<Description, actualizar  registros de empleados o colaboradores de la empresa>
-- =============================================
CREATE PROCEDURE [dbo].[SPsw_UpdateNewEmployee]
@IdTblEmployees AS INT,
@NameEmployee AS NVARCHAR(100),
@SurName AS NVARCHAR(100),
@DateofBirth AS DATE,
@TblCatMaritalStatusId AS INT,
@TblCatAcademicDegreeId AS INT,
@Address AS NVARCHAR(200)

AS
BEGIN

	BEGIN TRANSACTION
	BEGIN TRY


		UPDATE [dbo].[TblEmployees] 
		SET
				[Name] = @NameEmployee,
				Surname = @SurName,
				DateofBirth = @DateofBirth,
				TblCatMaritalStatusId = @TblCatMaritalStatusId,
				TblCatAcademicDegreeId = @TblCatAcademicDegreeId, 
				[Address] = @Address
		
	   SELECT 1 [Result]

	COMMIT TRANSACTION

	

		
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		
		SELECT
			0 [Result]
		   ,ERROR_MESSAGE() 'Description'
		   ,ERROR_NUMBER() 'ErrorNumber'
		   ,ERROR_SEVERITY() 'ErrorSeverity'
		   ,ERROR_STATE() 'ErrorState'
		   ,ERROR_PROCEDURE() 'ErrorProcedure'
		   ,ERROR_LINE() 'ErrorLine';

		
	END CATCH

END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'identificador de catalogo de grado academico del empleado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblCatAcademicDegree', @level2type=N'COLUMN',@level2name=N'IdTblCatAcademicDegree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nivel academico del empleado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblCatAcademicDegree', @level2type=N'COLUMN',@level2name=N'Academiclevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'identificador del catalogo de estado civil del empleado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblCatMaritalStatus', @level2type=N'COLUMN',@level2name=N'IdTblCatMaritalStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'indica si el registro esta activo ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblCatMaritalStatus', @level2type=N'COLUMN',@level2name=N'RowStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de creación del registro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblCatMaritalStatus', @level2type=N'COLUMN',@level2name=N'DateCreated'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'usuario que creo el registro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblCatMaritalStatus', @level2type=N'COLUMN',@level2name=N'TokenCreated'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fecha de modificación de registro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblCatMaritalStatus', @level2type=N'COLUMN',@level2name=N'DateUpdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'usuario que modifica el registro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblCatMaritalStatus', @level2type=N'COLUMN',@level2name=N'TokenUpdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identifiador de Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblEmployees', @level2type=N'COLUMN',@level2name=N'IdTblEmployees'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombres del empleado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblEmployees', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Apellidos del empleado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblEmployees', @level2type=N'COLUMN',@level2name=N'Surname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de nacimiento del empleado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblEmployees', @level2type=N'COLUMN',@level2name=N'DateofBirth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'identioficador del catalogo de estado civil del empleado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblEmployees', @level2type=N'COLUMN',@level2name=N'TblCatMaritalStatusId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificador de catalogo de grado academico' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblEmployees', @level2type=N'COLUMN',@level2name=N'TblCatAcademicDegreeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dirección de  residencia del empleado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TblEmployees', @level2type=N'COLUMN',@level2name=N'Address'
GO
