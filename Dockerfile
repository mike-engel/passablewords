FROM swiftdocker/swift
MAINTAINER mike@mike-engel.com

LABEL name="passablewords"
LABEL description="Is your password unique enough? Check against the million most common passwords"
LABEL version="1.0"

ENV APP_DIR=/usr/src/passablewords

WORKDIR ${APP_DIR}

RUN apt-get update \
  && apt-get install -y libssl-dev uuid-dev

COPY . ${APP_DIR}/

RUN swift build --clean \
  && swift build -c release

EXPOSE 3000

CMD [".build/release/passablewords"]
