{{ 
  config(
    name='staging_genome_tags',
    alias='genome_tags'
  )
}}

with raw_genome_tags as (
  select * from {{ source('raw', 'genome_tags') }}
)

select 
  tagID as tag_id
  , tag
from raw_genome_tags

