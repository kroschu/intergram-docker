FROM node:alpine

MAINTAINER Volodymyr Kovalenko <trebatak@hotmail.com>

RUN apk update && apk upgrade && \
    apk add --no-cache git curl

ENV HOME=/opt/intergram
ENV PORT=3000
RUN mkdir -p $HOME
WORKDIR $HOME

RUN git clone https://github.com/kroschu/intergram.git ${HOME}

RUN apk del git

RUN npm install
RUN npm run build

HEALTHCHECK CMD curl --fail http://localhost:${PORT} || exit 1

CMD npm run start
EXPOSE ${PORT}
