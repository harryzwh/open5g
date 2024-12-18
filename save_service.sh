#!/bin/bash

for img in $(docker compose config | awk '{if ($1 == "image:") print $2;}'); do
  images="$images $img"
done
echo $images

docker save $images | gzip > service.tar.gz
