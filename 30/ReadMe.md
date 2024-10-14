Домашнее задание: Сценарии iptables

задание:

реализовать knocking port
centralRouter может попасть на ssh inetrRouter через knock скрипт
пример в материалах.
добавить inetRouter2, который виден(маршрутизируется (host-only тип сети для виртуалки)) с хоста или форвардится порт через локалхост.
запустить nginx на centralServer.
пробросить 80й порт на inetRouter2 8080.

Запускаем vagrant up и наслаждаемся

Подключаемся по ssh к inetRouter 

![1](img/1.jpg)  

Подключаемся по ssh к inetRouter c centralServer

![2](img/2.jpg)

Запускаем скрипт, который меняет настройки iptables и knock

![3](img/3.jpg)

ssh отваливается

Доступ закрыт, стучим и подключаемся

![4](img/4.jpg)

Порт для nginx проброшет плейбуком, проверяем

![5](img/5.jpg)