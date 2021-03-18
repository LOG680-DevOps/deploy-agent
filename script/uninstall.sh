#!/bin/bash

sudo systemctl stop deployagent.service
sudo systemctl disable deployagent.service
sudo rm /lib/systemd/system/deployagent.service
sudo systemctl daemon-reload
sudo systemctl reset-failed