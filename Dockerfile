FROM python:3.7.7-slim-buster

RUN apt-get update && \
    apt-get install -y curl unzip git && \
    apt-get clean && \
    apt-get autoclean

# Install AWS CLI v2
RUN curl -L "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN  unzip awscliv2.zip && \
    ./aws/install

# Install workaround for updating credentials file
RUN git clone https://github.com/destornillador/aws-sso-cred-restore
RUN pip3 install ./aws-sso-cred-restore 

COPY update_credentials.sh /usr/local/bin/
