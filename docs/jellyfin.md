# Plex Setup

## [Docker Compose](../docker/jellyfin/docker-compose.yml)

This is the docker-compose file that worked for me. Based off of [https://hotio.dev/containers/plex/](https://hotio.dev/containers/plex/)

I put this file inside my `/home/nolan/docker/plex/` folder and named it `docker-compose.yml`

## Create Jellyfin Folders

```sh
sudo mkdir -p /mnt/ssd/docker/jellyfin/config
sudo mkdir -p /mnt/ssd/docker/jellyfin/transcode
```

```sh
sudo chmod -R 755 /mnt/ssd/docker/jellyfin
```

Below folders should already exist 

```sh
# Plex Media Folders
sudo mkdir -p /mnt/hdds/media
sudo mkdir -p /mnt/hdds/media/anime
sudo mkdir -p /mnt/hdds/media/anime-movies
sudo mkdir -p /mnt/hdds/media/documentaries
sudo mkdir -p /mnt/hdds/media/cartoons
sudo mkdir -p /mnt/hdds/media/cartoon-movies
sudo mkdir -p /mnt/hdds/media/movies
sudo mkdir -p /mnt/hdds/media/shows
```

## Run Docker Compose Up

inside `/home/nolan/docker/jellyfin/` run

```sh
docker-compose up -d
```

## Login to Jellyfin and Set Libraries

Assuming the docker-compose worked properly, 

Connect to Plex [http://server-ip:8096/](http://server-ip:8096)

Then you should be connected to Plex where you can configure the rest


