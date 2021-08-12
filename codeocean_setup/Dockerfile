# hash:sha256:fb9ac6ac160cc073551116ebe7c22a21a54641cfff731029b763d4cedbcdf3c8
FROM registry.codeocean.com/codeocean/ubuntu:20.04.2

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="voka"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY ./molp_project /molp_project
COPY ./scripts /scripts

WORKDIR /molp_project
EXPOSE 8000

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3.8 python3-pip && \
    pip install --upgrade pip && \
	pip install --upgrade pip setuptools_rust wheel && \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        docker-compose \
        docker.io \
        build-essential postgresql-server-dev-12 musl-dev \
        libpq-dev=12.7-0ubuntu0.20.04.1 python3-dev && \
    pip install -r /requirements.txt && \
    adduser --disabled-password --no-create-home molp_project && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown -R molp_project:molp_project /vol && \
    chmod -R 755 /vol && \
    chmod -R +x /scripts

ENV PATH="/scripts:/py/bin:$PATH"

USER molp_project

CMD ["run.sh"]
