FROM lavenderflowerdew/alpine-nginx

MAINTAINER Lavender Flowerdew <lavender.flowerdew@gmail.com>

ENV CLUSTER_CONF ""

# Expose the ports for nginx
EXPOSE 80 443

RUN chown -R nginx:www-data /usr/html && \
    apk update && apk upgrade && \
    apk --no-cache add \
      wget && \
    rm -rf /var/cache/apk/* && \
    cd /usr/html && \
    wget https://github.com/lavender-flowerdew/pandoc-web-editor/archive/master.zip && \
    unzip master.zip && \
    mv -f ./pandoc-web-editor-master/css /usr/html/css && \
    mv -f ./pandoc-web-editor-master/js /usr/html/js && \
    mv -f ./pandoc-web-editor-master/vendor /usr/html/vendor && \
    mv -f ./pandoc-web-editor-master/post_index.json /usr/html/post_index.json && \
    mv -f ./pandoc-web-editor-master/index.html /usr/html/index.html

VOLUME ["/usr/html"]

ENTRYPOINT ["/root/run.sh"]

CMD ["start"]
