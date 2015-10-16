#!/bin/bash

update()
{
sudo apt-get update
sudo apt-get -y upgrade > upgrade.log

if [ grep 'kept back' upgrade.log ]; then
	start=$(grep -n 'kept back' upgrade.log | cut -d':' -f1)
	end=$(grep -n 'not upgraded' upgrade.log | cut -d':' -f1)
	(( end-- ))

	for line in $(head -${end} upgrade.log | tail -${start}); do
		packages="$packages $line"
	done

	sudo apt-get -y install ${packages} > install.log
fi

} # update

#generate 21 secure passwords (`` or similar)
#Populate these passwords in password file

count=$(wc -l identities | cut -d' ' -f1)
for i in $(seq 1 $count); do
echo "export $(head -$i identities | tail -1)=$(openssl rand -hex 12)" >> passwords
done

#sudo cp hosts/$(hostname).hosts  /etc/hosts
#sudo cp interfaces/$(hostname).interfaces /etc/network/interfaces

ping -c3 openstack.org
        if [ $? -ne 0 ]; then
                echo "ping failed: openstack.org" >> ping.log
        fi

for i in $(grep '\.' /etc/hosts | cut -f2); do
        ping -c3 $i
        if [ $? -ne 0 ]; then
                echo "ping failed: $i" >> ping.log
        fi
done

sudo apt-get -y install ntp

#sudo cp $(hostname).ntp.conf /etc/ntp.conf
#sudo rm /var/lib/ntp/ntp.conf.dhcp
#sudo service ntp restart
#sudo apt-get install ubuntu-cloud-keyring
#sudo cp kilo.lst /etc/apt/sources.list.d/cloudarchive-kilo.list
#sudo apt-get update && apt-get upgrade
#sudo reboot
#
#Database server (controller)
#	apt-get install mysql-server python-mysqldb
#		use database root password from password.ods
#	sudo vim /etc/mysql/conf.d/mysqld_openstack.cnf
#		[mysqld]
#		...
#		bind-address = 10.0.0.2
#		default-storage-engine = innodb
#		innodb_file_per_table
#		collation-server = utf8_general_ci
#		init-connect = 'SET NAMES utf8'
#		character-set-server = utf8
#	# service mysql restart
#	# mysql_secure_installation
#
#Message Queue (controller)
	# apt-get install rabbitmq-server
	# rabbitmqctl add_user openstack RABBIT_PASS (from password.ods)
	# rabbitmqctl set_permissions openstack ".*" ".*" ".*"
