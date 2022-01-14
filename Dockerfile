FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update \
    && apt -y install apache2 unzip bzip2 git \
    && apt -y install php7.4 php7.4-gd php7.4-soap php7.4-bcmath php7.4-zip php7.4-intl php7.4-xml php7.4-xmlrpc php7.4-curl php7.4-fpm php7.4-mysql php7.4-opcache libapache2-mod-fcgid php7.4-cgi phpunit phpcpd \
    && rm -rf /var/lib/apt/lists/*
RUN adduser apache
COPY apache2.conf /etc/apache2/apache2.conf
RUN a2enmod mpm_event \
    && a2enmod proxy_fcgi setenvif \
    && a2enmod headers \
    && a2enmod proxy \
    && a2enmod proxy_ajp \
    && a2enmod proxy_connect \
    && a2enmod proxy_express \
    && a2enmod proxy_fcgi \
    && a2enmod proxy_ftp \
    && a2enmod proxy_html \
    && a2enmod proxy_http \
    && a2enmod proxy_scgi \
    && a2enmod proxy_wstunnel \
    && a2enmod rewrite \
    && a2enconf php7.4-fpm


EXPOSE 80

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

RUN apt update \
    && apt -y install sudo \
    && rm -rf /var/lib/apt/lists/*

RUN adduser support

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY site.conf /etc/apache2/sites-available/000-default.conf

COPY ports.conf /etc/apache2/ports.conf
ENTRYPOINT ["/docker-entrypoint.sh"]