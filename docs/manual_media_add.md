# How to Manually add a media file to Plex

First, copy the file from torrent folder to desired movie/show folder

```sh
sudo cp -rp movie.mkv /mnt/hdds/data/media/movies/
```

In this example I need to also create a folder for the movie. So inside my `movies/` folder

```sh
sudo mkdir 'Movie (1994)'
```

Make sure the folder name is exactly the same as the path inside Radarr/Sonarr

Now move the movie into the folder and I also want to rename the movie file to my desired filename.

```
sudo mv 'movie.mkv' "/mnt/hdds/data/media/movies/Movie (1994)/Movie (1994).mkv"
```

Now from the `movies/` folder, I need to change the owner and the group.

Easiest way to do this is copy the owner/group of other files in the movies folder
```sh
ls -la
```

You should see a bunch of files. Here's one example

```
drwxrwxr-x  2 radarr mediacenter  3 Jan 14 19:32 'Adieu Galaxy Express 999 (1981)'
```

So the owner is `radarr` and the group is `mediacenter`

Now to change my movie file to that owner/group

```sh
sudo chown radarr -R "Movie (1994)"
sudo chgrp mediacenter -R "Movie (1994)"
```

Now the movie should be properly added to Plex and if you named everything correctly, also Radarr/Sonarr

If you need to rename the files or somehting, it's easiest to do that within the container 

```sh
docker exec -it radarr /bin/sh
```

## Extracting Compressed Files

If you have a download that's compressed, for instance `.rar` you can use 7z to extract it

```sh
sudo 7z x file.rar
```

## Converting `.iso` to `.mkv`

I used makemkv to convert the file. FFMPEG can work but I had issues getting the subtiles and other audio files extracted.

Make sure the docker compose [MakeMKV](../docker/makemkv/docker-compose.yml) is setup and running

I copied the `.iso` file to the storage folder for Makemkv

```sh
sudo cp -rp *.iso /mnt/ssd/config/makemkv/storage/
```

Then on the MakeMKV web app `<IP>:5800`

Go to 

- File
- Open File
- Select the .iso file
- Select everything you want to convert within the file
- Click Make 
- The .mkv files should be extracted to `/mnt/ssd/config/makemkv/output/`

Now navigate to the `output/` folder and movie the movie file to the desired location.

Make sure to set the correct permissions and ownership for the movie file then delete the extra files in `output/` and `storage/`
