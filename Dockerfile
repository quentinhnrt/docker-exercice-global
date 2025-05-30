FROM prestashop/prestashop:latest

RUN wget https://github.com/PrestaShop/classic-theme/releases/download/3.0.2/classic-theme.zip \
    && unzip classic-theme.zip -d /var/www/html/themes/ \
    && rm classic-theme.zip
