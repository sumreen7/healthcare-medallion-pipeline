with source as (
    select * from {{ ref('silver_claims') }}
),

dim as (
    select * from {{ ref('dim_patient') }}
),

facts as (
    select
        row_number() over () as claim_key,
        d.patient_key,
        s.charges,
        s.is_high_value_claim,
        s.region,
        s.age_group,
        s.bmi_category,
        s.is_smoker
    from source s
    left join dim d
        on s.age = d.age
        and s.sex = d.sex
        and s.bmi = d.bmi
        and s.region = d.region
)

select * from facts