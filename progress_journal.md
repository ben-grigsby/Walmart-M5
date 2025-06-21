<details>
  <summary>📅 2025-06-19 – 🚀 Project Kickoff & 🧱 Data Engineering Setup</summary>

## 06/19/2025

Kick off a comprehensive data project that begins with SQL-based data engineering using the Walmart M5 dataset, 
then builds upward into machine learning and data science techniques. 
The final goal is a full-stack pipeline that showcases end-to-end technical competence.

### Progress
- Melted `sales_train_evaluation` and `sales_train_validation` using Python to convert wide-format datasets into a long format.
  This was essential because the original structure included thousands of columns — highly inefficient for relational databases and nearly unusable in SQL.

- Transferred the processed datasets to my secondary laptop, which is dedicated to SQL development.

- Initialized a new database and created the bronze schema in Microsoft SQL Server Management Studio (SSMS).

- The DE portion of this project will follow the medallion architecture and build on what I learned during my previous data warehouse project.

### Challenges
1. **File Path Errors**
   - Initial errors claimed the CSV file didn’t exist.
   - Verified path using `EXEC xp_fileexist`, which returned `1, 0, 1`, confirming correct path and file presence.

2. **Permission Conflicts**
   - Received: *“Cannot bulk load. The file does not exist or you don’t have file access.”*
   - Resolved by verifying read permissions and ensuring SQL Server had access.

3. **Data Type Mismatches**
   - Error: *“The column is too long in the data file for row 1, column 8.”*
   - Temporary solution: defined all columns as `NVARCHAR(MAX)` to eliminate truncation issues.

4. **Row Terminator Issue**
   - Data failed to import properly due to incorrect row terminator.
   - Resolved by explicitly setting `ROWTERMINATOR = '0x0a'`.

5. **Empty Table After Insert**
   - After running the `BULK INSERT`, a `SELECT *` returned no rows.
   - Root cause likely a combination of the above issues, resolved through isolation and re-running.

### Reflection

First day done.
There were definitely a fair number of challenges, the majority of which came from loading CSV files into my SQL Server database. 
It felt like every time I fixed one error, another would immediately follow. These ranged from file path issues to data type mismatches, and finally a newline encoding problem that 
silently broke my inserts. Despite the frustration, I pushed through and managed to solve all of the ingestion issues. I now have **reusable SQL code** that successfully handles 
loading external CSVs into the staging layer of my medallion architecture, even with tricky newline formats or unexpected data quirks. This was one of those days where the wins weren’t 
glamorous — but they were **foundational**. The project is now officially underway, though in all honesty there were a couple crash-outs.


</details>


<details>
  <summary>📅 2025-06-21 – ✅ Successful Full Bronze Load & Dev Edition Setup</summary>

## 06/21/2025

Today marked a major milestone in the infrastructure of the project: __successfully loading all Bronze layer tables__ into SQL using BULK INSERT via a fully automated stored procedure. This included runtime logging for each stage and batch. This was also the day I transitioned from SQL Express to __SQL Developer Edition__ after hitting storage and license limits -- a critical and necessary upgrade.

### Progress

- Ran and confirmed successful execution of the `bronze.load_bronze` stored procedure, which loaded all four M5 tables:
  - `calendar`
  - `sales_train_evaluation` (melted)
  - `sales_train_validation` (melted)
  - `sell_prices`

- Added execution time logs to each table's load process, outputting both minutes and seconds.
- Pushed Bronze Layer SQL scripts to GitHub with organized structure and comments.
- Enabled __autogrowth__ on both `walmart` and `walmart_log` files to prepare for growing data loads.
- Switched to SQL Server Developer Edition after encountering persistent storage allocation errors with Express Edition.

### Challenges

1. __Disk Space Limitations (SQL Express)__

  - Encountered: "*Insufficient disk space in fielgroup 'PRIMARY'*" and "*cumulative database size would exceed your licensed limit*"

  - Tried enabling autogrowth, but this did not resolve the issue -- the real blocker was the 10GB size cap of SQL Express

2. __SQL Developer Editino Migration__

  - After installing Dev Edition, inital confusin around MSSQLSERVER vs. SQLEXPRESS instances.
  - Verified active server with SELECT @@SERVICENAME, @@VERSION and successfully connected to the new instance.

3. __Data Reload from Scratch)__

  - Switching instances required rebuilding the database, re-importing the tables, and rerunning all creation + load scripts.
  - Fortunately, having clean and modular SQL scripts paid off -- this was tedious, but not chaotic.

4. __File Transfer Logistics__

  - Melted datasets were generated on Mac and moved via external hard drive to Windows laptop running SQL Server.

### __Reflection__

__Huge win today.__ The Bronze Layer is not just 'set up' -- its operational and robust. Every table now loads reliably from raw CSV, and runtime logging adds a layer of professionalism. It wasn't without pain: Express Edition's limits were a brick wall, and reinitializing the database felt redundant at times. But all of the frustration is front-loaded technical debt -- and now it's paid off. From here, I can build Silver/Gold layers confidently, knowing that data ingestion is no longer a bottleneck. Today was not flashy, but it was real. The foundation of the project is there now.

</details>
