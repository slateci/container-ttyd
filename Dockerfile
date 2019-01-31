FROM ubuntu:16.04
LABEL maintainer "Lincoln Bryant - lincolnb@uchicago.edu"

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
      pkg-config \
      vim-common \
      vim \
      emacs-nox \
      nano \
    && git clone --depth=1 https://github.com/warmcat/libwebsockets -b v3.1.0 /tmp/libwebsockets \
    && cd /tmp/libwebsockets && mkdir build && cd build \
    && cmake -DCMAKE_BUILD_TYPE=RELEASE .. \
    && make \
    && make install \
    && git clone --depth=1 https://github.com/slateci/slate-ttyd.git /tmp/ttyd \
    && cd /tmp/ttyd && rm -rf build && mkdir build && cd build \
    && cmake -DCMAKE_BUILD_TYPE=RELEASE .. \
    && make \
    && make install \
    && chmod 6755 /usr/local/bin/ttyd \
    && apt-get remove -y --purge \
        cmake \
        g++ \
        libjson-c-dev \
        libssl-dev \
        pkg-config \
    && apt-get purge -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/libwebsockets \
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

RUN rm -f /usr/bin/systemd-* /usr/bin/passwd /usr/bin/perl* /usr/bin/whereis /usr/bin/which /usr/bin/wall /usr/bin/vmstat /usr/bin/timedatectl /usr/bin/taskset /bin/system* /bin/*ctl /bin/uname /bin/dmesg /usr/bin/apt-* /usr/bin/apt /usr/bin/dpkg /usr/bin/dpkg-*
          

EXPOSE 7681

USER slate

ENTRYPOINT ["ttyd"]

CMD ["bash"]

