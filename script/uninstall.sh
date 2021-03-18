#!/bin/bash

systemctl stop deployagent.service
systemctl disable deployagent.service
rm /etc/systemd/system/deployagent.service
rm /etc/systemd/system/deployagent.service
rm /usr/lib/systemd/system/deployagent.service
rm /usr/lib/systemd/system/deployagent.service
systemctl daemon-reload
systemctl reset-failed