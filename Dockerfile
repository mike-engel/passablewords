FROM swiftdocker/swift
MAINTAINER mike@mike-engel.com

LABEL name="sec-check"
LABEL description="Check your user's passwords against the 1,000,000 most common passwords"
LABEL version="1.0"

ENV APP_DIR=/usr/src/sec-check

WORKDIR ${APP_DIR}

RUN apt-get update && \
    apt-get install -y libssl-dev uuid-dev

COPY Sources common-passwords.txt index.html Package.swift ${APP_DIR}/

RUN swift build --clean
RUN swift build -Xswiftc -O -c release

EXPOSE 3000

CMD [".build/release/sec-check"]
