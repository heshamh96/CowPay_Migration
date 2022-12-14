USE [Staging_Migration]
GO
/****** Object:  Table [dbo].[OrderTransactions]    Script Date: 1/1/2023 10:58:37 AM ******/
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
	[FK_Migration_Key_Orders] [uniqueidentifier] NULL,
 CONSTRAINT [PK_OrderTransactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionBalance]    Script Date: 1/1/2023 10:58:37 AM ******/
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
/****** Object:  Table [dbo].[WithdrawalRequestTransactions]    Script Date: 1/1/2023 10:58:37 AM ******/
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
	[FK_Migration_key_WithdrawalRequests] [uniqueidentifier] NULL,
	[IsSuccess] [bit] NULL,
 CONSTRAINT [PK_WithdrawalTransactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TransactionBalance_Prepared_RollOut]    Script Date: 1/1/2023 10:58:37 AM ******/
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
/****** Object:  Table [dbo].[Merchants]    Script Date: 1/1/2023 10:58:37 AM ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 1/1/2023 10:58:37 AM ******/
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
/****** Object:  View [dbo].[Cards_Prepared]    Script Date: 1/1/2023 10:58:37 AM ******/
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
isnull(cu.MerchantId,0) as [MerchantId],
NEWID() as TokenId,
cu.MerchantProfileId as CustomerRefId,
M.MerchantCode


from [CowPay_Production_Simulation].dbo.cards ca
join [Staging_Migration].[dbo].[Customers] cu
on ca.merchant_card_holder_id=cu.Old_id
join Merchants M on M.id=cu.MerchantId
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 1/1/2023 10:58:37 AM ******/
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
	[LockoutEnd] [datetimeoffset](7) NULL,
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
/****** Object:  View [dbo].[UserRoles_Prepared]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[UserRoles_Prepared] as


with new_user_roles as (
select 

case when m.[role_id] in(1,3,4) then  (select id from ExcelpayIdentity_Stage.dbo.AspNetRoles where name='Excelpay' )
when m.[role_id] in(2,5)  then (select id from ExcelpayIdentity_Stage.dbo.AspNetRoles where Name='Merchant' )  end as [RoleId]
,u.id as [UserId]
,m.[model_id] as Old_Userid 
,m.[role_id] as Old_Roleid
from [CowPay_Production_Simulation].[dbo].[model_has_roles] m join [Staging_Migration].[dbo].[AspNetUsers] u
on u.[old_id]=m.[model_id])

,filterd_RS 
as (

select 
ROW_NUMBER() over (partition by RoleId collate database_default +'_'+UserId collate database_default  order by Old_Userid,Old_Roleid asc) as rn
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
/****** Object:  Table [dbo].[Staging_Merchant]    Script Date: 1/1/2023 10:58:37 AM ******/
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
/****** Object:  View [dbo].[Orders_Prepared]    Script Date: 1/1/2023 10:58:37 AM ******/
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
, try_convert(int,ord.payment_method) OM_PaymentMethodTypeId
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
,NEWID() as Migration_Key
from CowPay_Production_Simulation.dbo.Orders ord join Merchants m on ord.merchant_code=m.old_code
left join CowPay_Production_Simulation.[dbo].[promo_codes] pc on ord.promo_code_id=pc.id
GO
/****** Object:  Table [dbo].[OrderTransactions_jsons_Staging]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderTransactions_jsons_Staging](
	[Transaction_ID] [bigint] NULL,
	[PGWMetaRequest] [varchar](max) NULL,
	[PGWMetaResponse] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders-Meta]    Script Date: 1/1/2023 10:58:37 AM ******/
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
	[OM_PaymentMethodTypeId] [int] NULL,
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
	[Old_Id] [bigint] NULL,
	[Migration_Key] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[OrderTransactions_Prepared]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO













CREATE view [dbo].[OrderTransactions_Prepared] as 
with Fullfillied_Order_Transactions as (
select 
--Null   as [Id]
NEWID()   as [TranxCode]
,t.transaction_number  as [TranxNumber]
,m.Id    as [MerchantId]
,m.MerchantCode    as [MerchantCode]
,o.ID   as [OrderId]
, t.amount  as [Amount]
, t.fees_amount  as [FeesAmount]
, t.vat_amount  as [VatAmount]
,case 
when  t.merchant_net_amount >= amount then 1 else 0 end as [IsFeesOnCustomer]

--,Case 
--when isnull(t.IsFeesOnCustomer,0)=1 then amount+(fees_amount+vat_amount) else amount end 
,case when  t.amount <= t.merchant_net_amount then t.amount +(t.fees_amount+t.vat_amount) else  t.amount end as [CustomerAmount]
--,Case
--when isnull(t.IsFeesOnCustomer,0)=1 then amount else amount-(fees_amount+vat_amount) end 
, t.merchant_net_amount as [MerchantAmount]
,  1 as [CurrencyId]
,  N'EGP' as [Currency]
,  case when t.type='OUT' then 2 else 1 end  as [TransactionTypeId]
, case when t.type='OUT' then 4 else 1 end  as [OperationTypeId]
, t.created_at  as [CreatedDate]
, t.updated_at  as [UpdatedDate]
, t.deleted_at  as [DeletedDate]
, null  as [IsDeleted]
,  1 as [TransactionStatusId]
,  try_convert(nvarchar(max),(select j.PGWMetaRequest from OrderTransactions_jsons_Staging j where j.Transaction_ID=t.id)) as [PGWMetaRequest]
,  try_convert(nvarchar(max),(select j.PGWMetaResponse from OrderTransactions_jsons_Staging j where j.Transaction_ID=t.id)) as [PGWMetaResponse]



--,  (select p.fees_amount_on_customer 
--from CowPay_Production_Simulation.dbo.payment_links p 
--join CowPay_Production_Simulation.dbo.Order_Transaction_SRC o on p.id=o.payment_link_id  
--where o.Transaction_ID=t.id ) 
--isnull(t.IsFeesOnCustomer,0) as [IsFeesOnCustomer] ---> this will be replaced when we play with derby's Module (will fetch the FK Paymentlink ID from The STG_Orders)



,  1 as [IsSuccess]
,  t.id as old_id
, o. Migration_Key as FK_Migration_Key_Orders

 
from CowPay_Production_Simulation.dbo.Transactionss t join Merchants m on m.old_code=t.merchant_code
join [Orders-Meta] o on o.Old_Id=t.model_id
--where t.model in ('App\Models\Order','App\Modules\Order\Models\Order') 
)


--=============================================================================

, Non_Fullfilled_Order_Transactions as (




select 

NEWID()   as [TranxCode]
,Null  as [TranxNumber]
,m.Id    as [MerchantId]
,m.MerchantCode    as [MerchantCode]
,o.ID   as [OrderId]
,o.O_OrderAmount  as [Amount]
,o.O_FeesAmount  as [FeesAmount]
,o.O_VatAmount  as [VatAmount]
,case 
when  o.O_MerchantAmount >= o.O_OrderAmount then 1 else 0 end as [IsFeesOnCustomer]


,case when  o.O_OrderAmount <= o.O_MerchantAmount then o.O_OrderAmount +(o.O_FeesAmount+o.O_VatAmount) else o.O_OrderAmount end as [CustomerAmount]

, o.O_MerchantAmount as [MerchantAmount]
,  1 as [CurrencyId]
,  N'EGP' as [Currency]
,  1 as [TransactionTypeId]
, 1  as [OperationTypeId]
, o.O_CreatedDate  as [CreatedDate]
, o.O_UpdatedDate  as [UpdatedDate]
, o.O_DeletedDate  as [DeletedDate]
, null  as [IsDeleted]
,  2 as [TransactionStatusId]
,  null as [PGWMetaRequest]
,  null as [PGWMetaResponse]
,  0 as [IsSuccess]
,  null as old_id
, o. Migration_Key as FK_Migration_Key_Orders


from [Orders-Meta] o left join Merchants m on m.MerchantCode=o.O_MerchantCode
 left join (select model_id from CowPay_Production_Simulation.dbo.Transactionss) as t  on t.model_id=o.Old_Id
where t.model_id is null
 
--from [Orders-Meta] o join Merchants m on m.MerchantCode=o.O_MerchantCode
--where o.Old_Id not in ( select  t.model_id from  CowPay_Production_Simulation.dbo.Transactionss t)



)




select * from Fullfillied_Order_Transactions
union 
select * from Non_Fullfilled_Order_Transactions
GO
/****** Object:  View [dbo].[Staging_Merchants_Prepared]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE view [dbo].[Staging_Merchants_Prepared] as 

select NEWID() as New_id 
,1 as MasterMerchantId
,cast([name] as nvarchar(50)) as name
,cast([email] as nvarchar(50)) as email
,cast([phone] as nvarchar(20)) as phone
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
	  ,try_cast((select id from AspNetUsers where old_code=sm.m_code) as uniqueidentifier) as UserId
from [dbo].[Staging_Merchant] sm
GO
/****** Object:  View [dbo].[Mobile_Wallets_Prepared]    Script Date: 1/1/2023 10:58:37 AM ******/
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

select *,NEWID() as Migration_Key_Mobile_Wallets from (

		select 
		ROW_NUMBER() over (partition by MobileNumber order by old_wallet_id desc) as rn
		,*
		from All_Mobile_Wallets
) as a 
where rn=1

GO
/****** Object:  View [dbo].[Customers_Prepared]    Script Date: 1/1/2023 10:58:37 AM ******/
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
/****** Object:  View [dbo].[Bank_Accounts_Prepared]    Script Date: 1/1/2023 10:58:37 AM ******/
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
,NEWID() as Migration_Key_Bank_Accounts

from cleansed_names cn
GO
/****** Object:  View [dbo].[TransactionBalance_Prepared]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[TransactionBalance_Prepared] as 
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
from [dbo].[OrderTransactions]
where IsSuccess=1
),
WithdrawalRequestTransactions_Data AS (
select 
[MerchantId]				as [MerchantId]
,Id						as TranxId
,MerchantAmount					as [Amount]
,[TransactionTypeId]		as [TranxTypeId]
,2							as [ModelTypeId]
,WithdrawalRequestId						as [ModelReferenceId]
--,calculated					as 
,null						as [AvailableBalance]
,[CreatedDate]				as [CreatedDate]	
,[UpdatedDate]				as [UpdatedDate]	
,[DeletedDate]				as [DeletedDate]	
,[IsDeleted]				as [IsDeleted]	
from [dbo].WithdrawalRequestTransactions
where IsSuccess=1
)

select 
*
,sum(case when [TranxTypeId]=1 then [Amount] else Amount*-1 end) over (partition by [MerchantId] order by  createddate) as [Balance]


from (
select * from OrderTransaction_Data
union all
select * from WithdrawalRequestTransactions_Data) as a
GO
/****** Object:  Table [dbo].[MobileWallets]    Script Date: 1/1/2023 10:58:37 AM ******/
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
	[old_wallet_ID] [int] NULL,
	[Migration_Key_Mobile_Wallets] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BankAccounts]    Script Date: 1/1/2023 10:58:37 AM ******/
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
	[old_bank_id] [int] NULL,
	[Migration_Key_Bank_Accounts] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_All_Accounts]    Script Date: 1/1/2023 10:58:37 AM ******/
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
/****** Object:  View [dbo].[Test_Balances]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
create view [dbo].[Test_Balances] as
with Test as (
SELECT [MerchantId]
      ,[CurrentBalance] as excelpay_CurrentBalance
      ,[AvailableBalance] as excelpay_AvailableBalance
	  ,u.m_balance as cowpay_Current_Balance
	  ,u.m_available_balance as cowpay_AvailableBalance
	  ,Case 
	  when [CurrentBalance]=u.m_balance and [AvailableBalance]=m_available_balance then  'True'
	  when [CurrentBalance]=u.m_balance or [AvailableBalance]=m_available_balance then 'Semi-True'
	  else 'False' end as IS_WELL_Migrated
  FROM [TransactionManagement_Stage].[dbo].[Balance] epm
  join Staging_Migration.dbo.Merchants m on epm.MerchantId = m.Id join
  CowPay_Production_Simulation.dbo.Users u on m.old_id=u.id )


 -- select * from Test

  select IS_WELL_Migrated,count(*) as CNT from Test 
  group by IS_WELL_Migrated
GO
/****** Object:  Table [dbo].[WithdrawalRequests]    Script Date: 1/1/2023 10:58:37 AM ******/
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
	[Old_Withdrawal_Request_ID] [int] NULL,
	[FK_Account_Migration_Key] [uniqueidentifier] NULL,
	[Migration_key_WithdrawalRequests] [uniqueidentifier] NULL,
 CONSTRAINT [PK_WithdrawalRequests] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[WithdrawalRequestsTransactions_Prepared]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE view [dbo].[WithdrawalRequestsTransactions_Prepared] as

with Fullfilled_WithdrawalTransactions as (
select
 NEWID() as TranxCode
,wrt.transaction_number as TranxNumber
,m.Id  as MerchantId
,m.MerchantCode as MerchantCode
,wr.Id as WithdrawalRequestId
,wrt.amount as Amount
,wrt.fees_amount as FeesAmount
,wrt.vat_amount  as VatAmount
--,wrt.fees_amount*.14
,wrt.amount as CustomerAmount
,wrt.amount as MerchantAmount
,1 as CurrencyId
,N'EGP' as Currency
,case when wrt.type='OUT' then 2 else 1 end  as TransactionTypeId
,case when wrt.type='OUT' then 1 else 4 end  as  OperationTypeId
,wrt.created_at    as CreatedDate
,wrt.updated_at    as UpdatedDate
,wrt.deleted_at    as DeletedDate
,null  as IsDeleted
,wrt.id as old_Transaction_Id
,wr.Migration_key_WithdrawalRequests as FK_Migration_key_WithdrawalRequests

from CowPay_Production_Simulation.dbo.vw_WRT_Withdrawal_Requests_Transactions_SRC as wrt
 join Merchants m on wrt.merchant_code=m.old_code 
 join WithdrawalRequests wr on wr.Old_Withdrawal_Request_ID=wrt.model_id and wr.WithdrawalTypeId=1

union all

select
 NEWID() as TranxCode
,cot.transaction_number as TranxNumber
,m.Id  as MerchantId
,m.MerchantCode as MerchantCode
,wr.Id as WithdrawalRequestId
,cot.amount as Amount
,cot.fees_amount as FeesAmount
,cot.vat_amount  as VatAmount
--,cot.fees_amount*.14
,cot.amount as CustomerAmount
,cot.amount as MerchantAmount
,1 as CurrencyId
,N'EGP' as Currency
,case when cot.type='OUT' then 2 else 1 end  as TransactionTypeId
,case when cot.type='OUT' then 1 else 4 end  as  OperationTypeId
,cot.created_at as CreatedDate
,cot.updated_at as UpdatedDate
,cot.deleted_at as DeletedDate
,null  as IsDeleted
,cot.id as old_Transaction_Id

,wr.Migration_key_WithdrawalRequests  as FK_Migration_key_WithdrawalRequests

from CowPay_Production_Simulation.dbo.vw_WRT_Cashouts_Transactions_SRC as cot
join Merchants m on cot.merchant_code=m.old_code 
join WithdrawalRequests wr on wr.Old_Withdrawal_Request_ID=cot.model_id and wr.WithdrawalTypeId=2
)
--=================================================================================================================================================================



,Non_Fullfiled_Withdrawal_Transactions as (

select
 NEWID() as TranxCode
,null as TranxNumber
,m.Id  as MerchantId
,m.MerchantCode as MerchantCode
,wr.Id as WithdrawalRequestId
,wr.Amount as Amount
,0 as FeesAmount
,0  as VatAmount
--,wrt.fees_amount*.14
,wr.Amount as CustomerAmount
,wr.amount as MerchantAmount
,1 as CurrencyId
,N'EGP' as Currency
, 2  as TransactionTypeId
,1   as  OperationTypeId
,wr.CreatedDate    as CreatedDate
,wr.UpdatedDate    as UpdatedDate
,wr.DeletedDate    as DeletedDate
,null  as IsDeleted
,null as old_Transaction_Id
,wr.Migration_key_WithdrawalRequests as FK_Migration_key_WithdrawalRequests

from WithdrawalRequests wr
 join Merchants m on wr.MerchantCode=m.MerchantCode 

 where wr.Old_Withdrawal_Request_ID  not in (select  wrt.model_id from CowPay_Production_Simulation.dbo.vw_WRT_Withdrawal_Requests_Transactions_SRC as wrt)
 and wr.WithdrawalTypeId=1


--implement cashouts

union 



select
 NEWID() as TranxCode
,null as TranxNumber
,m.Id  as MerchantId
,m.MerchantCode as MerchantCode
,wr.Id as WithdrawalRequestId
,wr.amount as Amount
,0 as FeesAmount
,0 as VatAmount
--,cot.fees_amount*.14
,wr.amount as CustomerAmount
,wr.amount as MerchantAmount
,1 as CurrencyId
,N'EGP' as Currency
, 2 as TransactionTypeId
, 1  as  OperationTypeId
,wr.CreatedDate as CreatedDate
,wr.UpdatedDate as UpdatedDate
,wr.DeletedDate as DeletedDate
,null  as IsDeleted
,null as old_Transaction_Id

,wr.Migration_key_WithdrawalRequests  as FK_Migration_key_WithdrawalRequests




from WithdrawalRequests wr
 join Merchants m on wr.MerchantCode=m.MerchantCode 

 where wr.Old_Withdrawal_Request_ID  not in (select  cot.model_id from CowPay_Production_Simulation.dbo.vw_WRT_Cashouts_Transactions_SRC as cot)
 and wr.WithdrawalTypeId=2


)





select *,1 as IsSuccess from Fullfilled_WithdrawalTransactions
union
select *,0 as IsSuccess from Non_Fullfiled_Withdrawal_Transactions
GO
/****** Object:  View [dbo].[Test_Balances_at_SRC]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/****** Script for SelectTopNRows command from SSMS  ******/

CREATE View [dbo].[Test_Balances_at_SRC] as

with Order_Trans as (
SELECT  [id]
     
      ,[merchant_net_amount]
      ,[merchant_code]
      ,[type]
   
      ,[created_at]
      ,[updated_at]
      ,[deleted_at]
     
  FROM [CowPay_Production_Simulation].[dbo].[Transactionss]

  )
  , Cashout_Trans as (
  select  [id]
      ,[merchant_net_amount]
      ,[merchant_code]
      ,[type]
      ,[created_at]
      ,[updated_at]
      ,[deleted_at]
  from CowPay_Production_Simulation.[dbo].[vw_WRT_Cashouts_Transactions_SRC]
  
  )
  , withdrawal_Trans as (
   select  [id]
      ,[merchant_net_amount]
      ,[merchant_code]
      ,[type]
      ,[created_at]
      ,[updated_at]
      ,[deleted_at]
  from CowPay_Production_Simulation.dbo.[vw_WRT_Withdrawal_Requests_Transactions_SRC]
  )
  ,SRC_Transaction_Balance as (
  select *
  ,case when rs.type='IN' then merchant_net_amount else merchant_net_amount*-1 end as Merchant_Balance
  
  ,sum(case when rs.type='IN' then merchant_net_amount else merchant_net_amount*-1 end) over (partition by [merchant_code] order by  [created_at]) as [Actual_Balance]
  
  ,YEAR(created_at) as Yearr
  ,MONTH(created_at) as Monthh
  
  
 from
  (
  select * from Order_Trans
  union all
  select * from Cashout_Trans
  union all
  select * from withdrawal_Trans
  )as rs
  --order by merchant_code,created_at
  )

  , Merchant_Balances as (
  select 
  merchant_code
  --,Yearr
  --,Monthh
  ,sum(Merchant_Balance) how_it_should_be_in_the_New_System 
  ,sum(case when type='IN' then 1 else 0 end) as count_IN
  ,sum(case when type='IN' then merchant_net_amount else 0 end) as Sum_IN
  ,sum(case when type!='IN' then 1 else 0 end) as count_OUT
  ,sum(case when type!='IN' then merchant_net_amount else 0 end) as Sum_OUT
  
  from
  SRC_Transaction_Balance
  group by 
  merchant_code
  --,Yearr
  --,Monthh
  )
  ---====================================================================================
  ,Merchant_Balances_Monthly as (
  select 
  merchant_code
  ,Yearr
  ,Monthh
  ,sum(Merchant_Balance) how_it_should 
  ,sum(case when type='IN' then 1 else 0 end) as count_IN
  ,sum(case when type='IN' then merchant_net_amount else 0 end) as Sum_IN
  ,sum(case when type!='IN' then 1 else 0 end) as count_OUT
  ,sum(case when type!='IN' then merchant_net_amount else 0 end) as Sum_OUT
  
  from
  SRC_Transaction_Balance
  group by 
  merchant_code
  ,Yearr
  ,Monthh
  )
  ---====================================================================================
  , Old_Test_Results as(
  select * from (
  select mb.*,u.m_balance as Actual_Balance_in_The_Old_System
  ,case when u.m_balance - [how_it_should_be_in_the_New_System]  = 0 then 1 else 0 end as is_truely_Calculated
  ,case when u.m_balance - [how_it_should_be_in_the_New_System] >0 then 'Topup' else 'Blocked_amount' end as Type_of_Missing_Transactions
  ,u.m_balance - [how_it_should_be_in_the_New_System] as The_Diffrenece_Postive_Isallowed_Negative_is_Not
  from  CowPay_Production_Simulation.dbo.Users u left join  Merchant_Balances mb
  on mb.merchant_code=u.m_code
  where u.is_merchant=1 and u.block=0 ) as final_Test
   where is_truely_Calculated=0 and merchant_code is not null )


   select  * from Old_Test_Results

  -- select * from Merchant_Balances_Monthly
  -- where merchant_code in (select  merchant_code from Old_Test_Results)
  ---- order by merchant_code, yearr,  Monthh 


GO
/****** Object:  View [dbo].[Test_Balances_at_TRGT]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Script for SelectTopNRows command from SSMS  ******/
create view [dbo].[Test_Balances_at_TRGT] as
with sum_Balances as (

SELECT   tb.[MerchantId] ,sum(case when tb.[TranxTypeId]=1 then tb.Amount else tb.Amount*-1 end ) as Total_Ttansaction_Balance
from  [TransactionManagement_Stage].dbo.TransactionBalance tb
group by tb.[MerchantId] )




  ,Last_window_Balance as(
  select MerchantId,Balance from(
  select *,ROW_NUMBER() over (partition by [MerchantId] order by [CreatedDate] desc) as rn
  from TransactionManagement_Stage.dbo.TransactionBalance tb) as rs
  where rn=1
  ) 


 -- select * from Test

  select a.MerchantId,b.Total_Ttansaction_Balance as Total_Balance, a.Balance as Last_Window_Balance
  ,b.Total_Ttansaction_Balance - a.Balance as Diffrence
  
  from 
  Last_window_Balance a join sum_Balances b on a.MerchantId=b.MerchantId
GO
/****** Object:  View [dbo].[Test_Balances_SRC_VS_TRGT]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Script for SelectTopNRows command from SSMS  ******/
CREATE view [dbo].[Test_Balances_SRC_VS_TRGT] as
select a.merchant_code
,c.MerchantId
,a.Actual_Balance as SRC_Actual_Balance
,a.how_it_should as SRC_how_it_should
,a.The_Diffrenece_Postive_Isallowed_Negative_isNot


,c.Total_Balance as TRGT_Total_Balance

, a.Actual_Balance-c.Total_Balance as Diffrence_between_two_Systems_zero_or_Positive_ISAllowed_Negative_IsNot


from Test_Balances_at_SRC a join  Merchants b on a.merchant_code=b.old_code
join Test_Balances_at_TRGT c on b.id=c.MerchantId




GO
/****** Object:  View [dbo].[SRC_Transactions_VS_TRGT_Transactions]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[SRC_Transactions_VS_TRGT_Transactions] as 




with Order_Trans as (
SELECT  [id]
     
      ,[merchant_net_amount]
      ,[merchant_code]
      ,[type]
   
      ,[created_at]
      ,[updated_at]
      ,[deleted_at]
     
  FROM [CowPay_Production_Simulation].[dbo].[Transactionss]

  )
  , Cashout_Trans as (
  select  [id]
      ,[merchant_net_amount]
      ,[merchant_code]
      ,[type]
      ,[created_at]
      ,[updated_at]
      ,[deleted_at]
  from CowPay_Production_Simulation.[dbo].[vw_WRT_Cashouts_Transactions_SRC]
  
  )
  , withdrawal_Trans as (
   select  [id]
      ,[merchant_net_amount]
      ,[merchant_code]
      ,[type]
      ,[created_at]
      ,[updated_at]
      ,[deleted_at]
  from CowPay_Production_Simulation.dbo.[vw_WRT_Withdrawal_Requests_Transactions_SRC]
  )
  ,SRC_Transaction_Balance as (
  select *
  ,case when rs.type='IN' then merchant_net_amount else merchant_net_amount*-1 end as Merchant_Balance
  
  ,sum(case when rs.type='IN' then merchant_net_amount else merchant_net_amount*-1 end) over (partition by [merchant_code] order by  [created_at]) as [Actual_Balance]
 from
  (
  select * from Order_Trans
  union all
  select * from Cashout_Trans
  union all
  select * from withdrawal_Trans
  )as rs
  --order by merchant_code,created_at
  )


  , Old_Merchant_Balances as (
  select  [merchant_code],sum(Merchant_Balance) as SRC_Balances
  from SRC_Transaction_Balance 
  group by merchant_code )

  select OB.merchant_code,NB.MerchantId,OB.SRC_Balances ,NB.TRGT_Total_Balance
  , case when OB.SRC_Balances -NB.TRGT_Total_Balance = 0 then 1 else 0 end as Is_Truly_Calculated
  ,OB.SRC_Balances -NB.TRGT_Total_Balance as Diff_Okay_if_Positive_ifNegative_IsNot
  from Old_Merchant_Balances OB join Test_Balances_SRC_VS_TRGT NB on OB.merchant_code=NB.merchant_code

GO
/****** Object:  View [dbo].[WithdrawalRequests_Prepared]    Script Date: 1/1/2023 10:58:37 AM ******/
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


CREATE view [dbo].[WithdrawalRequests_Prepared] as


select 
m.id as MerchantId

,m.MerchantCode as MerchantCode
,wr.amount as amount
,1 as AccountTypeId
,a.Id as AccountId
, 1 as WithdrawalTypeId
,convert(int,wr.status) as status
,case when convert(int,wr.status) in (2,3) then convert(uniqueidentifier,isnull((select id from AspNetUsers anu where anu.old_id=wr.handled_by),(select id from AspNetUsers anu where anu.old_id=1))) else convert(uniqueidentifier,(select id from AspNetUsers anu where anu.old_id=wr.handled_by)) end as HandledBy
,wr.handled_at as HandledDate
,wr.created_at as CreatedDate
,wr.updated_at as UpdatedDate
,null as DeletedDate
,null as IsDeleted
,wr.id as old_id
,a.Migration_Key_Bank_Accounts as FK_Account_Migration_Key

,NEWID() as Migration_key_WithdrawalRequests


from CowPay_Production_Simulation.dbo.vw_WR_Withdrawal_Requests_SRC wr
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
,convert(int,c.status) as status
,case when convert(int,c.status) in (2,3) then convert(uniqueidentifier,isnull((select anu.id from AspNetUsers anu where anu.old_id=c.handled_by),(select id from AspNetUsers anu where anu.old_id=1))) else convert(uniqueidentifier,(select anu.id from AspNetUsers anu where anu.old_id=c.handled_by)) end  as HandledBy
,c.handled_at as HandledDate
,c.created_at as CreatedDate
,c.updated_at as UpdatedDate
,null as DeletedDate
,null as IsDeleted
,c.id as old_id
,a.Migration_Key_Bank_Accounts as FK_Account_Migration_Key

,NEWID() as Migration_key_WithdrawalRequests

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
,convert(int,c.status) as status
,case when convert(int,c.status) in (2,3) then convert(uniqueidentifier,isnull((select id from AspNetUsers anu where anu.old_id=c.handled_by),(select id from AspNetUsers anu where anu.old_id=1))) else convert(uniqueidentifier,(select id from AspNetUsers anu where anu.old_id=c.handled_by)) end as HandledBy
,c.handled_at as HandledDate
,c.created_at as CreatedDate
,c.updated_at as UpdatedDate
,null as DeletedDate
,null as IsDeleted
,c.id as old_id
,a.Migration_Key_Mobile_Wallets as FK_Account_Migration_Key 

,NEWID() as Migration_key_WithdrawalRequests

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
/****** Object:  View [dbo].[Roles_Prepared]    Script Date: 1/1/2023 10:58:37 AM ******/
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
/****** Object:  View [dbo].[Users_Prepared]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO













CREATE view [dbo].[Users_Prepared] as

select 
try_convert(nvarchar(400),NEWID()) as id,
 [created_at] as CreatedDate,
 try_cast(null as varchar(50)) as DeletedDate,
 [updated_at] as UpdatedDate,
 0 as IsDeleted,
 try_convert(nvarchar(50),replace([phone],'+2','')) as UserName,
 try_convert(nvarchar(50),replace([phone],'+2','')) as NormalizedUserName,
 try_convert(nvarchar(50),[email]) as Email,
 try_convert(nvarchar(50),UPPER ([email])) as NormalizedEmail,
 0 as EmailConfirmed,
 TRY_CONVERT(nvarchar(50), [password]) as PasswordHash,
 'JBLJTPJFIIDIFTV2RJ44LV3B2BHN3FIY' as SecurityStamp,
 '985ba9aa-5a7d-4c39-9584-b6e3b21e7760' as ConcurrencyStamp,
 try_convert(nvarchar(50),replace([phone],'+2','')) as PhoneNumber,
 0 as PhoneNumberConfirmed,
 0 as TwoFactorEnabled,
 --try_cast(0 as varchar(50))  as LockoutEnd,
 null as LockoutEnd,
 0 as LockoutEnabled,
 0 as AccessFailedCount,
 try_cast(m_code as varchar(50)) as old_code
 ,id as old_id
 from CowPay_Production_Simulation.dbo.Users
 where is_merchant=1 and block=0
 
 union all



 select 
try_convert(nvarchar(400),NEWID()) as id,
 [created_at] as CreatedDate,
 try_cast(null as varchar(50)) as DeletedDate,
 [updated_at] as UpdatedDate,
 0 as IsDeleted,
 try_convert(nvarchar(50),replace([phone],'+2','')) as UserName,
 try_convert(nvarchar(50),replace([phone],'+2','')) as NormalizedUserName,
 try_convert(nvarchar(50),[email]) as Email,
 try_convert(nvarchar(50),UPPER ([email])) as NormalizedEmail,
 0 as EmailConfirmed,
 TRY_CONVERT(nvarchar(50), [password]) as PasswordHash,
 'JBLJTPJFIIDIFTV2RJ44LV3B2BHN3FIY' as SecurityStamp,
 '985ba9aa-5a7d-4c39-9584-b6e3b21e7760' as ConcurrencyStamp,
 try_convert(nvarchar(50),replace([phone],'+2','')) as PhoneNumber,
 0 as PhoneNumberConfirmed,
 0 as TwoFactorEnabled,
 --try_cast(0 as varchar(50))  as LockoutEnd,
 null as LockoutEnd,
 0 as LockoutEnabled,
 0 as AccessFailedCount,
 try_cast(m_code as varchar(50)) as old_code
 ,id as old_id
 from CowPay_Production_Simulation.dbo.Users
 where is_merchant=0 


GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 1/1/2023 10:58:37 AM ******/
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
/****** Object:  Table [dbo].[AspNetUsers_DBA]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers_DBA](
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
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[old_code] [varchar](50) NULL,
	[old_id] [int] NULL,
 CONSTRAINT [PK_AspNetUsers_DBA] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CardMetaData]    Script Date: 1/1/2023 10:58:37 AM ******/
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
/****** Object:  Table [dbo].[Merchant_Claims]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Merchant_Claims](
	[Id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[user_id] [nvarchar](100) NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Migration_RollOut]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Migration_RollOut](
	[id] [bigint] NOT NULL,
	[code] [nvarchar](200) NULL,
	[is_migrated] [bit] NOT NULL,
 CONSTRAINT [PK_Migration_RollOut] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Migration_RollOut] ADD  CONSTRAINT [DF_Migration_RollOut_is_migrated]  DEFAULT ((0)) FOR [is_migrated]
GO
/****** Object:  StoredProcedure [dbo].[TransactionBalance_Prepared_RollOut_Orders_Insertions]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USE [TransactionManagement_Stage]
--GO
--/****** Object:  StoredProcedure [dbo].[TransactionBalance_Prepared_RollOut_Orders_Insertions]    Script Date: 12/12/2022 7:10:14 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
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
/****** Object:  StoredProcedure [dbo].[TransactionBalance_Prepared_RollOut_Withdrawals_Insertions]    Script Date: 1/1/2023 10:58:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USE [TransactionManagement_Stage]
--GO
--/****** Object:  StoredProcedure [dbo].[TransactionBalance_Prepared_RollOut_Withdrawals_Insertions]    Script Date: 12/12/2022 7:09:54 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
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
