FROM openjdk:8-jre

ENV HAWTIO_VERSION 1.5.3
ENV HAWTIO_HOME /opt/hawtio

EXPOSE 8090

RUN set -x && \
    mkdir $HAWTIO_HOME && \
    cd $HAWTIO_HOME && \
    curl -o hawtio-app.jar https://oss.sonatype.org/content/repositories/public/io/hawt/hawtio-app/$HAWTIO_VERSION/hawtio-app-$HAWTIO_VERSION.jar && \
    useradd -r -M -d $HAWTIO_HOME HAWTIO && \
    chown -R HAWTIO:HAWTIO /opt/$HAWTIO && \
    chown -h HAWTIO:HAWTIO $HAWTIO_HOME

WORKDIR $HAWTIO_HOME

ENTRYPOINT [ "java", "-Dhawtio.proxyWhitelist=*", "-jar", "hawtio-app.jar" ]

CMD ["--port", "8090"]

#https://oss.sonatype.org/content/repositories/public/io/hawt/hawtio-app/1.5.3/hawtio-app-1.5.3.jar