---
title: Custom systemd service in Linux
date: 2019-7-17 20:45:36
tags:
    - Linux
---

# custom systemd service

+ service file in `/lib/systemd/system`

```
[Unit]
Description=ss local server
After=network.target network-online.target systemd-networkd.service NetworkManager.service connman.service

[Service]
Type=simple
RemainAfterExit=yes
ExecStart=/usr/bin/ss-local
ExecStop=/bin/kill -s QUIT $MAINPID

[Install]
WantedBy=multi-user.target
```

+ operations
```bash
# make change take effect
sudo systemctl daemon-reload

# start service
sudo service ss-local start

# stop service
sudo service ss-local stop

# view log
journalctl -xe
```