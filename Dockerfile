FROM ubuntu:16.04
LABEL maintainer "Lincoln Bryant - lincolnb@uchicago.edu"
LABEL maintainer "Shuanglei Tao - tsl0922@gmail.com"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      ca-certificates \
      cmake \
      curl \
      g++ \
      git \
      libjson-c2 \
      libjson-c-dev \
      libssl1.0.0 \
      libssl-dev \
      libwebsockets7 \
      libwebsockets-dev \
      pkg-config \
      vim-common \
      vim \
      emacs-nox \
      nano \
    && git clone --depth=1 https://github.com/tsl0922/ttyd.git /tmp/ttyd \
    && cd /tmp/ttyd && mkdir build && cd build \
    && cmake -DCMAKE_BUILD_TYPE=RELEASE .. \
    && make \
    && make install \
    && apt-get remove -y --purge \
        cmake \
        g++ \
        libwebsockets-dev \
        libjson-c-dev \
        libssl-dev \
        pkg-config \
    && apt-get purge -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/ttyd

# SLATE customizations for demo
RUN curl -O http://jenkins.slateci.io/artifacts/slate-linux.tar.gz && \
    tar -xvzf slate-linux.tar.gz && \
    mv slate /usr/local/bin 

# delete old /etc/bash.bashrc and replace with SLATE variant
RUN rm -f /etc/bash.bashrc

COPY bash.bashrc /etc/bash.bashrc

RUN groupadd -g 999 slate && \
    useradd -r -u 999 -g slate slate && \
    mkdir /home/slate && \
    chown slate:slate /home/slate

EXPOSE 7681

USER slate

ENTRYPOINT ["ttyd"]

CMD ["bash"]
