FROM python:3.8-alpine3.14
LABEL maintainer="voka"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY ./molp_project /molp_project
COPY ./scripts /scripts

WORKDIR /molp_project
EXPOSE 8000

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
	/py/bin/pip install --upgrade pip setuptools_rust wheel && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
        build-base postgresql-dev musl-dev  linux-headers && \
    apk add --update --no-cache python3-dev && \
    apk add --update --no-cache libressl-dev && \
    apk add --update --no-cache zlib && \
    apk add --update --no-cache cargo && \
    apk add --update libxml2-dev libxslt-dev libffi-dev gcc musl-dev libgcc curl && \
    apk add --update jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev && \
    /py/bin/pip install -r /requirements.txt && \
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home molp && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown -R molp_project:molp_project /vol && \
    chmod -R 755 /vol && \
    chmod -R +x /scripts

ENV PATH="/scripts:/py/bin:$PATH"

USER molp

CMD ["run.sh"]
