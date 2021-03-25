FROM php:7.4-fpm
ENV APP_URL="hello ^^"
RUN apt-get update && apt-get -y install cron
#RUN docker-php-ext-install pdo pdo_mysql
RUN printenv | sed 's/^\(.*\)$/export \1/g' > /root/project_env.sh
RUN touch /var/log/cron.log
COPY script.sh /etc
RUN chmod +x /etc/script.sh
COPY crontab /etc/crontabs/root
RUN chmod 0644 /etc/crontabs/root
RUN crontab /etc/crontabs/root
CMD cron && docker-php-entrypoint php-fpm
# FROM php:7.4-fpm-alpine
# RUN docker-php-ext-install pdo pdo_mysql
# COPY crontab /etc/crontabs/root
# CMD ["crond", "-f"]