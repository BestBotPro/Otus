Развертывание веб приложения

Задание:

1)Развернуть стенд nginx + php-fpm (wordpress) + python (django) + js(node.js)



Создаем конфигурационные файлы, получается вот такое дерево

![2](img/2.jpg)


Разворачиваем виртуальную машину:

Vagrant up

![1](img/1.jpg)


Проверка:

Откроем c нашей хост-машины веб-страницу http://192.168.56.10:8083

![3](img/3.jpg)


Откроем c нашей хост-машины веб-страницу http://192.168.56.10:8082

![4](img/4.jpg)


Откроем c нашей хост-машины веб-страницу http://192.168.56.10:8081

![5](img/5.jpg)

как мы видим - все работает
