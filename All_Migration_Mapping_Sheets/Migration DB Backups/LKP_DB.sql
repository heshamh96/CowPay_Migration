USE [LKP_DB]
GO
/****** Object:  Table [dbo].[Ref_Banks]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ref_Banks](
	[bank_name] [nvarchar](191) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[New_Sys_Value] [nvarchar](150) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Ref_Banks_Final]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[Ref_Banks_Final]
as 
select distinct bank_name,New_Sys_Value from Ref_Banks
--union
--select Name collate database_default ,Id from TransactionManagement_Stage.dbo.Banks

GO
/****** Object:  View [dbo].[desired_PGW_JSON_Transactions_shape]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[desired_PGW_JSON_Transactions_shape] as 

with Desired_TRGT as (
select ROW_NUMBER() over (partition by rs.Name order by rs.id) as rn ,* from (
SELECT  a.[Id]
      ,d.Name
      ,a.[PGWMetaRequest]
      ,a.[PGWMetaResponse]
      
      ,[TransactionStatusId]
  FROM [TransactionManagement_Stage].[dbo].[OrderTransactions]  a join
 [TransactionManagement_Stage].[dbo].Orders  b on a.OrderId=b.Id 
 join [TransactionManagement_Stage].[dbo].OrderMeta c on c.id=b.OrderMetaId 
  join [TransactionManagement_Stage].[dbo].PGWTypes d on d.Id=c.PGWTypeId) rs)


  select * from (
  select * from Desired_TRGT 
  --where  PGWMetaRequest is not null and PGWMetaResponse is not null
  ) a
  --where a.rn=4
GO
/****** Object:  Table [dbo].[Banks_cowpay]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banks_cowpay](
	[bank_name] [nvarchar](191) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Banks_Src]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banks_Src](
	[id] [numeric](10, 0) NULL,
	[name] [nvarchar](150) NULL,
	[createddate] [datetime2](7) NULL,
	[updateddate] [datetime2](7) NULL,
	[deleteddate] [datetime2](7) NULL,
	[isdeleted] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChannelTypes_cowpay]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChannelTypes_cowpay](
	[channel] [nvarchar](14) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChannelTypes_Src]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChannelTypes_Src](
	[id] [numeric](5, 0) NULL,
	[name] [nvarchar](50) NULL,
	[createddate] [datetime2](7) NULL,
	[updateddate] [datetime2](7) NULL,
	[deleteddate] [datetime2](7) NULL,
	[isdeleted] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cleansing_Merchants_not_Blocked Users]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cleansing_Merchants_not_Blocked Users](
	[id] [smallint] NOT NULL,
	[name] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[m_commercial_registry] [int] NULL,
	[m_commercial_registry_file] [nvarchar](1) NULL,
	[m_personal_id] [float] NULL,
	[m_personal_id_file] [nvarchar](1) NULL,
	[m_tax_id] [nvarchar](50) NULL,
	[m_tax_id_file] [nvarchar](1) NULL,
	[m_added_at] [float] NULL,
	[m_approved_at] [float] NULL,
 CONSTRAINT [PK_Cleansing_Merchants_not_Blocked Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Currency_cowpay]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currency_cowpay](
	[currency_code] [nvarchar](4) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CurrencyTypes_Src]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrencyTypes_Src](
	[id] [numeric](5, 0) NULL,
	[name] [nvarchar](50) NULL,
	[createddate] [datetime2](7) NULL,
	[updateddate] [datetime2](7) NULL,
	[deleteddate] [datetime2](7) NULL,
	[isdeleted] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[merchant_Claims]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchant_Claims](
	[user_id] [int] NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentLinkType_SRC]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentLinkType_SRC](
	[id] [numeric](10, 0) NULL,
	[name] [nvarchar](max) NULL,
	[createddate] [datetime2](7) NULL,
	[updateddate] [datetime2](7) NULL,
	[deleteddate] [datetime2](7) NULL,
	[isdeleted] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentLinkTypes_cowpay]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentLinkTypes_cowpay](
	[payment_link_type] [nvarchar](23) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentMethodTypes_cowpay]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethodTypes_cowpay](
	[payment_method] [nvarchar](14) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentMethodTypes_Src]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethodTypes_Src](
	[id] [numeric](5, 0) NULL,
	[name] [nvarchar](50) NULL,
	[pgwtypeid] [numeric](5, 0) NULL,
	[createddate] [datetime2](7) NULL,
	[updateddate] [datetime2](7) NULL,
	[deleteddate] [datetime2](7) NULL,
	[isdeleted] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentStatusTypes_cowpay]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentStatusTypes_cowpay](
	[payment_status] [nvarchar](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentStatusTypes_Src]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentStatusTypes_Src](
	[id] [numeric](5, 0) NULL,
	[name] [nvarchar](50) NULL,
	[statuscode] [numeric](10, 0) NULL,
	[createddate] [datetime2](7) NULL,
	[updateddate] [datetime2](7) NULL,
	[deleteddate] [datetime2](7) NULL,
	[isdeleted] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PGWTypes_cowpay]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PGWTypes_cowpay](
	[payment_gateway] [nvarchar](5) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PGWTypes_Src]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PGWTypes_Src](
	[id] [numeric](5, 0) NULL,
	[name] [nvarchar](50) NULL,
	[createddate] [datetime2](7) NULL,
	[updateddate] [datetime2](7) NULL,
	[deleteddate] [datetime2](7) NULL,
	[isdeleted] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ref_ChannelTypes]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ref_ChannelTypes](
	[channel] [nvarchar](14) NULL,
	[New_Sys_Value] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ref_CurrencyTypes]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ref_CurrencyTypes](
	[currency_code] [nvarchar](4) NULL,
	[New_Sys_Value] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ref_PaymentLinkType]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ref_PaymentLinkType](
	[payment_link_type] [nvarchar](23) NULL,
	[New_Sys_Value] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ref_PaymentMethodTypes]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ref_PaymentMethodTypes](
	[payment_method] [nvarchar](14) NULL,
	[New_Sys_Value] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ref_PaymentStatusTypes]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ref_PaymentStatusTypes](
	[payment_status] [nvarchar](32) NULL,
	[New_Sys_Value] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ref_PGWTypes]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ref_PGWTypes](
	[payment_gateway] [nvarchar](5) NULL,
	[New_Sys_Value] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ref_StatusTypes]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ref_StatusTypes](
	[status] [nvarchar](13) NULL,
	[New_Sys_Value] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusTypes_Cowpay]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusTypes_Cowpay](
	[status] [nvarchar](13) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusTypes_SRC]    Script Date: 11/17/2022 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusTypes_SRC](
	[id] [numeric](5, 0) NULL,
	[name] [nvarchar](50) NULL,
	[createddate] [datetime2](7) NULL,
	[updateddate] [datetime2](7) NULL,
	[deleteddate] [datetime2](7) NULL,
	[isdeleted] [bit] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Commercial International Bank ', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2021-04-11T12:36:24.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'qwe', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2020-09-25T16:56:46.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'AlAhly', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2020-09-25T16:56:46.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Qatar National Bank Alahli', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2021-04-11T12:36:24.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Bank of Alexandria', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Banque Misr', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2020-09-25T16:56:46.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Arab Bank ', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'National Bank of Egypt', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2020-09-25T16:56:46.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Audi Bank', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Export Development Bank of Egypt', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Arab African International Bank', CAST(N'2020-02-13T19:21:40.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'HSBC', CAST(N'2020-02-16T13:10:47.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Credit Agricole', CAST(N'2020-03-10T10:47:03.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Faisal Islamic Bank of Egypt', CAST(N'2020-03-22T16:28:22.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Ahly United Bank', CAST(N'2020-05-04T16:02:34.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'The United Bank', CAST(N'2020-05-23T15:14:39.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Abu Dhabi Islamic Bank – Egypt', CAST(N'2020-06-16T21:29:55.000' AS DateTime), CAST(N'2021-06-09T15:25:22.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Al Baraka Bank Egypt', CAST(N'2020-10-20T10:44:50.000' AS DateTime), CAST(N'2021-04-11T12:36:26.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Emirates National Bank of Dubai', CAST(N'2020-07-13T10:44:18.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Abu Dhabi Islamic Bank - Egypt', CAST(N'2020-07-13T17:38:37.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Blom Bank Egypt', CAST(N'2020-08-15T16:50:21.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Egyptian Gulf Bank', CAST(N'2020-09-16T11:38:53.000' AS DateTime), CAST(N'2021-04-11T12:36:27.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Banque Du Caire', CAST(N'2020-09-23T06:29:39.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Suez Canal Bank', CAST(N'2020-09-30T13:48:17.000' AS DateTime), CAST(N'2021-04-11T12:36:27.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Attijariwafa Bank Egypt', CAST(N'2020-10-06T15:26:17.000' AS DateTime), CAST(N'2021-04-11T12:36:27.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'', CAST(N'2021-01-05T01:04:51.000' AS DateTime), CAST(N'2021-04-11T12:36:26.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'National Bank of Kuwait', CAST(N'2021-02-09T11:06:49.000' AS DateTime), CAST(N'2021-04-11T12:36:26.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Union National Bank', CAST(N'2021-02-09T11:33:29.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'The Principal Bank for Development and Agri.', CAST(N'2021-03-30T11:07:25.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Al Ahli Bank of Kuwait - Egypt ', CAST(N'2021-03-31T13:06:37.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Abu Dhabi Islamic Bank Egypt', CAST(N'2021-04-22T23:45:34.000' AS DateTime), CAST(N'2021-04-22T23:45:34.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'﻿Arab African International Bank', CAST(N'2021-05-10T09:25:22.000' AS DateTime), CAST(N'2021-05-10T09:25:22.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Credit Agricole Egypt', CAST(N'2021-05-16T21:08:37.000' AS DateTime), CAST(N'2021-05-16T21:08:37.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'CIB', CAST(N'2021-05-24T11:09:49.000' AS DateTime), CAST(N'2021-05-24T11:09:49.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'QNB', CAST(N'2021-06-08T17:48:44.000' AS DateTime), CAST(N'2021-06-08T17:48:44.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'QNB AlAHLI', CAST(N'2021-06-08T19:48:41.000' AS DateTime), CAST(N'2021-06-08T19:48:41.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'البنك الاهلي للمعاملات الاسلاميه', CAST(N'2021-06-08T20:58:35.000' AS DateTime), CAST(N'2021-06-08T20:58:35.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'bank Misr', CAST(N'2021-06-10T16:22:59.000' AS DateTime), CAST(N'2021-06-10T16:22:59.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Bank Du Caire', CAST(N'2021-06-10T20:07:14.000' AS DateTime), CAST(N'2021-06-10T20:07:14.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'NBE', CAST(N'2021-06-12T10:50:32.000' AS DateTime), CAST(N'2021-06-12T10:50:32.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Egyptian Arab Land Bank', CAST(N'2021-08-05T10:26:47.000' AS DateTime), CAST(N'2021-08-05T10:26:47.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Arab Banking Corporation', CAST(N'2021-10-05T17:43:37.000' AS DateTime), CAST(N'2021-10-05T17:43:37.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Central Bank of Egypt', CAST(N'2021-10-05T20:15:33.000' AS DateTime), CAST(N'2021-10-05T20:15:33.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'masr', CAST(N'2021-11-14T17:13:23.000' AS DateTime), CAST(N'2021-11-14T17:13:23.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'1', CAST(N'2021-11-14T17:14:01.000' AS DateTime), CAST(N'2021-11-14T17:14:01.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'&', CAST(N'2021-11-14T17:16:05.000' AS DateTime), CAST(N'2021-11-14T17:16:05.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'sdgsdgsdg', CAST(N'2021-11-22T03:23:07.000' AS DateTime), CAST(N'2021-11-22T03:23:07.000' AS DateTime))
INSERT [dbo].[Banks_cowpay] ([bank_name], [created_at], [updated_at]) VALUES (N'Please, Select your bank name', CAST(N'2021-11-30T15:30:11.000' AS DateTime), CAST(N'2021-11-30T15:30:11.000' AS DateTime))
GO
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(1 AS Numeric(10, 0)), N'Arab African International Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(2 AS Numeric(10, 0)), N'Arab Banking Corporation', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(3 AS Numeric(10, 0)), N'Al Ahli Bank of Kuwait – Egypt', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(4 AS Numeric(10, 0)), N'Abu Dhabi Islamic Bank – Egypt', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(5 AS Numeric(10, 0)), N'Al Baraka Bank Egypt', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(6 AS Numeric(10, 0)), N'Arab Investment Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(7 AS Numeric(10, 0)), N'Arab Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(8 AS Numeric(10, 0)), N'Arab International Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(9 AS Numeric(10, 0)), N'Ahly United Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(10 AS Numeric(10, 0)), N'Audi Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(11 AS Numeric(10, 0)), N'Attijariwafa Bank Egypt', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(12 AS Numeric(10, 0)), N'Banque Du Caire', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(13 AS Numeric(10, 0)), N'Blom Bank Egypt', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(14 AS Numeric(10, 0)), N'Bank of Alexandria', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(15 AS Numeric(10, 0)), N'Credit Agricole Egypt', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(16 AS Numeric(10, 0)), N'Central Bank of Egypt', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(17 AS Numeric(10, 0)), N'Commercial International Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(18 AS Numeric(10, 0)), N'Citibank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(19 AS Numeric(10, 0)), N'Egyptian Arab Land Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(20 AS Numeric(10, 0)), N'Export Development Bank of Egypt', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(21 AS Numeric(10, 0)), N'Egyptian Gulf Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(22 AS Numeric(10, 0)), N'Emirates National Bank of Dubai', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(23 AS Numeric(10, 0)), N'First Abu Dhabi Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(24 AS Numeric(10, 0)), N'Faisal Islamic Bank of Egypt', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(25 AS Numeric(10, 0)), N'Housing And Development Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(26 AS Numeric(10, 0)), N'HSBC', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(27 AS Numeric(10, 0)), N'Industrial Development Bank of Egypt', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(28 AS Numeric(10, 0)), N'Mashreq Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(29 AS Numeric(10, 0)), N'Misr Iran Development Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(30 AS Numeric(10, 0)), N'Banque Misr', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(31 AS Numeric(10, 0)), N'National Bank of Egypt', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(32 AS Numeric(10, 0)), N'National Bank of Greece', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(33 AS Numeric(10, 0)), N'National Bank of Kuwait', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(34 AS Numeric(10, 0)), N'Nasser social Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(35 AS Numeric(10, 0)), N'The Principal Bank for Development and Agri.', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(36 AS Numeric(10, 0)), N'Egypt Post', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(37 AS Numeric(10, 0)), N'Qatar National Bank Alahli', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(38 AS Numeric(10, 0)), N'Societe Arabe Internationale De Banque', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(39 AS Numeric(10, 0)), N'Suez Canal Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(40 AS Numeric(10, 0)), N'The United Bank', NULL, NULL, NULL, NULL)
INSERT [dbo].[Banks_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(41 AS Numeric(10, 0)), N'Union National Bank', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[ChannelTypes_cowpay] ([channel]) VALUES (N'')
INSERT [dbo].[ChannelTypes_cowpay] ([channel]) VALUES (N'API')
INSERT [dbo].[ChannelTypes_cowpay] ([channel]) VALUES (N'PAYMENT_LINKS')
INSERT [dbo].[ChannelTypes_cowpay] ([channel]) VALUES (N'DIRECT_PAYMENT')
INSERT [dbo].[ChannelTypes_cowpay] ([channel]) VALUES (N'IFRAME')
INSERT [dbo].[ChannelTypes_cowpay] ([channel]) VALUES (N'CHECKOUT')
GO
INSERT [dbo].[ChannelTypes_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(1 AS Numeric(5, 0)), N'IFrame', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChannelTypes_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(2 AS Numeric(5, 0)), N'API', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (9, N'TechneSummit', N'tarek.elkady@kdgp.net', N'1098950608', 1479, NULL, 27906199781376, NULL, N'249-721-945', NULL, 43653.75, 43653.75)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (16, N'ikemya', N'ahmedali@qtinnovations.com', N'1125866494', 141117, NULL, 28509000957952, NULL, N'567-308-006', NULL, 43664.62890625, 43664.6328125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (68, N'cowpay-test', N'hessain.almenawy@cowpay.me', N'1065627557', NULL, NULL, NULL, NULL, NULL, NULL, 43716.73828125, 43716.73828125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (74, N'Jabal', N'tonsy86@gmail.com', N'1003402252', 179058, NULL, 28605300080640, NULL, N'667-822-542', NULL, NULL, 43735.69140625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (75, N'���� ����� ������', N'elreefelaraby@yahoo.com', N'1000421844', 161092, NULL, 27003300347904, NULL, N'205-605-540', NULL, 43735.69140625, 43735.6953125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (76, N'SYE', N'backoffice@syecommunity.com', N'1001883884', 202419, NULL, 27703098998784, NULL, N'234-808-055', NULL, 43745.3359375, 43745.3359375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (79, N'VOO', N'waleed@getvoo.com', N'1098888183', 97965, NULL, 28311199678464, NULL, N'533-126-959', NULL, 43754.3671875, 43754.37109375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (81, N'YouSplendid', N'yousplendid99@gmail.com', N'2.011E+11', 85919, NULL, 28810099556352, NULL, N'484-445-537', NULL, 43758.5703125, 43758.5703125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (101, N'Wasabi Experience', N'info@thewasabiexperience.com', N'1006009918', 60962, NULL, 27402199629824, NULL, N'416-139-507', NULL, NULL, 43816.49609375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (131, N'Empower Football Academy', N'empower.farida@gmail.com', N'1007186582', 13754, NULL, 29306199736320, NULL, N'616-653-492', NULL, NULL, 43859.6640625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (132, N'Urban Business Institute', N'dinaselmy@gmail.com', N'2.01111E+11', NULL, NULL, 28411300937728, NULL, NULL, NULL, NULL, 43860.45703125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (140, N'����� ������� ��������� ���������� �������', N'i@edl.com', N'1099000900', 55352, NULL, 25809999888384, NULL, N'381-336-700', NULL, NULL, 43871.67578125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (143, N'Fel 3ezba', N'm-safwat@hotmail.co.uk', N'1005566103', 97253, NULL, 28511299436544, NULL, N'530-987-945', NULL, NULL, 43884.796875)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (145, N'dbv.technesummit.com', N'dbv@technesummit.com', N'1006880001', 1479, NULL, 27906199781376, NULL, N'249-721-945', NULL, NULL, 43886.82421875)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (146, N'eg.technedrifts.com', N'info@techne.me', N'1066672730', 1479, NULL, 27906199781376, NULL, N'249-721-945', NULL, NULL, 43886.828125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (152, N'Heya Health', N'hello@heyahealth.net', N'2.01116E+11', 66387, NULL, 27704099340288, NULL, N'450-525-007', NULL, NULL, 43895.55859375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (155, N'Success Academy', N'success.for.training@gmail.com', N'1014616821', 28750, NULL, 29201100963840, NULL, N'494-217-448', NULL, NULL, 43905.74609375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (158, N'Raseedi', N'info@raseedi.co', N'1222222222', 128749, NULL, 29207100915712, NULL, N'726-619-337', NULL, NULL, 43907.546875)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (164, N'IGNITE EGYPT', N'habdeldayem@ignite-performance.co', N'20114422777', 95833, NULL, 28906000220160, NULL, N'528-488-678', NULL, NULL, 43909.0078125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (169, N'Gateway English Community', N'finance@gatewayuniverse.com', N'1156557778', 82641, NULL, 29002999791616, NULL, N'494-326-344', NULL, NULL, 43912.98046875)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (175, N'Gateway Alex Branch', N'aibrahim3@live.com', N'1006484824', 82641, NULL, 29002999791616, NULL, N'494-326-344', NULL, NULL, 43919.87890625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (177, N'Monsters', N'msafwat03@gmail.com', N'1009676670', 97253, NULL, 28511299436544, NULL, N'530-987-945', NULL, NULL, 43921.515625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (180, N'Mada Nursery - Concordia Branch', N'hadeel.badawy@mada-academy.com', N'1025045488', 172767, NULL, 28708201037824, NULL, N'648-210-367', NULL, NULL, 43923.60546875)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (181, N'Mada Nursery - Choueifat Branch', N'monazahh@yahoo.com', N'1019548043', 172767, NULL, 28708201037824, NULL, N'648-210-367', NULL, NULL, 43923.609375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (182, N'TEFLism', N'mohamedalikhalaf@gmail.com', N'1008444148', NULL, NULL, 28311000449024, NULL, NULL, NULL, NULL, 43923.984375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (187, N'CLTA', N'sabry.advisor@gmail.com', N'1227190711', 22148, NULL, 29007099723776, NULL, N'589-565-788', NULL, NULL, 43925.81640625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (188, N'Anubis k9', N'khaled.hiatmy@anubissecurity.com', N'2.01024E+11', 79945, NULL, 28601099485184, NULL, N'484-702-637', NULL, NULL, 43925.88671875)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (192, N'Concept. Egypt', N'Info@concept-egypt.com', N'1001522363', 202419, NULL, 27703098998784, NULL, N'234-808-055', NULL, NULL, 43926.8203125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (194, N'747 Consulting Group', N'Info@747cg.com', N'1288423309', NULL, NULL, 28802000355328, NULL, NULL, NULL, NULL, 43927.5390625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (195, N'A.L.I', N'mrmohamed.salah@hotmail.com', N'1000098200', 45701, NULL, 28004300357632, NULL, N'205-724-035', NULL, NULL, 43928.73828125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (196, N'Tortina Qatameya Branch', N'tortinaqatmeya@cowpay.me', N'1028063338', 35744, NULL, 27207099482112, NULL, N'301-222-479', NULL, NULL, 43928.84765625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (197, N'Tortina Maadi Branch', N'tortinamaadi@cowpay.me', N'1004737334', 35744, NULL, 27207099482112, NULL, N'301-222-479', NULL, NULL, 43928.84765625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (198, N'Tortina Mohandseen Branch', N'tortinamohandseen@gmail.com', N'1028063330', 35744, NULL, 27207099482112, NULL, N'301-222-479', NULL, NULL, 43928.84765625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (199, N'Tortina Arkan Branch', N'tortinaarkan@cowpay.me', N'1125695633', 35744, NULL, 27207099482112, NULL, N'301-222-479', NULL, NULL, 43928.8515625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (200, N'Tortina Zamalek Branch', N'zamalek1@cowpay.me', N'1203022406', 35744, NULL, 27207099482112, NULL, N'301-222-479', NULL, NULL, 43928.8515625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (201, N'Tortina Concord Plaza Branch', N'tortinaconcored@cowpay.me', N'1288004279', 35744, NULL, 27207099482112, NULL, N'301-222-479', NULL, NULL, 43928.8515625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (202, N'Tortina Misr l gdeda Branch', N'totrinamisrlgdeda@gmail.com', N'1275155499', 35744, NULL, 27207099482112, NULL, N'301-222-479', NULL, NULL, 43928.85546875)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (206, N'Space Code Academy', N'info@spacecodeacademy.com', N'1000277233', 147752, NULL, 29404098985984, NULL, N'579-573-249', NULL, NULL, 43930.79296875)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (207, N'Success Academy', N'm.success2015@gmail.com', N'1112888993', 28750, NULL, 29201100963840, NULL, N'494-217-448', NULL, NULL, 43931.12109375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (208, N'DFA', N'Khaled.roshdy@dfa-eg.net', N'1064243702', 166625, NULL, 28609200783360, NULL, N'631-052-364', NULL, NULL, 43932.87109375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (209, N'Contrato', N'info@thecontrato.com', N'1116362666', 154808, NULL, 28812200902656, NULL, N'599-455-004', NULL, NULL, 43933.60546875)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (213, N'The two-twenty', N'info@thetwo-twenty.com', N'1005175345', 93905, NULL, 28711199965184, NULL, N'526-087-986', NULL, NULL, 43937.69140625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (216, N'Gold''s Gym HQ', N'ahmed.senna@goldsgymegypt.com', N'1030903905', 29672, NULL, 27703098998784, NULL, N'200-125-036', NULL, 43940.61328125, 43940.61328125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (226, N'Sal''s Fit & Fab', N'sally.salama@gmail.com', N'1000065550', 66387, NULL, 27704099340288, NULL, N'450-525-007', NULL, NULL, 43944.078125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (227, N'Noon Academy', N'AP@noonacademy.com', N'1019977422', 108572, NULL, 28111200583680, NULL, N'545-804-388', NULL, NULL, 43944.4375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (243, N'Finoon Center', N'serag@finooncenter.com', N'1224780172', 95858, NULL, 28602099826688, NULL, N'528-511-025', NULL, NULL, 43956.93359375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (255, N'LA7 Gym', N'm.amin@la7gym.com', N'0 101 386 5555', 89679, NULL, 28402100731904, NULL, N'511-492-340', NULL, NULL, 43963.62890625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (268, N'In The Zone Sports', N'Adam.elzoghby@inthezone-sports.com', N'1006000737', 63658, NULL, 28604100509696, NULL, N'421-094-516', NULL, NULL, 43968.62109375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (277, N'Masar', N'mostafasalem@masar.academy', N'2.01002E+11', 132031, NULL, 28907300454400, NULL, N'724-190-724', NULL, NULL, 43974.6640625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (305, N'Correct for programming', N'mo.saleh4445@gmail.com', N'2.01066E+11', 476, NULL, 29307999092736, NULL, N'560-371-608', NULL, NULL, 44000.546875)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (311, N'EGY Spark', N'egyspark@gmail.com', N'1006808094', 56414, NULL, 28412200615936, NULL, N'374-298-564', NULL, NULL, 44004.6953125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (318, N'Doctor Online', N'admin@doctor-online.app', N'2.01002E+11', 14925, NULL, 28609100120064, NULL, N'582-011-426', NULL, NULL, 44009.9296875)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (335, N'15All', N'info@15all.net', N'1150920166', 135847, NULL, 29002999791616, NULL, N'562-203-605', NULL, NULL, 44019.62109375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (339, N'Tip of The Day', N'support@tipoftheday.co', N'1111210299', 11220, NULL, 29208000593920, NULL, N'731-292-448', NULL, 44021.69921875, 44021.69921875)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (349, N'value buisness solution', N'm.a.baioumy@gmail.com', N'1066706210', 71356, NULL, 28904200863744, NULL, N'464-616-417', NULL, NULL, 44026.53515625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (364, N'Bright-On English', N'brightonenglishcourses@gmail.com', N'2.01096E+11', NULL, NULL, 27510299426816, NULL, NULL, NULL, NULL, 44034.45703125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (382, N'ExBot', N'expandizer@gmail.com', N'1092199930', 8006, NULL, 28110001012736, NULL, N'301-206-392', NULL, NULL, 44062.47265625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (383, N'Mentarcise', N'info@mentarcise.com', N'1010000815', 75567, NULL, 28408299913216, NULL, N'477-085-547', NULL, NULL, 44068.4609375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (385, N'Neqabty', N'dina.elfouly@neqabty.com', N'1136416666', 3280, NULL, 28004099031040, NULL, N'726-168-076', NULL, NULL, 44071.90625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (386, N'Heba el sawah', N'h_sawah@yahoo.com', N'1005353709', NULL, NULL, 28411200274432, NULL, NULL, NULL, NULL, 44073.55078125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (407, N'������� ����������', N'karem3mad@gmail.com', N'1001114629', 27007, NULL, 28605100851200, NULL, N'481-934-790', NULL, NULL, 44088.5234375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (433, N'Smurf House Nursery', N'sherine.n@gmail.com', N'1222271071', 107994, NULL, 28308299317248, NULL, N'545-424-305', NULL, NULL, 44111.5)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (440, N'Medinfo', N'ahzmie@gmail.com', N'1288287880', 2186, NULL, 29709100384256, NULL, N'728-554-917', NULL, NULL, 44116.75390625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (443, N'Egyptian Virtual Academy', N'evaeducation.org@gmail.com', N'9.66555E+11', NULL, NULL, 28003100786688, NULL, NULL, NULL, NULL, 44117.66015625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (458, N'Yahya Demo', N'esraaelsayed870@gmail.com', N'1116261003', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 44124.48046875)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (462, N'Leadership Coaching Excellence', N'payment@lcecompany.net', N'1009870000', 40574, NULL, 24705100677120, NULL, N'328-259-489', NULL, NULL, 44125.515625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (463, N'Sarah Gad', N'sara.gad.92@gmail.com', N'1122234326', NULL, NULL, 29203999227904, NULL, NULL, NULL, NULL, 44126.375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (478, N'Tortina Online', N'alia.fahmy1989@gmail.com', N'1006010005', 35744, NULL, 27207099482112, NULL, N'301-222-479', NULL, 44140.45703125, 44140.45703125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (486, N'Go Bike', N'mohamedsammy1@gmail.com', N'1091000432', 1274557, NULL, 28608099778560, NULL, N'560-178-549', NULL, NULL, 44147.046875)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (490, N'tortina O1 branch', N'mlovek605@gmail.com', N'1002230051', 35744, NULL, 27207099482112, NULL, N'301-222-479', NULL, NULL, 44150.7734375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (500, N'El Course.net', N'elcourse0@gmail.com', N'1096860031', 8006, NULL, 28110001012736, NULL, N'301-206-392', NULL, NULL, 44158.62109375)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (501, N'Russian Computer Center', N'ikhaledadel@gmail.com', N'1002016616', 2961, NULL, 28208200155136, NULL, N'301-133-123', NULL, NULL, 44160.53515625)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (511, N'Omar Abdelrahim', N'omar.alaa@live.com', N'1000222262', 82641, NULL, 29002999791616, NULL, N'494-326-344', NULL, NULL, 44164.70703125)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (519, N'ELKHETA', N'abbas@elkheta.com', N'1002251510', 14951, NULL, 29210299072512, NULL, N'582-135-168', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (540, N'Markade LLC', N'booking@techne.me', N'1012240612', 1479, NULL, 27906199781376, NULL, N'249-721-945', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (553, N'The Specialist', N'Abdeldayem.hussein@gmail.com', N'1005551166', 95833, NULL, 28906000220160, NULL, N'528-488-678', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (554, N'RAA TOURS', N'raatours.web@gmail.com', N'1005608808', 209460, NULL, 25912099733504, NULL, N'225-562-863', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (555, N'EYouth', N'mohamed@eyouthegypt.com', N'1025828385', 58240, NULL, 29307000848384, NULL, N'530-955-296', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (558, N'Rosheta.com', N'ceo@waqtak.net', N'1063159515', 231316, NULL, 29008299294720, NULL, N'728-554-917', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (566, N'Vetwork Marketplace', N'Abdelrheem@vetwork.co', N'1226939046', 92560, NULL, 28809199878144, NULL, N'519-013-425', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (568, N'ABCs nursery & preschool', N'abcs.nursery@hotmail.com', N'1111173380', NULL, NULL, 28507100938240, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (577, N'Euro Pharma International', N'omarmedhatramadan@gmail.com', N'1281702222', 759, NULL, 25809999888384, NULL, N'200-152-947', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (601, N'cairo satallite channels', N'alaacairo2008@gmail.com', N'1008000160', 37637, NULL, 27401299951616, NULL, N'331-608-723', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (609, N'Authentic Coaching Academy', N'sharaf@relations.academy', N'1114449632', 140153, NULL, 27806299848704, NULL, N'565-251-392', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (610, N'Kon Digital', N'kondigital2020@gmail.com', N'1008686874', 156145, NULL, 28207099150336, NULL, N'602-124-883', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (625, N'Civil Academy', N'eng.abdallhmostafa@yahoo.com', N'1114040583', 115782, NULL, 29106999656448, NULL, N'728-453-304', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (629, N'Petopia', N'Petopia2021@gmail.com', N'2.01063E+11', 14881, NULL, 29411000713216, NULL, N'625-711-815', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (630, N'Inno space', N'manal.Ahmed@innovspace.co', N'1118461033', 157572, NULL, 29303999823872, NULL, N'609-161-083', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (632, N'Upedia', N'Upedia.eg@gmail.com', N'1555565755', 248776, NULL, 29409299922944, NULL, N'569-093-333', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (644, N'Hired Recruitment', N'business@hiredhr.net', N'2.01023E+11', 67218, NULL, 28609299349504, NULL, N'504-933-183', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (648, N'Body Blocks', N'info@bodyblockseg.com', N'1222162784', 90450, NULL, 28209299062784, NULL, N'516-112-155', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (651, N'Omneya Askar', N'omneyaskar66@gmail.com', N'1001210070', NULL, NULL, 26608299671552, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (672, N'Audiohat', N'engr.amr.yousry@gmail.com', N'532812882', 15523, NULL, 28401299619840, NULL, N'596-961-707', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (683, N'Michael''s English', N'mike1.labib@gmail.com', N'1147569146', 28218, NULL, 28211199082496, NULL, N'606-726-209', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (686, N'Nile crystal', N'it@nilecrystal.com', N'1001501470', 16, NULL, 24608099008512, NULL, N'100-026-648', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (689, N'Hammam Alsultan', N'hammamalsultan@gmail.com', N'1127111124', 68852, NULL, 28201199861760, NULL, N'463-362-586', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (698, N'iCare tuition', N'icare@cowpay.me', N'96170112681', 66982, NULL, 27803001028608, NULL, N'447-719-947', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (699, N'International Academy of Experts', N'iexpertsacademy.eg@gmail.com', N'1007614899', 112431, NULL, 29310299668480, NULL, N'552-342-939', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (701, N'Innovitics Inc.', N'info@innovitics.com', N'1221222902', 97663, NULL, 27803300921344, NULL, N'531-149-749', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (706, N'Squad For Digital Marketing', N'dina.ghazaly@bogo-plus.com', N'1063949983', 9094, NULL, 28107299880960, NULL, N'575-103-485', NULL, NULL, NULL)
GO
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (712, N'Golds Gym - Concord', N'Khaled.rashad@goldsgymegypt.com', N'1001885511', 29672, NULL, 27703098998784, NULL, N'200-125-036', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (723, N'Harraz For Food Industry And Natural Products', N'taysir@harrazeg.com', N'1066612600', 405877, NULL, 27402000400384, NULL, N'516-209-353', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (757, N'WinFi', N'mina.naguib@winfico.com', N'1229034706', 124767, NULL, 28610100461568, NULL, N'728-971-410', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (758, N'Sharara', N'shararaus@hotmail.com', N'1011011013', 13563, NULL, 25012100661248, NULL, N'506-804-437', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (759, N'Qaitbay', N'sharara@aia.edu.eg', N'1091119111', 13563, NULL, 25012100661248, NULL, N'506-804-437', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (773, N'Zschool', N'zschool.eg@gmail.com', N'1094181950', 418793, NULL, 28709299945472, NULL, N'547-741-766', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (774, N'Private Business Community', N'dramrhanafy89@gmail.com', N'1228806242', 17771, NULL, 28907099127808, NULL, N'569-869-323', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (775, N'Al iman for E-learning', N'arabiclanguage720@gmail.com', N'1067665914', 167928, NULL, 28709100716032, NULL, N'633-728-853', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (778, N'Empower Hub', N'empowerhub19@gmail.com', N'1007291135', 15813, NULL, 29506100264960, NULL, N'601-863-348', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (783, N'BuilderZ', N'ehab@inovola.co.uk', N'1146145860', 16429, NULL, 29103098953728, NULL, N'633-857-718', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (808, N'Ashraf Helal', N'ashraf@helalcmc.com', N'1005050150', 123917, NULL, 27112199159808, NULL, N'729-259-773', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (813, N'the supplylist', N'm.shaawat@thesupplylist.co', N'2.01287E+11', 170612, NULL, 28711099301888, NULL, N'643-041-338', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (814, N'Egyptian Amateur League - EAL', N'contact@egyptianamateurleague.com', N'1019187777', 91577, NULL, 29307300741120, NULL, N'518-799-085', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (817, N'ICPM Group', N'info@icpm-group.com', N'1121287282', 123669, NULL, 28212199424000, NULL, N'730-600-114', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (825, N'Tyro', N'mokhtar@tyro-app.com', N'1019819906', NULL, NULL, 29404199649280, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (832, N'Saladino Tours', N'''ahmed@saladinotoursegypt.com', N'1221676636', 44988, NULL, 28209299062784, NULL, N'215-274-695', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (835, N'Shopx', N'pgabra@panarab-media.com', N'1285224798', 16551, NULL, 28003199352832, NULL, N'667-638-954', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (837, N'Mashrou El Saada', N'mashrouelsaada@gmail.com', N'1149491918', 157689, NULL, 29207100915712, NULL, N'609-264-745', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (839, N'English 3raby', N'english3raby@gmail.com', N'1094006678', 92537, NULL, 29111300915200, NULL, N'729-125-114', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (851, N'������ ������� ����������', N'elrowad@elrowadinvest.com', N'1115704057', 170111, NULL, 28705000783872, NULL, N'641-134-142', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (853, N'Moahal Academy', N'mohamed.amer.success@gmail.com', N'1124373229', 18322, NULL, 29207300145152, NULL, N'645-562-343', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (854, N'Monglish Academy', N'mrshalaby87@gmail.com', N'1027704069', 163538, NULL, 28703100764160, NULL, N'324-058-810', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (858, N'Yanabea E-School', N'yanabeaschool@gmail.com', N'1501155387', 155447, NULL, 25502999904256, NULL, N'601-769-848', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (863, N'NG Academy', N'h.basiony@ng.edu.eg', N'1096870222', 140153, NULL, 27806299848704, NULL, N'565-251-392', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (869, N'WSFA', N'maghrabation@gmail.com', N'1032551155', 170923, NULL, 27506300157952, NULL, N'643-312-439', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (873, N'IQ Lead', N'admin@iqlead.org', N'1221602177', 57245, NULL, 28700999417856, NULL, N'403-963-958', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (881, N'EYouth2', N'admin@eyouthegypt.com', N'1559302007', 58240, NULL, 29307000848384, NULL, N'530-955-296', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (886, N'Imtenan', N'mahmoud.adam@imtenan.com', N'1210063002', 369456, NULL, 27211199414272, NULL, N'320-814-998', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (887, N'The nile anchor', N'amin@thenileanchor.com', N'1001705545', 169135, NULL, 27510100197376, NULL, N'636-355-055', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (894, N'ORing', N'islam.alnabaa@gmail.com', N'1208502238', NULL, NULL, 29210999521280, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (895, N'LPX', N'ahbahaeldin@gmail.com', N'1003884400', NULL, NULL, 28509300850688, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (897, N'SES', N'waleed.tarek.1@gmail.com', N'1022229146', NULL, NULL, 29004199362560, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (914, N'Hyper Design', N'info@hyper-design.com', N'1063525834', 93735, NULL, 28909200474112, NULL, N'523-602-979', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (925, N'inhouse Creative Studio', N'm.soliman@nhousecreatives.com', N'1111109488', 83200, NULL, 28801100677120, NULL, N'367-185-008', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (929, N'?CLAT Fabric Care', N'ceo@eclatfabriccare.com', N'1065001616', 241975, NULL, 27402300293120, NULL, N'559-345-623', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (979, N'SICAGATE', N'khalededeeb69@gmail.com', N'1111257555', 75461, NULL, 27507099172864, NULL, N'545-785-006', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (981, N'Dr: Mai Seoudy', N'maiseoudy202@gmail.com', N'1011318038', NULL, NULL, 29002200776704, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (982, N'aYa Ghareeb ��� ����', N'ayaghareeb2010@gmail.com', N'1060262802', NULL, NULL, 28807199195136, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (983, N'Israa Zain', N'israa.zain@gmail.com', N'israa.zain@gmail.com', NULL, NULL, 28901099175936, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (984, N'Target Academy', N'sheriefhamed90@gmail.com', N'1063208709', 2260, NULL, 29806299185152, NULL, N'731-574-877', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (987, N'German Speakers', N'Mohamed.salama@dfa-eg.net', N'1019994041', 166625, NULL, 28609200783360, NULL, N'631-052-364', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (990, N'BigBox', N'mhantirah@gmail.com', N'1001090066', NULL, NULL, 27209999843328, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (992, N'BossMom by Marwa Fakher', N'fakher.marwa@gmail.com', N'2.01002E+11', NULL, NULL, 28504099913728, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (996, N'Asmaa Demo', N'asmaa.abdelhamed@cowpay.me', N'1149297343', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (1005, N'PM House - Akram Alnajjar', N'anajjar@pmhouse.org', N'2.01005E+11', 536, NULL, 26107000651776, NULL, N'261-686-534', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (1006, N'Plaza Hotel Alexandria', N'reservation@plazahotelalex.com', N'1223409550', 117472, NULL, 26511199436800, NULL, N'202-470-156', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (1013, N'QFDM', N'ali@qutoon.com', N'1015510263', 18511, NULL, 29608200110080, NULL, N'648-214-915', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (1014, N'Eyadatak', N'support@eyadatak.com', N'19173762132', 129505, NULL, 28801100677120, NULL, N'726-147-397', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (1015, N'Lebanon Egypt for Restaurants', N'y.wahdan@dan.com.eg', N'1222170033', 24054, NULL, 26606999437312, NULL, N'337-945-942', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (1018, N'E-Learning Academy', N'asmaaelsisi1@gmail.com', N'1558488446', NULL, NULL, 28612099047424, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (1019, N'EGY4 SUPPORT', N'ashraf.abdallah312@gmail.com', N'1100890809', 84965, NULL, 27811999907840, NULL, N'499-048-695', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (1021, N'EJADA', N'Marwaeldriny@gmail.com', N'1222532291', 71673, NULL, 27403199971328, NULL, N'332-326-063', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (1025, N'Enlite College', N'info@enlite-college.com', N'545698587', NULL, NULL, 28904999878656, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (1026, N'Nataly Tours 2', N'mnabhan450@gmail.com', N'1001895889', 84131, NULL, 27404099649536, NULL, N'681-596-694', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (1027, N'2 Learn', N'stuffwrk@gmail.com', N'1009558958', 127071, NULL, 28208099491840, NULL, N'726-748-927', NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (1030, N'test cowpay', N'ayatmustafa1@gmail.com', N'1151181895', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Cleansing_Merchants_not_Blocked Users] ([id], [name], [email], [phone], [m_commercial_registry], [m_commercial_registry_file], [m_personal_id], [m_personal_id_file], [m_tax_id], [m_tax_id_file], [m_added_at], [m_approved_at]) VALUES (1031, N'/heba7777', N'Heba.mohy@nviseg.com', N'1115322000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Currency_cowpay] ([currency_code]) VALUES (N'EGP')
GO
INSERT [dbo].[CurrencyTypes_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(1 AS Numeric(5, 0)), N'EG', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Dashboard.View')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Dashboard.IniatePayment')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Transaction.View')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Transaction.ViewDetails')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Transaction.Export')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Transaction.Refund')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Balance.View')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Balance.Export')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Balance.TransferMoney')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.BalanceStatement.View')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.BalanceStatement.Export')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.VAT.View')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.VAT.Export')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Customer.View')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Customer.Export')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Team.View')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Team.Export')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Team.Create')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Team.Edit')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Team.Delete')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.ViewBank')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.ExportBank')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.CreateBank')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.EditBank')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.DeleteBank')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.ViewFawry')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.ExportFawry')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.CreateFawry')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.EditFawry')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.DeleteFawry')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.ViewWallet')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.ExportWallet')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.CreateWallet')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.EditWallet')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Account.DeleteWallet')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Profile.View')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Profile.ViewCompany')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Profile.EditCompany')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Profile.ChangePassword')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.ApiSetting.ViewToken')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.ApiSetting.ExportToken')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.ApiSetting.GenerateToken')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.ApiSetting.RemoveToken')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.ApiSetting.EditCallbackUrl')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.PaymentLink.View')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.Product.View')
INSERT [dbo].[merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (NULL, N'permission', N'Permissions.Merchant.IFrame.View')
GO
INSERT [dbo].[PaymentLinkType_SRC] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(1 AS Numeric(10, 0)), N'OneTimePaymentLink', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL, NULL, 0)
GO
INSERT [dbo].[PaymentLinkTypes_cowpay] ([payment_link_type]) VALUES (N'STANDALONE_PAYMENT_LINK')
INSERT [dbo].[PaymentLinkTypes_cowpay] ([payment_link_type]) VALUES (N'TICKET_PAYMENT_LINK')
INSERT [dbo].[PaymentLinkTypes_cowpay] ([payment_link_type]) VALUES (N'RECURRING_PAYMENT_LINK')
INSERT [dbo].[PaymentLinkTypes_cowpay] ([payment_link_type]) VALUES (N'INVOICE')
GO
INSERT [dbo].[PaymentMethodTypes_cowpay] ([payment_method]) VALUES (N'PAYATFAWRY')
INSERT [dbo].[PaymentMethodTypes_cowpay] ([payment_method]) VALUES (N'CASHONDELIVERY')
INSERT [dbo].[PaymentMethodTypes_cowpay] ([payment_method]) VALUES (N'CARD')
INSERT [dbo].[PaymentMethodTypes_cowpay] ([payment_method]) VALUES (N'WALLET')
INSERT [dbo].[PaymentMethodTypes_cowpay] ([payment_method]) VALUES (N'MEEZA')
GO
INSERT [dbo].[PaymentMethodTypes_Src] ([id], [name], [pgwtypeid], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(1 AS Numeric(5, 0)), N'CreditCard', CAST(5 AS Numeric(5, 0)), NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentMethodTypes_Src] ([id], [name], [pgwtypeid], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(2 AS Numeric(5, 0)), N'PayAtFawry', CAST(1 AS Numeric(5, 0)), NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentMethodTypes_Src] ([id], [name], [pgwtypeid], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(3 AS Numeric(5, 0)), N'FawryB2B', CAST(1 AS Numeric(5, 0)), NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentMethodTypes_Src] ([id], [name], [pgwtypeid], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(4 AS Numeric(5, 0)), N'MeezaCard', CAST(2 AS Numeric(5, 0)), NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentMethodTypes_Src] ([id], [name], [pgwtypeid], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(5 AS Numeric(5, 0)), N'MeezaRequest', CAST(2 AS Numeric(5, 0)), NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentMethodTypes_Src] ([id], [name], [pgwtypeid], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(6 AS Numeric(5, 0)), N'BostaCashCollection', CAST(3 AS Numeric(5, 0)), NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentMethodTypes_Src] ([id], [name], [pgwtypeid], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(7 AS Numeric(5, 0)), N'ValuPurchase', CAST(4 AS Numeric(5, 0)), NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentMethodTypes_Src] ([id], [name], [pgwtypeid], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(8 AS Numeric(5, 0)), N'Recurring', CAST(5 AS Numeric(5, 0)), NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentMethodTypes_Src] ([id], [name], [pgwtypeid], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(9 AS Numeric(5, 0)), N'Authorize', CAST(5 AS Numeric(5, 0)), NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentMethodTypes_Src] ([id], [name], [pgwtypeid], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(10 AS Numeric(5, 0)), N'Capture', CAST(5 AS Numeric(5, 0)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[PaymentStatusTypes_cowpay] ([payment_status]) VALUES (N'ARRIVED_AT_CUSTOMER')
INSERT [dbo].[PaymentStatusTypes_cowpay] ([payment_status]) VALUES (N'DELIVERED')
INSERT [dbo].[PaymentStatusTypes_cowpay] ([payment_status]) VALUES (N'EXPIRED')
INSERT [dbo].[PaymentStatusTypes_cowpay] ([payment_status]) VALUES (N'FAILED')
INSERT [dbo].[PaymentStatusTypes_cowpay] ([payment_status]) VALUES (N'PAID')
INSERT [dbo].[PaymentStatusTypes_cowpay] ([payment_status]) VALUES (N'PARTIALLY_REFUNDED')
INSERT [dbo].[PaymentStatusTypes_cowpay] ([payment_status]) VALUES (N'PARTIAL_REFUNDED')
INSERT [dbo].[PaymentStatusTypes_cowpay] ([payment_status]) VALUES (N'PENDING')
INSERT [dbo].[PaymentStatusTypes_cowpay] ([payment_status]) VALUES (N'PICKING_UP')
INSERT [dbo].[PaymentStatusTypes_cowpay] ([payment_status]) VALUES (N'REFUNDED')
INSERT [dbo].[PaymentStatusTypes_cowpay] ([payment_status]) VALUES (N'TERMINATED')
INSERT [dbo].[PaymentStatusTypes_cowpay] ([payment_status]) VALUES (N'UNPAID')
GO
INSERT [dbo].[PaymentStatusTypes_Src] ([id], [name], [statuscode], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(1 AS Numeric(5, 0)), N'Pending', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentStatusTypes_Src] ([id], [name], [statuscode], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(2 AS Numeric(5, 0)), N'Paid', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentStatusTypes_Src] ([id], [name], [statuscode], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(3 AS Numeric(5, 0)), N'Unpaid', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentStatusTypes_Src] ([id], [name], [statuscode], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(4 AS Numeric(5, 0)), N'Expired', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentStatusTypes_Src] ([id], [name], [statuscode], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(5 AS Numeric(5, 0)), N'Failed', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentStatusTypes_Src] ([id], [name], [statuscode], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(6 AS Numeric(5, 0)), N'Refunded', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PaymentStatusTypes_Src] ([id], [name], [statuscode], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(7 AS Numeric(5, 0)), N'PartiallyRefunded', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[PGWTypes_cowpay] ([payment_gateway]) VALUES (N'FAWRY')
INSERT [dbo].[PGWTypes_cowpay] ([payment_gateway]) VALUES (N'BOSTA')
INSERT [dbo].[PGWTypes_cowpay] ([payment_gateway]) VALUES (N'DIXI')
INSERT [dbo].[PGWTypes_cowpay] ([payment_gateway]) VALUES (N'UPG')
GO
INSERT [dbo].[PGWTypes_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(1 AS Numeric(5, 0)), N'Fawry', NULL, NULL, NULL, NULL)
INSERT [dbo].[PGWTypes_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(2 AS Numeric(5, 0)), N'Meeza', NULL, NULL, NULL, NULL)
INSERT [dbo].[PGWTypes_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(3 AS Numeric(5, 0)), N'Bosta', NULL, NULL, NULL, NULL)
INSERT [dbo].[PGWTypes_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(4 AS Numeric(5, 0)), N'Valu', NULL, NULL, NULL, NULL)
INSERT [dbo].[PGWTypes_Src] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(5 AS Numeric(5, 0)), N'Akurateko', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Commercial International Bank ', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2021-04-11T12:36:24.000' AS DateTime), N'17')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'qwe', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2020-09-25T16:56:46.000' AS DateTime), N'30')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'AlAhly', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2020-09-25T16:56:46.000' AS DateTime), N'9')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Qatar National Bank Alahli', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2021-04-11T12:36:24.000' AS DateTime), N'37')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Bank of Alexandria', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'14')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Banque Misr', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2020-09-25T16:56:46.000' AS DateTime), N'30')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Arab Bank ', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'7')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'National Bank of Egypt', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2020-09-25T16:56:46.000' AS DateTime), N'31')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Audi Bank', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'10')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Export Development Bank of Egypt', CAST(N'2020-02-09T08:58:53.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'20')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Arab African International Bank', CAST(N'2020-02-13T19:21:40.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'1')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'HSBC', CAST(N'2020-02-16T13:10:47.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'26')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Credit Agricole', CAST(N'2020-03-10T10:47:03.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'15')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Faisal Islamic Bank of Egypt', CAST(N'2020-03-22T16:28:22.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'24')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Ahly United Bank', CAST(N'2020-05-04T16:02:34.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'9')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'The United Bank', CAST(N'2020-05-23T15:14:39.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'40')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Abu Dhabi Islamic Bank – Egypt', CAST(N'2020-06-16T21:29:55.000' AS DateTime), CAST(N'2021-06-09T15:25:22.000' AS DateTime), N'4')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Al Baraka Bank Egypt', CAST(N'2020-10-20T10:44:50.000' AS DateTime), CAST(N'2021-04-11T12:36:26.000' AS DateTime), N'5')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Emirates National Bank of Dubai', CAST(N'2020-07-13T10:44:18.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'22')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Abu Dhabi Islamic Bank - Egypt', CAST(N'2020-07-13T17:38:37.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'4')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Blom Bank Egypt', CAST(N'2020-08-15T16:50:21.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'13')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Egyptian Gulf Bank', CAST(N'2020-09-16T11:38:53.000' AS DateTime), CAST(N'2021-04-11T12:36:27.000' AS DateTime), N'21')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Banque Du Caire', CAST(N'2020-09-23T06:29:39.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'12')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Suez Canal Bank', CAST(N'2020-09-30T13:48:17.000' AS DateTime), CAST(N'2021-04-11T12:36:27.000' AS DateTime), N'39')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Attijariwafa Bank Egypt', CAST(N'2020-10-06T15:26:17.000' AS DateTime), CAST(N'2021-04-11T12:36:27.000' AS DateTime), N'11')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'', CAST(N'2021-01-05T01:04:51.000' AS DateTime), CAST(N'2021-04-11T12:36:26.000' AS DateTime), N'30')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'National Bank of Kuwait', CAST(N'2021-02-09T11:06:49.000' AS DateTime), CAST(N'2021-04-11T12:36:26.000' AS DateTime), N'33')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Union National Bank', CAST(N'2021-02-09T11:33:29.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'41')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'The Principal Bank for Development and Agri.', CAST(N'2021-03-30T11:07:25.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'35')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Al Ahli Bank of Kuwait - Egypt ', CAST(N'2021-03-31T13:06:37.000' AS DateTime), CAST(N'2021-04-11T12:36:25.000' AS DateTime), N'3')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Abu Dhabi Islamic Bank Egypt', CAST(N'2021-04-22T23:45:34.000' AS DateTime), CAST(N'2021-04-22T23:45:34.000' AS DateTime), N'4')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'﻿Arab African International Bank', CAST(N'2021-05-10T09:25:22.000' AS DateTime), CAST(N'2021-05-10T09:25:22.000' AS DateTime), N'1')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Credit Agricole Egypt', CAST(N'2021-05-16T21:08:37.000' AS DateTime), CAST(N'2021-05-16T21:08:37.000' AS DateTime), N'15')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'CIB', CAST(N'2021-05-24T11:09:49.000' AS DateTime), CAST(N'2021-05-24T11:09:49.000' AS DateTime), N'17')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'QNB', CAST(N'2021-06-08T17:48:44.000' AS DateTime), CAST(N'2021-06-08T17:48:44.000' AS DateTime), N'37')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'QNB AlAHLI', CAST(N'2021-06-08T19:48:41.000' AS DateTime), CAST(N'2021-06-08T19:48:41.000' AS DateTime), N'37')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'البنك الاهلي للمعاملات الاسلاميه', CAST(N'2021-06-08T20:58:35.000' AS DateTime), CAST(N'2021-06-08T20:58:35.000' AS DateTime), N'9')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'bank Misr', CAST(N'2021-06-10T16:22:59.000' AS DateTime), CAST(N'2021-06-10T16:22:59.000' AS DateTime), N'30')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Bank Du Caire', CAST(N'2021-06-10T20:07:14.000' AS DateTime), CAST(N'2021-06-10T20:07:14.000' AS DateTime), N'12')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'NBE', CAST(N'2021-06-12T10:50:32.000' AS DateTime), CAST(N'2021-06-12T10:50:32.000' AS DateTime), N'31')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Egyptian Arab Land Bank', CAST(N'2021-08-05T10:26:47.000' AS DateTime), CAST(N'2021-08-05T10:26:47.000' AS DateTime), N'19')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Arab Banking Corporation', CAST(N'2021-10-05T17:43:37.000' AS DateTime), CAST(N'2021-10-05T17:43:37.000' AS DateTime), N'2')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Central Bank of Egypt', CAST(N'2021-10-05T20:15:33.000' AS DateTime), CAST(N'2021-10-05T20:15:33.000' AS DateTime), N'16')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'masr', CAST(N'2021-11-14T17:13:23.000' AS DateTime), CAST(N'2021-11-14T17:13:23.000' AS DateTime), N'30')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'1', CAST(N'2021-11-14T17:14:01.000' AS DateTime), CAST(N'2021-11-14T17:14:01.000' AS DateTime), N'30')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'&', CAST(N'2021-11-14T17:16:05.000' AS DateTime), CAST(N'2021-11-14T17:16:05.000' AS DateTime), N'30')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'sdgsdgsdg', CAST(N'2021-11-22T03:23:07.000' AS DateTime), CAST(N'2021-11-22T03:23:07.000' AS DateTime), N'30')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Please, Select your bank name', CAST(N'2021-11-30T15:30:11.000' AS DateTime), CAST(N'2021-11-30T15:30:11.000' AS DateTime), N'30')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Arab African International Bank', NULL, NULL, N'1')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Arab Banking Corporation', NULL, NULL, N'2')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Al Ahli Bank of Kuwait – Egypt', NULL, NULL, N'3')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Abu Dhabi Islamic Bank – Egypt', NULL, NULL, N'4')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Al Baraka Bank Egypt', NULL, NULL, N'5')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Arab Investment Bank', NULL, NULL, N'6')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Arab Bank', NULL, NULL, N'7')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Arab International Bank', NULL, NULL, N'8')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Ahly United Bank', NULL, NULL, N'9')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Audi Bank', NULL, NULL, N'10')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Attijariwafa Bank Egypt', NULL, NULL, N'11')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Banque Du Caire', NULL, NULL, N'12')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Blom Bank Egypt', NULL, NULL, N'13')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Bank of Alexandria', NULL, NULL, N'14')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Credit Agricole Egypt', NULL, NULL, N'15')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Central Bank of Egypt', NULL, NULL, N'16')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Commercial International Bank', NULL, NULL, N'17')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Citibank', NULL, NULL, N'18')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Egyptian Arab Land Bank', NULL, NULL, N'19')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Export Development Bank of Egypt', NULL, NULL, N'20')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Egyptian Gulf Bank', NULL, NULL, N'21')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Emirates National Bank of Dubai', NULL, NULL, N'22')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'First Abu Dhabi Bank', NULL, NULL, N'23')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Faisal Islamic Bank of Egypt', NULL, NULL, N'24')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Housing And Development Bank', NULL, NULL, N'25')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'HSBC', NULL, NULL, N'26')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Industrial Development Bank of Egypt', NULL, NULL, N'27')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Mashreq Bank', NULL, NULL, N'28')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Misr Iran Development Bank', NULL, NULL, N'29')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Banque Misr', NULL, NULL, N'30')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'National Bank of Egypt', NULL, NULL, N'31')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'National Bank of Greece', NULL, NULL, N'32')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'National Bank of Kuwait', NULL, NULL, N'33')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Nasser social Bank', NULL, NULL, N'34')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'The Principal Bank for Development and Agri.', NULL, NULL, N'35')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Egypt Post', NULL, NULL, N'36')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Qatar National Bank Alahli', NULL, NULL, N'37')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Societe Arabe Internationale De Banque', NULL, NULL, N'38')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Suez Canal Bank', NULL, NULL, N'39')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'The United Bank', NULL, NULL, N'40')
INSERT [dbo].[Ref_Banks] ([bank_name], [created_at], [updated_at], [New_Sys_Value]) VALUES (N'Union National Bank', NULL, NULL, N'41')
GO
INSERT [dbo].[Ref_ChannelTypes] ([channel], [New_Sys_Value]) VALUES (N'', N'1')
INSERT [dbo].[Ref_ChannelTypes] ([channel], [New_Sys_Value]) VALUES (N'API', N'2')
INSERT [dbo].[Ref_ChannelTypes] ([channel], [New_Sys_Value]) VALUES (N'PAYMENT_LINKS', N'1')
INSERT [dbo].[Ref_ChannelTypes] ([channel], [New_Sys_Value]) VALUES (N'DIRECT_PAYMENT', N'2')
INSERT [dbo].[Ref_ChannelTypes] ([channel], [New_Sys_Value]) VALUES (N'IFRAME', N'1')
INSERT [dbo].[Ref_ChannelTypes] ([channel], [New_Sys_Value]) VALUES (N'CHECKOUT', N'1')
GO
INSERT [dbo].[Ref_CurrencyTypes] ([currency_code], [New_Sys_Value]) VALUES (N'EGP', N'1')
GO
INSERT [dbo].[Ref_PaymentLinkType] ([payment_link_type], [New_Sys_Value]) VALUES (N'STANDALONE_PAYMENT_LINK', N'1')
INSERT [dbo].[Ref_PaymentLinkType] ([payment_link_type], [New_Sys_Value]) VALUES (N'TICKET_PAYMENT_LINK', NULL)
INSERT [dbo].[Ref_PaymentLinkType] ([payment_link_type], [New_Sys_Value]) VALUES (N'RECURRING_PAYMENT_LINK', NULL)
INSERT [dbo].[Ref_PaymentLinkType] ([payment_link_type], [New_Sys_Value]) VALUES (N'INVOICE', NULL)
GO
INSERT [dbo].[Ref_PaymentMethodTypes] ([payment_method], [New_Sys_Value]) VALUES (N'PAYATFAWRY', N'2')
INSERT [dbo].[Ref_PaymentMethodTypes] ([payment_method], [New_Sys_Value]) VALUES (N'CASHONDELIVERY', N'6')
INSERT [dbo].[Ref_PaymentMethodTypes] ([payment_method], [New_Sys_Value]) VALUES (N'CARD', N'1')
INSERT [dbo].[Ref_PaymentMethodTypes] ([payment_method], [New_Sys_Value]) VALUES (N'WALLET', N'5')
INSERT [dbo].[Ref_PaymentMethodTypes] ([payment_method], [New_Sys_Value]) VALUES (N'MEEZA', N'4')
GO
INSERT [dbo].[Ref_PaymentStatusTypes] ([payment_status], [New_Sys_Value]) VALUES (N'ARRIVED_AT_CUSTOMER', N'3')
INSERT [dbo].[Ref_PaymentStatusTypes] ([payment_status], [New_Sys_Value]) VALUES (N'DELIVERED', N'2')
INSERT [dbo].[Ref_PaymentStatusTypes] ([payment_status], [New_Sys_Value]) VALUES (N'EXPIRED', N'4')
INSERT [dbo].[Ref_PaymentStatusTypes] ([payment_status], [New_Sys_Value]) VALUES (N'FAILED', N'5')
INSERT [dbo].[Ref_PaymentStatusTypes] ([payment_status], [New_Sys_Value]) VALUES (N'PAID', N'2')
INSERT [dbo].[Ref_PaymentStatusTypes] ([payment_status], [New_Sys_Value]) VALUES (N'PARTIALLY_REFUNDED', N'7')
INSERT [dbo].[Ref_PaymentStatusTypes] ([payment_status], [New_Sys_Value]) VALUES (N'PARTIAL_REFUNDED', N'7')
INSERT [dbo].[Ref_PaymentStatusTypes] ([payment_status], [New_Sys_Value]) VALUES (N'PENDING', N'1')
INSERT [dbo].[Ref_PaymentStatusTypes] ([payment_status], [New_Sys_Value]) VALUES (N'PICKING_UP', N'3')
INSERT [dbo].[Ref_PaymentStatusTypes] ([payment_status], [New_Sys_Value]) VALUES (N'REFUNDED', N'6')
INSERT [dbo].[Ref_PaymentStatusTypes] ([payment_status], [New_Sys_Value]) VALUES (N'TERMINATED', N'3')
INSERT [dbo].[Ref_PaymentStatusTypes] ([payment_status], [New_Sys_Value]) VALUES (N'UNPAID', N'3')
GO
INSERT [dbo].[Ref_PGWTypes] ([payment_gateway], [New_Sys_Value]) VALUES (N'FAWRY', N'1')
INSERT [dbo].[Ref_PGWTypes] ([payment_gateway], [New_Sys_Value]) VALUES (N'BOSTA', N'3')
INSERT [dbo].[Ref_PGWTypes] ([payment_gateway], [New_Sys_Value]) VALUES (N'DIXI', N'5')
INSERT [dbo].[Ref_PGWTypes] ([payment_gateway], [New_Sys_Value]) VALUES (N'UPG', N'2')
GO
INSERT [dbo].[Ref_StatusTypes] ([status], [New_Sys_Value]) VALUES (N'APPROVED', N'2')
INSERT [dbo].[Ref_StatusTypes] ([status], [New_Sys_Value]) VALUES (N'CANCELLED', N'3')
INSERT [dbo].[Ref_StatusTypes] ([status], [New_Sys_Value]) VALUES (N'NEED_APPROVAL', N'1')
INSERT [dbo].[Ref_StatusTypes] ([status], [New_Sys_Value]) VALUES (N'REJECTED', N'3')
INSERT [dbo].[Ref_StatusTypes] ([status], [New_Sys_Value]) VALUES (N'PENDING', N'1')
GO
INSERT [dbo].[StatusTypes_Cowpay] ([status]) VALUES (N'APPROVED')
INSERT [dbo].[StatusTypes_Cowpay] ([status]) VALUES (N'CANCELLED')
INSERT [dbo].[StatusTypes_Cowpay] ([status]) VALUES (N'NEED_APPROVAL')
INSERT [dbo].[StatusTypes_Cowpay] ([status]) VALUES (N'REJECTED')
GO
INSERT [dbo].[StatusTypes_SRC] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(1 AS Numeric(5, 0)), N'Pending', NULL, NULL, NULL, NULL)
INSERT [dbo].[StatusTypes_SRC] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(2 AS Numeric(5, 0)), N'Approved', NULL, NULL, NULL, NULL)
INSERT [dbo].[StatusTypes_SRC] ([id], [name], [createddate], [updateddate], [deleteddate], [isdeleted]) VALUES (CAST(3 AS Numeric(5, 0)), N'Decline', NULL, NULL, NULL, NULL)
GO
