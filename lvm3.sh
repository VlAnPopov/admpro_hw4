lvremove -f /dev/vg_root/lv_root
vgremove -f /dev/vg_root
pvremove -f /dev/sdb
# lvcreate -L 100MB -s -n home_snap /dev/VolGroup00/LogVol_Home