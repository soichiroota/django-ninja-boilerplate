FROM python:3.9-buster
ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y build-essential graphviz-dev graphviz

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/app

ARG POETRY_VERSION="1.6.1"
ENV POETRY_VIRTUALENVS_CREATE=false \
  POETRY_VIRTUALENVS_IN_PROJECT=false \
  POETRY_NO_INTERACTION=1 \
  POETRY_VERSION=${POETRY_VERSION}

COPY poetry.lock pyproject.toml ./
RUN pip3 install poetry && poetry install --no-dev

COPY . /opt/app