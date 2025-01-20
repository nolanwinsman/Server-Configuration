# Qbittorrent Install and Setup

## [Docker Compose](../docker/qbittorrent/docker-compose.yml)

This is the docker-compose file that worked for me. Based off of [https://hotio.dev/containers/qbittorrent/#__tabbed_3_2](https://hotio.dev/containers/qbittorrent/#__tabbed_3_2)

I put this file inside my `/home/nolan/docker/qbittorrent/` folder and named it `docker-compose.yml`

## Run Docker Compose Up Once

inside `/home/nolan/docker/qbittorrent/` run

```sh
sudo docker-compose up -d
```

to start the service. If you check the logs, it will fail since you won't have `wg0.conf` created and configured

Stop the service

```sh
sudo docker-compose down
```

## [wg0.conf](../conf/wireguard/wg0.conf)

Inside my `/mnt/ssd/docker/qbittorrent/wireguard/` folder, I created `wg0.conf` based off of the file above. Public and Private key generated from [https://mullvad.net/en/account/wireguard-config](https://mullvad.net/en/account/wireguard-config)

## Rerun Docker-Compose and Check Logs

inside `/home/nolan/docker/qbittorrent/` run

```sh
sudo docker-compose up -d
```

now if you check the logs, 

```sh
docker logs qbittorrent
```

if successful, it should give you a temporary password. Login to the Qbittorrent webportal

```sh
http://<Server IP>:8080
```

```sh
username: admin
password: <temporary password>
```

Now go to Settings --> WebUI --> Authentication

then change your password


## Specific Indexers

Documentation for setting up primarily private indexers on the server.

[Myanonamouse](/docs/indexers/myanonamous.md)

