FROM seppinho/cdh5-hadoop-mrv1

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

# Replace old config with new file to store hdfs data in /data/hadoop/dfs
ADD hdfs-site.xml /etc/hadoop/conf/hdfs-site.xml

# Install Cloudgene
RUN mkdir /opt/cloudgene
RUN cd /opt/cloudgene; curl -fsSL cloudgene.uibk.ac.at/install | bash
ENV PATH=/opt/cloudgene:$PATH

# Add cloudgene.conf to set dirs to /data
ADD cloudgene.conf /opt/cloudgene/cloudgene.conf

# Add docker specific pages to cloudgene
ADD pages /opt/cloudgene/sample/pages

# Add startup scripts
ADD start-hadoop /usr/bin/start-hadoop
RUN chmod +x /usr/bin/start-hadoop

ADD startup /usr/bin/startup
RUN chmod +x /usr/bin/startup

RUN mkdir /data

# Cloudgene Docker Branding
ENV CLOUDGENE_SERVICE_NAME="Cloudgene Docker"
ENV CLOUDGENE_HELP_PAGE="https://github.com/lukfor/docker-cloudgene"

# Mark folders as volume
VOLUME ["/data/"]

# Startup script to start Hadoop and Cloudgene
CMD ["/usr/bin/startup"]
