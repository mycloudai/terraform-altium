#!/bin/bash

apt-get update -y
apt-get install -y htop iotop stress ncat mysql-client
ARGUS_VERSION=3.5.12 /bin/bash -c "$(curl -s https://cms-agent-cn-hongkong.oss-cn-hongkong-internal.aliyuncs.com/Argus/agent_install-1.13.sh)" >> /var/log/user-data.log

echo "deb [trusted=yes] http://${pkg_repository}/ubuntu focal main" > /etc/apt/sources.list.d/custom.list
apt-get update -y

if ! apt-get install -y ${pkg_name}; then
    echo "$(date): CRITICAL - Failed to install ${pkg_name} from ${pkg_repository}" >> /var/log/user-data.log
    exit 1
fi

if ! dpkg -l | grep nginx; then 
    echo "$(date): Package ${pkg_name} not installed" >> /var/log/user-data.log
    exit 1
else
    echo "$(date): Package ${pkg_name} installed" >> /var/log/user-data.log
    systemctl enable ${pkg_name} || true
    systemctl start ${pkg_name} || true
    touch /var/www/html/index.nginx-debian.html
    curl http://100.100.100.200/latest/meta-data/instance-id > /var/www/html/index.nginx-debian.html
fi

if ! systemctl is-active --quiet nginx; then
    echo "$(date): Application  ${pkg_name} not Running" >> /var/log/user-data.log
    exit 1
else
    echo "$(date): Application  ${pkg_name} Running" >> /var/log/user-data.log
fi

echo "$(date): User data script completed successfully" >> /var/log/user-data.log
