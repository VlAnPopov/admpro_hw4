# ДЗ 4 Работа с LVM

Задачи:
* уменьшить том под / до 8G
* выделить том под /home
* выделить том под /var (/var - сделать в mirror)
* для /home - сделать том для снэпшотов
* прописать монтирование в fstab (попробовать с разными опциями и разными файловыми системами на выбор)

Вышеперечисленные задачи решаются набором скриптов, запускаемых вагрантом (lvm1-lvm3, разделение связано с необходимостью двух перезагрузок)

* Работа со снапшотами:
** сгенерировать файлы в /home/
**  снять снэпшот
**  удалить часть файлов
**  восстановиться со снэпшота
Отчётность по этой части сдаётся отдельно, скриншотами и логом. 