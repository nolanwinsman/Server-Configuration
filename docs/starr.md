# Starr

Sonarr, Radarr, and Bazarr are powerful automation tools for managing and organizing media libraries. Sonarr is designed for TV shows, allowing users to automatically download, organize, and rename episodes from multiple sources based on their preferences. Radarr serves a similar function but is tailored for movies, automating the process of finding, downloading, and managing high-quality film files. Bazarr works in conjunction with Sonarr and Radarr, focusing on subtitle management by automatically searching for, downloading, and syncing subtitles in various languages for TV shows and movies. Together, these tools streamline the process of maintaining a well-organized and accessible media collection, particularly when integrated with download clients like qBittorrent and Usenet.

## What are the Starr Apps?

Sonarr, Radarr, Lidarr, etc.

# Create directories if they don't exist

```sh
# Create directories if they don't exist
sudo mkdir -p /mnt/hdds/docker/qbittorrent/downloads
sudo mkdir -p /mnt/ssd/docker/qbittorrent/downloads
sudo mkdir -p /mnt/ssd/docker/radarr
sudo mkdir -p /mnt/ssd/docker/sonarr
sudo mkdir -p /mnt/ssd/docker/bazarr
```

```sh
# Set ownership to match the PUID/PGID
sudo chown -R 1000:1000 /mnt/hdds/docker /mnt/ssd/docker
```

# Plex Setup

## [Docker Compose](../docker/starr/docker-compose.yml)

This is the docker-compose file that worked for me. Based off of [https://trash-guides.info/File-and-Folder-Structure/How-to-set-up/Docker/](https://trash-guides.info/File-and-Folder-Structure/How-to-set-up/Docker/)

I put this file inside my `/home/nolan/docker/starr/` folder and named it `docker-compose.yml`

## Run Docker Compose Up

inside `/home/nolan/docker/plex/` run

```sh
docker-compose up -d
```

## Login to Web Pages

Radarr: http://<server-ip>:7878
Sonarr: http://<server-ip>:8989
Bazarr: http://<server-ip>:6767

