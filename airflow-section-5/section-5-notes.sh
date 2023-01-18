Airflow

- run: run a single task instance
- list_dags: list all the dags
- dag_state: get the status of a dag run
- task_state: get the status of a task instance
- rest: test a task instance without checking for dependencies or recording its state in the db

# How to add another worker with Celery

docker run --network airflow-section-5_default --expose 8793 -v /Users/jemendoza/Desktop/Study/Airflow/airflow-materials/airflow-section-5/mnt/airflow/dags:/usr/local/airflow/dags -v /Users/jemendoza/Desktop/Study/Airflow/airflow-materials/airflow-section-5/mnt/airflow/airflow.cfg:/usr/local/airflow/airflow.cfg -dt --rm --name airflow-worker python:3.7

docker exec -it airflow-worker /bin/bash

export AIRFLOW_HOME=/usr/local/airflow
useradd -ms /bin/bash -d $AIRFLOW_HOME airflow
chown -R airflow: $AIRFLOW_HOME

pip install "apache-airflow[celery, crypto, postgres, redis]==1.10.12" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-1.10.12/constraints-3.7.txt"

## Start the Worker
su - airflow
export AIRFLOW_HOME=/usr/local/airflow
airflow initdb
airflow worker


## The airflow.cfg changes
executor = CeleryExecutor
sql_alchemy_conn = postgresql+psycopg2://airflow:airflow@postgres:5432/airflow
broker_url = redis://:redispass@redis:6379/1
result_backend = db+postgresql://airflow:airflow@postgres:5432/airflow

# Scale workers from docker-compose
docker-compose -f docker-compose-CeleryExecutor.yml up --scale worker=3
