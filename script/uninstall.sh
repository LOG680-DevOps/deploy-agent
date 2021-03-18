#!/bin/bash

sudo systemctl stop deployagent2.service
sudo systemctl disable deployagent2.service
sudo rm /lib/systemd/system/deployagent2.service
sudo systemctl daemon-reload
sudo systemctl reset-failed