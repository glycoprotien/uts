{% snapshot CENSUS_G01_timestamp %}

    {{
        config(
          target_schema='RAW',
          strategy='timestamp',
          unique_key='LGA_CODE_2016',
          updated_at='updated_at',
        )
    }}

    select * from {{ source( 'CENSUS_G01') }}

{% endsnapshot %}