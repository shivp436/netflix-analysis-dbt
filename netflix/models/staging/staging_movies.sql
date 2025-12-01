{{ 
  config(
    alias='movies'
  )
}}

-- name: dbt model name
-- schema: snowflake schema
-- alias: snowflake object name

with raw_movies as (
  select * from {{ source('raw', 'movies') }}
)

select 
  movieID as movie_id
  , title
  , genres
from raw_movies
