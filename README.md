# Cloudgene Docker Image :whale:


## Getting Started

After the successful installation, all you need to do is:

```
 docker run -d -p 8080:8082 lukfor/cloudgene
```
After about 1 minute you are able to access your Cloudgene instance on http://localhost:8080.

## Interactive Session

For an interactive session, you can execute:

```
 docker run -it -p 8080:8082 lukfor/cloudgene /bin/bash
```

and run the `startup` script by yourself, to start Hadoop and Cloudgene.


## Persistent Cloudgene Container

Docker images are "read-only", all your changes inside one session will be lost after restart. To install Cloudgene applications or to save your data you need to export it to the host computer.

```
docker run -d -p 8080:8082  -v /home/lukas/cloudgene_data/:/data/ lukfor/cloudgene
```

## Install Applications from a REPOSITORY

TODO: implement http support for clone!

```
docker run -d -p 8080:8082 -e REPOSITORY="https://imputationserver.sph.umich.edu/static/downloads/apps.yaml" -v /home/lukas/cloudgene_data/:/data/ lukfor/cloudgene
```

### Customize Pages

Create a folder `pages` in cloudgene-storage folder. You can customie the files `home.ejs`, `contact.ejs` and `help.ejs`.
