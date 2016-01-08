FROM centos:7
MAINTAINER Romain Philibert <Filirom1@gmail.com>

ENV NODE_VERSION 4.2.3

ADD ./package.json /app/
WORKDIR /app

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.gz" \
  && yum install -y git make gcc gcc-c++ \
  && npm install \
  && yum autoremove -y \
  && yum clean all -y

ADD . /app

ENTRYPOINT ["node", "/app/cluster.js"]
CMD ["http://proxyconf.localnet/wpad.dat"]
EXPOSE 3128 12345
