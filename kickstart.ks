#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use network installation
url --url="http://nas1.racinrandall.com/repo/centos/7/os/x86_64/"
# Use graphical install
graphical
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=sda
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --device=ens192 --ipv6=auto --activate
network  --hostname=pxe.racinrandall.com

# Root password
rootpw --iscrypted $6$cNl2wLm1IXmotTnK$ww1.YGxFEZQPvWmAmeWVNMWrqoWpcXyIaaXjmhUl1ZaulEmZM/66uLiuR/663uVM7UupB.nKxNt4ZBS.Luv5F.
# System services
services --enabled="chronyd"
# System timezone
timezone America/Chicago --isUtc
user --groups=wheel --homedir=/local_home/admin_local --name=admin_local --password=$6$freQpQPnR/YGSZ8h$.IX2iqdpsa2QdrS7LTH.ae6dYkyi95LTZUD/J85V/HSygwrgd2bkwAzc/ZM8hDD/W4WlCYhUTPDzvXpqs064Q1 --iscrypted --uid=3333 --gecos="Local Administrator" --gid=3333
# X Window System configuration information
xconfig  --startxonboot
# System bootloader configuration
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=sda
# Partition clearing information
clearpart --none --initlabel
# Disk partitioning information
part /boot --fstype="xfs" --ondisk=sda --size=500
part pv.144 --fstype="lvmpv" --ondisk=sda --size=50699
volgroup vg_centos --pesize=4096 pv.144
logvol /export/home/oracle  --fstype="xfs" --size=5120 --name=lv_export_home_oracle --vgname=vg_centos
logvol /  --fstype="xfs" --size=10760 --name=lv_root --vgname=vg_centos
logvol /var/log  --fstype="xfs" --size=2048 --name=lv_var_log --vgname=vg_centos
logvol /local_home  --fstype="xfs" --size=2048 --name=lv_local_home --vgname=vg_centos
logvol /tmp  --fstype="xfs" --size=5120 --name=lv_tmp --vgname=vg_centos
logvol /var  --fstype="xfs" --size=15360 --name=lv_var --vgname=vg_centos
logvol swap  --fstype="swap" --size=8192 --name=lv_swap --vgname=vg_centos
logvol /var/log/audit  --fstype="xfs" --size=2048 --name=lv_var_log_audit --vgname=vg_centos

%packages
@^graphical-server-environment
@base
@core
@desktop-debugging
@dial-up
@fonts
@gnome-desktop
@guest-agents
@guest-desktop-agents
@hardware-monitoring
@input-methods
@internet-browser
@multimedia
@print-client
@x11
chrony
kexec-tools

%end

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=50 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=50 --notstrict --nochanges --notempty
pwpolicy luks --minlen=6 --minquality=50 --notstrict --nochanges --notempty
%end


