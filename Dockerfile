FROM debian:bullseye-slim

SHELL ["/bin/bash", "-eo", "pipefail", "-c"]

# mkdir the man/man1 directory due to Debian bug #863199
RUN apt-get update && \
    mkdir -p /usr/share/man/man1 && \
    apt-get install --yes --no-install-recommends \
      clang \
      cmake \
      curl \
      g++ \
      libc6-dev \
      make \
      openjdk-11-jdk-headless \
      sqlite3 \
      xz-utils \
      zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

ENV INFER_VERSION v1.1.0
# Download the Infer release
WORKDIR /opt
RUN curl -sL https://github.com/facebook/infer/releases/download/${INFER_VERSION}/infer-linux64-${INFER_VERSION}.tar.xz | \
    tar xvJ && \
    rm -f /infer && \
    ln -s ${PWD}/infer-linux64-$INFER_VERSION /infer

# Install infer
ENV PATH /infer/bin:${PATH}
