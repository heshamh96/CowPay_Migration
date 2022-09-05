import pandas as pd
import pyspark.sql as dfapi
import pyspark.pandas as pds
from sqlalchemy import create_engine

mysql_Path = r'C:\Users\Administrator\Documents\cowpay_migration\Extra_Connections\MYSQL_8_Jar_Connector\mysql-connector-java-8.0.11.jar'
MSSQL_Path = r'C:\Users\Administrator\Documents\cowpay_migration\Extra_Connections\MSSQL_JDBC_Connector\enu\mssql-jdbc-11.2.0.jre17.jar'
spark = dfapi.SparkSession.Builder().config("spark.jars",mysql_Path).config("spark.driver.extraClassPath",MSSQL_Path)\
.appName("tryout").getOrCreate()

mysql_jdbc_Conn="jdbc:mysql://localhost:3306/cowpay_staging?user=root&password=P@ssw0rd"
#"jdbc:mysql://localhost:3306/cowpay_staging
MSSQL_Jdbc_Conn ="jdbc:sqlserver://localhost:1433;database=MerchantManagement;user=sa;password=2580;trustServerCertificate=true;"
engine = create_engine('mssql+pymssql://sa:2580@localhost:1433/MerchantManagement')


df = spark.read.format("jdbc").option("url", mysql_jdbc_Conn) \
   .option("driver", "com.mysql.jdbc.Driver").option("dbtable", "countries") \
    .load()
  #  .option("user", "root").option("password", "P@ssw0rd").load()
df.createOrReplaceTempView('city')
df_staging=spark.sql('''
select 
cast(id as int) id, cast(name as varchar(50)) as name, cast (code as int) code , cast(flag as int) flag, created_at, updated_at, deleted_at
from city
''')

cowpay_cities_src=df_staging.to_pandas_on_spark()

cowpay_cities_trgt=pds.read_sql("select * from dbo.cities_bkb",MSSQL_Jdbc_Conn )

new_names= {'id':'ID', 'name':'Name', 'code':'CountryId', 'flag':'IsDeleted', 'created_at':'CreatedDate', 'updated_at':'UpdatedDate', 'deleted_at':'DeletedDate'}

cowpay_cities_src.rename(new_names,inplace=True,axis=1)

cowpay_cities_src.drop('ID',axis='columns').to_spark_io(format="jdbc", mode="append",
    dbtable="cities_bkb", url=MSSQL_Jdbc_Conn)


spark.stop()