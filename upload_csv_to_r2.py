import os
import sys
import boto3
from pathlib import Path
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# R2 Configuration from environment variables
BUCKET_NAME = os.getenv("R2_BUCKET_NAME")
ACCESS_KEY_ID = os.getenv("R2_ACCESS_KEY_ID")
SECRET_ACCESS_KEY = os.getenv("R2_SECRET_ACCESS_KEY")
ACCOUNT_ID = os.getenv("R2_ACCOUNT_ID")

def upload_csvs_to_r2(local_dir):
    """Upload CSV files from local directory to Cloudflare R2"""
    
    # Validate environment variables
    if not all([BUCKET_NAME, ACCESS_KEY_ID, SECRET_ACCESS_KEY, ACCOUNT_ID]):
        print("Error: Missing required environment variables")
        print("Please set: R2_BUCKET_NAME, R2_ACCESS_KEY_ID, R2_SECRET_ACCESS_KEY, R2_ACCOUNT_ID")
        sys.exit(1)
    
    # Configure R2 client
    s3_client = boto3.client(
        's3',
        endpoint_url=f'https://{ACCOUNT_ID}.r2.cloudflarestorage.com',
        aws_access_key_id=ACCESS_KEY_ID,
        aws_secret_access_key=SECRET_ACCESS_KEY,
        region_name='auto'
    )
    
    # Get directory name for R2 path
    dir_name = os.path.basename(os.path.normpath(local_dir))
    
    # Upload CSV files
    local_path = Path(local_dir)
    csv_files = list(local_path.glob('*.csv'))
    
    if not csv_files:
        print(f"No CSV files found in {local_dir}")
        return
    
    print(f"Found {len(csv_files)} CSV files")
    
    for csv_file in csv_files:
        r2_key = f"{dir_name}/{csv_file.name}"
        print(f"Uploading {csv_file.name} to {r2_key}...")
        
        s3_client.upload_file(
            str(csv_file),
            BUCKET_NAME,
            r2_key
        )
        print(f"✓ Uploaded {csv_file.name}")
    
    print(f"\nCompleted: {len(csv_files)} files uploaded to {BUCKET_NAME}/{dir_name}/")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python upload_csv_to_r2.py <local_dir>")
        sys.exit(1)
    
    local_dir = sys.argv[1]
    
    if not os.path.isdir(local_dir):
        print(f"Error: {local_dir} is not a valid directory")
        sys.exit(1)
    
    upload_csvs_to_r2(local_dir)
