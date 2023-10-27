{{
    config(
        unique_key='LISTING_ID'
    )
}}



select LISTING_ID, HOST_ID, HOST_IS_SUPERHOST, HOST_NAME, HOST_NEIGHBOURHOOD, HOST_SINCE, LISTING_NEIGHBOURHOOD,
ACCOMMODATES
from {{ ref('listings_stg') }} 