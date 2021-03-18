#!/bin/bash

echo "--> Fetching last version."
git add .
git reset origin --hard
git pull
echo "--> Build Agent."
sudo go build -o DeployAgent src/main.go
echo "--> Complete!"
