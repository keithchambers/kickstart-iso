install
text
reboot
skipx
lang en_US.UTF-8
firewall --service=ssh
keyboard sg-latin1
rootpw --iscrypted $1$psODmD.2$BTBTTwiKlkX7uzc3RbxDp0
authconfig --enableshadow --passalgo=sha512
timezone --utc Europe/Zurich
bootloader --location=mbr --append="nofb quiet splash=quiet"

network --device=eth0 --bootproto dhcp

zerombr
clearpart --all --initlabel
part /boot --fstype ext4 --size=512 --ondisk=sda --asprimary
part pv.00 --size=1 --grow --asprimary --ondisk=sda
volgroup system pv.00
logvol swap --vgname=system --size=2096 --name=swap --fstype=swap
logvol / --vgname=system --grow --size 2048 --maxsize=20480 --name=root --fstype=ext4
part pv.01 --size=1 --grow --size 2048 --asprimary --ondisk=sdb
volgroup data pv.01
logvol /media/data --vgname=data --grow --name=data --fstype=ext4


%packages
@core
@server-policy
yum-priorities
e4fsprogs
irqbalance
man-pages
mlocate
openssh-clients
redhat-lsb-core
vim-enhanced
wget


%post
exec < /dev/tty3 > /dev/tty3
/usr/bin/chvt 3

exit 0
