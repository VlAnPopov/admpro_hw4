#!/bin/bash
# создаем группу файлов
cd /
touch /home/file{1..20}
# для наглядности лога
ls /home
# снимаем снепшот
lvcreate -L 100MB -s -n home_snap /dev/VolGroup00/LogVol_Home
# сносим часть файлов
rm -f /home/file{11..20}
# для наглядности лога
ls /home
# восстанавливаемся
umount -l /home
lvconvert --merge /dev/VolGroup00/home_snap
mount /home
# для наглядности лога
ls /home