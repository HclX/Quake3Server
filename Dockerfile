FROM alpine:3.17.0 AS ioq3_builder
RUN \
  apk --no-cache add git curl g++ gcc make sdl2-dev && \
  git clone https://github.com/ioquake/ioq3 /ioq3 && \
  cd /ioq3 && \
  make && \
  make copyfiles

FROM golang:alpine3.17 as gotty_builder
RUN apk update && \
    apk add --virtual build-deps make git && \
    go install github.com/sorenisanerd/gotty@v1.5.0

FROM alpine:3.17.0
ENV HOME /usr/local/games/quake3
ENV USER ioq3svr
RUN apk update && \
  apk add screen && \
  mkdir -p ${HOME} && \
  adduser ${USER} -D -h ${HOME}

USER ${USER}
WORKDIR ${HOME}
COPY --chown=${USER} --from=ioq3_builder ${HOME} ${HOME}
COPY --chown=${USER} --from=gotty_builder /go/bin/gotty ${HOME}/gotty
ADD --chown=${USER} files/ ${HOME}/

RUN cat ${HOME}/urls.txt | xargs -n 1 wget -q -P ${HOME}/baseq3/ && \
  wget -q https://files.ioquake3.org/quake3-latest-pk3s.zip && \
  unzip quake3-latest-pk3s.zip && \
  cp -r quake3-latest-pk3s/* ${HOME}/ && \
  rm -rf quake3-latest-pk3s quake3-latest-pk3s.zip

EXPOSE 27960/udp 8080/tcp
CMD /bin/sh ${HOME}/start.sh
