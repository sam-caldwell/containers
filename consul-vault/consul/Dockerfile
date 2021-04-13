FROM ubuntu:groovy-20210325

ENV CONSUL_VERSION 1.4.4
ENV UI_VERSION 1.4.4

RUN apt-get update -y --fix-missing && \
    apt-get upgrade -y && \
    apt-get install ca-certificates curl unzip -y && \
    apt-get autoclean && \
    apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN bash -c 'mkdir -p /consul/{data,conf.d,ui}'

RUN curl -Lo /consul/${CONSUL_VERSION}_linux_amd64.zip https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip \
    && unzip /consul/${CONSUL_VERSION}_linux_amd64.zip -d /consul  && \
    rm -rf /consul/${CONSUL_VERSION}_linux_amd64.zip && \
    chmod +x /consul/consul && \
    echo "done"
    
EXPOSE 8300 8400 8500 8600

ENTRYPOINT ["/consul/consul"]
