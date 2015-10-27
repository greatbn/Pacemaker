#Script cai dat Apache Cluster 2 node
export netaddr=10.10.10.0
export node1=10.10.10.11
export node2=10.10.10.12
export VIP=10.10.10.30
export IP=`ifconfig | grep 'net addr' | awk 'FNR== 1 {print $2}' | cut -d ':' -f2`

echo " - - - Update package - - -"
sleep 3

apt-get update -y
echo " - - - Install DRBD  - -- "
sleep 3
apt-get install drbd8-utils -y
echo "- - - Install Pacemaker Corosync and Resource-agents"
sleep 3
apt-get install pacemaker crmsh corosync cluster-glue resource-agents apache2 -y
echo " - - - Install MYSQL - - - "
sleep 3
apt-get install mysql-server -y
modprobe drbd

#start pacemaker during boot
update-rc.d pacemaker defaults
update-rc.d corosync defaults
sed -i "s/START=no/START=yes/g" /etc/default/corosync

#Config corosync
sed -i.bak "s/.*bindnetaddr:.*/bindnetaddr:\ $netaddr/g" /etc/corosync/corosync.conf

#Start service 
service corosync restart
service pacemaker restart
service apache2 restart
#Config DRBD to sync web data
mysql_conf=/etc/drbd.d/mysql.res
echo -e "o\nn\np\n\n\n+2000MB\nn\np\n2\n\n\n\nw" | fdisk /dev/sdb
cat << EOF > $mysql_conf
resource mysql {
        disk /dev/sdb1;
        device /dev/drbd0;
        meta-disk internal;
        on ctl1 {
                address $node1:7789;
        }
        on ctl2 {
                address $node2:7789;
        }
}

EOF
web_data=/etc/drbd.d/webdata.res
cat << EOF > $webdata
resource webdata{
	disk /dev/sdb2;
	device /dev/drbd1;
	meta-disk internal;
	on ctl1 {
		address $node1:7790;
	}
	on ctl2{
		address $node2:7790;
	}
}
EOF
service drbd restart
drbdadm create-md mysql
drbdadm create-md webdata
drbdadm up mysql
drbdadm up webdata



