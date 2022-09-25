import pandas as pd
#import mysql.connector as lol
import json
import collections
import sys
from sys import path
import pyarabic.araby as araby
import os
from decimal import *
#sys.path.append("module_path")
import sys
from sqlalchemy import create_engine


import connections as c

#conn_mysql = lol.connect(user='root', password='P@ssw0rd',host='localhost',database='cowpay_staging')
my_data = pd.read_sql("select *, case when block = 0 and is_merchant = 1 then 'approved' when block = 1 and is_merchant = 1 then 'Suspended' end as status from CowPay_Production_Simulation.[dbo].[Users] where is_merchant=1",c.cnxn)
#print text.encode('utf8')
#my_data.to_csv('d.csv',encoding='utf-8-sig')
#my_data.to_csv('d.csv',encoding='utf8')


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
settings = """select id, null,null ,null,m_callback_url,m_payments_notification,m_orders_notification,m_cowpay_payatfawry_percentage_commission,m_cowpay_payatfawry_fixed_commission,m_cowpay_credit_card_percentage_commission,m_cowpay_credit_card_fixed_commission,m_cowpay_collect_percentage_commission,m_cowpay_collect_fixed_commission,m_available_balance,m_commercial_registry_file,m_tax_id_file,m_personal_id_file from CowPay_Production_Simulation.dbo.users where is_merchant=1"""
cursor = c.cnxn.cursor()
cursor.execute(settings)
result = cursor.fetchall()
settings_dict={'id':[],'json_settings':[]}
for row in result:
    settings_id=row[0]
    settings_data = {
        "id": "",
        "merchantCode": row[1],
        "StatusTypeId": row[1],
        "moreSetting": {"m_callback_url": row[5], "m_payments_notification": row[6],"m_orders_notification":row[7]},
        "limitationNBlocking":[],
        "financialConfig":{"comessions":[{"payMethodType":2,"fixedVal":row[8],"percentage":row[7],"isEnabled":'true' },
                                         {"payMethodType":1,"fixedVal":row[10],"percentage":row[9],"isEnabled":'true'},
                                         {"payMethodType":6,"fixedVal":row[12],"percentage":row[11],"isEnabled":'true'}
                                        ],
        "autoWithdrawal":{"isEnabled":"","peroidType":"","monthDay":"","daysValue":"","day":""},
        "b2b":{"isEnabled":"","fixedVal":"","percentage":""},
        "chashout":{"isEnabled":"","values":[]}},
         "balanceConfiguration":{"m_available_balance":row[13]}
         }
    settings_dict['id'].append(settings_id)
    #class DecimalEncoder(json.JSONEncoder):
        #def default(self, obj):
       
           #if isinstance(obj, Decimal):
               #return str(obj)
        
           #return json.JSONEncoder.default(self, obj)




    settings_dict['json_settings'].append(json.dumps(settings_data , cls = JSONEncoder))
#s_json = json.dumps(settings_list)

s_json =pd.DataFrame(settings_dict)
#df2 = s_json.to_string(index=False)
#print(df1)
#s_json.to_csv('s.csv')
#print(s_json.to_string(index=False))
#s_json
#display(df.hide_index())
#df2


select_Users = """SELECT id,m_facebook,m_twitter,m_linked_in,m_instagram,m_website FROM CowPay_Production_Simulation.dbo.users where is_merchant=1"""
cursor = c.cnxn.cursor()
cursor.execute(select_Users)
result = cursor.fetchall()
Urls_dict={'id':[],'Urls_settings':[]}
for row in result:
    url_id=row[0]
    url_data = [
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
      
        ]
  
    Urls_dict['id'].append(url_id)
    Urls_dict['Urls_settings'].append(json.dumps(url_data))
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
    
        "m_commercial_registry_file": [row[1]],
        "m_tax_id_file": [row[2]],"m_personal_id_file": [row[3]]
        
    }
    image_dict['id'].append(image_id)
    image_dict['json_image'].append(json.dumps(image_data))
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





