#!/bin/bash

echo "--> Install GO."
sudo yum install golang -y
echo "--> Create systemd."
sudo cp deployagent.service /lib/systemd/system/
sudo chmod 644 /lib/systemd/system/deployagent.service
sudo systemctl daemon-reload
sudo systemctl enable deployagent.service
sudo systemctl status deployagent.service
echo "--> Complete!"