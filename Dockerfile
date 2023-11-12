FROM ubuntu

RUN apt-get update
RUN apt-get install -y python-is-python3
RUN apt-get install -y python3-pip
RUN pip install flask

COPY app.py /opt/app1.py

ENTRYPOINT FLASK_APP=app.py flask run --host=0.0.0.0
