USE [master]
GO
/****** Object:  Database [Staging_Migration]    Script Date: 10/18/2022 1:40:40 PM ******/
CREATE DATABASE [Staging_Migration]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Staging_Migration', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Staging_Migration.mdf' , SIZE = 1843200KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Staging_Migration_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Staging_Migration_log.ldf' , SIZE = 1449984KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Staging_Migration] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Staging_Migration].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Staging_Migration] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Staging_Migration] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Staging_Migration] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Staging_Migration] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Staging_Migration] SET ARITHABORT OFF 
GO
ALTER DATABASE [Staging_Migration] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Staging_Migration] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Staging_Migration] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Staging_Migration] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Staging_Migration] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Staging_Migration] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Staging_Migration] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Staging_Migration] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Staging_Migration] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Staging_Migration] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Staging_Migration] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Staging_Migration] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Staging_Migration] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Staging_Migration] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Staging_Migration] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Staging_Migration] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Staging_Migration] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Staging_Migration] SET RECOVERY FULL 
GO
ALTER DATABASE [Staging_Migration] SET  MULTI_USER 
GO
ALTER DATABASE [Staging_Migration] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Staging_Migration] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Staging_Migration] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Staging_Migration] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Staging_Migration] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Staging_Migration] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Staging_Migration', N'ON'
GO
ALTER DATABASE [Staging_Migration] SET QUERY_STORE = OFF
GO
USE [Staging_Migration]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 10/18/2022 1:40:40 PM ******/
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
	[Old_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Cards_Prepared]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[Cards_Prepared] as
select 

ca.[id] as old_id,
try_cast(cu.Id as bigint) as [CustomerId] ,
convert(char(6),first_six)+'******'+convert(char(4),last_four) as [CardNumber],
[first_six] as [FirstSix] ,
[last_four] as [LastFour] ,
[expiry_month] as [CardExpMonth] ,
[expiry_year] as [CardExpYear] ,
[token] as [CardToken] ,
[token_expiry_date] as [TokenExpiryDate],
ca.[created_at] as [CreatedDate],
ca.[updated_at] as [UpdatedDate],
ca.[deleted_at] as [DeletedDate],
null as [IsDeleted] ,
isnull(cu.MerchantId,0) as [MerchantId]
from [CowPay_Production_Simulation].dbo.cards ca
join [Staging_Migration].[dbo].[Customers] cu
on ca.merchant_card_holder_id=cu.Old_id
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[DeletedDate] [varchar](50) NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [varchar](50) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[old_code] [varchar](50) NULL,
	[old_id] [int] NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[UserRoles_Prepared]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[UserRoles_Prepared] as


with new_user_roles as (
select 

case when m.[role_id] in(1,3,4) then '18ad5048-e0fb-4514-ae3c-237714165103' 
when m.[role_id] in(2,5)  then 'f62057bf-ebb7-463c-ae27-cd34a13232ea' end as [RoleId]
,u.id as [UserId]
,m.[model_id] as Old_Userid 
,m.[role_id] as Old_Roleid
from [CowPay_Production_Simulation].[dbo].[model_has_roles] m join [Staging_Migration].[dbo].[AspNetUsers] u
on u.[old_id]=m.[model_id])

,filterd_RS 
as (

select 
ROW_NUMBER() over (partition by RoleId+'_'+UserId order by Old_Userid,Old_Roleid asc) as rn
,RoleId
,UserId
--,RoleId+'_'+UserId as lol 
,Old_Userid
,Old_Roleid
from new_user_roles

)
--group by RoleId+'_'+UserId --, min(Old_Userid),min(Old_Roleid)

select * from filterd_RS where rn=1
GO
/****** Object:  Table [dbo].[Staging_Merchant]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staging_Merchant](
	[index] [bigint] NULL,
	[id] [bigint] NULL,
	[parent_id] [varchar](max) NULL,
	[name] [varchar](max) NULL,
	[email] [varchar](max) NULL,
	[phone] [varchar](max) NULL,
	[password] [varchar](max) NULL,
	[api_token] [varchar](max) NULL,
	[remember_token] [varchar](max) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[is_merchant] [bigint] NULL,
	[m_sms_id] [varchar](max) NULL,
	[m_payments_notification] [bigint] NULL,
	[m_orders_notification] [bigint] NULL,
	[m_country_id] [float] NULL,
	[m_city_id] [float] NULL,
	[m_facebook] [varchar](max) NULL,
	[m_twitter] [varchar](max) NULL,
	[m_linked_in] [varchar](max) NULL,
	[m_instagram] [varchar](max) NULL,
	[m_about] [varchar](max) NULL,
	[m_website] [varchar](max) NULL,
	[m_logo] [varchar](max) NULL,
	[m_code] [varchar](max) NULL,
	[m_hash_key] [varchar](max) NULL,
	[m_address] [varchar](max) NULL,
	[m_invoices] [float] NULL,
	[m_balance] [float] NULL,
	[m_available_balance] [float] NULL,
	[m_min_payout_threshold] [float] NULL,
	[m_bank_name] [varchar](max) NULL,
	[m_bank_address] [varchar](max) NULL,
	[m_bank_account_num] [varchar](max) NULL,
	[m_bank_account_name] [varchar](max) NULL,
	[m_bank_account_holder_name] [varchar](max) NULL,
	[m_bank_account_swift_code] [varchar](max) NULL,
	[m_callback_url] [varchar](max) NULL,
	[m_ipn_listener_url] [varchar](max) NULL,
	[m_total_received_amount] [float] NULL,
	[m_cowpay_commission] [float] NULL,
	[m_cowpay_payatfawry_percentage_commission] [float] NULL,
	[m_cowpay_payatfawry_fixed_commission] [float] NULL,
	[m_cowpay_credit_card_percentage_commission] [float] NULL,
	[m_cowpay_credit_card_fixed_commission] [float] NULL,
	[m_cowpay_collect_percentage_commission] [float] NULL,
	[m_cowpay_collect_fixed_commission] [float] NULL,
	[m_commercial_registry_file] [varchar](max) NULL,
	[m_tax_id_file] [varchar](max) NULL,
	[m_personal_id_file] [varchar](max) NULL,
	[m_commercial_registry] [varchar](max) NULL,
	[m_tax_id] [varchar](max) NULL,
	[m_personal_id] [varchar](max) NULL,
	[m_total_sales_per_year] [float] NULL,
	[m_added_by] [float] NULL,
	[m_added_at] [datetime] NULL,
	[m_approved_by] [float] NULL,
	[m_approved_at] [datetime] NULL,
	[environment] [varchar](max) NULL,
	[block] [bigint] NULL,
	[name_ar] [varchar](max) NULL,
	[category] [varchar](max) NULL,
	[mid_category] [varchar](max) NULL,
	[contract_file] [varchar](max) NULL,
	[authorize_signatory_name] [varchar](max) NULL,
	[fawry_sub_merchant] [varchar](max) NULL,
	[cowpay_fees] [float] NULL,
	[status] [varchar](max) NULL,
	[json_settings] [varchar](max) NULL,
	[Urls_settings] [varchar](max) NULL,
	[json_image] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Merchants]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Merchants](
	[Id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[MasterMerchantId] [bigint] NULL,
	[MerchantCode] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NULL,
	[Name] [nvarchar](150) NOT NULL,
	[Mobile] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[CountryId] [smallint] NOT NULL,
	[CityId] [smallint] NOT NULL,
	[Address] [nvarchar](250) NULL,
	[OptionalAddress] [nvarchar](250) NULL,
	[NationalId] [nchar](14) NULL,
	[CommercialRegistrationNum] [nvarchar](50) NULL,
	[TaxId] [nchar](50) NULL,
	[AttachamentImages] [nvarchar](max) NULL,
	[SocialLinks] [nvarchar](max) NULL,
	[StatusTypeId] [smallint] NOT NULL,
	[Settings] [nvarchar](max) NULL,
	[IsWebsite] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	[DeletedDate] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[Logo] [nvarchar](max) NULL,
	[AboutUs] [nvarchar](max) NULL,
	[TermsAndConditions] [nvarchar](max) NULL,
	[old_id] [bigint] NULL,
	[Is_Old_System] [bit] NULL,
	[old_code] [varchar](50) NULL,
 CONSTRAINT [PK_Merchants] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Orders_Prepared]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[Orders_Prepared] as 
select 
null as ID
,NEWID() as   O_OrderCode 
,m.Id O_MerchantId 
,m.MerchantCode  O_MerchantCode 
,ord.merchant_reference_id O_MerchantRefId 
,null O_OrderMetaId 
,ord.customer_merchant_profile_id O_CustomerRefId   
,(select c.Id from Customers c where c.Old_id=ord.customer_id) O_CustomerId  
,ord.amount  O_OrderAmount 
,ord.fees_amount  O_FeesAmount
,ord.vat_amount  O_VatAmount
,0  O_CustomerAmount 
,0  O_MerchantAmount 
,1  O_CurrencyId 
,N'EG'  O_Currency 
,try_convert(nvarchar(1000),ord.description)  O_Description 
,null  O_OrderDetails
,ord.paid_at  O_PaidDate 
,ord.expires_at  O_ExpiredDate
,null  O_ActionDate 
,ord.created_at  O_CreatedDate
,ord.updated_at  O_UpdatedDate
,ord.deleted_at  O_DeletedDate
,null  O_IsDeleted 
,try_convert(int,ord.payment_status)  O_PaymentStatusTypeId
--  FROM TransactionManagement.dbo.Orders
-------------------------
--,NULL  OM_ID
,try_convert(int,ord.payment_gateway)  OM_PGWTypeId
,TRY_CONVERT(int,ord.channel)  OM_ChannelTypeId
,TRY_CONVERT(int,ord.payment_link_type) OM_PaymentLinkTypeId
, null OM_PaymentLinkId
, ord.payment_method OM_PaymentMethodTypeId
, ord.card_number OM_CardNumber
, ord.token OM_Token
, null OM_ExtraData
--,  OM_PGWMetaRequest
--,  OM_PGWMetaResponse
,pc.name  OM_PromoCode
,ord.payment_gateway_reference_id  OM_PGWRefId
,try_convert(nvarchar(1000),(select m_callback_url from Staging_Merchant where id=m.old_id))  OM_ReturnURL
, ord.created_at OM_CreatedDate
, ord.updated_at OM_UpdatedDate
, ord.deleted_at OM_DeletedDate
, null OM_IsDeleted
,ord.id  Old_Id
from CowPay_Production_Simulation.dbo.Orders ord join Merchants m on ord.merchant_code=m.old_code
left join CowPay_Production_Simulation.[dbo].[promo_codes] pc on ord.promo_code_id=pc.id
GO
/****** Object:  Table [dbo].[Orders-Meta]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders-Meta](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[O_OrderCode] [uniqueidentifier] NULL,
	[O_MerchantId] [bigint] NULL,
	[O_MerchantCode] [uniqueidentifier] NULL,
	[O_MerchantRefId] [nvarchar](64) NULL,
	[O_OrderMetaId] [int] NULL,
	[O_CustomerRefId] [nvarchar](64) NULL,
	[O_CustomerId] [bigint] NULL,
	[O_OrderAmount] [float] NULL,
	[O_FeesAmount] [float] NULL,
	[O_VatAmount] [float] NULL,
	[O_CustomerAmount] [int] NULL,
	[O_MerchantAmount] [int] NULL,
	[O_CurrencyId] [int] NULL,
	[O_Currency] [nvarchar](2) NULL,
	[O_Description] [nvarchar](1000) NULL,
	[O_OrderDetails] [int] NULL,
	[O_PaidDate] [datetime] NULL,
	[O_ExpiredDate] [datetime] NULL,
	[O_ActionDate] [int] NULL,
	[O_CreatedDate] [datetime] NULL,
	[O_UpdatedDate] [datetime] NULL,
	[O_DeletedDate] [datetime] NULL,
	[O_IsDeleted] [int] NULL,
	[O_PaymentStatusTypeId] [int] NULL,
	[OM_PGWTypeId] [int] NULL,
	[OM_ChannelTypeId] [int] NULL,
	[OM_PaymentLinkTypeId] [int] NULL,
	[OM_PaymentLinkId] [int] NULL,
	[OM_PaymentMethodTypeId] [nvarchar](14) NULL,
	[OM_CardNumber] [nvarchar](199) NULL,
	[OM_Token] [nvarchar](1024) NULL,
	[OM_ExtraData] [int] NULL,
	[OM_PromoCode] [nvarchar](191) NULL,
	[OM_PGWRefId] [nvarchar](199) NULL,
	[OM_ReturnURL] [nvarchar](1000) NULL,
	[OM_CreatedDate] [datetime] NULL,
	[OM_UpdatedDate] [datetime] NULL,
	[OM_DeletedDate] [datetime] NULL,
	[OM_IsDeleted] [int] NULL,
	[Old_Id] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[OrderTransactions_Prepared]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[OrderTransactions_Prepared] as 

select 
--Null   as [Id]
NEWID()   as [TranxCode]
,t.transaction_number  as [TranxNumber]
,(select m.Id from Merchants m where m.old_code=t.merchant_code)   as [MerchantId]
, (select m.MerchantCode from Merchants m where m.old_code=t.merchant_code)   as [MerchantCode]
, (select o.ID from [Orders-Meta] o where o.Old_Id=t.model_id)  as [OrderId]
, t.amount  as [Amount]
, t.fees_amount  as [FeesAmount]
, t.vat_amount  as [VatAmount]
, 0  as [CustomerAmount]
, 0  as [MerchantAmount]
,  1 as [CurrencyId]
,  N'EG' as [Currency]
,  case when t.type='OUT' then 2 else 1 end  as [TransactionTypeId]
, case when t.type='OUT' then 1 else 4 end  as [OperationTypeId]
, t.created_at  as [CreatedDate]
, t.updated_at  as [UpdatedDate]
, t.deleted_at  as [DeletedDate]
, null  as [IsDeleted]
,  1 as [TransactionStatusId]
,  null as [PGWMetaRequest]
,  null as [PGWMetaResponse]
,  null as [IsFeesOnCustomer]
,  1 as [IsSuccess]
,  t.id as old_id
 

 
from CowPay_Production_Simulation.dbo.transactions t
where t.model in ('App\Models\Order','App\Modules\Order\Models\Order') 
GO
/****** Object:  View [dbo].[Staging_Merchants_Prepared]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[Staging_Merchants_Prepared] as 

select NEWID() as New_id 
,1 as MasterMerchantId
,cast([name] as nvarchar(50)) as name
,cast([email] as nvarchar(50)) as email
,cast([phone] as nvarchar(50)) as phone
  ,cast([m_address] as nvarchar(250)) as m_address
  ,[index]
      
      ,[parent_id],
	   case 
 when block = 0 and is_merchant = 1 then 2
 when block = 1 and is_merchant = 1 then 4 end as status
      ,[password]
      ,[api_token]
      ,[remember_token]
      ,[created_at]
      ,[updated_at]
      ,[is_merchant]
      ,[m_sms_id]
      ,[m_payments_notification]
      ,[m_orders_notification]
      , 4 as [m_country_id]
      ,3 as [m_city_id]
      ,[m_facebook]
      ,[m_twitter]
      ,[m_linked_in]
      ,[m_instagram]
      ,try_cast([m_about] as nvarchar(max) ) as m_about
      ,[m_website]
      ,try_cast([m_logo] as nvarchar(max) ) as m_logo
      ,[m_code]
      ,[m_hash_key]
  
      ,[m_invoices]
      ,[m_balance]
      ,[m_available_balance]
      ,[m_min_payout_threshold]
      ,[m_bank_name]
      ,[m_bank_address]
      ,[m_bank_account_num]
      ,[m_bank_account_name]
      ,[m_bank_account_holder_name]
      ,[m_bank_account_swift_code]
      ,[m_callback_url]
      ,[m_ipn_listener_url]
      ,[m_total_received_amount]
      ,[m_cowpay_commission]
      ,[m_cowpay_payatfawry_percentage_commission]
      ,[m_cowpay_payatfawry_fixed_commission]
      ,[m_cowpay_credit_card_percentage_commission]
      ,[m_cowpay_credit_card_fixed_commission]
      ,[m_cowpay_collect_percentage_commission]
      ,[m_cowpay_collect_fixed_commission]
      ,[m_commercial_registry_file]
      ,[m_tax_id_file]
      ,[m_personal_id_file]
,try_cast ([m_commercial_registry] as nvarchar(50)) as m_commercial_registry 
      
      ,try_cast([m_tax_id] as nchar(50)) as  m_tax_id
     ,try_cast([m_personal_id] as nchar(14)) as m_personal_id 
      ,[m_total_sales_per_year]
      ,[m_added_by]
      ,[m_added_at]
      ,[m_approved_by]
      ,[m_approved_at]
      ,[environment]
      ,[block]
      ,[name_ar]
      ,[category]
      ,[mid_category]
      ,[contract_file]
      ,[authorize_signatory_name]
      ,[fawry_sub_merchant]
      ,[cowpay_fees]
      ,[status] as old_status
      ,try_cast([json_settings] as nvarchar(max)) as json_settings
      ,try_cast([Urls_settings] as nvarchar(max)) as Urls_settings
      ,try_cast([json_image] as nvarchar(max)) as json_image
	  , 1 as is_old_System
	  ,try_cast(m_code as varchar(50)) as old_code
	  ,[id] as old_id
	  ,(select id from AspNetUsers where old_code=sm.m_code) as UserId
from [dbo].[Staging_Merchant] sm
GO
/****** Object:  View [dbo].[Mobile_Wallets_Prepared]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[Mobile_Wallets_Prepared]
as


with Merchant_Wallets as(
select 
NEWID() as WalletCode
,TRY_CONVERT(nvarchar(150),m.Name) as HolderName
,1 as IsDefault
,m.Id as MerchantID
,1 as IsMerchantAccount
,case when len(mw.mobile_number)>11 then try_convert(nvarchar(11),replace(mw.mobile_number,'+2','')) else try_convert(nvarchar(11),mw.mobile_number) end as MobileNumber
,mw.created_at as CreatedDate
,mw.updated_at as UpdatedDate
,mw.deleted_at as DeletedDate
,null as isDeleted
,mw.id as old_wallet_id

from CowPay_Production_Simulation.dbo.mobile_wallets mw join Merchants m 
on mw.user_id=m.old_id
where 
case when len(mw.mobile_number)>11 then try_convert(nvarchar(11),replace(mw.mobile_number,'+2','')) else try_convert(nvarchar(11),mw.mobile_number) end --as MobileNumber
= case when len(m.Mobile)>11 then try_convert(nvarchar(11),replace(m.Mobile,'+2','')) else try_convert(nvarchar(11),m.Mobile) end
), Client_Wallets as 
(
select 
NEWID() as WalletCode
,TRY_CONVERT(nvarchar(50),mw.holder_name) as HolderName
,0 as IsDefault
,m.Id as MerchantID
,0 as IsMerchantAccount
,case when len(mw.mobile_number)>11 then try_convert(nvarchar(11),replace(mw.mobile_number,'+2','')) else try_convert(nvarchar(11),mw.mobile_number) end as MobileNumber
,mw.created_at as CreatedDate
,mw.updated_at as UpdatedDate
,mw.deleted_at as DeletedDate
,null as isDeleted
,mw.id as old_wallet_id

from CowPay_Production_Simulation.dbo.mobile_wallets mw join Merchants m 
on mw.user_id=m.old_id
where 
case when len(mw.mobile_number)>11 then try_convert(nvarchar(11),replace(mw.mobile_number,'+2','')) else try_convert(nvarchar(11),mw.mobile_number) end --as MobileNumber
<> case when len(m.Mobile)>11 then try_convert(nvarchar(11),replace(m.Mobile,'+2','')) else try_convert(nvarchar(11),m.Mobile) end



)
,All_Mobile_Wallets as 
(select * from 
Merchant_Wallets
union
select * from Client_Wallets
)

select * from (

		select 
		ROW_NUMBER() over (partition by MobileNumber order by old_wallet_id desc) as rn
		,*
		from All_Mobile_Wallets
) as a 
where rn=1

GO
/****** Object:  View [dbo].[Customers_Prepared]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[Customers_Prepared] as
select
m.Id as MerchantId
,c.name
,c.email Email
,c.customer_merchant_profile_id MerchantProfileId
,case when len(c.mobile)>11 then try_convert(nvarchar(11),replace(c.mobile,'+2','')) else try_convert(nvarchar(11),c.mobile) end as Mobile
,c.created_at CreatedDate
,c.updated_at UpdatedDate
,c.deleted_at DeletedDate
,null IsDeleted
,c.id old_Customer_Id

from 
CowPay_Production_Simulation.dbo.customers c join dbo.Merchants m on c.merchant_id=m.old_id
GO
/****** Object:  View [dbo].[Bank_Accounts_Prepared]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[Bank_Accounts_Prepared] as 


with cleansed_names as (
select 

NEWID() as [BankAccountCode]
,m.MerchantCode as [MerchantCode]
,convert(int,ba.bank_name) as [BankId]
,case when ba.name in ('NA','rrrrrrrrrrrrrrrrrrrrrrr','12') then null else ba.name end as name
,case when ba.holder_name in ('NA','rrrrrrrrrrrrrrrrrrrrrrr','12') then null else ba.holder_name end as holder_name
,ba.number as [AccountNumber]
,ba.is_default  as [IsDefault]
,m.Id as [MerchantID]
,1 as [IsMerchantAccount]
,ba.created_at as [CreatedDate]
,ba.updated_at as [UpdatedDate]
,ba.deleted_at as [DeletedDate]
,null as [IsDeleted] 
,ba.id as old_bank_id
from CowPay_Production_Simulation.dbo.bank_accounts ba join [dbo].[Merchants] m on ba.user_id = m.old_id 
--join LKP_DB.dbo.Banks_Src br on br.name = ba.bank_name --this activates when the LKPs Task is Done & the The one later will be removed
--join LKP_DB.dbo.Banks_Src br on br.name = ba.bank_name collate Arabic_100_CI_AI 
)
--,
--Duplicates_Removed as (


--select 
--ROW_NUMBER() over (partition by old_bank_id order by )
--* 
--from cleansed_names

--)




select 
[BankAccountCode]
,[MerchantCode]
,[BankId]
,isnull(cn.name,cn.holder_name) as HolderName
,[AccountNumber]
,[IsDefault]
,[MerchantID]
,[IsMerchantAccount]
,[CreatedDate]
,[UpdatedDate]
,[DeletedDate]
,[IsDeleted]
,old_bank_id


from cleansed_names cn
GO
/****** Object:  Table [dbo].[MobileWallets]    Script Date: 10/18/2022 1:40:40 PM ******/
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
	[old_wallet_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BankAccounts]    Script Date: 10/18/2022 1:40:40 PM ******/
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
	[old_bank_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_All_Accounts]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_All_Accounts] as 
select 
[Id]                      as Account_ID
,[BankAccountCode]		  as Code
,[MerchantCode]			  as [MerchantCode]
,[BankId]				  as [BankId]
,[HolderName]			  as Holder_Name
,[AccountNumber]		  as Account_Number
,[IsDefault]			  as IsDefault
,[MerchantID]			  as [MerchantID]
,[IsMerchantAccount]	  as [IsMerchantAccount]
,[CreatedDate]			  as [CreatedDate]
,[UpdatedDate]			  as [UpdatedDate]
,[DeletedDate]			  as [DeletedDate]
,[IsDeleted]			  as [IsDeleted]
,NULL					  as [MobileNumber]
,NULL					  as [NationalId]
,1						  as Acount_type_ID
,old_bank_id			  as old_id
from BankAccounts

union 

select 
[Id]                      as Account_ID
,[WalletCode]			  as Code
,NULL					  as [MerchantCode]
,NULL					  as [BankId]
,[HolderName]			  as Holder_Name
,NULL					  as Account_Number
,[IsDefault]			  as IsDefault
,[MerchantID]			  as [MerchantID]
,[IsMerchantAccount]	  as [IsMerchantAccount]
,[CreatedDate]			  as [CreatedDate]
,[UpdatedDate]			  as [UpdatedDate]
,[DeletedDate]			  as [DeletedDate]
,[IsDeleted]			  as [IsDeleted]
,[MobileNumber]			  as [MobileNumber]
,NULL					  as [NationalId]
,2						  as Acount_type_ID
,old_wallet_ID			  as old_id


from
MobileWallets





















GO
/****** Object:  View [dbo].[WithdrawalReqests_Prepared]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--USE [Staging_Migration]
--GO

--/****** Object:  View [dbo].[WithdrawalReqests_Prepared]    Script Date: 9/28/2022 2:33:46 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


CREATE view [dbo].[WithdrawalReqests_Prepared] as


select 
m.id as MerchantId

,m.MerchantCode as MerchantCode
,wr.amount as amount
,1 as AccountTypeId
,a.Id as AccountId
, 1 as WithdrawalTypeId
,wr.status as status
,(select id from AspNetUsers anu where anu.old_id=m.old_id) as HandledBy
,wr.handled_at as HandledDate
,wr.created_at as CreatedDate
,wr.updated_at as UpdatedDate
,null as DeletedDate
,null as IsDeleted
,wr.id as old_id
from CowPay_Production_Simulation.dbo.vw_WR_withdrawal_reqests_SRC wr
 --join Staging_Migration.dbo.AspNetUsers anu on anu.old_id=wr.handled_by
 join Staging_Migration.dbo.Merchants m on wr.merchant_id=m.old_id
 left join Staging_Migration.dbo.BankAccounts a on wr.account_id=a.old_bank_id
 --join LKP_DB.dbo.StatusTypes_SRC s on wr.status=s.name --collate database_default

union all


select 

m.id as MerchantId

,m.MerchantCode as MerchantCode
,c.amount as amount
,1 as AccountTypeId
,a.Id as AccountId
, 2 as WithdrawalTypeId
,c.status as status
,(select id from AspNetUsers anu where anu.old_id=m.old_id) as HandledBy
,c.handled_at as HandledDate
,c.created_at as CreatedDate
,c.updated_at as UpdatedDate
,null as DeletedDate
,null as IsDeleted
,c.id as old_id


from
(
select * from 
[CowPay_Production_Simulation].[dbo].[vw_WR_Cashouts_SRC] 

where
[cashoutable_type]='App\Models\BankAccount') as c

left join Staging_Migration.dbo.BankAccounts a
on c.[cashoutable_id]=a.old_bank_id
join Staging_Migration.dbo.Merchants m on c.merchant_code=m.old_code
-- join LKP_DB.dbo.StatusTypes_SRC s on c.status=s.name --collate database_default


union 

select 

m.id as MerchantId

,m.MerchantCode as MerchantCode
,c.amount as amount
,2 as AccountTypeId
,a.Id as AccountId
, 2 as WithdrawalTypeId
,c.status as status
,(select id from AspNetUsers anu where anu.old_id=m.old_id) as HandledBy
,c.handled_at as HandledDate
,c.created_at as CreatedDate
,c.updated_at as UpdatedDate
,null as DeletedDate
,null as IsDeleted
,c.id as old_id
 

from
(
select * from 
[CowPay_Production_Simulation].[dbo].[vw_WR_Cashouts_SRC] 

where
[cashoutable_type]='App\Models\MobileWallet') as c

left join Staging_Migration.dbo.MobileWallets a
on c.[cashoutable_id]=a.old_wallet_ID
join Staging_Migration.dbo.Merchants m on c.merchant_code=m.old_code
-- join LKP_DB.dbo.StatusTypes_SRC s on c.status=s.name --collate database_default



GO
/****** Object:  Table [dbo].[WithdrawalRequests]    Script Date: 10/18/2022 1:40:40 PM ******/
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
	[old_Withdrawal_Request_ID] [int] NULL,
 CONSTRAINT [PK_WithdrawalRequests] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[WithdrawalRequestsTransactions_Prepared]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[WithdrawalRequestsTransactions_Prepared] as
select
 NEWID() as TranxCode
,null as TranxNumber
,m.Id  as MerchantId
,m.MerchantCode as MerchantCode
,wr.Id as WithdrawalRequestId
,wrt.amount as Amount
,wrt.fees_amount as FeesAmount
,wrt.vat_amount  as VatAmount
--,wrt.fees_amount*.14
,0 as CustomerAmount
,0 as MerchantAmount
,1 as CurrencyId
,N'EG' as Currency
,case when wrt.type='OUT' then 2 else 1 end  as TransactionTypeId
,case when wrt.type='OUT' then 1 else 4 end  as  OperationTypeId
,wrt.created_at    as CreatedDate
,wrt.updated_at    as UpdatedDate
,wrt.deleted_at    as DeletedDate
,null  as IsDeleted
,wrt.id as old_Transaction_Id


from CowPay_Production_Simulation.dbo.vw_WRT_Withdrawal_Requests_Transactions_SRC as wrt
 join Merchants m on wrt.merchant_code=m.old_code 
 join WithdrawalRequests wr on wr.Old_Withdrawal_Request_ID=wrt.model_id and wr.WithdrawalTypeId=1

union all

select
 NEWID() as TranxCode
,null as TranxNumber
,m.Id  as MerchantId
,m.MerchantCode as MerchantCode
,wr.Id as WithdrawalRequestId
,cot.amount as Amount
,cot.fees_amount as FeesAmount
,cot.vat_amount  as VatAmount
--,cot.fees_amount*.14
,0 as CustomerAmount
,0 as MerchantAmount
,1 as CurrencyId
,N'EG' as Currency
,case when cot.type='OUT' then 2 else 1 end  as TransactionTypeId
,case when cot.type='OUT' then 1 else 4 end  as  OperationTypeId
,cot.created_at as CreatedDate
,cot.updated_at as UpdatedDate
,cot.deleted_at as DeletedDate
,null  as IsDeleted
,cot.id as old_Transaction_Id


from CowPay_Production_Simulation.dbo.vw_WRT_Cashouts_Transactions_SRC as cot
join Merchants m on cot.merchant_code=m.old_code 
join WithdrawalRequests wr on wr.Old_Withdrawal_Request_ID=cot.model_id and wr.WithdrawalTypeId=2
GO
/****** Object:  View [dbo].[Roles_Prepared]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[Roles_Prepared] as
select distinct
case 
when name in('agent','admin','system-admin')then try_convert(nvarchar(500),NEWID())
else try_convert(nvarchar(500),NEWID())end as New_id
 
,name
,'791a8bf3-d24d-405e-b87b-0fbb6f65f3a5' as ConcurrencyStamp

,  case 
when name in('system-admin','agent','admin') then 'EXCELPAY'
  else 'MERCHANT' end as NormalizedName

, try_cast(id as varchar(50)) as old_code
   FROM [CowPay_Production_Simulation].[dbo].[Roles]
GO
/****** Object:  View [dbo].[Users_Prepared]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE view [dbo].[Users_Prepared] as

select 
NEWID() as id,
 [created_at] as CreatedDate,
 try_cast(null as varchar(50)) as DeletedDate,
 [updated_at] as UpdatedDate,
 0 as IsDeleted,
 try_convert(nvarchar(50),replace([phone],'+2','')) as UserName,
 try_convert(nvarchar(50),replace([phone],'+2','')) as NormalizedUserName,
 try_convert(nvarchar(50),[email]) as Email ,
 try_convert(nvarchar(50),[email]) as NormalizedEmail,
 0 as EmailConfirmed,
 TRY_CONVERT(nvarchar(50), [password]) as PasswordHash,
 'JBLJTPJFIIDIFTV2RJ44LV3B2BHN3FIY' as SecurityStamp,
 '985ba9aa-5a7d-4c39-9584-b6e3b21e7760' as ConcurrencyStamp,
 try_convert(nvarchar(50),replace([phone],'+2','')) as PhoneNumber,
 0 as PhoneNumberConfirmed,
 0 as TwoFactorEnabled,
 try_cast(0 as varchar(50))  as LockoutEnd,
 0 as LockoutEnabled,
 0 as AccessFailedCount,
 try_cast(m_code as varchar(50)) as old_code
 ,id as old_id
 from CowPay_Production_Simulation.dbo.Users
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 10/18/2022 1:40:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[Old_Userid] [numeric](18, 0) NULL,
	[Old_Roleid] [numeric](18, 0) NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CardMetaData]    Script Date: 10/18/2022 1:40:40 PM ******/
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
	[Old_Id] [numeric](20, 0) NULL,
 CONSTRAINT [PK_CardMetaData] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderTransactions]    Script Date: 10/18/2022 1:40:40 PM ******/
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
	[Old_Id] [bigint] NULL,
 CONSTRAINT [PK_OrderTransactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WithdrawalRequestTransactions]    Script Date: 10/18/2022 1:40:40 PM ******/
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
	[old_WithdrawalTransaction] [bigint] NULL,
 CONSTRAINT [PK_WithdrawalTransactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [ix_Staging_Merchant_index]    Script Date: 10/18/2022 1:40:40 PM ******/
CREATE NONCLUSTERED INDEX [ix_Staging_Merchant_index] ON [dbo].[Staging_Merchant]
(
	[index] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [Staging_Migration] SET  READ_WRITE 
GO
