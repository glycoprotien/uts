{{
    config(
        unique_key='LISTING_ID'
    )
}}

with

source  as (

    select * from {{ ref('listings_snapshot') }}

),

renamed as (
    select
        LISTING_ID,
        SCRAPE_ID, SCRAPED_DATE, HOST_ID,
    HOST_NAME, 
    TO_DATE (HOST_SINCE, 'DD/MM/YYYY') AS HOST_SINCE, 
    HOST_IS_SUPERHOST, 
    CASE WHEN HOST_NEIGHBOURHOOD='NAN' THEN 'UNKNOWN' ELSE HOST_NEIGHBOURHOOD END, 
    LISTING_NEIGHBOURHOOD,
    PROPERTY_TYPE,ROOM_TYPE,ACCOMMODATES, PRICE,HAS_AVAILABILITY,
    AVAILABILITY_30,NUMBER_OF_REVIEWS, 
    CASE WHEN REVIEW_SCORES_RATING='NAN' THEN 0 ELSE REVIEW_SCORES_RATING END, 
    CASE WHEN REVIEW_SCORES_ACCURACY='NAN' THEN 0 ELSE REVIEW_SCORES_ACCURACY END,
    CASE WHEN REVIEW_SCORES_CLEANLINESS='NAN' THEN 0 ELSE REVIEW_SCORES_CLEANLINESS END, 
    CASE WHEN REVIEW_SCORES_CHECKIN='NAN' THEN 0 ELSE REVIEW_SCORES_CHECKIN END,
    REVIEW_SCORES_COMMUNICATION,
    REVIEW_SCORES_VALUE
    from source
),

unknown as (
    select
        0 as LISTING_ID,
        'unknown' as brand_description,
        '1900-01-01'::timestamp  as dbt_valid_from,
        null::timestamp as dbt_valid_to

)
select * from unknown
union all
select * from renamed