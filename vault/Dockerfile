FROM ubuntu:latest

WORKDIR /opt/
RUN apt-get update -y --fix-missing && \
    apt-get upgrade -y && \
    apt-get install wget unzip -y && \
    wget https://releases.hashicorp.com/vault/1.1.0/vault_1.1.0_linux_arm64.zip && \
    cd /opt/ && \
    unzip vault_1.1.0_linux_arm64.zip

COPY files/etc/vault/config.json /etc/vault/config.json
COPY files/bootstrap.sh /root/bootstrap.sh

EXPOSE 8200 8500 

RUN ["/bin/sh","/root/bootstrap.sh"]

ENTRYPOINT ["/opt/vault","server","-config=/etc/vault/config.json","--log-level=debug"]
