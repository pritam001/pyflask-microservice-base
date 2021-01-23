#!/bin/bash
app="docker.image.pyflask-base"
docker build -t ${app} .
docker run -d -p 56733:80 --name=${app} -v $PWD:/app ${app}
