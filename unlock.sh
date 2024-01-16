#!/usr/bin/env bash

mount -o rw,remount / 
chown -R root:500 /usr/www/
chown -R root:500 /opt/nvram/

sed -i 's/MTN/BUL/' /usr/www/private/GP/*.asp

[ ! -f /opt/nvram/nvram.cfg.bk ] && cp -a /opt/nvram/nvram.cfg /opt/nvram/nvram.cfg.bk

cat > /opt/nvram/nvram.cfg <<EOF
router_name=TF-i60 G1
router_style=GP
http_username=admin
http_passwd=admin
webManageTimeout=10
lan_ipaddr=192.168.1.1
lan_management_ipaddr=192.168.1.1
dhcp_start=10
dhcp_end=100
dhcp_num=91
dhcp_lease=720
mtu_enable=1
wan_mtu=1500
ip_proto=0
sqns_simLimit_enable=0
upnp_enable=1
https_wan_enable=0
deviceManageSecurity=1
block_wan=1
time_zone=+03.5 1 6
ntp_sec_server=asia.pool.ntp.org
wlan_countrycode=IR
wlan_channelwidth=HT20
wlan_wpacipher=3
wlan_wps_onoff=0
sqns_connection_fastScan=1
sqns_connection_pwrScan=1
ntp_server=pool.ntp.org
sqns_network_mode=TDD/FDD
EOF

cd /usr/www/private/GP/pub/images/

if [ ! -d backup ]
then
  mkdir -p backup
  cp -afv iran_* ./backup/
fi

chown -R 500:500 /usr/www/
chown -R 500:500 /opt/nvram/

nvram_set 0 sshd_enable 0
nvram_set 0 telnetd_enable 0
nvram commit 0

sleep 3

reboot
