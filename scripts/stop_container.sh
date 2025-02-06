#!/bin/bash
set -e

# Stop the running container (if any)
# echo "Hi"
# docker ps | aws -F " " '{print $1}' | tail -n +2 | xargs docker stop

container_id=`docker ps | awk 'FNR == 2 {print $1}'`
docker rm -f $container_id