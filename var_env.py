from dotenv import load_dotenv
import os

load_dotenv() # Load environment variables from .env file

SNOWFLAKE_USER=os.getenv('SNOWFLAKE_USER')
SNOWFLAKE_ROLE=os.getenv('SNOWFLAKE_ROLE')
EMAIL=os.getenv('EMAIL')
FIRST_NAME=os.getenv('FIRST_NAME')
LAST_NAME=os.getenv('LAST_NAME')
SNOWFLAKE_PASSWORD=os.getenv('SNOWFLAKE_PASSWORD')
DAYS_TO_ESPIRY=os.getenv('DAYS_TO_ESPIRY')