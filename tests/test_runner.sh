#!/bin/sh

# stop when one cmd fails, print commands
set -e
set -x

# start docker image
docker run -d -p 8080:80 --name test genepi/cloudgene
sleep 90


# check if cloudgene is running on host port
curl -v -k --fail http://localhost:8080/api/v2/server/version.svg


# test hadoop cluster with wordcount (from execute-wordcount.sh)
docker exec -t -i test hadoop fs -mkdir input
docker exec -t -i test bash -c "hadoop fs -put /etc/hadoop/conf/* input"
docker exec -t -i test hadoop jar /usr/lib/hadoop-0.20-mapreduce/hadoop-examples.jar wordcount input output

# export output
docker exec -t -i test mkdir /data/wordcount-cmd/
docker exec -t -i test hadoop fs -get output/part-r-00000 /data/wordcount-cmd/part-r-00000

# test connection between cloudgene and hadoop with wordcount.yaml application
docker exec -t -i test cloudgene install wordcount /usr/lib/hadoop-0.20-mapreduce/wordcount.yaml
docker exec -t -i test cloudgene run wordcount --input  /etc/hadoop/conf/ --output /data/wordcount-cloudgene  --conf /etc/hadoop/conf

# remove job config files
docker exec -t -i test bash -c "rm /data/wordcount-cloudgene/output/job_*"

# compare results
docker exec -t -i test diff -r /data/wordcount-cloudgene/output/ /data/wordcount-cmd/


# cleanup
docker stop test && docker rm test
