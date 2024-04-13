FROM alpine:3.8 AS base_image

FROM base_image AS build

RUN apk add --no-cache curl build-base openssl openssl-dev zlib-dev linux-headers pcre-dev ffmpeg ffmpeg-dev perl
RUN mkdir openresty nginx-vod-module

ENV OPENRESTY_VERSION 1.25.3.1
ENV VOD_MODULE_VERSION 1.33

RUN curl -sL https://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz | tar -C /openresty --strip 1 -xz
RUN curl -sL https://github.com/kaltura/nginx-vod-module/archive/${VOD_MODULE_VERSION}.tar.gz | tar -C /nginx-vod-module --strip 1 -xz


WORKDIR /openresty
RUN ./configure \
  -j2 --with-pcre-jit --with-ipv6 \
	--add-module=../nginx-vod-module \
	--with-http_ssl_module \
	--with-file-aio \
	--with-threads \
	--with-cc-opt="-O3"
RUN make -j2
RUN make install

# RUN rm -rf /usr/local/openresty/html /usr/local/openresty/conf/*.default

FROM base_image
RUN apk add --no-cache ca-certificates openssl pcre zlib ffmpeg
RUN apk add --no-cache perl
COPY --from=build /usr/local/openresty /usr/local/openresty
ENTRYPOINT ["/usr/local/openresty/bin/openresty"]
CMD ["-g", "daemon off;"]
