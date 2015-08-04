# What is Headphones?

Headphones is an automated music downloader for NZB and Torrent, written in Python. It supports SABnzbd, NZBget, Transmission, µTorrent and Blackhole.

> [More info](https://github.com/rembo10/headphones)

![Headphones](https://raw.githubusercontent.com/vSense/docker-headphones/master/logo.png)


# How to choose a tag

Available tags:
-   `latest` : based on master branch
-   `develop` : based on develop branch
-   `supervisord-latest` : based on master branch
-   `supervisord-develop` : based on develop branch

The above tags provide images with or without an init process (headphones or supervisor as PID 1)

Depending on how you are planning to launch headphones you have to choose the right image.

# How to use this image.

Run headphones :

	docker run vsense/headphones:<yourtag>

You can test it by visiting `http://container-ip:5050` in a browser or, if you need access outside the host, on port 5050 :

	docker run -p 5050:5050 vsense/headphones:<yourtag>

Then go to `http://localhost:5050` or `http://host-ip:5050` in a browser.

# Overriding

The image has two volumes :
-   /config : contains headphones configuration
-   /downloads : contains the files downloaded by the service provider of your choice : NZB, Torrents or Others. Also postprocessed files. You can pretty much drop whatever you want here it is sort of a data volume.

headphones is installed in the /headphones directory but it is not a volume. If you wish to use host mount point instead of volumes it's possible.

To use an on-host config (for persistent configuration if you do not want to deal with volumes:

    docker run --restart=always --name headphones --hostname headphones -v /srv/configs/headphones:/config vsense/headphones

To mount your download folder (you will probably need to do that anyway) :

    docker run --restart=always --name headphones --hostname headphones -v /srv/configs/headphones:/config -v /srv/seedbox:/downloads vsense/headphones

You can even override headphones directory if you prefer to git clone on your host for whatever reason :

    docker run --restart=always --name headphones --hostname headphones -v /srv/headphones:/headphones vsense/headphones

And you can combine the commands above as you like :

    docker run --restart=always --name headphones --hostname headphones  -v /srv/seedbox:/downloads -v /srv/headphones:/headphones -v /srv/configs/headphones:/config vsense/headphones

# Recommanded running methods

## Running without init with Docker

```
docker run --restart=always --name headphones --hostname headphones  -v /srv/seedbox:/downloads -v /srv/configs/headphones:/config vsense/headphones
```

## Running with systemd (Preferred)

```
# /etc/systemd/system/headphones.service
[Unit]
Description=Headphones music downloader
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker pull vsense/headphones
ExecStart=/usr/bin/docker run --rm --name headphones --hostname headphones --dns=172.17.42.1 -v /srv/configs/headphones:/config -v /srv/seedbox:/downloads vsense/headphones
ExecStop=/usr/bin/docker stop headphones
ExecReload=/usr/bin/docker restart headphones

[Install]
WantedBy=multi-user.target
```
