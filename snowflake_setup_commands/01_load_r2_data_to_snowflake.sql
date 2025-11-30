USE WAREHOUSE NETFLIX_DBT_WH;
USE ROLE NETFLIX_DBT_ROLE;
USE DATABASE NETFLIX_DBT_DB;
USE SCHEMA RAW;

-- ============================================
-- Step 1: Create Storage Integration for R2
-- ============================================
CREATE OR REPLACE STORAGE INTEGRATION netflix_r2_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::000000000000:role/dummy' -- DUMMY ROLE, FOR PLACEHOLDER PURPOSES
  STORAGE_ALLOWED_LOCATIONS = ('s3://netflix-dbt/ml-20m/')
  COMMENT = 'Cloudflare R2 integration';

-- ============================================
-- Step 2: Create File Format for CSV
-- ============================================
CREATE OR REPLACE FILE FORMAT csv_format
  TYPE = 'CSV'
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  NULL_IF = ('NULL', 'null', '')
  EMPTY_FIELD_AS_NULL = TRUE
  COMPRESSION = AUTO;

-- ============================================
-- Step 3: Create External Stage pointing to R2
-- ============================================
CREATE OR REPLACE STAGE netflix_r2_stage
  URL = 's3compat://netflix-dbt/ml-20m/'
  CREDENTIALS = (
    AWS_KEY_ID = 'a4cf912e6b02db22a7a0b7f28b7593d9'
    AWS_SECRET_KEY = '84869c5c79e6b5119f5ebb87e4f5828acc05acc8b6ee26832009713b5a91497b'
  )
  ENDPOINT = '4f4677cd49f9a0dd42ea333d899e6283.r2.cloudflarestorage.com'
  FILE_FORMAT = csv_format;

-- LIST FILES FROM R2 ENDPOINT 
LIST @netflix_r2_stage;

