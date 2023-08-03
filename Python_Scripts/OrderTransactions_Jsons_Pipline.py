import connections as conn
import df_initilizer as dfi
import pandas as pd
from pandas import NaT
import pyspark.pandas as pds
import json
import dask.dataframe as ddf
from sqlalchemy import create_engine

engine = create_engine(conn.CowPay_Production_Simulation_DB)

def Apply_Fawry_Request(row):
    json_ser='''{"paymentExpiry": "1631138500000"}'''
    json_des=json.loads(json_ser)
    json_des["paymentExpiry"]=str(row.paymentExpiry)
    #new_json=
    #return json.dumps(json_des)
    return json.dumps(json_des)#.replace("'", '"')
    #print(json.dumps(json_des))


def Apply_Fawry_Response(row):
    json_ser ='''{"referenceNumber": "7105039001"}'''
    json_des=json.loads(json_ser)
    json_des["referenceNumber"]=str(row.referenceNumber)
    return json.dumps(json_des)


def Apply_Bosta_Request(row):
    json_ser ='''{"address": "ssdaaaassdasd","apartment": 2,"floor": 1,"cityCode": "EG-01","district": "ddd"}'''
    json_des=json.loads(json_ser)
    json_des.update({"address": str(row.address),"apartment":str(row.apartment),"floor": str(row.floor),"cityCode":str(row.cityCode),"district":str(row.district)})
    return json.dumps(json_des)



def Apply_Akurateko_Request(row):
    json_ser='''{"action":"Sale","cardNumber":"411111******1111","cardExpMonth":"01","cardExpYear":"2024","isTokenized":true,"isRecurring":true,"customerEmail":"doe@example.com","period":null,"initPeriod":null,"times":null,"cardToken":null,"termUrl3ds":null,"transId":null,"recurringToken":null,"recurringFirstTransId":null,"amount":0.0}'''
    json_des=json.loads(json_ser)
    json_des.update({"action":str(row.action),"cardNumber":str(row.cardNumber),"cardExpMonth":str(row.cardExpMonth),"cardExpYear":str(row.cardExpYear),"isTokenized":str(row.isTokenized),"isRecurring":str(row.isRecurring),"customerEmail":str(row.customerEmail),"period":str(row.period),"initPeriod":str(row.initPeriod),"times":str(row.times),"cardToken":str(row.cardToken),"termUrl3ds":str(row.termUrl3ds),"transId":str(row.transId),"recurringToken":str(row.recurringToken),"recurringFirstTransId":str(row.recurringFirstTransId),"amount":str(row.amount)})
    return json.dumps(json_des)
    


def Apply_Meeza_Request(row):
    json_ser='''{"tahweelQR": null,"mVisaQR": null,"validity": "jhjh","consumerMobileNumber": null,"loyaltyNumber": "asasN","customerLabel": "CL","purposeOfTransaction": "Test","billNumber":"01001920550","convenienceFeeFixed": null,"convenienceFeePercentage": null,"dateTimeLocalTrxn": null,"tip": null,"gatewayTargetMethod": 0,"merchantReferenceId": null,"customerMerchantProfileId": "11111","merchantId": 0,"merchantCode": "00000000-0000-0000-0000-000000000000","amount": 10,"description": "string","paymentGatewayTypeId": 0,"channelType": 0,"customerFirstName": "ahmed","customerLastName": null,"customerMobile": "01008606003","customerEmail": "ahmed@gmail.com","returnURL": null,"isFeesOnCustomer": false,"paymentLinkTypeId": 0,"paymentLinkId": null,"commession": null,"PromoCode": null,"ExtraData": null}'''
    json_des=json.loads(json_ser)
    json_des.update({"tahweelQR": str( row.tahweelQR) ,"mVisaQR": str( row.mVisaQR) ,"validity": str( row.validity) ,"consumerMobileNumber": str( row.consumerMobileNumber) ,"loyaltyNumber": str( row.loyaltyNumber) ,"customerLabel": str( row.customerLabel) ,"purposeOfTransaction": str( row.purposeOfTransaction) ,"billNumber": str( row.billNumber) ,"convenienceFeeFixed": str( row.convenienceFeeFixed) ,"convenienceFeePercentage": str( row.convenienceFeePercentage) ,"dateTimeLocalTrxn": str( row.dateTimeLocalTrxn) ,"tip": str( row.tip) ,"gatewayTargetMethod": str( row.gatewayTargetMethod) ,"merchantReferenceId": str( row.merchantReferenceId) ,"customerMerchantProfileId": str( row.customerMerchantProfileId) ,"merchantId": str( row.merchantId) ,"merchantCode": str( row.merchantCode) ,"amount": str( row.amount) ,"description": str( row.description) ,"paymentGatewayTypeId": str( row.paymentGatewayTypeId) ,"channelType": str( row.channelType) ,"customerFirstName": str( row.customerFirstName) ,"customerLastName": str( row.customerLastName) ,"customerMobile": str( row.customerMobile) ,"customerEmail": str( row.customerEmail) ,"returnURL": str( row.returnURL) ,"isFeesOnCustomer": str( row.isFeesOnCustomer) ,"paymentLinkTypeId": str( row.paymentLinkTypeId) ,"paymentLinkId": str( row.paymentLinkId) ,"commession": str( row.commession) ,"PromoCode": str( row.PromoCode) ,"ExtraData": str( row.ExtraData)})
    return json.dumps(json_des)


Akurateko_Transactions='''select * from Akurateko_Transactions where merchantCode  
in (select code from Staging_Migration.dbo.Migration_RollOut where is_migrated=0)'''

Bosta_Transactions= '''select * from Bosta_Transactions where merchantCode  
in (select code from Staging_Migration.dbo.Migration_RollOut where is_migrated=0) '''

Fawry_Transactions = '''select * from Fawry_Transactions where merchantCode  
in (select code from Staging_Migration.dbo.Migration_RollOut where is_migrated=0)'''

Meeza_Transactions = '''select * from Meeza_Transactions where merchantCode  
in (select code from Staging_Migration.dbo.Migration_RollOut where is_migrated=0) '''






fawry_df = pd.read_sql(Fawry_Transactions,engine,index_col='Transaction_ID')
if len(fawry_df)>0:
    fawry_df['PGWMetaRequest']=fawry_df.apply(Apply_Fawry_Request,axis=1)
    fawry_df['PGWMetaResponse']=fawry_df.apply(Apply_Fawry_Response,axis=1)
fawry_df=ddf.from_pandas(fawry_df,npartitions=1)



# Bosta_df = pd.read_sql(Bosta_Transactions,engine,index_col='Transaction_ID')
# if len(Bosta_df.index)>0:
#      Bosta_df['PGWMetaRequest']=Bosta_df.apply(Apply_Bosta_Request,axis=1)
#      Bosta_df['PGWMetaResponse']=NaT
# Bosta_df=ddf.from_pandas(Bosta_df,npartitions=1)



Akurateko_df = pd.read_sql(Akurateko_Transactions,engine,index_col='Transaction_ID')
if len(Akurateko_df)>0:
    Akurateko_df['PGWMetaRequest']=Akurateko_df.apply(Apply_Akurateko_Request,axis=1)
    Akurateko_df['PGWMetaResponse']=NaT
#Akurateko_df= pd.DataFrame(Akurateko_df.compute())
Akurateko_df=ddf.from_pandas(Akurateko_df,npartitions=1)






# Meeza_df = pd.read_sql(Meeza_Transactions,engine,index_col='Transaction_ID',)
# #Meeza_df = ddf.read_sql("Meeza_Transactions",conn.CowPay_Production_Simulation_DB,index_col='Transaction_ID',)
# #Meeza_df= pd.DataFrame(Meeza_df.compute())
# #Meeza_df.fillna(0)
# if len(Meeza_df)>0:
#     Meeza_df['PGWMetaRequest']=Meeza_df.df.apply(Apply_Meeza_Request,axis=1)
#     Meeza_df['PGWMetaResponse']=NaT
# #Meeza_df.head()
# Meeza_df=ddf.from_pandas(Meeza_df,npartitions=1)



df1= fawry_df[['PGWMetaRequest','PGWMetaResponse']]
df2= Akurateko_df[['PGWMetaRequest','PGWMetaResponse']]
# df3= Meeza_df[['PGWMetaRequest','PGWMetaResponse']]
# df4= Bosta_df[['PGWMetaRequest','PGWMetaResponse']]


all_data = ddf.concat([df1,df2],sort=False)
all_data.to_sql("OrderTransactions_jsons_Staging",conn.Staging_Migration_DB,if_exists='replace')
