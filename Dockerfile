FROM continuumio/miniconda3
LABEL maintainer="Sanket Bhandare <sanket01bhandare@gmail.com>"

WORKDIR /mlflow/

ARG MLFLOW_VERSION=1.19.0
RUN mkdir -p /mlflow/ \
  && yum install -y default-libmysqlclient-dev libpq-dev build-essential \
  && pip install \
    mlflow==$MLFLOW_VERSION \
    sqlalchemy \
    boto3 \
    google-cloud-storage \
    psycopg2 \
    mysql 

RUN mkdir -p /mlflow/store
RUN mkdir -p /mlflow/mlflow-artifacts
RUN chmod 777 -R /mlflow/

EXPOSE 5000

ENV BACKEND_URI /mlflow/store
ENV ARTIFACT_ROOT /mlflow/mlflow-artifacts
CMD echo "Artifact Root is ${ARTIFACT_ROOT}" && \
  mlflow server \
  --backend-store-uri ${BACKEND_URI} \
  --default-artifact-root ${ARTIFACT_ROOT} \
  --host 0.0.0.0
