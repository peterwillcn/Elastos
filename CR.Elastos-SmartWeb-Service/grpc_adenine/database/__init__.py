import logging

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy_wrapper import SQLAlchemy
from decouple import config

# Set up logging
logging.basicConfig(
    format='%(asctime)s %(levelname)-8s %(message)s',
    level=logging.DEBUG,
    datefmt='%Y-%m-%d %H:%M:%S'
)

# Connect to the database
db_name = config('DB_NAME')
db_user = config('DB_USER')
db_password = config('DB_PASSWORD')
db_host = config('DB_HOST')
db_port = config('DB_PORT')

database_uri = f"postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}"
gce = config('GCE', default=False, cast=bool)
if gce:
    database_uri = f"postgresql+psycopg2://{db_user}:{db_password}@localhost:5432/"

try:
    db_engine = create_engine(database_uri)
    session_maker = sessionmaker(bind=db_engine)
    connection = SQLAlchemy(database_uri)
except Exception as e:
    logging.debug(f"Error while connecting to the database: {e}")

