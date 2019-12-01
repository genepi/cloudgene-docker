FROM genepi/cdh5-hadoop-mrv1:v1.0.1

MAINTAINER Sebastian Schoenherr <sebastian.schoenherr@i-med.ac.at>, Lukas Forer <lukas.forer@i-med.ac.at>

# Install R
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" | sudo tee -a /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN apt-get update -y
RUN apt-get install r-base -y --force-yes

# Install R Packages
RUN R -e "install.packages('knitr', repos = 'http://cran.rstudio.com' )"
RUN R -e "install.packages('markdown', repos = 'http://cran.rstudio.com' )"
RUN R -e "install.packages('rmarkdown', repos = 'http://cran.rstudio.com' )"
RUN R -e "install.packages('ggplot2', repos = 'http://cran.rstudio.com' )"
RUN R -e "install.packages('data.table', repos = 'http://cran.rstudio.com' )"

# Install Cloudgene
ENV CLOUDGENE_VERSION=2.0.4
RUN mkdir /opt/cloudgene
RUN cd /opt/cloudgene; curl -fsSL install.cloudgene.io | bash -s $CLOUDGENE_VERSION
ENV PATH=/opt/cloudgene:$PATH

# Add cloudgene.conf to set all dirs to /data
COPY cloudgene/cloudgene.conf /opt/cloudgene/cloudgene.conf

# Add docker specific pages to cloudgene
COPY cloudgene/pages /opt/cloudgene/sample/pages

COPY cloudgene/startup /usr/bin/startup
RUN chmod +x /usr/bin/startup

# Cloudgene Docker Branding
ENV CLOUDGENE_SERVICE_NAME="Cloudgene Docker"
ENV CLOUDGENE_HELP_PAGE="https://github.com/lukfor/docker-cloudgene"
ENV START_CLOUDGENE="true"
ENV START_HADOOP="true"

# Add test workflow to hadoop example directory
COPY tests/wordcount.yaml /usr/lib/hadoop-0.20-mapreduce/wordcount.yaml

# Startup script to start Hadoop and Cloudgene
EXPOSE 80
CMD ["/usr/bin/startup"]
