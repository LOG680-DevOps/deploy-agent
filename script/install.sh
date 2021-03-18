#!/bin/bash

sudo yum install golang -y
cd ..
go build -o DeployAgent src/main.go
cd script
sudo cp deployagent.service /lib/systemd/system/
sudo chmod 755 /lib/systemd/system/deployagent.service
sudo systemctl daemon-reload
sudo systemctl enable deployagent.service
sudo systemctl status deployagent.service
systemd-analyze verify /usr/lib/systemd/system/deployagent.service