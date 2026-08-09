FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV COMPOSER_ALLOW_SUPERUSER=1

RUN apt-get update && apt-get install -y  \
    supervisor \
    software-properties-common \
    curl \
    git \
    unzip \
    7zip \
    bash-completion \
    sudo \
    vim && \
    LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php && \
    apt-get install -y php8.4-fpm \
        php8.4-zip \
        php8.4-mbstring \
        php8.4-curl \
        php8.4-xml \
        php8.4-mysql \
        php8.4-xdebug && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 user && \
useradd -m -u 1000 -g 1000 -s /bin/bash user && \
echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir -p /var/log/supervisor && \
mkdir -p /run/php && \
mkdir -p /var/www

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN sed -i '/if \[ -f \/etc\/bash_completion \] && ! shopt -oq posix; then/,/fi/s/^#//g' /home/user/.bashrc
RUN echo "eval \"\$(/usr/local/bin/composer completion bash)\"" >> /home/user/.bashrc
RUN echo "eval \"\$(/home/user/.config/composer/vendor/bin/laravel completion bash)\"" >> /home/user/.bashrc
RUN echo "PATH=\"\$PATH:\$HOME/.config/composer/vendor/bin\"" >> /home/user/.bashrc

USER user

RUN composer global require laravel/installer

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

ENV NVM_DIR /home/user/.nvm

RUN . ~/.nvm/nvm.sh && \
    nvm install 20 && \
    nvm use 20 && \
    nvm alias default 20

COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY config/fpm.conf /etc/php/8.4/fpm/php-fpm.conf
COPY config/fpm-pool.conf /etc/php/8.4/fpm/pool.d/www.conf
COPY config/xdebug.ini /etc/php/8.4/fpm/conf.d/20-xdebug.ini

EXPOSE 9000/tcp

WORKDIR /var/www/site

USER root

CMD ["/usr/bin/supervisord"]