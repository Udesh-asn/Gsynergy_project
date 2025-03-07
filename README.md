# Gsynergy_project

Attached is the :
1.ER duagram
2. JSON file for the pipeline on ADF
3. Stored procedures with which transformation is done

We are storing the data of the tables given to us in pipe(|) separated format on ADLS gen2,
from there we are picking it up with the help of ADF pipeline and then writing it to a 
raw schema on our SQL server hosted on Azure after that we are transferring the data to our final schema 
i.e. dbo where all the Foreighn key Primary key relationship is maintained with the help of Stored 
Procedure(dbo.TableLoading) which we are calling from Adf pipeline only. And finally we are transferring the data to 
the final table mview weekly sales with the help of transformations done in Stored procedure(dbo.final_process) which also we 
are calling from ADF.
