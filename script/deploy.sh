#!/bin/bash

set -e

echo $1 $2 $3

echo "||| Starting deployment ..."
echo ""
echo "||| Pulling image ..."
docker pull $1/$2:$3
echo ""
echo "||| Removing container ..."
docker rm $2 --force || true
echo ""
echo "||| Starting new version ..."
docker run -d --name $2 $1/$2:$3
echo ""
echo "||| Deployment complete !"