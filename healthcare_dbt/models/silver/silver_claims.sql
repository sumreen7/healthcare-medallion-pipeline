with source as (
    select * from bronze_claims
),

cleaned as (
    select
        -- standardize smoker to boolean
        case when smoker = 'yes' then true else false end as is_smoker,

        -- bucket age into groups
        case
            when age < 18 then 'minor'
            when age between 18 and 35 then 'young_adult'
            when age between 36 and 55 then 'middle_aged'
            else 'senior'
        end as age_group,

        -- standardize BMI into categories
        case
            when bmi < 18.5 then 'underweight'
            when bmi between 18.5 and 24.9 then 'normal'
            when bmi between 25 and 29.9 then 'overweight'
            else 'obese'
        end as bmi_category,

        -- flag high-value claims
        case when charges > 30000 then true else false end as is_high_value_claim,

        -- keep original columns too
        age,
        sex,
        bmi,
        children,
        region,
        round(charges, 2) as charges

    from source
)

select * from cleaned