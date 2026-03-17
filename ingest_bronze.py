import duckdb
import pandas as pd

# Connect to a local DuckDB database file
con = duckdb.connect("pipeline.duckdb")

# Read the raw CSV exactly as-is — no cleaning, no changes
raw_df = pd.read_csv("data/insurance.csv")

# Land it into the Bronze table, preserving everything
con.execute("DROP TABLE IF EXISTS bronze_claims")
con.execute("CREATE TABLE bronze_claims AS SELECT * FROM raw_df")

# Confirm it worked
result = con.execute("SELECT COUNT(*) FROM bronze_claims").fetchone()
print(f"Bronze layer loaded: {result[0]} rows")

# Peek at the first 5 rows
print(con.execute("SELECT * FROM bronze_claims LIMIT 5").df())

con.close()