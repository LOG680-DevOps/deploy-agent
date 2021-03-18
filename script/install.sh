#!/bin/bash

echo "--> Install GO."
sudo yum install golang -y
cd ..
echo "--> Build Agent."
sudo go build -o DeployAgent src/main.go
cd script
echo "--> Create systemd."
sudo cp deployagent.service /lib/systemd/system/
sudo chmod 644 /lib/systemd/system/deployagent.service
sudo systemctl daemon-reload
sudo systemctl enable deployagent.service
sudo systemctl status deployagent.service
echo "--> Complete!"