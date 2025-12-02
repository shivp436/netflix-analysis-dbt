{{
  config (
    materialized = 'table'
  )
}}

with fact_ratings as (
  select * from {{ ref('fact_ratings')}}
)
, seed_dates as (
  select * from {{ ref('seed_movie_release_dates')}}
)

select
  f.*
  , case
      when d.release_date is null then 'Unknown'
      else 'known'
    end as release_info_available
from fact_ratings as f 
left join seed_dates as d 
  on f.movie_id = d.movie_id
