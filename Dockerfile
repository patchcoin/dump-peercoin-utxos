FROM alpine:3.21.3 AS build
COPY 0001-enforce-stopatheight-option.patch /
RUN apk add --no-cache git build-base libtool autoconf automake pkgconfig boost-dev openssl-dev sqlite-dev libevent-dev && \
    git clone https://github.com/peercoin/peercoin.git && \
    cd peercoin && \
    git checkout 86d3bc90546ceb7584dcff4a03c8cc22c98877a6 && \
    git apply /0001-enforce-stopatheight-option.patch && \
    ./autogen.sh && \
    ./configure --disable-tests --disable-bench --disable-fuzz-binary --without-bdb && \
    make -j$(nproc)

FROM alpine:3.21.3

ARG UID=1000
ARG GID=1000

RUN addgroup -g $GID peercoin && adduser -D -u $UID -G peercoin peercoin

RUN apk add --no-cache boost-libs libevent openssl sqlite
COPY --from=build /peercoin/src/peercoind /usr/local/bin/peercoind
COPY --from=build /peercoin/src/peercoin-cli /usr/local/bin/peercoin-cli

USER peercoin
WORKDIR /home/peercoin
