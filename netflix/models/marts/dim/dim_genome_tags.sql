with staging_genome_tags as (
  select * from {{ ref('staging_genome_tags') }}
)

select 
  tag_id
  , INITCAP(TRIM(tag)) as tag_name
from staging_genome_tags
