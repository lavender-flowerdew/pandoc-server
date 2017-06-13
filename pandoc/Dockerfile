FROM lavenderflowerdew/alpine-base

LABEL maintainer "lavender.flowerdew@gmail.com"

RUN mkdir -p /home/flower/www /home/flower/conf /home/flower/bin

COPY ./bin /home/flower/bin
COPY ./www /home/flower/www
COPY ./stack-work.tar.gz /

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk --no-cache add \
      gmp-dev \
      libffi \
    	linux-vanilla-dev \
      make \
      perl \
      perl-dev \
      perl-fcgi \
      wget && \
    /home/flower/bin/prep.sh && \
    cd /home/flower && \
    apk del linux-vanilla-dev && \
    rm -rf /usr/share/man /tmp/* /var/cache/apk/* && \
    chmod -R +x /home/flower/bin/*.pl /home/flower/www/*.pl && \
    chown -R flower:flower /home/flower/www && \
    curl -L https://cpanmin.us | perl - App::cpanminus && \
    cpanm URI::Escape LWP::UserAgent HTML::HeadParser HTML::Entities HTTP::Request::StreamingUpload File::Slurp || true && \
    mkdir -p /home/flower/logs && \
    chown flower:flower /home/flower/logs && \
    chown flower:flower /home/flower/bin/* && \
    touch /home/flower/logs/perl-fastcgi.log && \
    chown flower:flower /home/flower/logs/perl-fastcgi.log && \
    rm -rf /root/.cpanm /root/.local /root/.stack /home/flower/bin/prep.sh && \
    cd / && \
    tar -zxf stack-work.tar.gz && \
    rm /stack-work.tar.gz && \
    ln -s /usr/src/pandoc/.stack-work/install/x86_64-linux/lts-8.12/8.0.2/bin/pandoc /usr/bin/pandoc && \
    ln -s /usr/src/pandoc/.stack-work/install/x86_64-linux/lts-8.12/8.0.2/bin/pandoc-citeproc /usr/bin/pandoc-citeproc && \
    ln -s /usr/src/pandoc/.stack-work/install/x86_64-linux/lts-8.12/8.0.2/bin/pandoc /home/flower/bin/pandoc && \
    ln -s /usr/src/pandoc/.stack-work/install/x86_64-linux/lts-8.12/8.0.2/bin/pandoc-citeproc /home/flower/bin/pandoc-citeproc

EXPOSE 9000

WORKDIR /home/flower

ENTRYPOINT ["/home/flower/bin/run.sh","pfastcgi","start","tail","-f","/home/flower/logs/perl-fastcgi.log"]
