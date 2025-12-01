with staging_genome_scores as (
  select * from {{ ref('staging_genome_scores') }}
)

select 
  movie_id
  , tag_id
  , round(relevance, 4) as relevance_score
from staging_genome_scores
where relevance > 0
