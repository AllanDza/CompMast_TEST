FROM python:3

ENV PYTHONUNBUFFERED 1

WORKDIR /app

ADD . /app

COPY ./Requirements.txt /app/Requirements.txt

RUN pip install -r Requirements.txt

COPY . /app





