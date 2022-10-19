USE [master]
GO
/****** Object:  Database [CowPay_Production_Simulation]    Script Date: 10/19/2022 6:13:35 PM ******/
CREATE DATABASE [CowPay_Production_Simulation]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CowPay_Production_Simulation', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CowPay_Production_Simulation.mdf' , SIZE = 1646592KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CowPay_Production_Simulation_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CowPay_Production_Simulation_log.ldf' , SIZE = 991232KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CowPay_Production_Simulation] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CowPay_Production_Simulation].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CowPay_Production_Simulation] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET ARITHABORT OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET RECOVERY FULL 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET  MULTI_USER 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CowPay_Production_Simulation] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CowPay_Production_Simulation] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CowPay_Production_Simulation', N'ON'
GO
ALTER DATABASE [CowPay_Production_Simulation] SET QUERY_STORE = OFF
GO
USE [CowPay_Production_Simulation]
GO
/****** Object:  Table [dbo].[withdrawal_requests]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[withdrawal_requests](
	[id] [bigint] NULL,
	[merchant_id] [int] NULL,
	[amount] [numeric](12, 2) NULL,
	[account_id] [bigint] NULL,
	[status] [nvarchar](13) NULL,
	[description] [nvarchar](max) NULL,
	[handled_by] [bigint] NULL,
	[handled_at] [datetime] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[merchant_reference_id] [nvarchar](191) NULL,
	[available_balance_before] [float] NULL,
	[available_balance_after] [float] NULL,
	[withdrawal_requests_date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transactions]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transactions](
	[id] [bigint] NULL,
	[added_to_merchant_available_balance] [smallint] NULL,
	[amount] [numeric](14, 2) NULL,
	[fees_amount] [numeric](14, 2) NULL,
	[vat_amount] [numeric](14, 2) NULL,
	[merchant_net_amount] [numeric](14, 2) NULL,
	[merchant_code] [nvarchar](191) NULL,
	[accountant_id] [bigint] NULL,
	[transaction_number] [nvarchar](199) NULL,
	[transaction_date] [datetime] NULL,
	[model_id] [numeric](20, 0) NULL,
	[model] [nvarchar](199) NULL,
	[description] [nvarchar](max) NULL,
	[type] [nvarchar](3) NULL,
	[environment] [nvarchar](11) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[deleted_at] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_WR_withdrawal_reqests_SRC]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
create view [dbo].[vw_WR_withdrawal_reqests_SRC] as
SELECT
wr.*
,t.[model_id]
,t.[model]
,t.[type]
      
  FROM withdrawal_requests wr 
  left join  
  (select * from transactions 
  where model='App\Models\WithdrawalRequest') as t on t.model_id=wr.id
GO
/****** Object:  Table [dbo].[cashouts]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cashouts](
	[id] [numeric](20, 0) NULL,
	[merchant_code] [nvarchar](191) NULL,
	[uuid] [nvarchar](36) NULL,
	[description] [nvarchar](max) NULL,
	[cashoutable_type] [nvarchar](191) NULL,
	[cashoutable_id] [numeric](20, 0) NULL,
	[commissions_on_customer] [smallint] NULL,
	[amount] [numeric](14, 2) NULL,
	[fees_amount] [numeric](14, 2) NULL,
	[vat_amount] [numeric](14, 2) NULL,
	[cashout_amount] [numeric](14, 2) NULL,
	[status] [nvarchar](9) NULL,
	[handled_by] [numeric](20, 0) NULL,
	[handled_at] [datetime] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_WR_Cashouts_SRC]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Script for SelectTopNRows command from SSMS  ******/
CREATE view [dbo].[vw_WR_Cashouts_SRC] as
SELECT
co.*
,t.[model_id]
,t.[model]
,t.[type]
      
  FROM cashouts co 
  left join  
  (select * from transactions 
  where model='App\Models\Cashout') as t on t.model_id=co.id
GO
/****** Object:  View [dbo].[vw_WRT_Withdrawal_Requests_Transactions_SRC]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Script for SelectTopNRows command from SSMS  ******/
create view [dbo].[vw_WRT_Withdrawal_Requests_Transactions_SRC] as
SELECT
t.*
,wr.merchant_id
,wr.id as Withdrawal_request_ID
  FROM withdrawal_requests wr 
   join  
  (select * from transactions 
  where model='App\Models\WithdrawalRequest') as t on t.model_id=wr.id
GO
/****** Object:  View [dbo].[vw_WRT_Cashouts_Transactions_SRC]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Script for SelectTopNRows command from SSMS  ******/
create view [dbo].[vw_WRT_Cashouts_Transactions_SRC] as
SELECT

t.*
,co.merchant_code as Cashout_Merchant_Code
,co.id as CashOut_ID
      
  FROM cashouts co 
   join  
  (select * from transactions 
  where model='App\Models\Cashout') as t on t.model_id=co.id
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[id] [bigint] NULL,
	[merchant_code] [nvarchar](20) NULL,
	[promo_code_id] [int] NULL,
	[payment_gateway] [nvarchar](5) NULL,
	[channel] [nvarchar](14) NULL,
	[iframe_id] [nvarchar](64) NULL,
	[payment_link_type] [nvarchar](24) NULL,
	[api_access_type] [nvarchar](8) NULL,
	[payment_method] [nvarchar](14) NULL,
	[payment_status] [nvarchar](32) NULL,
	[card_number] [nvarchar](199) NULL,
	[payment_link_id] [bigint] NULL,
	[customer_merchant_profile_id] [nvarchar](64) NULL,
	[customer_id] [bigint] NULL,
	[customer_mobile] [nvarchar](20) NULL,
	[customer_email] [nvarchar](50) NULL,
	[customer_name] [nvarchar](512) NULL,
	[merchant_reference_id] [nvarchar](64) NULL,
	[card_token] [nvarchar](190) NULL,
	[token] [nvarchar](1024) NULL,
	[init_amount] [float] NULL,
	[amount] [float] NULL,
	[fees_amount] [float] NULL,
	[vat_amount] [float] NULL,
	[net_amount] [real] NULL,
	[currency_code] [nvarchar](4) NULL,
	[description] [nvarchar](max) NULL,
	[charge_items] [nvarchar](max) NULL,
	[payment_gateway_reference_id] [nvarchar](199) NULL,
	[payment_gateway_tracking_number] [nvarchar](64) NULL,
	[cowpay_commission] [real] NULL,
	[expires_at] [datetime] NULL,
	[paid_at] [datetime] NULL,
	[general_extra_data] [nvarchar](max) NULL,
	[environment] [nvarchar](10) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[deleted_at] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[promo_codes]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[promo_codes](
	[id] [bigint] NULL,
	[merchant_id] [int] NULL,
	[name] [nvarchar](191) NULL,
	[deadline] [date] NULL,
	[payment_link_id] [int] NULL,
	[payment_link_type] [nvarchar](191) NULL,
	[model] [nvarchar](191) NULL,
	[discount_type] [nvarchar](10) NULL,
	[discount_amount] [float] NULL,
	[enabled] [smallint] NULL,
	[once] [smallint] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[deleted_at] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Order_Transaction_SRC]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE view [dbo].[Order_Transaction_SRC] as
SELECT 
--pc.[id] as Promo_code_ID
  [merchant_id]
  ,pc.[name] as PromoCode_Name
  ,[deadline]
  --,[payment_link_id]
  --,[payment_link_type]
  ,pc.[model] as payment_link_Model
  ,[discount_type]
  ,[discount_amount]
  ,[enabled]
  ,[once]
  --,[created_at]
  --,[updated_at]
  --,[deleted_at]

,o.[id] as Order_id
  --,[merchant_code]
  ,[promo_code_id]
  ,PGW.name as Payment_Gateway_Name
  ,[channel]
  ,[iframe_id]
  ,o.[payment_link_type]
  ,[api_access_type]
  ,[payment_method]
  ,[payment_status]
  ,[card_number]
  ,o.[payment_link_id]
  ,[customer_merchant_profile_id]
  ,[customer_id]
  ,[customer_mobile]
  ,[customer_email]
  ,[customer_name]
  ,[merchant_reference_id]
  ,[card_token]
  ,[token]
  ,[init_amount]
 -- ,[amount]
 -- ,[fees_amount]
 -- ,[vat_amount]
  ,[net_amount]
  ,[currency_code]
  --,o.[description] as Order_Desctiption
  ,[charge_items]
  ,[payment_gateway_reference_id]
  ,[payment_gateway_tracking_number]
  ,[cowpay_commission]
  ,[expires_at]
  ,[paid_at]
  ,[general_extra_data]
  --,[environment]
  --,[created_at]
  --,[updated_at]
  --,[deleted_at]
,t.[id] as Transaction_ID
      ,[added_to_merchant_available_balance]
      ,t.[amount]
      ,t.[fees_amount]
      ,t.[vat_amount]
      ,t.[merchant_net_amount]
      ,t.[merchant_code]
      ,[accountant_id]
      ,[transaction_number]
      ,[transaction_date]
      ,[model_id]
      ,t.[model]
      ,t.[description]
      ,[type]
      ,t.[environment]
      ,t.[created_at]
      ,t.[updated_at]
      ,t.[deleted_at]
  FROM [CowPay_Production_Simulation].[dbo].[transactions] t join Orders o on t.model_id=o.id 
  join LKP_DB.dbo.PGWTypes_Src PGW on payment_gateway=PGW.id
  left join promo_codes pc on pc.id=o.promo_code_id
  where t.model in ('App\Models\Order','App\Modules\Order\Models\Order') 

GO
/****** Object:  View [dbo].[Fawry_Transactions]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[Fawry_Transactions] as
select Transaction_ID
,[expires_at] as paymentExpiry
,payment_gateway_reference_id as referenceNumber


from [dbo].[Order_Transaction_SRC]
where Payment_Gateway_Name='Fawry'
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [bigint] NULL,
	[parent_id] [numeric](20, 0) NULL,
	[name] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[phone] [nvarchar](20) NULL,
	[password] [nvarchar](191) NULL,
	[api_token] [nvarchar](100) NULL,
	[remember_token] [nvarchar](100) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[is_merchant] [smallint] NULL,
	[m_sms_id] [nvarchar](256) NULL,
	[m_payments_notification] [smallint] NULL,
	[m_orders_notification] [smallint] NULL,
	[m_country_id] [int] NULL,
	[m_city_id] [bigint] NULL,
	[m_facebook] [nvarchar](100) NULL,
	[m_twitter] [nvarchar](100) NULL,
	[m_linked_in] [nvarchar](191) NULL,
	[m_instagram] [nvarchar](191) NULL,
	[m_about] [nvarchar](max) NULL,
	[m_website] [nvarchar](100) NULL,
	[m_logo] [nvarchar](1024) NULL,
	[m_code] [nvarchar](200) NULL,
	[m_hash_key] [nvarchar](200) NULL,
	[m_address] [nvarchar](max) NULL,
	[m_invoices] [bigint] NULL,
	[m_balance] [real] NULL,
	[m_available_balance] [real] NULL,
	[m_min_payout_threshold] [float] NULL,
	[m_bank_name] [nvarchar](50) NULL,
	[m_bank_address] [nvarchar](max) NULL,
	[m_bank_account_num] [nvarchar](191) NULL,
	[m_bank_account_name] [nvarchar](191) NULL,
	[m_bank_account_holder_name] [nvarchar](191) NULL,
	[m_bank_account_swift_code] [nvarchar](191) NULL,
	[m_callback_url] [nvarchar](191) NULL,
	[m_ipn_listener_url] [nvarchar](191) NULL,
	[m_total_received_amount] [float] NULL,
	[m_cowpay_commission] [float] NULL,
	[m_cowpay_payatfawry_percentage_commission] [float] NULL,
	[m_cowpay_payatfawry_fixed_commission] [float] NULL,
	[m_cowpay_credit_card_percentage_commission] [float] NULL,
	[m_cowpay_credit_card_fixed_commission] [float] NULL,
	[m_cowpay_collect_percentage_commission] [float] NULL,
	[m_cowpay_collect_fixed_commission] [float] NULL,
	[m_commercial_registry_file] [nvarchar](191) NULL,
	[m_tax_id_file] [nvarchar](191) NULL,
	[m_personal_id_file] [nvarchar](191) NULL,
	[m_commercial_registry] [nvarchar](191) NULL,
	[m_tax_id] [nvarchar](191) NULL,
	[m_personal_id] [nvarchar](191) NULL,
	[m_total_sales_per_year] [float] NULL,
	[m_added_by] [bigint] NULL,
	[m_added_at] [datetime] NULL,
	[m_approved_by] [bigint] NULL,
	[m_approved_at] [datetime] NULL,
	[environment] [nvarchar](10) NULL,
	[block] [smallint] NULL,
	[name_ar] [nvarchar](191) NULL,
	[category] [nvarchar](191) NULL,
	[mid_category] [nvarchar](191) NULL,
	[contract_file] [nvarchar](191) NULL,
	[authorize_signatory_name] [nvarchar](191) NULL,
	[fawry_sub_merchant] [nvarchar](191) NULL,
	[cowpay_fees] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payment_links]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment_links](
	[id] [bigint] NULL,
	[uuid] [nvarchar](36) NULL,
	[merchant_id] [int] NULL,
	[payment_link_name] [nvarchar](1024) NULL,
	[payment_link_type] [nvarchar](23) NULL,
	[cover_photo] [nvarchar](256) NULL,
	[description] [nvarchar](max) NULL,
	[vat_amount_on_customer] [smallint] NULL,
	[fees_amount_on_customer] [smallint] NULL,
	[model] [nvarchar](191) NULL,
	[model_id] [int] NULL,
	[transactions_number] [int] NULL,
	[transactions_volume] [real] NULL,
	[suspended] [smallint] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[deleted_at] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Meeza_Transactions]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Meeza_Transactions] as
select 
Transaction_ID
--,[expires_at],
--payment_gateway_reference_id 
,customer_merchant_profile_id
,customer_id
,null as is_fees_on_Customer


  ,(select m.Id from Staging_Migration.dbo.Merchants m where old_code=t.merchant_code) as merchantId
  ,(select m.MerchantCode from Staging_Migration.dbo.Merchants m where old_code=t.merchant_code) as merchantCode
  ,amount
  ,description
  ,(select p.id from LKP_DB.dbo.PGWTypes_Src p where p.name=t.Payment_Gateway_Name) paymentGatewayTypeId
  ,channel as  channelType
  ,customer_name as customerFirstName
  ,null as customerLastName
  ,customer_mobile as customerMobile
  ,customer_email as  customerEmail
  ,(select u.m_callback_url from Users u where u.m_code=t.merchant_code) as returnURL
  ,(select p.fees_amount_on_customer from payment_links p where p.id=t.payment_link_id ) as isFeesOnCustomer
  
  ,null paymentLinkTypeId
  ,null paymentLinkId
  
  
  ,null as commession
  ,PromoCode_Name as PromoCode



from [dbo].[Order_Transaction_SRC] t
where Payment_Gateway_Name='Meeza'
GO
/****** Object:  View [dbo].[Bosta_Transactions]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Bosta_Transactions] as

select 
t.Transaction_ID
, (select u.m_address from Users u where u.m_code=t.merchant_code) as address
, null as apartment
, null as floor
, null as cityCode
, null as district



from [dbo].[Order_Transaction_SRC] t
where Payment_Gateway_Name='Bosta'
GO
/****** Object:  View [dbo].[Akurateko_Transactions]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Akurateko_Transactions] as

select 
t.Transaction_ID
,  null as action
,  t.card_number as cardNumber
,  null as cardExpMonth
,  null as cardExpYear
,  null as isTokenized
, null  as isRecurring
, customer_email  as customerEmail
, null  as period
, null  as initPeriod
, null  as times
,  card_token as cardToken
,  null as termUrl3ds
,  Transaction_ID as transId
,  null as recurringToken
,  null as recurringFirstTransId
, t.amount  as amount
---------------------------------------



, null as transDate
, null as redirectUrl
, null as redirectParams
, null as redirectMethod
, null as status
, null as descriptor
, null as authCode
, null as declineReason
, null as creditvoidDate




from [dbo].[Order_Transaction_SRC] t
where Payment_Gateway_Name='Akurateko'
GO
/****** Object:  Table [dbo].[admin_logs]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admin_logs](
	[id] [bigint] NULL,
	[admin_id] [int] NULL,
	[link] [nvarchar](max) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bank_accounts]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bank_accounts](
	[id] [numeric](20, 0) NULL,
	[user_id] [bigint] NULL,
	[type] [nvarchar](10) NULL,
	[bank_name] [nvarchar](191) NULL,
	[bank_address] [nvarchar](max) NULL,
	[number] [nvarchar](64) NULL,
	[name] [nvarchar](191) NULL,
	[holder_name] [nvarchar](191) NULL,
	[swift_code] [nvarchar](191) NULL,
	[is_default] [smallint] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[deleted_at] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cards]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cards](
	[id] [numeric](20, 0) NULL,
	[merchant_code] [nvarchar](191) NULL,
	[merchant_card_holder_id] [nvarchar](191) NULL,
	[merchant_token_id] [nvarchar](191) NULL,
	[tokenized_order_id] [numeric](20, 0) NULL,
	[token] [nvarchar](191) NULL,
	[first_six] [nvarchar](191) NULL,
	[last_four] [nvarchar](191) NULL,
	[card_holder] [nvarchar](191) NULL,
	[expiry_year] [nvarchar](2) NULL,
	[expiry_month] [nvarchar](2) NULL,
	[tokenization_date] [datetime] NULL,
	[token_expiry_date] [date] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[deleted_at] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customers]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customers](
	[id] [int] NULL,
	[merchant_id] [int] NULL,
	[email] [nvarchar](191) NULL,
	[mobile] [nvarchar](191) NULL,
	[name] [nvarchar](255) NULL,
	[customer_merchant_profile_id] [nvarchar](64) NULL,
	[card_token] [nvarchar](max) NULL,
	[cvv] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[deleted_at] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[merchant_financials_configs]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[merchant_financials_configs](
	[id] [numeric](20, 0) NULL,
	[merchant_code] [nvarchar](191) NULL,
	[b2b_available_balance_threshold] [smallint] NULL,
	[available_balance_threshold] [smallint] NULL,
	[fawry_percentage] [float] NULL,
	[fawry_fixed] [float] NULL,
	[card_percentage] [float] NULL,
	[card_fixed] [float] NULL,
	[collection_percentage] [float] NULL,
	[collection_fixed] [float] NULL,
	[b2b_percentage] [float] NULL,
	[b2b_fixed] [float] NULL,
	[bank_cashout] [float] NULL,
	[wallet_cashout] [float] NULL,
	[fawry_cashout] [float] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[meeza_percentage] [float] NULL,
	[meeza_fixed] [float] NULL,
	[meeza_r2p_percentage] [float] NULL,
	[meeza_r2p_fixed] [float] NULL,
	[valu_percentage] [float] NULL,
	[valu_fixed] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mobile_wallets]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mobile_wallets](
	[id] [numeric](20, 0) NULL,
	[user_id] [bigint] NULL,
	[holder_name] [nvarchar](191) NULL,
	[mobile_number] [nvarchar](191) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[deleted_at] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[model_has_permissions]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[model_has_permissions](
	[permission_id] [numeric](20, 0) NULL,
	[model_type] [nvarchar](191) NULL,
	[model_id] [numeric](20, 0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[model_has_roles]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[model_has_roles](
	[role_id] [numeric](20, 0) NULL,
	[model_type] [nvarchar](191) NULL,
	[model_id] [numeric](20, 0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[id] [numeric](20, 0) NULL,
	[name] [nvarchar](191) NULL,
	[guard_name] [nvarchar](191) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role_has_permissions]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role_has_permissions](
	[permission_id] [numeric](20, 0) NULL,
	[role_id] [numeric](20, 0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 10/19/2022 6:13:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[id] [numeric](20, 0) NULL,
	[name] [nvarchar](191) NULL,
	[guard_name] [nvarchar](191) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [CowPay_Production_Simulation] SET  READ_WRITE 
GO
