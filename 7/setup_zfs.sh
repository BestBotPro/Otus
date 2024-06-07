#!/bin/bash

# Создание ZFS пулов в режиме зеркала
zpool create otus1 mirror /dev/sdb /dev/sdc
zpool create otus2 mirror /dev/sdd /dev/sde
zpool create otus3 mirror /dev/sdf /dev/sdg
zpool create otus4 mirror /dev/sdh /dev/sdi

# Настройка алгоритмов сжатия для каждого пула
zfs set compression=lzjb otus1
zfs set compression=lz4 otus2
zfs set compression=gzip-9 otus3
zfs set compression=zle otus4

# Вывод информации о созданных пулах и их сжатии
echo "ZFS pools and compression settings:"
zfs get compression

# Скачивание файла в каждый пул
for i in {1..4}; do
    wget -P /otus$i https://gutenberg.org/cache/epub/2600/pg2600.converter.log
done

# Вывод информации о файлах в каждом пуле
echo "Files downloaded to each pool:"
ls -lh /otus*/pg2600.converter.log

# Вывод использования дискового пространства и степени сжатия
echo "Disk usage and compression ratio:"
zfs list
zfs get compressratio -o name,value -H | grep otus

# Проверка степени сжатия файлов
echo "Checking compression ratios:"
zfs get all | grep compressratio | grep -v ref