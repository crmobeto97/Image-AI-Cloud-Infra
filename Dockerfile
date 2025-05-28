FROM ubuntu:22.04

RUN mkdir terraform
WORKDIR /home/terraform

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America\Mexico_City
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y tzdata gpg gnupg2 wget lsb-release curl nano unzip

# from https://developer.hashicorp.com/terraform/install 
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt-get -y update
RUN apt-get install -y terraform

# instalar cli AWS
# RUN snap install aws-cli --classic
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
