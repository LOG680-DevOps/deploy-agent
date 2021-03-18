#!/bin/bash

set -e

echo $1 $2 $3 $4

echo "||| Starting deployment ..."
echo ""
echo "||| Pulling image ..."
docker pull $1/$2:$3
echo ""
echo "||| Removing container ..."
docker rm $2 --force || true
echo ""
echo "||| Starting new version ..."
docker run -d $4 --name $2 $1/$2:$3
echo ""
echo "||| Deployment complete !"