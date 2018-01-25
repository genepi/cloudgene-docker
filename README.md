# Cloudgene Docker Image :whale:

[![Docker Build Status](https://img.shields.io/docker/build/genepi/cloudgene.svg)](https://hub.docker.com/r/genepi/cloudgene)
[![Docker Pulls](https://img.shields.io/docker/pulls/genepi/cloudgene.svg)](https://hub.docker.com/r/genepi/cloudgene)
![Travis](https://img.shields.io/travis/genepi/cloudgene-docker.svg)

## Getting Started

After the successful installation of Docker, all you need to do is:

```
 docker run -d -p 8080:80 genepi/cloudgene
```
After about 1 minute you are able to access your Cloudgene instance on http://localhost:8080.

Login as **admin** with the default admin password **admin1978**.

## Persistent Cloudgene Container

Docker images are "read-only", all your changes inside one session will be lost after restart. To install Cloudgene applications or to save your data between sessions, you need to mount a folder from your host to the container:

```
docker run -d -p 8080:8082  -v /home/lukas/cloudgene_data/:/data/ genepi/cloudgene
```

## Start Cloudgene without Hadoop cluster

You can use the environment variable `START_HADOOP` to disable the Hadoop service:

```
 docker run -d -p 8080:80 -e START_HADOOP="false" genepi/cloudgene
```

## Interactive Session

For an interactive session, you can execute:

```
 docker run -it -p 8080:80 genepi/cloudgene
```

You well see all log messages from Hadoop and from Cloudgene itself.

To get access to Hadoop specific web-applications you can map additional ports to your host:

```
 docker run -d -p 8080:80 -p 50030:50030 genepi/cloudgene
```

Hadoop's web-interface is now accessible on http://localhost:50030.


## Install Applications from a Repository

A repository is a collection of applications that can be installed when you start a new Cloudgene Docker instance. For example, we can use the repository provided by the [Michigan Imputationserver](https://imputationserver.sph.umich.edu) to clone it in our Docker instance:

```
docker run -d -p 8080:80 -e CLOUDGENE_REPOSITORY="https://imputationserver.sph.umich.edu/static/downloads/apps.yaml" -v /home/lukas/cloudgene_data/:/data/ genepi/cloudgene
```

## Credits

Thanks to the people behind this [Galaxy image](https://github.com/bgruening/docker-galaxy-stable) for inspiration.
