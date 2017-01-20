FROM swiftdocker/swift
MAINTAINER mike@mike-engel.com

LABEL name="passablewords"
LABEL description="Is your password unique enough? Check against the million most common passwords"
LABEL version="1.0"

ENV APP_DIR=/usr/src/passablewords

WORKDIR ${APP_DIR}

COPY .build Sources common-passwords.txt index.html Package.swift ${APP_DIR}/

EXPOSE 3000

CMD [".build/release/passablewords"]
