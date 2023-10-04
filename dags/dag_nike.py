from airflow import DAG
from airflow.operators.python import PythonOperator
import sys

sys.path.append('./dags/scrapper')
import configs
from scrap import nike_scrapper

dag_args = configs.dag_args()

def nike_scrap_api():
    nike_scrapper()

# Define the DAG
with DAG('nike_scrap', default_args=dag_args) as dag:
    nike_scrap_api_task = PythonOperator(
        task_id='nike_scrap',
        provide_context=True,
        python_callable=nike_scrap_api
    )

nike_scrap_api_task