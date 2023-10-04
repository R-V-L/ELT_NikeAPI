from airflow import DAG
from airflow.operators.python import PythonOperator
from snowflake.connector import connect
import sys
from pathlib import Path

scripts_path = r"./dags/scripts/"
sys.path.append('./dags/scrapper')
sys.path.append('./solution/dags/scrapper')
sys.path.append('./solution/dags/scripts')

import configs

SCRIPTS = configs.Scripts()

# Load snowflake_args into objects
snowflake_args = configs.snowflake_args()

# Read CREATE_RAW_OBJECTS.SQL
with open(scripts_path + 'CREATE_RAW_OBJECTS.SQL') as f:
    SCRIPTS.CREATE_RAW_OBJECTS = f.read()

# Read CREATE_CLEAN_OBJECTS.SQL
with open(scripts_path + 'CREATE_CLEAN_OBJECTS.SQL') as f:
    SCRIPTS.CREATE_CLEAN_OBJECTS = f.read()

# Read CLEAN_DATA_INSERT.SQL
with open(scripts_path + 'CLEAN_DATA_INSERT.SQL') as f:
    SCRIPTS.CLEAN_DATA_INSERT = f.read()

# Read DELETE_ALL_OBJECTS.SQL
with open(scripts_path + 'DELETE_ALL_OBJECTS.SQL') as f:
    SCRIPTS.DELETE_ALL_OBJECTS = f.read()


# Get only files from folder and subfolder
def get_files_from_directory(directory):
    return sorted(list(Path(directory).rglob("*.csv")))[-1]

def execute_query(query):
    with connect(**snowflake_args) as connection:
        cursor = connection.cursor()
        cursor.execute(query)
    return cursor.fetchone()

def load_stage_data(file, table):
    with connect(**snowflake_args) as connection:
        cursor = connection.cursor()

        put_file_query = f"PUT file://{file} @~/staged;"
        cursor.execute(put_file_query)

        copy_into_query = f"COPY INTO {table} FROM '@~' FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = '|' SKIP_HEADER = 1 ESCAPE_UNENCLOSED_FIELD = None) ON_ERROR = 'CONTINUE';"
        cursor.execute(copy_into_query)
        
        remove_files_query = "REMOVE @~"
        cursor.execute(remove_files_query)

def snowflake_load():
    # Get products and sales CSV files
    products_csv = get_files_from_directory("./data/products")
    sales_csv = get_files_from_directory("./data/sales")

    # REMOVER ESTO DESPUES
    #products_csv = get_files_from_directory("./solution/data/products")
    #sales_csv = get_files_from_directory("./solution/data/sales")

    # Create tables if not exists
    execute_query(SCRIPTS.CREATE_RAW_OBJECTS)

    # Load data to snowflake
    load_stage_data(products_csv, "PRODUCTS_RAW")
    load_stage_data(sales_csv, "SALES_RAW")

def snowflake_transform():
    # Create tables if not exists
    execute_query(SCRIPTS.CREATE_CLEAN_OBJECTS)

    # Insert normalized data
    execute_query(SCRIPTS.CLEAN_DATA_INSERT) 

def snowflake_remove_all_objects():
    # Remove all objects in database
    execute_query(SCRIPTS.DELETE_ALL_OBJECTS)  

dag_args = configs.dag_args()

# Define the DAG
with DAG('snowflake_dag', default_args=dag_args) as dag:
    snowflake_load = PythonOperator(
        task_id='load',
        provide_context=True,
        python_callable=snowflake_load
    )
    snowflake_transform = PythonOperator(
        task_id='transform',
        provide_context=True,
        python_callable=snowflake_transform
    )

snowflake_load >> snowflake_transform