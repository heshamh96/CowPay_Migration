import connections as conn
import df_initilizer as dfi
import pandas as pd
from pandas import NaT
import pyspark.pandas as pds
import json
import dask.dataframe as ddf


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
    json_des.update({"address": row.address,"apartment":row.apartment,"floor": row.floor,"cityCode":row.cityCode,"district":row.district})
    return json.dumps(json_des)

def Apply_Akurateko_Request(row):
    json_ser='''{"action":"Sale","cardNumber":"411111******1111","cardExpMonth":"01","cardExpYear":"2024","isTokenized":true,"isRecurring":true,"customerEmail":"doe@example.com","period":null,"initPeriod":null,"times":null,"cardToken":null,"termUrl3ds":null,"transId":null,"recurringToken":null,"recurringFirstTransId":null,"amount":0.0}'''
    json_des=json.loads(json_ser)
    json_des.update({"action":row.action,"cardNumber":row.cardNumber,"cardExpMonth":row.cardExpMonth,"cardExpYear":row.cardExpYear,"isTokenized":row.isTokenized,"isRecurring":row.isRecurring,"customerEmail":row.customerEmail,"period":row.period,"initPeriod":row.initPeriod,"times":row.times,"cardToken":row.cardToken,"termUrl3ds":row.termUrl3ds,"transId":row.transId,"recurringToken":row.recurringToken,"recurringFirstTransId":row.recurringFirstTransId,"amount":row.amount})
    return json.dumps(json_des)

    
def Apply_Meeza_Request(row):
    json_ser='''{"tahweelQR": null,"mVisaQR": null,"validity": "jhjh","consumerMobileNumber": null,"loyaltyNumber": "asasN","customerLabel": "CL","purposeOfTransaction": "Test","billNumber":"01001920550","convenienceFeeFixed": null,"convenienceFeePercentage": null,"dateTimeLocalTrxn": null,"tip": null,"gatewayTargetMethod": 0,"merchantReferenceId": null,"customerMerchantProfileId": "11111","merchantId": 0,"merchantCode": "00000000-0000-0000-0000-000000000000","amount": 10,"description": "string","paymentGatewayTypeId": 0,"channelType": 0,"customerFirstName": "ahmed","customerLastName": null,"customerMobile": "01008606003","customerEmail": "ahmed@gmail.com","returnURL": null,"isFeesOnCustomer": false,"paymentLinkTypeId": 0,"paymentLinkId": null,"commession": null,"PromoCode": null,"ExtraData": null}'''
    json_des=json.loads(json_ser)
    json_des.update({"tahweelQR": str( row.tahweelQR) ,"mVisaQR": str( row.mVisaQR) ,"validity": str( row.validity) ,"consumerMobileNumber": str( row.consumerMobileNumber) ,"loyaltyNumber": str( row.loyaltyNumber) ,"customerLabel": str( row.customerLabel) ,"purposeOfTransaction": str( row.purposeOfTransaction) ,"billNumber": str( row.billNumber) ,"convenienceFeeFixed": str( row.convenienceFeeFixed) ,"convenienceFeePercentage": str( row.convenienceFeePercentage) ,"dateTimeLocalTrxn": str( row.dateTimeLocalTrxn) ,"tip": str( row.tip) ,"gatewayTargetMethod": str( row.gatewayTargetMethod) ,"merchantReferenceId": str( row.merchantReferenceId) ,"customerMerchantProfileId": str( row.customerMerchantProfileId) ,"merchantId": str( row.merchantId) ,"merchantCode": str( row.merchantCode) ,"amount": str( row.amount) ,"description": str( row.description) ,"paymentGatewayTypeId": str( row.paymentGatewayTypeId) ,"channelType": str( row.channelType) ,"customerFirstName": str( row.customerFirstName) ,"customerLastName": str( row.customerLastName) ,"customerMobile": str( row.customerMobile) ,"customerEmail": str( row.customerEmail) ,"returnURL": str( row.returnURL) ,"isFeesOnCustomer": str( row.isFeesOnCustomer) ,"paymentLinkTypeId": str( row.paymentLinkTypeId) ,"paymentLinkId": str( row.paymentLinkId) ,"commession": str( row.commession) ,"PromoCode": str( row.PromoCode) ,"ExtraData": str( row.ExtraData)})
    return json.dumps(json_des)


fawry_df = ddf.read_sql("Fawry_Transactions",conn.CowPay_Production_Simulation_DB,index_col='Transaction_ID')
fawry_df['PGWMetaRequest']=fawry_df.apply(Apply_Fawry_Request,axis=1)
fawry_df['PGWMetaResponse']=fawry_df.apply(Apply_Fawry_Response,axis=1)



Bosta_df = ddf.read_sql("Bosta_Transactions",conn.CowPay_Production_Simulation_DB,index_col='Transaction_ID')
Bosta_df['PGWMetaRequest']=Bosta_df.apply(Apply_Bosta_Request,axis=1)
Bosta_df['PGWMetaResponse']=NaT




Akurateko_df = ddf.read_sql("Akurateko_Transactions",conn.CowPay_Production_Simulation_DB,index_col='Transaction_ID')
#Akurateko_df= pd.DataFrame(Akurateko_df.compute())
Akurateko_df['PGWMetaRequest']=Akurateko_df.apply(Apply_Akurateko_Request,axis=1)
Akurateko_df['PGWMetaResponse']=NaT



Meeza_df = ddf.read_sql("Meeza_Transactions",conn.CowPay_Production_Simulation_DB,index_col='Transaction_ID')
#Meeza_df= pd.DataFrame(Meeza_df.compute())
Meeza_df['PGWMetaRequest']=Meeza_df.apply(Apply_Meeza_Request,axis=1)
Meeza_df['PGWMetaResponse']=NaT



df1= fawry_df[['PGWMetaRequest','PGWMetaResponse']]
df2= Akurateko_df[['PGWMetaRequest','PGWMetaResponse']]
df3= Meeza_df[['PGWMetaRequest','PGWMetaResponse']]
df4= Bosta_df[['PGWMetaRequest','PGWMetaResponse']]


all_data = ddf.concat([df1,df2,df3,df4],sort=False)
all_data.to_sql("OrderTransactions_jsons_Staging",conn.Staging_Migration_DB,if_exists='replace')