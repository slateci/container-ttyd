FROM tsl0922/musl-cross
RUN git clone --depth=1 https://github.com/slateci/slate-ttyd.git /ttyd \
    && cd /ttyd && ./scripts/cross-build.sh x86_64

FROM ubuntu:18.04
LABEL maintainer "Lincoln Bryant - lincolnb@uchicago.edu"

COPY --from=0 /ttyd/build/ttyd /usr/local/bin/ttyd

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      git \
      libjson-c3 \
      libssl1.0.0 \
      vim-common \
      vim \
      emacs-nox \
      nano \
    && chmod 6755 /usr/local/bin/ttyd \
    && apt-get purge -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* 

# SLATE customizations for demo
RUN curl -O https://jenkins.slateci.io/artifacts/client/slate-linux.tar.gz && \
    tar -xvzf slate-linux.tar.gz && \
    mv slate /usr/local/bin 

# delete old /etc/bash.bashrc and replace with SLATE variant
RUN rm -f /etc/bash.bashrc

COPY bash.bashrc /etc/bash.bashrc

RUN groupadd -g 999 slate && \
    useradd -r -u 999 -g slate slate && \
    mkdir /home/slate && \
    chown slate:slate /home/slate

RUN rm -f /usr/bin/systemd-* /usr/bin/passwd /usr/bin/perl* /usr/bin/whereis /usr/bin/which /usr/bin/wall /usr/bin/vmstat /usr/bin/timedatectl /usr/bin/taskset /bin/system* /bin/*ctl /bin/uname /bin/dmesg /usr/bin/apt-* /usr/bin/apt /usr/bin/dpkg /usr/bin/dpkg-* /usr/bin/slabtop
          
EXPOSE 7681

USER slate

ENTRYPOINT ["ttyd"]

CMD ["bash"]

