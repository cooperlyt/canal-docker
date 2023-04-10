FROM ibm-semeru-runtimes:open-8-jdk

ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive

ADD download_node_exporter.sh /tmp/

RUN apt-get -y update && apt-get -y upgrade \
    && apt-get -y install --no-install-recommends \
    tzdata \
    man \
    dstat \
    unzip \
    netcat \
    tar \
    # which \
    wget \
    perl \
    file \
    && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/*  \
    && mkdir -p /usr/local/app \
    && mkdir -p /opt/config \
    && groupadd -r admin && useradd -g admin admin \
    && chmod +x /tmp/download_node_exporter.sh \
    && sh /tmp/download_node_exporter.sh 


COPY image/ /tmp/docker/

RUN mkdir -p /home/admin/canal-server

COPY ./canal.deployer-1.1.6/ /home/admin/canal-server/

RUN \
    cp -R /tmp/docker/alidata /alidata && \
    chmod +x /alidata/bin/* && \
    mkdir -p /home/admin && \
    cp -R /tmp/docker/app.sh /home/admin/  && \
    cp -R /tmp/docker/admin/* /home/admin/  && \
    /bin/cp -f alidata/bin/lark-wait /usr/bin/lark-wait && \
    mkdir /home/admin/node_exporter &&\ 
    tar zxvf /tmp/node_exporter.tar.gz -C /home/admin/node_exporter --strip-components 1 && \
    mkdir -p home/admin/canal-server/logs  && \
    chmod +x /home/admin/*.sh  && \
    chmod +x /home/admin/bin/*.sh  && \
    chown admin: -R /home/admin

# 11110 admin , 11111 canal , 11112 metrics, 9100 exporter
EXPOSE 11110 11111 11112 9100

WORKDIR /home/admin

ENTRYPOINT [ "/alidata/bin/main.sh" ]
CMD [ "/home/admin/app.sh" ]