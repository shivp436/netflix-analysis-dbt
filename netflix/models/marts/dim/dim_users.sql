with rating_users as (
  select distinct user_id from {{ ref('staging_ratings') }}
)

, tags_users as (
  select distinct user_id from {{ ref('staging_tags') }}
)

select user_id from rating_users
union 
select user_id from tags_users
