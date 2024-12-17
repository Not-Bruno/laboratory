FROM php:8.2-apache

ENV WEBROOT=/var/www/html \
    INDEXFILE=index.html \
    STYLEFILE=style.css \
    SCRIPTFILE=script.js \
    IMAGESFOLDER=./images/

COPY ./content/* ${WEBROOT}
COPY ./content/images/* ${WEBROOT}/images/

WORKDIR ${WEBROOT}

RUN chown -R www-data:www-data $WEBROOT && chmod -R 755 $WEBROOT

EXPOSE 80

CMD [ "apache2-foreground" ]
