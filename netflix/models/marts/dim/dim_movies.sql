WITH staging_movies as (
  select * from {{ ref('staging_movies') }}
)

SELECT 
  movie_id, 
  INITCAP(TRIM(title)) as movie_title, 
  SPLIT(genres, '|') as genre_array,
  genres
FROM staging_movies
