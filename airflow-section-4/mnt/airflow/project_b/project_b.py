from airflow import DAG
from airflow.operators.bash_operator import BashOperator
# Commenting the previous line generates an error that cannot be seen from the UI (since this DAG was added by a DagBag).
# The error can be seen from the docker logs, though.

from datetime import datetime, timedelta

default_args = {
    'start_date': datetime(2019, 1, 1),
    'owner': 'Airflow',
    'email': 'owner@test.com',
    'retries': 3,
    'retry_delay': timedelta(seconds=60),
}

with DAG(dag_id='project_b', schedule_interval="0 0 * * *", default_args=default_args, catchup=False) as dag:
    
    # Task 1
    bash_task_1 = BashOperator(task_id='bash_task_1', bash_command="echo 'first task'")
    
    # Task 2
    bash_task_2 = BashOperator(task_id='bash_task_2', bash_command="echo 'second task'")

    bash_task_1 >> bash_task_2