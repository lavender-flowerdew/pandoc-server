FROM lavenderflowerdew/alpine-perl-fastcgi

LABEL maintainer "lavender.flowerdew@gmail.com"

ADD ./www /home/flower/www

RUN chown -R flower:flower /home/flower/www && \
    chmod -R +x /home/flower/www/*.pl && \
    apk --no-cache --update add wget && \
    curl -L https://cpanmin.us | perl - App::cpanminus && \
    cpanm DateTime::Tiny

EXPOSE 9000

WORKDIR /home/flower

ENTRYPOINT ["/home/flower/bin/run.sh","pfastcgi","start","tail","-f","/dev/stdout"]
