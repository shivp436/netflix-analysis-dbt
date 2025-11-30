USE WAREHOUSE NETFLIX_DBT_WH;
USE ROLE NETFLIX_DBT_ROLE;
USE DATABASE NETFLIX_DBT_DB;
USE SCHEMA RAW;

-- MOVIE TABLE
CREATE OR REPLACE TABLE raw_movies (
    movieId INTEGER,
    title STRING,
    genres STRING
);
COPY INTO raw_movies
FROM @netflix_r2_stage/movies.csv
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

-- RATINGS 
CREATE OR REPLACE TABLE raw_ratings (
  userId INTEGER,
  movieId INTEGER,
  rating FLOAT,
  timestamp BIGINT
);
COPY INTO raw_ratings
FROM @netflix_r2_stage/ratings.csv
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

-- TAGS
CREATE OR REPLACE TABLE raw_tags (
  userId INTEGER,
  movieId INTEGER,
  tag STRING,
  timestamp BIGINT
);
COPY INTO raw_tags
FROM @netflix_r2_stage/tags.csv
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

-- GENOME SCORES
CREATE OR REPLACE TABLE raw_genome_scores (
  movieId INTEGER,
  tagId INTEGER,
  relevance FLOAT
);
COPY INTO raw_genome_scores
FROM @netflix_r2_stage/genome-scores.csv
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

-- RAW GENOME TAGS
CREATE OR REPLACE TABLE raw_genome_tags (
  tagId INTEGER,
  tag STRING
);
COPY INTO raw_genome_tags
FROM @netflix_r2_stage/genome-tags.csv
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

-- LINKS
CREATE OR REPLACE TABLE raw_links (
  movieId INTEGER,
  imdbId INTEGER,
  tmdbId INTEGER
);
COPY INTO raw_links
FROM @netflix_r2_stage/links.csv
FILE_FORMAT = csv_format
ON_ERROR = 'CONTINUE';

-- CHECK ROWS
SELECT COUNT(1) FROM raw_movies;
SELECT COUNT(1) FROM raw_ratings;
SELECT COUNT(1) FROM raw_tags;
SELECT COUNT(1) FROM raw_genome_scores;
SELECT COUNT(1) FROM raw_genome_tags;
SELECT COUNT(1) FROM raw_links;