FROM alpine:3.17.0 AS ioq3_builder
RUN \
  apk --no-cache add git curl g++ gcc make sdl2-dev && \
  git clone https://github.com/ioquake/ioq3 /ioq3 && \
  cd /ioq3 && \
  make && \
  make copyfiles

FROM alpine:3.17.0
ENV Q3SVR_HOME /usr/local/games/quake3
ENV Q3SVR_USER ioq3svr
RUN apk update && \
  apk add shadow && \
  mkdir -p ${Q3SVR_HOME} && \
  adduser ${Q3SVR_USER} -D -h ${Q3SVR_HOME}

COPY --chown=${Q3SVR_USER} --from=ioq3_builder ${Q3SVR_HOME} ${Q3SVR_HOME}
ADD --chown=${Q3SVR_USER} files/ ${Q3SVR_HOME}/

EXPOSE 27960/udp 8080/tcp
CMD /bin/sh ${Q3SVR_HOME}/start.sh
