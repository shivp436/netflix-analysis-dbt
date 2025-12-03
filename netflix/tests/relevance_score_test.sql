select 
  movie_id
  , tag_id
from {{ ref('fact_genome_scores') }}
where relevance_score <= 0
