#!/bin/bash

sudo systemctl stop deployagent.service
sudo systemctl disable deployagent.service
sudo rm /etc/systemd/system/deployagent.service
sudo rm /usr/lib/systemd/system/deployagent.service
sudo systemctl daemon-reload
sudo systemctl reset-failed