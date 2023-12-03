FROM python:3.9-alpine3.13
LABEL maintainer="balyaelfata@yahoo.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app

WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /venv && \
    /py/bin/pip install  --upgrade pip && \
    apk add  --update --no-cache postgresql-client jpeg-dev && \
    apk add  --update --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r 