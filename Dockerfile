FROM continuumio/miniconda3
LABEL maintainer="Sanket Bhandare <sanket01bhandare@gmail.com>"

WORKDIR /mlflow/

ARG MLFLOW_VERSION=1.19.0
RUN mkdir -p /mlflow/ \
  && pip install \
    mlflow==$MLFLOW_VERSION \
    boto3

RUN mkdir -p /mlflow/store
RUN mkdir -p /mlflow/mlflow-artifacts
RUN chmod 777 -R /mlflow/

EXPOSE 5000

ENV BACKEND_URI /mlflow/store
ENV ARTIFACT_ROOT /mlflow/mlflow-artifacts
CMD mlflow server \
  --backend-store-uri ${BACKEND_URI} \
  --default-artifact-root ${ARTIFACT_ROOT} \
  --host 0.0.0.0
