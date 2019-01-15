FROM rust AS build

WORKDIR /root

RUN git clone https://github.com/brandur/redis-cell.git
RUN cd redis-cell && \
    cargo build --release

FROM redis

COPY --from=build /root/redis-cell/target/release/libredis_cell.so /root/

RUN stat /root/libredis_cell.so

ENTRYPOINT ["redis-server"]

EXPOSE 6379
CMD ["--loadmodule", "/root/libredis_cell.so"]
