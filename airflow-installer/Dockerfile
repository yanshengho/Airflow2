# https://airflow.apache.org/docs/apache-airflow/stable/start/docker.html
# https://airflow.apache.org/docs/docker-stack/index.html
# https://airflow.apache.org/docs/docker-stack/build.html


# Base Image
# FROM apache/airflow:2.3.2-python3.10
FROM apache/airflow:slim-2.3.2-python3.10

USER root

ENV DEBIAN_FRONTEND noninteractive
# Add Airflow folders to Python Path
ENV PYTHONPATH "${PYTHONPATH}:/opt/airflow/plugins/Utils_Python"
ENV PYTHONPATH "${PYTHONPATH}:/opt/airflow/plugins/pipelines"

RUN sudo apt-get update
RUN sudo apt-get upgrade
RUN sudo apt-get install g++ -y

# Downloading additional pips
USER airflow
COPY requirements.txt /requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r /requirements.txt