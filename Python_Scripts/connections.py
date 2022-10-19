import pyodbc
cnxn_str = ("Driver={SQL Server Native Client 11.0};Server=BI-SERVER2022;port=1433;Database=CowPay_Production_Simulation;UID=python;PWD=python;")
cnxn = pyodbc.connect(cnxn_str)
conn_sql="Server=BI-SERVER2022;Database=CowPay_Production_Simulation;User Id=python;Password=python;"
cursor = cnxn.cursor()



#cowpay_JDBC="jdbc:mysql://localhost:3306/cowpay_staging?user=root&password=P@ssw0rd"

#cowpay='mysql+pymysql://root:P@ssw0rdr@localhost/cowpay_staging'

CowPay_Production_Simulation_DB_JDBC ="jdbc:sqlserver://localhost:1433;database=CowPay_Production_Simulation;user=python;password=python;trustServerCertificate=true;"
Staging_Migration_DB_JDBC ="jdbc:sqlserver://localhost:1433;database=Staging_Migration;user=sa;password=2580;trustServerCertificate=true;"


CowPay_Production_Simulation_DB='mssql+pymssql://python:python@localhost:1433/CowPay_Production_Simulation'
Staging_Migration_DB='mssql+pymssql://sa:2580@localhost:1433/Staging_Migration'