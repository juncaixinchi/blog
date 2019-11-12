---
title: Some bash scripts
date: 2019-4-2 19:43:09
tags:
    - Bash
---

# setInterval in bash

```bash
while true; do ls -l; sleep 2; done
```

# count files fastly
```
find . -type f | wc -l
```

# find files that large than 1 GiB
```bash
find . -type f -size +1G
```

# test if file exist
```bash
myFile="/home/lxw/abc"
if [ ! -f "$myFile" ]; then
touch "$myFile"
else
echo "skip"
fi
```

# kill process
find all `dart` process and kill them all
```bash
# find
ps -aux | grep dart
# find && kill
pgrep -f dart | xargs kill
```

# Wifi

```bash
# connect to wifi
sudo nmcli d wifi connect iPhone password 11345678

# show saved connections
ls -sail /etc/NetworkManager/system-connections/
```