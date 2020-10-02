FROM rust AS build

WORKDIR /root

RUN git clone https://github.com/brandur/redis-cell.git \
    && cd redis-cell \
    && cargo build --release

<<<<<<< HEAD
FROM bitnami/redis:6.0.8
=======
FROM bitnami/redis
>>>>>>> 1709d5072d459f1bfe0dd6afa97fd98e0f16b3c3

COPY --from=build /root/redis-cell/target/release/libredis_cell.so /opt/bitnami/redis/

RUN stat /opt/bitnami/redis/libredis_cell.so