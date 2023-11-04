FROM ubuntu:22.04

WORKDIR /workspace

RUN apt update \
    && apt install -y git

# REGION rustup

RUN apt install -y build-essential curl gcc make

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o /workspace/rustup.sh \
    && chmod +x /workspace/rustup.sh \
    && ./rustup.sh -y \
    && . "$HOME/.cargo/env" \
    && rustup install nightly-2023-05-28 \
    && cargo +nightly-2023-05-28 install --git https://github.com/facebook/buck2.git buck2 \
    && ln -s  /root/.cargo/bin/buck2 /bin/buck2

RUN apt install -y groovy

COPY bin .

# CMD "buck2 run :"