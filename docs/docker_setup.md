# Docker Setup

## Install Docker

```sh
sudo apt update
sudo apt install -y docker.io
```

## Install Docker Compose

```sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## Create Docker Folder in Home Directory