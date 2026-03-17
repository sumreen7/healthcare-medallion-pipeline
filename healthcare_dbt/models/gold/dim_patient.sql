with source as (
    select * from {{ ref('silver_claims') }}
),

dim as (
    select
        row_number() over () as patient_key,
        age,
        age_group,
        sex,
        bmi,
        bmi_category,
        is_smoker,
        children,
        region
    from source
)

select * from dim