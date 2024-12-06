# Plex Setup

## [Docker Compose](../docker/plex/docker-compose.yml)

This is the docker-compose file that worked for me. Based off of [https://hotio.dev/containers/plex/](https://hotio.dev/containers/plex/)

I put this file inside my `/home/nolan/docker/plex/` folder and named it `docker-compose.yml`

## [.env file](../docker/plex/env.txt)

Copy my `env.txt` file and rename the filename to `.env`

Fill in the proper information inside the `.env` file. You get your Plex Claim via [https://plex.tv/claim](https://plex.tv/claim) This claim key only lasts a few minutes so if you run out of time, generate a new key

I put this file inside my `/home/nolan/docker/plex/` folder importantly this is the same folder as the `docker-compose.yml`

## Create Plex Folders

```sh
sudo mkdir -p /mnt/ssd/docker/plex/config
sudo mkdir -p /mnt/ssd/docker/plex/transcode
sudo mkdir -p /mnt/hdds/media

# Plex Media Folders
sudo mkdir -p /mnt/hdds/media/anime
sudo mkdir -p /mnt/hdds/media/anime-movies
sudo mkdir -p /mnt/hdds/media/cartoons
sudo mkdir -p /mnt/hdds/media/cartoon-movies
sudo mkdir -p /mnt/hdds/media/movies
sudo mkdir -p /mnt/hdds/media/shows
```

Ensure the Plex container has permission to access these directories:

```sh
sudo chown -R $(id -u):$(id -g) /mnt/ssd/docker/plex
sudo chown -R $(id -u):$(id -g) /mnt/hdds/media/

```

## Run Docker Compose Up

inside `/home/nolan/docker/plex/` run

```sh
docker-compose --env-file .env up -d
```

You might not need to the `--env-file` flag but it seems to run more consistently.

## Login to Plex and Set Libraries

Assuming the docker-compose worked properly, 

Connect to Plex [http://<server-ip>:32400/web](http://<server-ip>:32400/web)

Then you should be connected to Plex where you can configure the rest


