#!/bin/bash
# Первая часть скрипта, реализующего сокращение тома
mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh
yum -y update
yum install -y mdadm smartmontools hdparm gdisk xfsdump lsof
#готовим временный том
pvcreate /dev/sdb
vgcreate vg_root /dev/sdb
lvcreate -n lv_root -l +100%FREE /dev/vg_root
mkfs.xfs /dev/vg_root/lv_root
mount /dev/vg_root/lv_root /mnt

#копируем всё
xfsdump -J - /dev/VolGroup00/LogVol00 | xfsrestore -J - /mnt

#делаем chroot
for i in /proc/ /sys/ /dev/ /run/ /boot/; do mount --bind $i /mnt/$i; done

chroot /mnt /bin/bash << "EOT"
grub2-mkconfig -o /boot/grub2/grub.cfg
cd /boot
for i in `ls initramfs-*img`; do dracut -v $i `echo $i|sed "s/initramfs-//g; s/.img//g"` --force; done
sed -i 's/VolGroup00\/LogVol00/vg_root\/lv_root/g' /boot/grub2/grub.cfg
EOT