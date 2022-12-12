USE [TransactionManagement_Stage]
GO
/****** Object:  Table [dbo].[Banks]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banks](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FawryAccounts]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FawryAccounts](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FawryCode] [uniqueidentifier] NULL,
	[Name] [nvarchar](150) NULL,
	[MobileNumber] [nvarchar](11) NULL,
	[NationalId] [nvarchar](14) NULL,
	[IsDefault] [bit] NULL,
	[MerchantID] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[IsMerchantAccount] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MobileWallets]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MobileWallets](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[WalletCode] [uniqueidentifier] NULL,
	[HolderName] [nvarchar](150) NULL,
	[MobileNumber] [nvarchar](11) NULL,
	[IsDefault] [bit] NULL,
	[MerchantID] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[IsMerchantAccount] [bit] NULL,
	[Migration_Key_Mobile_Wallets] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountTypes]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountTypes](
	[Id] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_AccountTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BankAccounts]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankAccounts](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[BankAccountCode] [uniqueidentifier] NULL,
	[MerchantCode] [uniqueidentifier] NULL,
	[BankId] [int] NULL,
	[HolderName] [nvarchar](150) NULL,
	[AccountNumber] [nvarchar](50) NULL,
	[IsDefault] [bit] NULL,
	[MerchantID] [bigint] NULL,
	[IsMerchantAccount] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[Migration_Key_Bank_Accounts] [uniqueidentifier] NULL,
 CONSTRAINT [PK__BankAcco__3214EC07D1488D47] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[xV_Accounts]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USE [TransactionManagement_Stage]
--GO

--EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Balance'
--GO

--EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Balance'
--GO

--/****** Object:  View [dbo].[xV_TransactionWithdrawal2]    Script Date: 9/7/2022 7:37:24 PM ******/
--DROP VIEW [dbo].[xV_TransactionWithdrawal2]
--GO

--/****** Object:  View [dbo].[xV_Transactions]    Script Date: 9/7/2022 7:37:24 PM ******/
--DROP VIEW [dbo].[xV_Transactions]
--GO

--/****** Object:  View [dbo].[xV_TransactionOrder2]    Script Date: 9/7/2022 7:37:24 PM ******/
--DROP VIEW [dbo].[xV_TransactionOrder2]
--GO

--/****** Object:  View [dbo].[xV_TransactionOrder]    Script Date: 9/7/2022 7:37:24 PM ******/
--DROP VIEW [dbo].[xV_TransactionOrder]
--GO

--/****** Object:  View [dbo].[xV_TransactionDetails]    Script Date: 9/7/2022 7:37:24 PM ******/
--DROP VIEW [dbo].[xV_TransactionDetails]
--GO

--/****** Object:  View [dbo].[V_TransferVolumn]    Script Date: 9/7/2022 7:37:24 PM ******/
--DROP VIEW [dbo].[V_TransferVolumn]
--GO

--/****** Object:  View [dbo].[V_TotalRevenues]    Script Date: 9/7/2022 7:37:24 PM ******/
--DROP VIEW [dbo].[V_TotalRevenues]
--GO

--/****** Object:  View [dbo].[Balance]    Script Date: 9/7/2022 7:37:24 PM ******/
--DROP VIEW [dbo].[Balance]
--GO

--/****** Object:  View [dbo].[xV_TransactionWithdrawal]    Script Date: 9/7/2022 7:37:24 PM ******/
--DROP VIEW [dbo].[xV_TransactionWithdrawal]
--GO

--/****** Object:  View [dbo].[xV_Accounts]    Script Date: 9/7/2022 7:37:24 PM ******/
--DROP VIEW [dbo].[xV_Accounts]
--GO

--/****** Object:  View [dbo].[xV_Accounts]    Script Date: 9/7/2022 7:37:24 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--USE [TransactionManagement_Stage]
--GO

--EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Balance'
--GO

--EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Balance'
--GO

--/****** Object:  View [dbo].[xV_TransactionWithdrawal2]    Script Date: 9/7/2022 7:28:08 PM ******/
--DROP VIEW [dbo].[xV_TransactionWithdrawal2]
--GO

--/****** Object:  View [dbo].[xV_Transactions]    Script Date: 9/7/2022 7:28:08 PM ******/
--DROP VIEW [dbo].[xV_Transactions]
--GO

--/****** Object:  View [dbo].[xV_TransactionOrder2]    Script Date: 9/7/2022 7:28:08 PM ******/
--DROP VIEW [dbo].[xV_TransactionOrder2]
--GO

--/****** Object:  View [dbo].[xV_TransactionOrder]    Script Date: 9/7/2022 7:28:08 PM ******/
--DROP VIEW [dbo].[xV_TransactionOrder]
--GO

--/****** Object:  View [dbo].[xV_TransactionDetails]    Script Date: 9/7/2022 7:28:08 PM ******/
--DROP VIEW [dbo].[xV_TransactionDetails]
--GO

--/****** Object:  View [dbo].[V_TransferVolumn]    Script Date: 9/7/2022 7:28:08 PM ******/
--DROP VIEW [dbo].[V_TransferVolumn]
--GO

--/****** Object:  View [dbo].[V_TotalRevenues]    Script Date: 9/7/2022 7:28:08 PM ******/
--DROP VIEW [dbo].[V_TotalRevenues]
--GO

--/****** Object:  View [dbo].[Balance]    Script Date: 9/7/2022 7:28:08 PM ******/
--DROP VIEW [dbo].[Balance]
--GO

--/****** Object:  View [dbo].[xV_TransactionWithdrawal]    Script Date: 9/7/2022 7:28:08 PM ******/
--DROP VIEW [dbo].[xV_TransactionWithdrawal]
--GO

--/****** Object:  View [dbo].[xV_Accounts]    Script Date: 9/7/2022 7:28:08 PM ******/
--DROP VIEW [dbo].[xV_Accounts]
--GO

--/****** Object:  View [dbo].[xV_Accounts]    Script Date: 9/7/2022 7:28:08 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


----USE [TransactionManagement]
----GO

----EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Transaction_Order'
----GO

----EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Transaction_Order'
----GO

----EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Transaction_Order'
----GO

----EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Balance'
----GO

----EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Balance'
----GO

----/****** Object:  View [dbo].[xV_TransactionWithdrawal2]    Script Date: 9/4/2022 9:22:47 AM ******/
----DROP VIEW [dbo].[xV_TransactionWithdrawal2]
----GO

----/****** Object:  View [dbo].[xV_Transactions]    Script Date: 9/4/2022 9:22:47 AM ******/
----DROP VIEW [dbo].[xV_Transactions]
----GO

----/****** Object:  View [dbo].[xV_TransactionOrder2]    Script Date: 9/4/2022 9:22:47 AM ******/
----DROP VIEW [dbo].[xV_TransactionOrder2]
----GO

----/****** Object:  View [dbo].[xV_TransactionOrder]    Script Date: 9/4/2022 9:22:47 AM ******/
----DROP VIEW [dbo].[xV_TransactionOrder]
----GO

----/****** Object:  View [dbo].[V_TransferVolumn]    Script Date: 9/4/2022 9:22:47 AM ******/
----DROP VIEW [dbo].[V_TransferVolumn]
----GO

----/****** Object:  View [dbo].[V_TotalRevenues]    Script Date: 9/4/2022 9:22:47 AM ******/
----DROP VIEW [dbo].[V_TotalRevenues]
----GO

----/****** Object:  View [dbo].[Transaction_Order]    Script Date: 9/4/2022 9:22:47 AM ******/
----DROP VIEW [dbo].[Transaction_Order]
----GO

----/****** Object:  View [dbo].[Balance]    Script Date: 9/4/2022 9:22:47 AM ******/
----DROP VIEW [dbo].[Balance]
----GO

----/****** Object:  View [dbo].[xV_TransactionWithdrawal]    Script Date: 9/4/2022 9:22:47 AM ******/
----DROP VIEW [dbo].[xV_TransactionWithdrawal]
----GO

----/****** Object:  View [dbo].[xV_Accounts]    Script Date: 9/4/2022 9:22:47 AM ******/
----DROP VIEW [dbo].[xV_Accounts]
----GO

----/****** Object:  View [dbo].[xV_Accounts]    Script Date: 9/4/2022 9:22:47 AM ******/
----SET ANSI_NULLS ON
----GO

----SET QUOTED_IDENTIFIER ON
----GO



Create VIEW [dbo].[xV_Accounts]
WITH SCHEMABINDING
AS
SELECT      
      ACT.Name AS [AccountTypeName]
	  ,ACT.Id As [AccountTypeId]
      ,BA.[Id]
	  ,[MerchantID]
      ,[BankAccountCode] As [AccountCode]
	  ,[HolderName] As [Name]
	  ,[AccountNumber]
	  ,'' [MobileNumber]
	  ,'' As [NationalId]
      ,[BankId]
	   ,B.[Name] As [BankName]
      ,[IsDefault]
      ,[IsMerchantAccount]
      ,BA.[CreatedDate]
      ,BA.[UpdatedDate]
      ,BA.[DeletedDate]
      ,BA.[IsDeleted]
FROM            dbo.BankAccounts BA
inner join      dbo.Banks B on BA.BankId=B.Id
inner join      dbo.AccountTypes ACT on ACT.Id=1


 union

	  select
      ACT.Name AS [AccountTypeName]
	  ,ACT.Id As [AccountTypeId]
      ,MW.[Id]
	  ,[MerchantID]
	  ,[WalletCode] As [AccountCode]
      ,[HolderName]As [Name]
	  ,'' [AccountNumber]
      ,[MobileNumber]
      ,'' As [NationalId]
	   ,'' As [BankId]
	   ,'' As [BankName]
      ,[IsDefault]
      ,[IsMerchantAccount]
      ,MW.[CreatedDate]
      ,MW.[UpdatedDate]
      ,MW.[DeletedDate]
      ,MW.[IsDeleted]
      
	  from dbo.MobileWallets MW
	  inner join      dbo.AccountTypes ACT on ACT.Id=2

union
select
       ACT.Name AS [AccountTypeName]
	  ,ACT.Id As [AccountTypeId]
      ,FA.[Id]
	  ,[MerchantID]
	  ,[FawryCode] As [AccountCode]
      ,FA.[Name]
	  ,'' [AccountNumber]
      ,[MobileNumber]
      ,[NationalId]
	   ,'' As [BankId]
	   ,'' As [BankName]
      ,[IsDefault]
      ,[IsMerchantAccount]
      ,FA.[CreatedDate]
      ,FA.[UpdatedDate]
      ,FA.[DeletedDate]
      ,FA.[IsDeleted]
      
	  from dbo.FawryAccounts FA
	  inner join      dbo.AccountTypes ACT on ACT.Id=3

	 

GO
/****** Object:  Table [dbo].[CurrencyTypes]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrencyTypes](
	[Id] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Currencies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusTypes]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusTypes](
	[Id] [smallint] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_StatusTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionTypes]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionTypes](
	[Id] [smallint] NOT NULL,
	[Name] [nvarchar](10) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_TranxTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OperationTypes]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OperationTypes](
	[Id] [smallint] NOT NULL,
	[Name] [nvarchar](10) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_OperationTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WithdrawalRequestTransactions]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WithdrawalRequestTransactions](
	[Id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TranxCode] [uniqueidentifier] NOT NULL,
	[TranxNumber] [nvarchar](50) NULL,
	[WithdrawalRequestId] [bigint] NULL,
	[MerchantId] [bigint] NULL,
	[MerchantCode] [uniqueidentifier] NULL,
	[Amount] [decimal](18, 2) NULL,
	[FeesAmount] [decimal](18, 2) NULL,
	[VatAmount] [decimal](18, 2) NULL,
	[CustomerAmount] [decimal](18, 2) NULL,
	[MerchantAmount] [decimal](18, 2) NULL,
	[CurrencyId] [smallint] NULL,
	[Currency] [nvarchar](5) NULL,
	[TransactionTypeId] [smallint] NULL,
	[OperationTypeId] [smallint] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[FK_Migration_key_WithdrawalRequests] [uniqueidentifier] NULL,
	[IsSuccess] [bit] NULL,
 CONSTRAINT [PK_WithdrawalTransactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WithdrawalRequests]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WithdrawalRequests](
	[Id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[MerchantId] [bigint] NULL,
	[MerchantCode] [uniqueidentifier] NULL,
	[Amount] [decimal](18, 2) NULL,
	[AccountTypeId] [smallint] NULL,
	[AccountId] [bigint] NULL,
	[WithdrawalTypeId] [smallint] NULL,
	[Status] [smallint] NULL,
	[HandledBy] [uniqueidentifier] NULL,
	[HandledDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[FK_Account_Migration_Key] [uniqueidentifier] NULL,
	[Migration_key_WithdrawalRequests] [uniqueidentifier] NULL,
 CONSTRAINT [PK_WithdrawalRequests] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WithdrawalTypes]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WithdrawalTypes](
	[Id] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_WithdrawalTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[xV_TransactionWithdrawal]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[xV_TransactionWithdrawal]
   
AS
select T.Id [TranxId]
,T.TranxCode
,T.TranxNumber
,T.MerchantId
,T.MerchantCode
,T.Amount
,T.MerchantAmount
,T.CustomerAmount
,T.FeesAmount
,T.VatAmount
,T.OperationTypeId
,OT.[Name] OperationTypeName
,T.TransactionTypeId
,TT.[Name] TransactionTypeName
,T.CurrencyId
,CT.[Name] CurrencyName
,WR.Id [WithdrawalRequestId]
,WR.AccountTypeId
,AC.AccountTypeName
,WR.HandledBy
,WR.HandledDate
,WR.[Status]
,ST.[Name] [StatusActionName]
,WR.WithdrawalTypeId
,WT.[Name] WithdrawalTypeName
,WR.AccountId
,AC.AccountCode
,AC.AccountNumber
,AC.BankId
,AC.BankName
,AC.IsDefault
,AC.IsMerchantAccount
,AC.MobileNumber
,AC.[Name] [HolderName]
,AC.NationalId
,T.CreatedDate
,T.UpdatedDate

from dbo.xV_Accounts AC
inner join dbo.WithdrawalRequests WR on AC.Id=WR.AccountId
inner join dbo.WithdrawalRequestTransactions T on WR.Id =T.WithdrawalRequestId
inner join dbo.TransactionTypes TT on T.TransactionTypeId=TT.Id
inner join dbo.OperationTypes OT on T.OperationTypeId=OT.Id
inner join dbo.WithdrawalTypes WT on WR.WithdrawalTypeId=WT.Id
inner join dbo.StatusTypes ST on WR.[Status]=ST.Id
inner join dbo.CurrencyTypes CT on T.CurrencyId=CT.Id

GO
/****** Object:  Table [dbo].[TransactionBalance]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionBalance](
	[Id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[MerchantId] [bigint] NULL,
	[TranxId] [bigint] NULL,
	[Amount] [decimal](18, 2) NULL,
	[TranxTypeId] [smallint] NULL,
	[ModelTypeId] [smallint] NULL,
	[ModelReferenceId] [bigint] NULL,
	[Balance] [decimal](18, 2) NULL,
	[AvailableBalance] [decimal](18, 2) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_TransactionBalance] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Balance]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[Balance]
  
AS
SELECT        Balance_1.MerchantId, Balance_1.Balance AS CurrentBalance, AvailableBalance.AvailableBalance
FROM            (SELECT        MerchantId, SUM(Amount) AS Balance
                          FROM            (SELECT        MerchantId, CASE WHEN [TranxTypeId] = 1 THEN [Amount] WHEN [TranxTypeId] = 2 THEN [Amount] * - 1 END AS Amount, DATEDIFF(DAY, GETDATE(), CreatedDate) AS DateDiff
                                                    FROM            dbo.TransactionBalance) AS b
                          GROUP BY MerchantId) AS Balance_1 FULL OUTER JOIN



                             (SELECT        MerchantId, SUM(Amount) AS AvailableBalance
                               FROM            (SELECT        TransactionBalance_1.MerchantId, ModelTypeId,[TranxTypeId],CASE WHEN [TranxTypeId] = 1 THEN TransactionBalance_1.[Amount] WHEN [TranxTypeId] = 2 THEN TransactionBalance_1.[Amount] * - 1 END AS Amount, DATEDIFF(DAY, TransactionBalance_1.CreatedDate, GETDATE()) AS DateDiff
                                                         FROM            dbo.TransactionBalance AS TransactionBalance_1   
														 --where [TranxTypeId] != 2
														 ) AS b_1
                               --WHERE        (DateDiff >= 7 and [TranxTypeId]=1 and ModelTypeId != 2 )  or  [TranxTypeId]=2
                              WHERE (DateDiff >= 7 and [TranxTypeId]=1)  or  [TranxTypeId]=2 or ([TranxTypeId]=1 and ModelTypeId = 2 ) 
							   GROUP BY MerchantId) AS AvailableBalance ON AvailableBalance.MerchantId = Balance_1.MerchantId
GO
/****** Object:  Table [dbo].[OrderTransactions]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderTransactions](
	[Id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TranxCode] [uniqueidentifier] NOT NULL,
	[TranxNumber] [nvarchar](50) NULL,
	[OrderId] [bigint] NULL,
	[MerchantId] [bigint] NULL,
	[MerchantCode] [uniqueidentifier] NULL,
	[Amount] [decimal](18, 2) NULL,
	[FeesAmount] [decimal](18, 2) NULL,
	[VatAmount] [decimal](18, 2) NULL,
	[CustomerAmount] [decimal](18, 2) NULL,
	[MerchantAmount] [decimal](18, 2) NULL,
	[IsFeesOnCustomer] [bit] NULL,
	[CurrencyId] [smallint] NULL,
	[Currency] [nvarchar](5) NULL,
	[TransactionTypeId] [smallint] NULL,
	[OperationTypeId] [smallint] NULL,
	[PGWMetaRequest] [nvarchar](max) NULL,
	[PGWMetaResponse] [nvarchar](max) NULL,
	[IsSuccess] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[TransactionStatusId] [smallint] NULL,
	[FK_Migration_Key_Orders] [uniqueidentifier] NULL,
 CONSTRAINT [PK_OrderTransactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [bigint] IDENTITY(10000000000,1) NOT FOR REPLICATION NOT NULL,
	[OrderCode] [uniqueidentifier] NULL,
	[MerchantId] [bigint] NULL,
	[MerchantCode] [uniqueidentifier] NULL,
	[MerchantRefId] [nvarchar](100) NULL,
	[OrderMetaId] [bigint] NULL,
	[CustomerRefId] [nvarchar](100) NULL,
	[CustomerId] [bigint] NULL,
	[OrderAmount] [decimal](18, 2) NULL,
	[CurrencyId] [smallint] NULL,
	[Currency] [nvarchar](5) NULL,
	[Description] [nvarchar](250) NULL,
	[OrderDetails] [nvarchar](max) NULL,
	[PaidDate] [datetime] NULL,
	[ExpiredDate] [datetime] NULL,
	[ActionDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[PaymentStatusTypeId] [smallint] NULL,
	[FK_migration_Key] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_TotalRevenues]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE VIEW [dbo].[V_TotalRevenues]
  
AS
SELECT       orders.MerchantId, trans.VatAmount, trans.CreatedDate, trans.IsDeleted, trans.FeesAmount
FROM            dbo.Orders AS orders INNER JOIN
                         dbo.OrderTransactions AS trans ON trans.OrderId = orders.Id
						 WHERE         orders.PaymentStatusTypeId=2
GO
/****** Object:  View [dbo].[V_TransferVolumn]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








create VIEW [dbo].[V_TransferVolumn]
  
AS
select (select sum(Amount) from WithdrawalRequests where WithdrawalTypeId=1 ) as TranseferToMyAccount
,(select sum(Amount) from WithdrawalRequests where WithdrawalTypeId=2 ) as TranseferToOther
,(select sum(Amount) from WithdrawalRequests where WithdrawalTypeId=2 or WithdrawalTypeId=1 ) as TotalTransfer
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[MerchantId] [bigint] NULL,
	[Name] [nvarchar](100) NULL,
	[Email] [nvarchar](50) NULL,
	[MerchantProfileId] [nvarchar](50) NULL,
	[Mobile] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderMeta]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderMeta](
	[Id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[PGWTypeId] [smallint] NULL,
	[ChannelTypeId] [smallint] NULL,
	[PaymentLinkTypeId] [smallint] NULL,
	[PaymentLinkId] [nchar](10) NULL,
	[PaymentMethodTypeId] [smallint] NULL,
	[ExtraData] [nvarchar](max) NULL,
	[PGWMetaRequest] [nvarchar](max) NULL,
	[PGWMetaResponse] [nvarchar](max) NULL,
	[PromoCode] [nvarchar](50) NULL,
	[PGWRefId] [nvarchar](50) NULL,
	[ReturnURL] [nvarchar](300) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[Migration_Key] [uniqueidentifier] NULL,
 CONSTRAINT [PK_OrderMeta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentMethodTypes]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethodTypes](
	[Id] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [nvarchar](50) NULL,
	[PGWTypeId] [smallint] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_PaymentMethodTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PGWTypes]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PGWTypes](
	[Id] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_PGWTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentStatusTypes]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentStatusTypes](
	[Id] [smallint] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[StatusCode] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [datetime] NULL,
 CONSTRAINT [PK_PaymentStatusTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[xV_TransactionDetails]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[xV_TransactionDetails]
   
AS
SELECT        trans.Id AS TransactionId , trans.VatAmount as VatAmount,trans.Amount as TotalAmount,trans.FeesAmount as CowpayFees, 
			  orders.OrderCode AS CowpayID, trans.MerchantAmount AS NetAmount, operationType.Name AS PaymentMethod,
			  ordermeta.PGWRefId as PaymentNumber , orders.ExpiredDate as ExpiryDate, orders.CreatedDate as PaymentDate,
			  orders.PaidDate as ActualPaymentDate,stat.Name as PaymentStatus,
			  cust.Name AS CustomerName,cust.Email AS CustomerEmail,cust.Mobile AS CustomerMobile,ordermeta.PGWTypeId as PGWTypeId , PGWTypes.Name as PGWName ,orders.Id OrderId
 FROM            dbo.Orders AS orders INNER JOIN
                         dbo.OrderMeta AS ordermeta ON ordermeta.Id = orders.OrderMetaId INNER JOIN
						 dbo.PGWTypes as PGWTypes on PGWTypes.id = ordermeta.PGWTypeId INNER JOIN
                         dbo.OrderTransactions AS trans ON trans.OrderId = orders.Id INNER JOIN
                         dbo.PaymentStatusTypes AS stat ON orders.PaymentStatusTypeId = stat.Id INNER JOIN
						 dbo.OperationTypes AS operationType ON operationType.Id = trans.OperationTypeId INNER JOIN
                         dbo.PaymentMethodTypes AS methods ON methods.Id = ordermeta.PaymentMethodTypeId INNER JOIN
                         dbo.Customers AS cust ON cust.Id = orders.CustomerId 
						


GO
/****** Object:  View [dbo].[xV_TransactionOrder]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[xV_TransactionOrder]
 
AS
SELECT        trans.Id AS TransId, orders.MerchantId, orders.Id AS OrderId,orders.OrderCode, trans.VatAmount, methods.Name AS Method, cust.Name AS Customer,cust.Email AS CustomerEmail, trans.Amount, trans.CreatedDate, stat.Name AS Status, trans.DeletedDate, trans.IsDeleted, 
                         trans.UpdatedDate, trans.TranxCode,trans.TranxNumber As TranxNumber ,orders.PaidDate As PaidDate
FROM            dbo.Orders AS orders INNER JOIN
                         dbo.OrderMeta AS ordermeta ON ordermeta.Id = orders.OrderMetaId INNER JOIN
                         dbo.OrderTransactions AS trans ON trans.OrderId = orders.Id INNER JOIN
                         dbo.PaymentStatusTypes AS stat ON orders.PaymentStatusTypeId = stat.Id INNER JOIN
                         dbo.PaymentMethodTypes AS methods ON methods.Id = ordermeta.PaymentMethodTypeId INNER JOIN
                         dbo.Customers AS cust ON cust.Id = orders.CustomerId
GO
/****** Object:  View [dbo].[xV_TransactionOrder2]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[xV_TransactionOrder2]
 
AS
SELECT       
 T.Id [TranxId]
,T.TranxCode
,T.TranxNumber
,T.MerchantId
,T.MerchantCode
,T.Amount
,T.MerchantAmount
,T.CustomerAmount
,T.FeesAmount
,T.VatAmount
,T.OperationTypeId
,OT.[Name] OperationTypeName
,T.TransactionTypeId
,TT.[Name] TransactionTypeName
,T.CurrencyId
,CT.[Name] CurrencyName
,O.Id OrderId
,O.OrderCode
,O.CustomerId
,C.[Name] CustomerName
,O.CustomerRefId
,O.MerchantRefId
,O.[Description] OrderDescription
,O.PaymentStatusTypeId
,PST.[Name] PaymentStatusTypeName
,O.ExpiredDate
,O.ActionDate
,O.PaidDate
,O.OrderMetaId
,OM.ChannelTypeId
,CHT.[Name] ChannelTypeName
,OM.PaymentMethodTypeId
,PM.[Name] PaymentMethodTypeName
,OM.PGWMetaRequest
,OM.PGWMetaResponse
,OM.PGWRefId
,OM.PGWTypeId
,PGT.[Name] PGWTypeName
,OM.ReturnURL
,T.CreatedDate
,T.UpdatedDate
FROM                    dbo.OrderTransactions  T  INNER JOIN
                        dbo.Orders O ON T.OrderId = O.Id INNER JOIN
                        dbo.OrderMeta OM ON OM.Id = O.OrderMetaId INNER JOIN
						dbo.OperationTypes OT on T.OperationTypeId=OT.Id INNER JOIN
                        dbo.PaymentStatusTypes PST ON O.PaymentStatusTypeId = PST.Id INNER JOIN
                        dbo.PaymentMethodTypes PM ON PM.Id = OM.PaymentMethodTypeId INNER JOIN
						dbo.TransactionTypes TT ON T.TransactionTypeId = TT.Id INNER JOIN
						dbo.PGWTypes PGT ON OM.PGWTypeId=PGT.Id INNER JOIN 
						dbo.CurrencyTypes CT ON T.CurrencyId=CT.Id INNER JOIN 
						dbo.CurrencyTypes CHT ON OM.ChannelTypeId=CHT.Id INNER JOIN 
                        dbo.Customers AS C ON C.Id = O.CustomerId
GO
/****** Object:  View [dbo].[xV_Transactions]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[xV_Transactions]
 
AS
SELECT      
      'Order' AS [ModelType]
      ,[Id]
      ,[TranxCode]
      ,[TranxNumber]
      ,[OrderId] AS [ModelReferenceId]
      ,[MerchantId]
      ,[MerchantCode]
      ,[Amount]
      ,[FeesAmount]
      ,[VatAmount]
      ,[CustomerAmount]
      ,[MerchantAmount]
      ,[CurrencyId]
      ,[Currency]
      ,[TransactionTypeId]
      ,[OperationTypeId]
      ,[CreatedDate]
      ,[UpdatedDate]
      ,[DeletedDate]
      ,[IsDeleted]
FROM            dbo.OrderTransactions

union

SELECT      
      'WithdrawalRequest' AS [ModelType]
      ,[Id]
      ,[TranxCode]
      ,[TranxNumber]
      ,[WithdrawalRequestId] AS [ModelReferenceId]
      ,[MerchantId]
      ,[MerchantCode]
      ,[Amount]
      ,[FeesAmount]
      ,[VatAmount]
      ,[CustomerAmount]
      ,[MerchantAmount]
      ,[CurrencyId]
      ,[Currency]
      ,[TransactionTypeId]
      ,[OperationTypeId]
      ,[CreatedDate]
      ,[UpdatedDate]
      ,[DeletedDate]
      ,[IsDeleted]
FROM            dbo.WithdrawalRequestTransactions
GO
/****** Object:  View [dbo].[xV_TransactionWithdrawal2]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[xV_TransactionWithdrawal2]
   
AS

SELECT        withdraw.Id AS TransId,withdraw.MerchantCode,withdraw.MerchantId,Bank.HolderName As Name , Bank.AccountNumber AccountNumber , '' MobileNumber, Banks.Name BankName ,''NationalId, withdraw.Amount AS Requested
, withdraw.CreatedDate, withdraw.HandledDate, stat.Name Status, withdraw.DeletedDate, withdraw.IsDeleted, trans.Amount , trans.CreatedDate TranxCreatedDate, '' TranxStatus, trans.TranxNumber,
                         withdraw.UpdatedDate,WithTypes.Name WithdrawalTypeName,AccountType.Name AccountTypeName, withdraw.AccountTypeId
FROM            dbo.WithdrawalRequests AS withdraw INNER JOIN
                         ( SELECT Amount,CreatedDate,TranxNumber,WithdrawalRequestId
            , ROW_NUMBER() OVER (PARTITION BY transactions.WithdrawalRequestId order by transactions.WithdrawalRequestId) AS rn
       FROM  dbo.WithdrawalRequestTransactions transactions
	 
     ) AS trans ON trans.WithdrawalRequestId = withdraw.Id and rn=1
                     INNER JOIN 
						 [dbo].[StatusTypes] AS stat ON stat.Id = withdraw.Status INNER JOIN
						 [dbo].AccountTypes AS AccountType ON AccountType.Id = withdraw.AccountTypeId INNER JOIN
                         dbo.BankAccounts AS Bank ON withdraw.AccountId = Bank.Id inner join 
						 dbo.Banks as Banks on BankId = Banks.Id inner join 
						
						  dbo.WithdrawalTypes as WithTypes on WithTypes.Id = withdraw.WithdrawalTypeId

WHERE         withdraw.AccountTypeId=1


--wallet

-----------------------------------------------------------------------------------------------

union
SELECT       withdraw.Id AS TransId, withdraw.MerchantCode,withdraw.MerchantId,wallet.HolderName As Name , '' AccountNumber, wallet.MobileNumber MobileNumber, '' BankName ,''NationalId, withdraw.Amount AS Requested
, withdraw.CreatedDate, withdraw.HandledDate, stat.Name Status, withdraw.DeletedDate, withdraw.IsDeleted, trans.Amount , trans.CreatedDate TranxCreatedDate, '' TranxStatus, trans.TranxNumber,
                         withdraw.UpdatedDate,WithTypes.Name WithdrawalTypeName,AccountType.Name AccountTypeName,withdraw.AccountTypeId
FROM             dbo.WithdrawalRequests AS withdraw INNER JOIN
                         ( SELECT Amount,CreatedDate,TranxNumber,WithdrawalRequestId
            , ROW_NUMBER() OVER (PARTITION BY transactions.WithdrawalRequestId order by transactions.WithdrawalRequestId) AS rn
       FROM  dbo.WithdrawalRequestTransactions transactions
	   
     ) AS trans ON trans.WithdrawalRequestId = withdraw.Id and rn=1
                     INNER JOIN 
						 [dbo].[StatusTypes] AS stat ON stat.Id = withdraw.Status INNER JOIN
						 [dbo].AccountTypes AS AccountType ON AccountType.Id = withdraw.AccountTypeId INNER JOIN
                         dbo.MobileWallets AS wallet ON withdraw.AccountId = wallet.Id inner join 
						  dbo.WithdrawalTypes as WithTypes on WithTypes.Id = withdraw.WithdrawalTypeId

WHERE        withdraw.AccountTypeId=2



--fawry

--------------------------------------------------------------------------------------------------
union
SELECT        withdraw.Id AS TransId,withdraw.MerchantCode,withdraw.MerchantId,fawry.Name As Name , '' AccountNumber, fawry.MobileNumber MobileNumber, '' BankName,fawry.NationalId NationalId , withdraw.Amount AS Requested
, withdraw.CreatedDate, withdraw.HandledDate, stat.Name Status, withdraw.DeletedDate, withdraw.IsDeleted, trans.Amount , trans.CreatedDate TranxCreatedDate, '' TranxStatus, trans.TranxNumber,
                         withdraw.UpdatedDate,WithTypes.Name WithdrawalTypeName,AccountType.Name AccountTypeName,withdraw.AccountTypeId
FROM           dbo.WithdrawalRequests AS withdraw INNER JOIN
                         ( SELECT Amount,CreatedDate,TranxNumber,WithdrawalRequestId
            , ROW_NUMBER() OVER (PARTITION BY transactions.WithdrawalRequestId order by transactions.WithdrawalRequestId) AS rn
       FROM  dbo.WithdrawalRequestTransactions transactions
	  
     ) AS trans ON trans.WithdrawalRequestId = withdraw.Id and rn=1
                     INNER JOIN 
						 [dbo].[StatusTypes] AS stat ON stat.Id = withdraw.Status INNER JOIN
						 [dbo].AccountTypes AS AccountType ON AccountType.Id = withdraw.AccountTypeId INNER JOIN
                         dbo.FawryAccounts AS fawry ON withdraw.AccountId = fawry.Id inner join 
						  dbo.WithdrawalTypes as WithTypes on WithTypes.Id = withdraw.WithdrawalTypeId

WHERE         withdraw.AccountTypeId=3

GO
/****** Object:  View [dbo].[TransactionBalance_Prepared_RollOut]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--USE [Staging_Migration]
--GO

--/****** Object:  View [dbo].[TransactionBalance_Prepared_RollOut]    Script Date: 12/12/2022 3:28:28 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO



CREATE view [dbo].[TransactionBalance_Prepared_RollOut] as 
with OrderTransaction_Data as(
select 
[MerchantId]				as [MerchantId]
,Id						as TranxId
,MerchantAmount					as [Amount]
,[TransactionTypeId]		as [TranxTypeId]
,1							as [ModelTypeId]
,OrderId						as [ModelReferenceId]
--,calculated					as 
,null						as [AvailableBalance]
,[CreatedDate]				as [CreatedDate]	
,[UpdatedDate]				as [UpdatedDate]	
,[DeletedDate]				as [DeletedDate]	
,[IsDeleted]				as [IsDeleted]	
from dbo.[OrderTransactions]
where IsSuccess=1
),




WithdrawalRequestTransactions_Data AS (
select 
[MerchantId]				as [MerchantId]
,Id						    as TranxId
,MerchantAmount			    as [Amount]
,[TransactionTypeId]		as [TranxTypeId]
,2							as [ModelTypeId]
,WithdrawalRequestId		as [ModelReferenceId]
--,calculated					as 
,null						as [AvailableBalance]
,[CreatedDate]				as [CreatedDate]	
,[UpdatedDate]				as [UpdatedDate]	
,[DeletedDate]				as [DeletedDate]	
,[IsDeleted]				as [IsDeleted]	
from dbo.WithdrawalRequestTransactions
where IsSuccess=1
)
, All_New_Transaction_Balance as (
select 
[MerchantId]
,TranxId
,[Amount]
,[TranxTypeId]
,[ModelTypeId]
,[ModelReferenceId]
,[AvailableBalance]
,[CreatedDate]	
,[UpdatedDate]	
,[DeletedDate]	
,[IsDeleted]	
,sum(case when [TranxTypeId]=1 then [Amount] else Amount*-1 end) over (partition by [MerchantId] order by  createddate) as [Balance]


from (
select 
[MerchantId]
,TranxId
,[Amount]
,[TranxTypeId]
,[ModelTypeId]
,[ModelReferenceId]
,[AvailableBalance]
,[CreatedDate]	
,[UpdatedDate]	
,[DeletedDate]	
,[IsDeleted]
from OrderTransaction_Data
union all
select 
[MerchantId]
,TranxId
,[Amount]
,[TranxTypeId]
,[ModelTypeId]
,[ModelReferenceId]
,[AvailableBalance]
,[CreatedDate]	
,[UpdatedDate]	
,[DeletedDate]	
,[IsDeleted]
from WithdrawalRequestTransactions_Data) as a )





select 
 anb.[MerchantId]
,anb.TranxId
,anb.[Amount]
,anb.[TranxTypeId]
,anb.[ModelTypeId]
,anb.[ModelReferenceId]
,anb.[AvailableBalance]
,anb.[CreatedDate]	
,anb.[UpdatedDate]	
,anb.[DeletedDate]	
,anb.[IsDeleted]
,anb.Balance
from All_New_Transaction_Balance anb left join (select TranxId from dbo.TransactionBalance where ModelTypeId=1 ) as tmp on anb.TranxId =tmp.TranxId
where tmp.TranxId is null

union 

select 
 anb.[MerchantId]
,anb.TranxId
,anb.[Amount]
,anb.[TranxTypeId]
,anb.[ModelTypeId]
,anb.[ModelReferenceId]
,anb.[AvailableBalance]
,anb.[CreatedDate]	
,anb.[UpdatedDate]	
,anb.[DeletedDate]	
,anb.[IsDeleted]
,anb.Balance
from All_New_Transaction_Balance anb left join (select TranxId from dbo.TransactionBalance where ModelTypeId=2 ) as tmp2 on anb.TranxId =tmp2.TranxId
where tmp2.TranxId is null

GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CardMetaData]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CardMetaData](
	[Id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CustomerId] [bigint] NOT NULL,
	[CardNumber] [char](16) NOT NULL,
	[FirstSix] [char](6) NOT NULL,
	[LastFour] [char](4) NOT NULL,
	[CardExpMonth] [char](2) NOT NULL,
	[CardExpYear] [char](4) NOT NULL,
	[CardToken] [nvarchar](64) NULL,
	[TokenExpiryDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[MerchantId] [bigint] NOT NULL,
	[TokenId] [uniqueidentifier] NULL,
	[CustomerRefId] [nvarchar](100) NULL,
	[MerchantCode] [uniqueidentifier] NULL,
 CONSTRAINT [PK_CardMetaData] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChannelTypes]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChannelTypes](
	[Id] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_ChannelTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ModelTypes]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModelTypes](
	[Id] [smallint] NOT NULL,
	[Name] [nvarchar](10) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Models] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScheduleOrderType]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduleOrderType](
	[Id] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_ScheduleOrderType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScheduleRequestMeta]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduleRequestMeta](
	[Id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Period] [int] NOT NULL,
	[OrderId] [nvarchar](50) NOT NULL,
	[PGWRefId] [nvarchar](50) NOT NULL,
	[IsENABLED] [bit] NOT NULL,
	[InitPeriod] [int] NULL,
	[Times] [int] NULL,
	[CowPayRefrenceId] [nvarchar](max) NOT NULL,
	[RecurringToken] [nvarchar](max) NOT NULL,
	[RecurringFirstTransId] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[ScheduleOrderTypeId] [int] NULL,
 CONSTRAINT [PK_ScheduleRequestMeta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionStatusType]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionStatusType](
	[Id] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [nvarchar](10) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_TransactionStatusType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OrderTransactions] ADD  CONSTRAINT [DF_OrderTransactions_IsFeesOnCustomer]  DEFAULT ((0)) FOR [IsFeesOnCustomer]
GO
ALTER TABLE [dbo].[BankAccounts]  WITH CHECK ADD  CONSTRAINT [FK__BankAccou__BankI__30C33EC3] FOREIGN KEY([BankId])
REFERENCES [dbo].[Banks] ([Id])
GO
ALTER TABLE [dbo].[BankAccounts] CHECK CONSTRAINT [FK__BankAccou__BankI__30C33EC3]
GO
ALTER TABLE [dbo].[BankAccounts]  WITH CHECK ADD  CONSTRAINT [FK__BankAccou__BankI__395884C4] FOREIGN KEY([BankId])
REFERENCES [dbo].[Banks] ([Id])
GO
ALTER TABLE [dbo].[BankAccounts] CHECK CONSTRAINT [FK__BankAccou__BankI__395884C4]
GO
/****** Object:  StoredProcedure [dbo].[TransactionBalance_Prepared_RollOut_Orders_Insertions]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USE [TransactionManagement_Stage]
--GO

--/****** Object:  View [dbo].[TransactionBalance_Prepared_RollOut]    Script Date: 12/12/2022 6:49:09 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO



--USE [Staging_Migration]
--GO

--/****** Object:  View [dbo].[TransactionBalance_Prepared_RollOut]    Script Date: 12/12/2022 3:28:28 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO



CREATE Procedure [dbo].[TransactionBalance_Prepared_RollOut_Orders_Insertions] as 
with OrderTransaction_Data as(
select 
[MerchantId]				as [MerchantId]
,Id						as TranxId
,MerchantAmount					as [Amount]
,[TransactionTypeId]		as [TranxTypeId]
,1							as [ModelTypeId]
,OrderId						as [ModelReferenceId]
--,calculated					as 
,null						as [AvailableBalance]
,[CreatedDate]				as [CreatedDate]	
,[UpdatedDate]				as [UpdatedDate]	
,[DeletedDate]				as [DeletedDate]	
,[IsDeleted]				as [IsDeleted]	
from dbo.[OrderTransactions]
where IsSuccess=1
),




WithdrawalRequestTransactions_Data AS (
select 
[MerchantId]				as [MerchantId]
,Id						    as TranxId
,MerchantAmount			    as [Amount]
,[TransactionTypeId]		as [TranxTypeId]
,2							as [ModelTypeId]
,WithdrawalRequestId		as [ModelReferenceId]
--,calculated					as 
,null						as [AvailableBalance]
,[CreatedDate]				as [CreatedDate]	
,[UpdatedDate]				as [UpdatedDate]	
,[DeletedDate]				as [DeletedDate]	
,[IsDeleted]				as [IsDeleted]	
from dbo.WithdrawalRequestTransactions
where IsSuccess=1
)
, All_New_Transaction_Balance as (
select 
*	
,sum(case when [TranxTypeId]=1 then [Amount] else Amount*-1 end) over (partition by [MerchantId] order by  createddate) as [Balance]


from (
select 
*
from OrderTransaction_Data
union all
select 
*
from WithdrawalRequestTransactions_Data) as a )




insert into TransactionBalance (
[MerchantId]
,TranxId
,[Amount]
,[TranxTypeId]
,[ModelTypeId]
,[ModelReferenceId]
,[AvailableBalance]
,[CreatedDate]	
,[UpdatedDate]	
,[DeletedDate]	
,[IsDeleted]
,Balance)
select 
 anb.[MerchantId]
,anb.TranxId
,anb.[Amount]
,anb.[TranxTypeId]
,anb.[ModelTypeId]
,anb.[ModelReferenceId]
,anb.[AvailableBalance]
,anb.[CreatedDate]	
,anb.[UpdatedDate]	
,anb.[DeletedDate]	
,anb.[IsDeleted]
,anb.Balance
from All_New_Transaction_Balance anb left join (select TranxId from dbo.TransactionBalance where ModelTypeId=1 ) as tmp on anb.TranxId =tmp.TranxId
where anb.ModelTypeId=1 and tmp.TranxId is null





GO
/****** Object:  StoredProcedure [dbo].[TransactionBalance_Prepared_RollOut_Withdrawals_Insertions]    Script Date: 12/12/2022 7:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USE [TransactionManagement_Stage]
--GO

--/****** Object:  View [dbo].[TransactionBalance_Prepared_RollOut]    Script Date: 12/12/2022 6:49:09 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO



--USE [Staging_Migration]
--GO

--/****** Object:  View [dbo].[TransactionBalance_Prepared_RollOut]    Script Date: 12/12/2022 3:28:28 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO



CREATE Procedure [dbo].[TransactionBalance_Prepared_RollOut_Withdrawals_Insertions] as 
with OrderTransaction_Data as(
select 
[MerchantId]				as [MerchantId]
,Id						as TranxId
,MerchantAmount					as [Amount]
,[TransactionTypeId]		as [TranxTypeId]
,1							as [ModelTypeId]
,OrderId						as [ModelReferenceId]
--,calculated					as 
,null						as [AvailableBalance]
,[CreatedDate]				as [CreatedDate]	
,[UpdatedDate]				as [UpdatedDate]	
,[DeletedDate]				as [DeletedDate]	
,[IsDeleted]				as [IsDeleted]	
from dbo.[OrderTransactions]
where IsSuccess=1
),




WithdrawalRequestTransactions_Data AS (
select 
[MerchantId]				as [MerchantId]
,Id						    as TranxId
,MerchantAmount			    as [Amount]
,[TransactionTypeId]		as [TranxTypeId]
,2							as [ModelTypeId]
,WithdrawalRequestId		as [ModelReferenceId]
--,calculated					as 
,null						as [AvailableBalance]
,[CreatedDate]				as [CreatedDate]	
,[UpdatedDate]				as [UpdatedDate]	
,[DeletedDate]				as [DeletedDate]	
,[IsDeleted]				as [IsDeleted]	
from dbo.WithdrawalRequestTransactions
where IsSuccess=1
)
, All_New_Transaction_Balance as (
select 
*	
,sum(case when [TranxTypeId]=1 then [Amount] else Amount*-1 end) over (partition by [MerchantId] order by  createddate) as [Balance]


from (
select 
*
from OrderTransaction_Data
union all
select 
*
from WithdrawalRequestTransactions_Data) as a )




insert into TransactionBalance (
[MerchantId]
,TranxId
,[Amount]
,[TranxTypeId]
,[ModelTypeId]
,[ModelReferenceId]
,[AvailableBalance]
,[CreatedDate]	
,[UpdatedDate]	
,[DeletedDate]	
,[IsDeleted]
,Balance)
select 
 anb.[MerchantId]
,anb.TranxId
,anb.[Amount]
,anb.[TranxTypeId]
,anb.[ModelTypeId]
,anb.[ModelReferenceId]
,anb.[AvailableBalance]
,anb.[CreatedDate]	
,anb.[UpdatedDate]	
,anb.[DeletedDate]	
,anb.[IsDeleted]
,anb.Balance
from All_New_Transaction_Balance anb left join (select TranxId from dbo.TransactionBalance where ModelTypeId=2 ) as tmp2 on anb.TranxId =tmp2.TranxId
where anb.ModelTypeId=2 and tmp2.TranxId is null

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Balance_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AvailableBalance"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Balance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Balance'
GO
