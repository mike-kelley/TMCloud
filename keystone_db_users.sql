	CREATE DATABASE keystone;
	GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
	  IDENTIFIED BY 'KEYSTONE_DBPASS';
    GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
      IDENTIFIED BY 'KEYSTONE_DBPASS'; 
