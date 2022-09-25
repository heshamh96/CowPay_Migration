import pyodbc
cnxn_str = ("Driver={SQL Server Native Client 11.0};Server=BI-SERVER2022;port=1433;Database=CowPay_Production_Simulation;UID=python;PWD=python;")
cnxn = pyodbc.connect(cnxn_str)
conn_sql="Server=BI-SERVER2022;Database=CowPay_Production_Simulation;User Id=python;Password=python;"
cursor = cnxn.cursor()