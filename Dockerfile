FROM centos
MAINTAINER Romain Philibert <Filirom1@gmail.com>

ENV NODE_VERSION 4.2.3

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.gz" \
  && yum install -y git make gcc gcc-c++

ADD . /app

WORKDIR /app
RUN npm i

ENTRYPOINT ["node", "/app/cluster.js"]
CMD ["http://proxyconf.localnet/wpad.dat"]
EXPOSE 3128 12345
