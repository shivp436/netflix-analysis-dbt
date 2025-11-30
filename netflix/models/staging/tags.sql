{{
  config(
    materialized='table',
    name='staging_tags',
    alias='tags
  )
}}

WITH raw_tags AS (
  SELECT * FROM {{ source('raw', 'tags') }}
)

SELECT
  userId AS user_id,
  movieId AS movie_id,
  tag,
  TO_TIMESTAMP_LTZ(timestamp) AS tag_timestamp
FROM raw_tags
