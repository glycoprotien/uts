{% snapshot NSW_LGA_CODE_timestamp %}

    {{
        config(
          target_schema='RAW',
          strategy='timestamp',
          unique_key='LGA_CODE',
          updated_at='updated_at'
        )
    }}

    select * from {{ source('NSW_LGA_CODE') }}

{% endsnapshot %}