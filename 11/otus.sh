#!/bin/bash

# ���� � ����� ����
log_file="/home/pt/access-4560-644067.log"

# ������ �� ������������� ������ ���������� ����� �������
lock_file="/home/pt/otus.lock"
if [ -f "$lock_file" ]; then
    echo "������ ��� �����������."
    exit
fi
touch "$lock_file"

start_time=$(awk 'NR==1{print $4}' $log_file | cut -d'[' -f2 | cut -d':' -f1-3)
end_time=$(awk 'END{print $4}' $log_file | cut -d'[' -f2 | cut -d':' -f1-3)

# ������������ ������
echo "����� �� ������ � $start_time �� $end_time" > report.txt
echo "��� IP-�������:" >> report.txt
awk '{print $1}' "$log_file" | sort | uniq -c | sort -nr | head -n 5 >> report.txt

echo "��� ������������� URL:" >> report.txt
awk '{print $7}' "$log_file" | sort | uniq -c | sort -nr | head -n 5 >> report.txt

echo "������ ���-������� (HTTP ������� 5xx):" >> report.txt
awk '$9 ~ /^5/ {print $0}' "$log_file" >> report.txt

echo "HTTP ���� �������:" >> report.txt
awk '{print $9}' "$log_file" | sort | uniq -c | sort -nr >> report.txt

# mail -s "����� � $start_time �� $end_time" recipient@example.com < report.txt

# �������
rm "$lock_file"