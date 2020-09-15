FROM rust AS build

WORKDIR /root

RUN git clone https://github.com/brandur/redis-cell.git \
    && cd redis-cell \
    && cargo build --release

FROM bitnami/redis

COPY --from=build /root/redis-cell/target/release/libredis_cell.so /opt/bitnami/redis/

RUN stat /opt/bitnami/redis/libredis_cell.so \
    && echo 'loadmodule /opt/bitnami/redis/libredis_cell.so' >> /opt/bitnami/redis/etc/redis.conf
