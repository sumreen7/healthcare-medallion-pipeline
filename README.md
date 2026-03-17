# Healthcare Claims — Medallion Architecture Pipeline

An end-to-end ETL pipeline built on a real healthcare claims dataset using Python, DuckDB, and dbt. Demonstrates Bronze/Silver/Gold medallion architecture with Kimball dimensional modeling.

## Architecture
```
Raw CSV → Bronze (raw ingest) → Silver (dbt cleaning) → Gold (fact + dimensions)
```

## Layers

**Bronze** — Raw 1,338 healthcare claims ingested as-is from CSV into DuckDB. No transformations. Preserves source truth.

**Silver** — dbt models that clean and standardize the Bronze data. Applies business rules: BMI categorization, age bucketing, smoker flag normalization, high-value claim flagging. 6 data quality tests passing.

**Gold** — Kimball-style dimensional model with `dim_patient` and `fact_claims`. Business-ready tables for analytics.

## Key Insight

Smokers average **$32,108** in claims vs **$8,415** for non-smokers — a 3.8x difference.

## Tech Stack

- Python 3.13
- DuckDB
- dbt-core 1.11 + dbt-duckdb
- Tableau Public

## Project Structure
```
MEDALLION-PIPELINE/
├── data/               # Raw source CSV
├── ingest_bronze.py    # Bronze ingestion script
└── healthcare_dbt/
    └── models/
        ├── silver/     # Cleaning models + tests
        └── gold/       # Fact and dimension tables
```

## How to Run
```bash
# 1. Activate virtual environment
source venv/bin/activate

# 2. Ingest raw data into Bronze
python3 ingest_bronze.py

# 3. Run dbt models (Silver + Gold)
cd healthcare_dbt
dbt run

# 4. Run data quality tests
dbt test
```

## Dashboard

Built on top of the Gold layer using Tableau Public.

[View live dashboard](https://public.tableau.com/app/profile/fathima.sumreen/viz/HealthcareClaims-MedallionPipelineDashboard/Dashboard1)

Key findings:
- Smokers average **$32,108** in claims vs **$8,415** for non-smokers (3.8x higher)
- Senior age group carries the highest average claim cost
- Southeast region has the highest claim volume