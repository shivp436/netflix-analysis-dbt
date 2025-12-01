{{ 
  config (
    materialized='incremental',
    on_schema_change='fail'
  )
}}

with staging_ratings as (
  select * from {{ ref('staging_ratings') }}
)

select 
  user_id
  , movie_id
  , rating 
  , rating_timestamp
from staging_ratings
where rating is not null

{% if is_incremental() %}
  and rating_timestamp > (select max(rating_timestamp) from {{ this }} )
{% endif %}
