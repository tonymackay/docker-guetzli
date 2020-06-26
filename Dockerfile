FROM alpine:3.12.0 AS build

ARG VERSION=v1.0.1

WORKDIR /build

RUN apk add --no-cache build-base git libpng-dev \
    && git clone https://github.com/google/guetzli.git . && git checkout ${VERSION}

RUN make config=release

FROM scratch
COPY --from=build /build/bin/Release/guetzli /usr/local/bin/guetzli
COPY --from=build /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=build /lib/libz.so.1 /lib/libz.so.1
COPY --from=build /usr/lib/libpng16.so.16 /usr/lib/libpng16.so.16
COPY --from=build /usr/lib/libstdc++.so.6 /usr/lib/libstdc++.so.6
COPY --from=build /usr/lib/libgcc_s.so.1 /usr/lib/libgcc_s.so.1

WORKDIR /data
ENTRYPOINT ["/usr/local/bin/guetzli"]
CMD []
