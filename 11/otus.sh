#!/bin/bash

# Путь к файлу лога
log_file="/home/pt/access-4560-644067.log"

# Запрет на одновременный запуск нескольких копий скрипта
lock_file="/home/pt/otus.lock"
if [ -f "$lock_file" ]; then
    echo "Скрипт уже выполняется."
    exit
fi
touch "$lock_file"

start_time=$(awk 'NR==1{print $4}' $log_file | cut -d'[' -f2 | cut -d':' -f1-3)
end_time=$(awk 'END{print $4}' $log_file | cut -d'[' -f2 | cut -d':' -f1-3)

# Формирование отчёта
echo "Отчет за период с $start_time по $end_time" > report.txt
echo "Топ IP-адресов:" >> report.txt
awk '{print $1}' "$log_file" | sort | uniq -c | sort -nr | head -n 5 >> report.txt

echo "Топ запрашиваемых URL:" >> report.txt
awk '{print $7}' "$log_file" | sort | uniq -c | sort -nr | head -n 5 >> report.txt

echo "Ошибки веб-сервера (HTTP статусы 5xx):" >> report.txt
awk '$9 ~ /^5/ {print $0}' "$log_file" >> report.txt

echo "HTTP коды ответов:" >> report.txt
awk '{print $9}' "$log_file" | sort | uniq -c | sort -nr >> report.txt

# mail -s "Отчет с $start_time по $end_time" recipient@example.com < report.txt

# Очистка
rm "$lock_file"