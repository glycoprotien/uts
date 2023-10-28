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
        SCRAPE_ID, TO_DATE (SCRAPED_DATE, 'YYYY/MM/DD') as SCRAPED_DATE, HOST_ID,
    HOST_NAME, 
     CASE WHEN HOST_SINCE='NaN' THEN '01-01-1900' ELSE TO_DATE(HOST_SINCE, 'DD-MM-YYYY')AS HOST_SINCE,
    HOST_IS_SUPERHOST, 
    CASE WHEN HOST_NEIGHBOURHOOD='NaN' THEN 'UNKNOWN' ELSE HOST_NEIGHBOURHOOD END, 
    LISTING_NEIGHBOURHOOD,
    PROPERTY_TYPE,ROOM_TYPE,ACCOMMODATES, PRICE,HAS_AVAILABILITY,
    AVAILABILITY_30,NUMBER_OF_REVIEWS, 
    CAST (CASE WHEN REVIEW_SCORES_RATING='NaN' THEN '0' ELSE REVIEW_SCORES_RATING END AS DECIMAL) AS REVIEW_SCORES_RATING, 
    CAST (CASE WHEN REVIEW_SCORES_ACCURACY='NaN' THEN '0' ELSE REVIEW_SCORES_ACCURACY END AS DECIMAL) AS REVIEW_SCORES_ACCURACY,
    CAST (CASE WHEN REVIEW_SCORES_CLEANLINESS='NaN' THEN '0' ELSE REVIEW_SCORES_CLEANLINESS END AS DECIMAL) AS REVIEW_SCORES_CLEANLINESS, 
    CAST (CASE WHEN REVIEW_SCORES_CHECKIN='NaN' THEN '0' ELSE REVIEW_SCORES_CHECKIN END AS DECIMAL) AS REVIEW_SCORES_CHECKIN,
    CAST (CASE WHEN REVIEW_SCORES_COMMUNICATION='NaN' THEN '0' ELSE REVIEW_SCORES_COMMUNICATION END AS DECIMAL) AS REVIEW_SCORES_COMMUNICATION,
    CAST (CASE WHEN REVIEW_SCORES_VALUE='NaN' THEN '0' ELSE REVIEW_SCORES_VALUE END AS DECIMAL) AS REVIEW_SCORES_VALUE,
    dbt_scd_id, dbt_updated_at, dbt_valid_from, dbt_valid_to
    from source
)

select * from renamed