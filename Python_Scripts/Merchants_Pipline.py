import pandas as pd
#import mysql.connector as lol
import json
import collections
import sys
from sys import path
import os
from decimal import *
#sys.path.append("module_path")
import sys
from sqlalchemy import create_engine


import connections as c

my_data = pd.read_sql("select *, case when block = 0 and is_merchant = 1 then 'approved' when block = 1 and is_merchant = 1 then 'Suspended' end as status from CowPay_Production_Simulation.[dbo].[Users] where is_merchant=1",c.cnxn)


def fix_Dict(comessions):
    arr = []
    for element in comessions :
        if element['percentage'] != 0.0 or element['fixedVal'] != 0.0:
            arr.append(element)
    return arr


def fix_Url(url_data):
    arr = []
    for element in url_data :
        if element['SocialUrl'] != None:
           arr.append(element) 
    return arr

class create_dict(dict): 
  
    # __init__ function 
    def __init__(self): 
        self = dict() 
          
    # Function to add key:value 
    def add(self, key, value): 
        self[key] = value
        

class JSONEncoder(json.JSONEncoder):
    def default (self, obj):
        if isinstance(obj, Decimal):
            return float(obj)
        return json.JSONEncoder.default(self, obj)


mydict = create_dict()
settings = """select * from Merchants_Settings"""
cursor = c.cnxn.cursor()
cursor.execute(settings)
result = cursor.fetchall()
settings_dict={'id':[],'json_settings':[]}
for row in result:
    settings_id=row[0]
    settings_data = {
     "id": "",
        "merchantCode": '' if row[1] is None else row[1],
        "StatusTypeId": '' if row[2] is None else row[2],
        "moreSetting": {"NotificationSetting":{"callbackURL":'' if row[4] is None else row[4] ,"allowPaymentNotify":False if row[5] is 0 else True,"allowOrderNotify":False if row[6] is 0 else True, "SMSSetting":{"EnableSendSMS":False,"QuotaSMS":0,"ConsumedSMS":0,"RemainingSMS":0}}},
        "limitationNBlocking":[],
        "financialConfig":{"comessions":fix_Dict([{"payMethodType":2,"fixedVal":row[8],"percentage":row[7],"isEnabled":True},
                                         {"payMethodType":1,"fixedVal":row[10],"percentage":row[9],"isEnabled":True},
                                         {"payMethodType":6,"fixedVal":row[12],"percentage":row[11],"isEnabled":True},
                                         {"payMethodType":3,"fixedVal":row[14],"percentage":row[13],"isEnabled":True},
                                         {"payMethodType":4,"fixedVal":row[16],"percentage":row[15],"isEnabled":True},
                                         {"payMethodType":5,"fixedVal":row[18],"percentage":row[17],"isEnabled":True},
                                         {"payMethodType":7,"fixedVal":row[20],"percentage":row[19],"isEnabled":True}
                                        ]),
        "autoWithdrawal":{"isEnabled":False,"peroidType":"Days","peroidValue":"0"},
        "b2b":{"isEnabled":False,"fixedVal":"","percentage":""},
        "chashout":{"isEnabled":False,"values":[]}},
         "balanceConfiguration":{"AvailableBalanceThresholdDays":row[21]}  }
    settings_dict['id'].append(settings_id)
    #class DecimalEncoder(json.JSONEncoder):
        #def default(self, obj):
       
           #if isinstance(obj, Decimal):
               #return str(obj)
        
           #return json.JSONEncoder.default(self, obj)




    settings_dict['json_settings'].append(json.dumps(settings_data , cls = JSONEncoder).replace('null', '[]'))
    #r = json.dumps(j).replace('null', '""')
#s_json = json.dumps(settings_list)

s_json =pd.DataFrame(settings_dict)
#df2 = s_json.to_string(index=False)
#print(df1)
            
    
#s_json.to_csv('s.csv')
#print(s_json.to_string(index=False))
#s_json.head()
#display(df.hide_index())
#df2

#def fix_Url(url_data):
#    arr = []
#    for element in url_data :
#        if element['SocialUrl'] == None:
#           arr.append(element) 
#    return arr

select_Users = """SELECT id,m_facebook,m_twitter,m_linked_in,m_instagram,m_website FROM CowPay_Production_Simulation.dbo.users where is_merchant=1"""
cursor = c.cnxn.cursor()
cursor.execute(select_Users)
result = cursor.fetchall()
Urls_dict={'id':[],'Urls_settings':[]}
for row in result:
    url_id=row[0]
    url_data = fix_Url( [
      {      
    
        "SocialUrl": row[1],
        "SocialType": {"id": "1", "Name": "Facebook","Icon":"fab fa-facebook-f"}
        
    },
          
    {
       "SocialUrl": row[2],
        "SocialType": {"id": "2", "Name": "Twitter","Icon":"fab fa-twitter"},
    },
    {
        "SocialUrl": row[3],
        "SocialType": {"id": "3", "Name": "LinkedIn","Icon":"fas fa-link"},
    },
    {
        "SocialUrl": row[4],
        "SocialType": {"id": "5", "Name": "m_instagram","Icon":"fas fa-instagram"},
    },
        
    {
        "SocialUrl": row[5],
        "SocialType": {"id": "4", "Name": "Website","Icon":""},
    }
      
        ])
  
    Urls_dict['id'].append(url_id)
    Urls_dict['Urls_settings'].append(json.dumps(url_data).replace('null', '[]'))
#s_json = json.dumps(settings_list)

u_json =pd.DataFrame(Urls_dict)
#u_json
#u_json.to_csv('u.csv')

    #list.append(data)
    #print(data)
#stud_json = json.dumps(list)

#stud_json
#list

select_Usersss= """SELECT id,m_commercial_registry_file,m_tax_id_file,m_personal_id_file FROM CowPay_Production_Simulation.dbo.users where is_merchant=1"""

cursor = c.cnxn.cursor()
cursor.execute(select_Usersss)
result = cursor.fetchall()
image_dict={'id':[],'json_image':[]}
for row in result:
    image_id=row[0]

    image_data = {      
        "TaxIdImageUrls": [row[2]],
        "PersonalIDImageUrls": [row[3]],
        "CommercialRegistrationImageUrls": [row[1]],
        
        
    }
    image_dict['id'].append(image_id)
    image_dict['json_image'].append(json.dumps(image_data).replace('[null]', '[]'))
#s_json = json.dumps(settings_list)

i_json =pd.DataFrame(image_dict)
#i_json.to_csv('i.csv')
#i_json

    #Urls.append(image_data)
    #print(data)
#Urls_json = json.dumps(Urls)
#Urls_json

 
      
      


final=my_data.merge(s_json ,on='id').merge(u_json,on='id').merge(i_json,on='id')

#final.to_csv('final.csv', encoding='utf-8-sig')
#lol.to_csv('vat_vs_withholding.csv',encoding='utf-8')
#final.to_csv
#final.to_csv('final.csv',encoding='utf-8-sig')
#lol.to_csv('vat_vs_withholding.csv',encoding='utf-8')
#final.to_csv



MSS_Staging_engine = create_engine("mssql+pymssql://python:python@localhost:1433/Staging_Migration?charset=utf8")
final.to_sql('Staging_Merchant', con=MSS_Staging_engine,schema=None, if_exists='replace')





