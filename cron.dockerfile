FROM php:7.4-fpm
RUN apt-get update && apt-get -y install cron
#RUN docker-php-ext-install pdo pdo_mysql
RUN touch /var/log/cron.log
COPY crontab /etc/crontabs/root
RUN chmod 0644 /etc/crontabs/root
RUN crontab /etc/crontabs/root
CMD cron && docker-php-entrypoint php-fpm