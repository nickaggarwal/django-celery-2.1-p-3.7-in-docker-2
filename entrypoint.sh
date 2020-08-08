#!/usr/bin/env bash

# Start redis-server
redis-server --daemonize yes  --protected-mode no

# Start mysql
mysqld_safe --skip-grant-tables &
sleep 2
mysql -e "FLUSH PRIVILEGES"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'admin'"
service mysql start
sleep 2
mysql -u root --password=admin -e "create database db"

# Start celery worker
celery -A cjapp worker -c 4 -l info &

# Start server
python manage.py migrate
python manage.py runserver 0.0.0.0:8080
