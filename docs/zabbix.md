# Zabbix Setup

I am following the official Zabbix website for setup instructions 
[https://www.zabbix.com/download?zabbix=7.0&os_distribution=ubuntu&os_version=24.04&components=server_frontend_agent&db=mysql&ws=apache](https://www.zabbix.com/download?zabbix=7.0&os_distribution=ubuntu&os_version=24.04&components=server_frontend_agent&db=mysql&ws=apache)

All of this is installed on my Ubuntu VM.

## 1. Choose Your Platform

- Zabbix Version: 7.0 LTS
- OS Distribution: Ubuntu
- OS Version: 24.04 (Noble)
- Zabbix Component: Server, Frontend Agent
- Database: MySQL
- Web Server: Apache

## 2. 

Become root user

```sh
sudo -s
```

Install Zabbix repository

```sh
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.0+ubuntu24.04_all.deb
dpkg -i zabbix-release_latest_7.0+ubuntu24.04_all.deb
apt update 
```

Install Zabbix server, frontend, agent

```sh
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
```

Create initial database

Make sure you have database server up and running

```sh
apt install mysql-server
```

