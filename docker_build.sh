#!/bin/bash

# pyflask_config: service_name
app="docker.image.pyflask-microservice"
docker build -t ${app} .
docker run -d -p 56733:80 --name=${app} -v "$PWD":/app ${app}
