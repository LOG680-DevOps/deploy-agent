#!/bin/bash

sudo yum install golang -y

sudo cp deployagent.service /lib/systemd/system/
sudo chmod +x /lib/systemd/system/deployagent.service
sudo systemctl daemon-reload
sudo systemctl enable deployagent.service
sudo systemctl status deployagent.service
systemd-analyze verify /usr/lib/systemd/system/deployagent.service