FROM centos



MAINTAINER Telo <joaotelo.nh@hotmail.com>



EXPOSE 8001

RUN yum update -y

RUN yum groupinstall -y 'Development Tools'

RUN yum install -y git


RUN curl -sL https://rpm.nodesource.com/setup | bash
RUN yum install -y nodejs
RUN npm install -g coffee-script



COPY . /service


WORKDIR /service

RUN npm install

WORKDIR /service/server

CMD coffee index.coffee
# Run with docker run -p DESIREDPORT:8001 moharu/waferpie-sample
# OR with -d to run in background!