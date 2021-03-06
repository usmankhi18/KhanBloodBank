USE [KhanBloodBank]
GO
/****** Object:  Table [dbo].[BloodGroup]    Script Date: 1/11/2019 2:56:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BloodGroup](
	[BloodGroupID] [int] IDENTITY(1,1) NOT NULL,
	[BloodGroupName] [varchar](3) NOT NULL,
 CONSTRAINT [PK_BloodGroup] PRIMARY KEY CLUSTERED 
(
	[BloodGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Donations]    Script Date: 1/11/2019 2:56:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Donations](
	[DonationID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[BloodGroupID] [int] NOT NULL,
	[BottlesDonate] [int] NOT NULL,
	[BottlesReceive] [int] NOT NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_Donations] PRIMARY KEY CLUSTERED 
(
	[DonationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 1/11/2019 2:56:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserRoles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](10) NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 1/11/2019 2:56:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserFirstName] [varchar](50) NOT NULL,
	[UserLastName] [varchar](50) NOT NULL,
	[UserEmail] [varchar](100) NULL,
	[ContactNumber] [varchar](14) NOT NULL,
	[Gender] [bit] NOT NULL,
	[Address] [varchar](100) NULL,
	[BloodGroupID] [int] NOT NULL,
	[UserRoleID] [int] NOT NULL,
	[IsDoner] [bit] NOT NULL,
	[LastDonationDate] [datetime] NULL,
	[Organization] [varchar](50) NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BloodGroup] ON 

GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [BloodGroupName]) VALUES (1, N'A+')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [BloodGroupName]) VALUES (2, N'A-')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [BloodGroupName]) VALUES (3, N'B+')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [BloodGroupName]) VALUES (4, N'B-')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [BloodGroupName]) VALUES (5, N'AB+')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [BloodGroupName]) VALUES (6, N'AB-')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [BloodGroupName]) VALUES (7, N'O+')
GO
INSERT [dbo].[BloodGroup] ([BloodGroupID], [BloodGroupName]) VALUES (8, N'O-')
GO
SET IDENTITY_INSERT [dbo].[BloodGroup] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRoles] ON 

GO
INSERT [dbo].[UserRoles] ([RoleID], [RoleName]) VALUES (1, N'Admin')
GO
INSERT [dbo].[UserRoles] ([RoleID], [RoleName]) VALUES (2, N'User')
GO
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
GO
ALTER TABLE [dbo].[Donations] ADD  CONSTRAINT [DF_Donations_BottlesDonate]  DEFAULT ((0)) FOR [BottlesDonate]
GO
ALTER TABLE [dbo].[Donations] ADD  CONSTRAINT [DF_Donations_BottlesReceive]  DEFAULT ((0)) FOR [BottlesReceive]
GO
ALTER TABLE [dbo].[Donations]  WITH CHECK ADD  CONSTRAINT [FK_Donations_BloodGroup] FOREIGN KEY([BloodGroupID])
REFERENCES [dbo].[BloodGroup] ([BloodGroupID])
GO
ALTER TABLE [dbo].[Donations] CHECK CONSTRAINT [FK_Donations_BloodGroup]
GO
ALTER TABLE [dbo].[Donations]  WITH CHECK ADD  CONSTRAINT [FK_Donations_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Donations] CHECK CONSTRAINT [FK_Donations_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_BloodGroup] FOREIGN KEY([BloodGroupID])
REFERENCES [dbo].[BloodGroup] ([BloodGroupID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_BloodGroup]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserRoles] FOREIGN KEY([UserRoleID])
REFERENCES [dbo].[UserRoles] ([RoleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserRoles]
GO
/****** Object:  StoredProcedure [dbo].[sp_LoadAllBloodGroup]    Script Date: 1/11/2019 2:56:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		M.Usman Khan
-- Create date: 10-January-2019
-- Description:	Load All Blood Groups
-- =============================================
CREATE PROCEDURE [dbo].[sp_LoadAllBloodGroup]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM BloodGroup;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LoadAllDonations]    Script Date: 1/11/2019 2:56:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		M.Usman Khan
-- Create date: 11-January-2019
-- Description:	Load All Donations
-- =============================================
CREATE PROCEDURE [dbo].[sp_LoadAllDonations]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Donations
	inner join BloodGroup on BloodGroup.BloodGroupID = Donations.BloodGroupID
	inner join Users on Users.UserID = Donations.UserID
	where BottlesDonate > 0 and Users.IsDoner = 1;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LoadAllDoners]    Script Date: 1/11/2019 2:56:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		M.Usman Khan
-- Create date: 11-January-2019
-- Description:	Load All Doners
-- =============================================
CREATE PROCEDURE [dbo].[sp_LoadAllDoners]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Users where IsDoner = 1;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LoadAllReceivers]    Script Date: 1/11/2019 2:56:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		M.Usman Khan
-- Create date: 11-January-2019
-- Description:	Load All Receivers
-- =============================================
CREATE PROCEDURE [dbo].[sp_LoadAllReceivers]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Users where UserID IN (SELECT DISTINCT(UserID) from Donations where BottlesReceive > 0);
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LoadAllReceivings]    Script Date: 1/11/2019 2:56:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		M.Usman Khan
-- Create date: 11-January-2019
-- Description:	Load All Receivings
-- =============================================
CREATE PROCEDURE [dbo].[sp_LoadAllReceivings]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Donations
	inner join BloodGroup on BloodGroup.BloodGroupID = Donations.BloodGroupID
	inner join Users on Users.UserID = Donations.UserID
	where BottlesReceive > 0;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LoadAllTransactions]    Script Date: 1/11/2019 2:56:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		M.Usman Khan
-- Create date: 11-January-2019
-- Description:	Load All Transactions
-- =============================================
CREATE PROCEDURE [dbo].[sp_LoadAllTransactions]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Donations
	inner join BloodGroup on BloodGroup.BloodGroupID = Donations.BloodGroupID
	inner join Users on Users.UserID = Donations.UserID;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LoadAllUsers]    Script Date: 1/11/2019 2:56:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		M.Usman Khan
-- Create date: 11-January-2019
-- Description:	Load All Users
-- =============================================
CREATE PROCEDURE [dbo].[sp_LoadAllUsers]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Users;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LoadSpecificTransaction]    Script Date: 1/11/2019 2:56:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		M.Usman Khan
-- Create date: 11-January-2019
-- Description:	Load Specific Transaction
-- =============================================
CREATE PROCEDURE [dbo].[sp_LoadSpecificTransaction]
@DonationID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Donations
	inner join BloodGroup on BloodGroup.BloodGroupID = Donations.BloodGroupID
	inner join Users on Users.UserID = Donations.UserID
	where DonationID = @DonationID;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_LoadSpecificUser]    Script Date: 1/11/2019 2:56:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		M.Usman Khan
-- Create date: 11-January-2019
-- Description:	Load Specific User
-- =============================================
CREATE PROCEDURE [dbo].[sp_LoadSpecificUser]
@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Users where UserID = @UserID;
END


GO
