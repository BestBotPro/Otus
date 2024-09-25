#!/bin/bash

clk_tck=$(getconf CLK_TCK)  # Получаем количество тактов в секунду

(echo "PID|TTY|STAT|TIME|COMMAND"  # Формируем заголовок

for dir in /proc/[0-9]*; do  # Перебираем каталоги процессов
    if [ -d "$dir" ]; then
        pid=$(basename $dir)  # Получаем PID

        # Читаем команду процесса
        if [ -f "$dir/cmdline" ]; then
            cmd=$(tr -d '\0' < $dir/cmdline | awk '{print $1}' | tr -d ' ')
            if [ -n "$cmd" ]; then
                cmd=$(basename -- "$cmd" 2>/dev/null) 
                if [ -z "$cmd" ]; then
                    cmd="-"
                fi
            else
                cmd="-"
            fi
        else
            cmd="-"
        fi

        # Читаем статус процесса
        stat=$(<"$dir/stat")
        state=$(echo "$stat" | awk '{print $3}')
        tty_nr=$(echo "$stat" | awk '{print $7}')
        tty="?"  # По умолчанию неизвестный tty
        if [ "$tty_nr" -ne 0 ]; then
            tty_file="/proc/$pid/fd/0"
            if [ -e "$tty_file" ]; then
                tty=$(ls -l $tty_file | awk '{print $11}' | awk -F '/' '{print $3}')
            fi
        fi

        utime=$(echo "$stat" | awk '{print $14}')  # Пользовательское время
        stime=$(echo "$stat" | awk '{print $15}')  # Системное время
        ttime=$((utime + stime))
        time=$((ttime / clk_tck))

        echo "${pid}|${tty}|${state}|${time}|${cmd}"  # Выводим строку информации о процессе
    fi
done ) | column -t -s "|"

