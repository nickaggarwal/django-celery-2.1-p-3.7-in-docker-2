FROM python:3.7-slim

EXPOSE 8080

ARG workspace="none"
ARG broker="none"

RUN apt-get update \
    && apt-get install --assume-yes wget

RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/backend-project/python/pre-build.sh
RUN chmod 775 ./pre-build.sh
RUN sh pre-build.sh


RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/backend-project/database/mysql-setup.sh
RUN chmod 775 ./mysql-setup.sh
RUN sh mysql-setup.sh

RUN apt install  --assume-yes redis-server

RUN mkdir -p /var/app

WORKDIR /var/app

ADD requirements.txt /var/app

# Build the app
RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/backend-project/python/build.sh
RUN chmod 775 ./build.sh
RUN sh build.sh

ADD . .

# Run the app
RUN chmod 775 ./entrypoint.sh
CMD sh entrypoint.sh
