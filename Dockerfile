FROM python:3.9-alpine3.17
LABEL maintainer="Manan Chauhan" 

ENV PYTHONUNBUFFERD=1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

# RUN echo $DEV
ARG DEV=false

RUN python -m venv /env && \
    /env/bin/pip install --upgrade pip setuptools wheel && \
    if [$DEV = true]; \
        then /env/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev && \
    /env/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    apk del .tmp-build-deps && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# RUN /env/bin/pip install -r /tmp/requirements.dev.txt


ENV PATH="/env/bin:$PATH"

USER django-user