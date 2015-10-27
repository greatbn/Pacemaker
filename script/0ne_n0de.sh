export VIP=10.10.10.30
#on one node
drbdadm primary --force mysql
drbdadm primary --force webdata
#config cluster
#Thuc hien tren 1 node
crm configure property no-quorum-policy="ignore" stonith-enabled="false"
crm configure primitive p_IP ocf:heartbeat:IPaddr2 params ip="$VIP" cidr_netmask="24" nic="eth0" op monitor interval="30s"
crm configure primitive p_apache ocf:heartbeat:apache params configfile="/etc/apache2/apache2.conf" port="80" op monitor interval="30s" op start interval="0s" timeout="40s" op stop interval="0s" timeout="40s"
crm configure primitive p_drbd_mysql ocf:linbit:drbd params drbd_resource="mysql" op monitor interval="3s"
crm configure primitive p_drbd_data ocf:linbit:drbd params drbd_resource="webdata" op monitor interval="3s"
crm configure primitive p_fs_data ocf:heartbeat:Filesystem params device="/dev/drbd1" directory="/mnt/web" fstype="ext4" op start interval="0s" timeout="40s" op stop interval="0s" timeout="40s" op monitor interval="3s"
crm configure primitive p_fs_mysql ocf:heartbeat:Filesystem params device="/dev/drbd0" directory="/mnt/database" fstype="ext4" op start interval="0s" timeout="40s" op stop interval="0s" timeout="40s" op monitor interval="3s"
crm configure primitive p_mysql ocf:heartbeat:mysql params additional_parameters="--bind-address=$VIP" config="/etc/mysql/my.cnf" pid="/var/run/mysqld/mysqld.pid" socket="/var/run/mysqld/mysqld.sock" log="/var/log/mysql/mysqld.log" op monitor interval="20s" timeout="10s" op start timeout="120s" op stop timeout="120s"
crm configure ms ms_drbd_mysql p_drbd_mysql meta master-max="1"  master-node-max="1" clone-max="2" clone-node-max="1" notify="true"
crm configure ms ms_drbd_data p_drbd_data meta master-max="1"  master-node-max="1" clone-max="2" clone-node-max="1" notify="true"
crm configure colocation fs-on-drbd inf: p_fs_data ms_drbd_data:Master
crm configure colocation mysqldb-on-drbd inf: p_fs_mysql ms_drbd_mysql:Master
crm configure colocation IP-with-drbd-mysql inf: p_IP p_fs_mysql
crm configure colocation IP-with-drbd-data inf: p_IP p_fs_data
crm configure colocation apache-with-IP inf: apache p_IP
crm configure colocation mysql-with-IP inf: p_mysql p_IP
crm configure order fs-after-drbd inf: ms_drbd_data:promote p_fs_data:start
crm configure order mysql-after-drbd inf: ms_drbd_mysql:promote p_fs_mysql:start

