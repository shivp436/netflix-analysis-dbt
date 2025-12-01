{{ 
  config(
    alias='genome_scores'
  )
}}

with raw_genome_scores as (
  select * from {{ source('raw', 'genome_scores') }}
)

select 
  movieID as movie_id
  , tagID as tag_id
  , relevance
from raw_genome_scores
