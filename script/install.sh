#!/bin/bash

echo "--> Install GO."
sudo yum install golang -y
cd ..
echo "--> Build Agent."
sudo go build -o DeployAgent src/main.go
cd script
echo "--> Create systemd."
sudo cp deployagent2.service /lib/systemd/system/
sudo chmod 644 /lib/systemd/system/deployagent2.service
sudo systemctl daemon-reload
sudo systemctl enable deployagent2.service
sudo systemctl status deployagent2.service
sudo systemd-analyze verify /usr/lib/systemd/system/deployagent2.service
echo "--> Complete!"