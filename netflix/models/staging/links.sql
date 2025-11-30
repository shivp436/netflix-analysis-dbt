{{ 
  config(
    name='staging_links',
    alias='links'
  )
}}

with raw_links as (
  select * from {{ source('raw', 'links') }}
)

SELECT
  movieId AS movie_id,
  imdbId AS imdb_id,
  tmdbId AS tmdb_id
FROM raw_links
