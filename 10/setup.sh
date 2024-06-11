#!/bin/bash

# Обновление и установка Nginx
apt-get update
apt-get install -y nginx spawn-fcgi php php-cgi php-cli apache2 libapache2-mod-fcgid

systemctl enable nginx

# Копирование и активация custom nginx@.service
cp /home/vagrant/nginx@.service /etc/systemd/system/nginx@.service
systemctl daemon-reload

cp /home/vagrant/watchlog.sh /opt/watchlog.sh
chmod +x /opt/watchlog.sh
cp /home/vagrant/spawn-fcgi.service /etc/systemd/system/spawn-fcgi.service
cp /home/vagrant/watchlog /etc/default/watchlog
cp /home/vagrant/watchlog.service /etc/systemd/system/watchlog.service
cp /home/vagrant/watchlog.timer /etc/systemd/system/watchlog.timer
mkdir /etc/spawn-fcgi/
cp /home/vagrant/fcgi.conf /etc/spawn-fcgi/fcgi.conf

systemctl start watchlog.timer
systemctl start spawn-fcgi

# Перемещение конфигурационных файлов Nginx
cp /home/vagrant/nginx-first.conf /etc/nginx/nginx-first.conf
cp /home/vagrant/nginx-second.conf /etc/nginx/nginx-second.conf

# Перезапуск и проверка статуса экземпляров nginx
systemctl start nginx@first
systemctl start nginx@second
systemctl status nginx@first
systemctl status nginx@second


