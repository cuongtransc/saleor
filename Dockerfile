# FROM python:3.5
# ENV PYTHONUNBUFFERED 1

FROM bitnami/minideb:jessie
LABEL maintainer="cuongtransc@gmail.com"

ENV REFRESHED_AT 2017-10-10

RUN apt-get update -qq

# Using apt-cacher-ng proxy for caching deb package
# RUN echo 'Acquire::http::Proxy "http://172.17.0.1:3142/";' > /etc/apt/apt.conf.d/01proxy

#RUN \
  #apt-get -y update && \
  #apt-get install -y gettext && \
  #apt-get clean

RUN apt-get install -y python3-pip gettext

COPY requirements.txt /app/
RUN pip install -r /app/requirements.txt

COPY requirements.dev.txt /app/
RUN pip install -r /app/requirements.dev.txt

COPY . /app
WORKDIR /app

EXPOSE 8000
# ENV PORT 8000

STOPSIGNAL SIGINT

CMD ["uwsgi", "/app/saleor/wsgi/uwsgi.ini"]
