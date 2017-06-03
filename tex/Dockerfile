FROM lavenderflowerdew/alpine-texlive:20160523

LABEL maintainer "lavender.flowerdew@gmail.com"

RUN mkdir -p /home/flower/www /home/flower/conf /home/flower/bin

COPY ./bin /home/flower/bin
COPY ./www /home/flower/www

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk --no-cache add \
    	linux-vanilla-dev \
      make \
      perl \
      perl-fcgi \
      wget && \
    /home/flower/bin/prep.sh && \
    cd /home/flower && \
    apk del linux-vanilla-dev && \
    rm -rf /usr/share/man /tmp/* /var/cache/apk/* && \
    chmod -R +x /home/flower/bin/*.pl /home/flower/www/*.pl && \
    chown -R flower:flower /home/flower/www && \
    curl -L https://cpanmin.us | perl - App::cpanminus && \
    cpanm Config::Properties

EXPOSE 9000

WORKDIR /home/flower

ENTRYPOINT ["/home/flower/bin/run.sh","pfastcgi","start","tail","-f","/dev/stdout"]
