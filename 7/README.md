1-� ������� (����������� ��������� � ��������� �������) ����������� �������� (��. �����)
2-� ������� (����������� �������� ����) 
    1  ls
    2  wget -O archive.tar.gz --no-check-certificate 'https://drive.usercontent.google.com/download?id=1MvrcEp-WgAQe57aDEzxSRalPAwbNN1Bb&export=download'
    3  tar -xzvf archive.tar.gz
    4  zpool import -d zpoolexport/
    5  sudo zpool import -d zpoolexport/
    6  sudo zpool import -d zpoolexport/ otus
    7  zpool status
    8  sudo zpool status
    9  zpool get all otus
   10  sudo zfs get available otus
   11  zfs get readonly otus
   12  zfs get recordsize otus
   13  zfs get compression otus
   14  zfs get checksum otus
3-� ������� (������ �� ���������, ����� ��������� �� �������������)
   1  wget -O otus_task2.file --no-check-certificate https://drive.usercontent.google.com/download?id=1wgxjih8YZ-cqLqaZVa0lA3h3Y029c3oI&export=download
   2  zfs receive otus/test@today < otus_task2.file
   3  sudo zfs receive otus/test@today < otus_task2.file
   4  cat /otus/test/task1/file_mess/secret_message
������� https://otus.ru/lessons/linux-hl/
��� �� ����� ������ �� ���� OTUS, ������� ���������.
