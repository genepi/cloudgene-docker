# Cloudgene Docker Image :whale:

[![Docker Build Status](https://img.shields.io/docker/build/genepi/cloudgene.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/genepi/cloudgene.svg)]()
[![Travis](https://img.shields.io/travis/lukfor/docker-cloudgene.svg)]()

## Getting Started

After the successful installation of Docker, all you need to do is:

```
 docker run -d -p 8080:8082 genepi/cloudgene
```
After about 1 minute you are able to access your Cloudgene instance on http://localhost:8080.

## Persistent Cloudgene Container

Docker images are "read-only", all your changes inside one session will be lost after restart. To install Cloudgene applications or to save your data between sessions, you need to mount a folder from your host to container:

```
docker run -d -p 8080:8082  -v /home/lukas/cloudgene_data/:/data/ genepi/cloudgene
```

## Interactive Session

For an interactive session, you can execute:

```
 docker run -it -p 8080:8082 genepi/cloudgene startup
```

You well see all log messages from Hadoop and from Cloudgene itself.

To get access to Hadoop specfic web-applications you can map additional ports to your host:

```
 docker run -d -p 8080:8082 -p 50030:50030 genepi/cloudgene
```

Hadoop's web-interface is now accessible on http://localhost:50030.


## Install Applications from a Repository

A repository is a collection of applications that can be installed when you start a new Cloudgene Docker instance. For example, we can use the repository provided by the [Michigan Imputationserver](https://imputationserver.sph.umich.edu) to clone it in our Docker instance:

```
docker run -d -p 8080:8082 -e CLOUDGENE_REPOSITORY="https://imputationserver.sph.umich.edu/static/downloads/apps.yaml" -v /home/lukas/cloudgene_data/:/data/ genepi/cloudgene
```

## Credits

Thanks to the people behind this [Galaxy image](https://github.com/bgruening/docker-galaxy-stable) for inspiration.
