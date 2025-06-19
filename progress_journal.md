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
