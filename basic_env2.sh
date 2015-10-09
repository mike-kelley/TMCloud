home=$HOME
source $home/passwords
$home/sql_install.sh

address=$(ifconfig eth0 | grep 'inet addr' | cut -d':' -f2 | cut -d' ' -f1)
if [ -f /etc/mysql/conf.d/mysqld_openstack.cnf ]; then
	line=$(grep -n '\[mysqld\]' /etc/mysql/conf.d/mysqld_openstack.cnf | cut -d':' -f1)
	sed -i "$line\ bind-address = $address" /etc/mysql/conf.d/mysqld_openstack.cnf
	sed -i "${line}i\ bind-address = $address" /etc/mysql/conf.d/mysqld_openstack.cnf
	sed -i "${line}i\ default-storage-engine = innodb" /etc/mysql/conf.d/mysqld_openstack.cnf
	sed -i "${line}i\ innodb_file_per_table" /etc/mysql/conf.d/mysqld_openstack.cnf
	sed -i "${line}i\ collation-server = utf8_general_ci" /etc/mysql/conf.d/mysqld_openstack.cnf
	sed -i "${line}i\ init-connect = 'SET NAMES utf8'" /etc/mysql/conf.d/mysqld_openstack.cnf
	sed -i "${line}i\ character-set-server = utf8" /etc/mysql/conf.d/mysqld_openstack.cnf
else 
	echo "[mysqld]" >> mysqld_openstack.cnf
	echo "bind-address = $address" >> mysqld_openstack.cnf
	echo "default-storage-engine = innodb" >> mysqld_openstack.cnf
	echo "innodb_file_per_table" >> mysqld_openstack.cnf
	echo "collation-server = utf8_general_ci" >> mysqld_openstack.cnf
	echo "init-connect = 'SET NAMES utf8'" >> mysqld_openstack.cnf
	echo "character-set-server = utf8" >> mysqld_openstack.cnf
	
	mv mysqld_openstack.cnf /etc/mysql/conf.d/
	chown openstack:openstack /etc/mysql/conf.d/mysqld_openstack.cnf
fi

 service mysql restart

 apt-get -y install rabbitmq-server > rabbit-server.log
 rabbitmqctl add_user openstack $RABBIT_PASS (from password.ods)
 rabbitmqctl set_permissions openstack ".*" ".*" ".*"
