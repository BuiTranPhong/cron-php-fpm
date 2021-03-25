FROM php:7.4-fpm
ENV APP_URL="hello ^^"
RUN apt-get update && apt-get -y install cron
#RUN docker-php-ext-install pdo pdo_mysql
# Grep all env variable and COPY to crontab file
RUN printenv | sed 's/^\(.*\)$/\1/g' > /etc/cron.d/crontab
RUN touch /var/log/cron.log
#COPY script.sh /etc
#RUN chmod +x /etc/script.sh
RUN cronfile >> /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab
RUN crontab /etc/cron.d/crontab
CMD cron && docker-php-entrypoint php-fpm
# FROM php:7.4-fpm-alpine
# RUN docker-php-ext-install pdo pdo_mysql
# COPY crontab /etc/crontabs/root
# CMD ["crond", "-f"]