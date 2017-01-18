FROM swiftdocker/swift

ENV APP_DIR=/usr/src/sec-check

WORKDIR ${APP_DIR}

RUN apt-get update && \
    apt-get install -y libssl-dev uuid-dev

COPY Sources common-passwords.txt index.html Package.swift ${APP_DIR}/

RUN swift build --clean
RUN swift build -Xswiftc -O -c release

EXPOSE 3000

CMD [".build/release/sec-check"]
