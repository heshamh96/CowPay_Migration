import connections as conn
from sqlalchemy import create_engine
import pandas as pd


Merchants = '''SELECT *
  FROM [Staging_Migration].[dbo].[AspNetUsers] where old_id in (select id from Staging_Merchant) '''
engine = create_engine(conn.Staging_Migration_DB)
merchants_df = pd.read_sql(Merchants,engine)


def prepare_query(id):
    Insert_query=f'''
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Dashboard.View ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Dashboard.IniatePayment ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Transaction.View ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Transaction.ViewDetails ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Transaction.Export ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Transaction.Refund ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Balance.View ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Balance.Export ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Balance.TransferMoney ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.BalanceStatement.View ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.BalanceStatement.Export ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.VAT.View ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.VAT.Export ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Customer.View ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Customer.Export ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Team.View ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Team.Export ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Team.Create ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Team.Edit ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Team.Delete ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.ViewBank ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.ExportBank ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.CreateBank ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.EditBank ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.DeleteBank ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.ViewFawry ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.ExportFawry ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.CreateFawry ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.EditFawry ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.DeleteFawry ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.ViewWallet ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.ExportWallet ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.CreateWallet ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.EditWallet ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Account.DeleteWallet ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Profile.View ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Profile.ViewCompany ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Profile.EditCompany ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Profile.ChangePassword ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.ApiSetting.ViewToken ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.ApiSetting.ExportToken ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.ApiSetting.GenerateToken ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.ApiSetting.RemoveToken ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.ApiSetting.EditCallbackUrl ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.PaymentLink.View ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.Product.View ') 
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'permission', N'Permissions.Merchant.IFrame.View ')
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'name', N'')
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'memberrole', N'SuperAdmin')
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'MerchantCode', N'')
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'MerchantId', N'')
INSERT into [dbo].[Merchant_Claims] ([user_id], [ClaimType], [ClaimValue]) VALUES (N'{str(id)}', N'IsMaster', N'true')                   
'''
    return Insert_query


for id in merchants_df.Id:
    engine.connect().execute(prepare_query(id))









