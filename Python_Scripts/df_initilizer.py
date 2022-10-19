from turtle import setx
import pandas as pd
import pyspark.sql as dfapi
import pyspark.pandas as pds
from sqlalchemy import create_engine
import connections 

#def Initialize_Connections():
Cowpay_JDBC_conn_string=connections.CowPay_Production_Simulation_DB_JDBC
MSSQL_Jdbc_Conn_string =connections.Staging_Migration_DB_JDBC


#Cowpay_conn = create_engine(secrets.cowpay)

#Merchants_Management_Conn= create_engine(secrets.Merchants_Management_DB)


def initialize_spark_object(APPName):
    mysql_Path = r'C:\Users\Administrator\Documents\cowpay_migration\Extra_Connections\MYSQL_8_Jar_Connector\mysql-connector-java-8.0.11.jar'
    MSSQL_Path = r'C:\Users\Administrator\Documents\cowpay_migration\Extra_Connections\MSSQL_JDBC_Connector\enu\mssql-jdbc-11.2.0.jre17.jar'
    spark = dfapi.SparkSession.Builder().config("spark.jars",mysql_Path).config("spark.driver.extraClassPath",MSSQL_Path)\
        .appName(APPName).getOrCreate()
    return spark


def cowpay_spark_df(Spark_Object,Query,conn=Cowpay_JDBC_conn_string):
    df = Spark_Object.read.format("jdbc").option("url", conn) \
        .option("driver", "com.mysql.jdbc.Driver").option("query", Query) \
            .load()
    return df.to_pandas_on_spark()

# def cowpay_spark_df():
#     pass