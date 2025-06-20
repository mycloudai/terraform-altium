#!/bin/bash

apt-get update -y
apt-get install -y htop iotop stress ncat mysql-client debconf-utils
ARGUS_VERSION=3.5.12 /bin/bash -c "$(curl -s https://cms-agent-cn-hongkong.oss-cn-hongkong-internal.aliyuncs.com/Argus/agent_install-1.13.sh)" >> /var/log/user-data.log

echo "mysql-server mysql-server/root_password password ${db_password}" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password ${db_password}" | debconf-set-selections

if ! apt-get install -y mysql-server; then
    echo "$(date): CRITICAL - Failed to install mysql-server" >> /var/log/user-data.log
    exit 1
fi

if ! dpkg -l | grep mysql-server; then 
    echo "$(date): Package mysql-server not installed" >> /var/log/user-data.log
    exit 1
else
    echo "$(date): Package mysql-server installed" >> /var/log/user-data.log
    sed -i 's/bind-address.*= 127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
    sed -i 's/mysqlx-bind-address.*= 127.0.0.1/mysqlx-bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
    systemctl enable mysql || true
    systemctl start mysql || true
    systemctl restart mysql || true
fi

if ! systemctl is-active --quiet mysql; then
    echo "$(date): Application  mysql not Running" >> /var/log/user-data.log
    exit 1
else
    echo "$(date): Application  mysql Running" >> /var/log/user-data.log
fi

echo "$(date): User data script completed successfully" >> /var/log/user-data.log
