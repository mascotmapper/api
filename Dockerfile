FROM python:3.6-alpine as base

WORKDIR /app

COPY app.py wsgi.py data.json /app/
COPY ./docker-requirements.txt /app/requirements.txt

RUN pip install -r /app/requirements.txt

EXPOSE 5000
CMD ["python","app.py"]
