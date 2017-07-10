---
title: Brtfs Filesystem
date: 2017-07-05 19:06:28
tags:
	- Brtfs
	- Linux
---

# Btrfs文件系统

Btrfs是新一代的Linux文件系统，目标是取代Linux目前的ext3文件系统，改善ext3的限制，特别是单一文件大小的限制，总文件系统大小限制以及加入文件校验和特性。

<!-- more -->

## 基本的操作系统命令(一般都需要sudo权限)

* 安装Btrfs工具

```
apt-get install brtfs-tools
```

* 创建btrfs文件系统(以sdb为例)

```
mkfs.btrfs /dev/sdb
```

* 搜索brtfs文件系统

```
btrfs device scan
btrfs device scan /dev/sdb
```

* 挂在文件系统

```
mount -t btrfs /dev/sdb /mnt/btrfs
```

* 快照（Snapshots）和建立子卷（subvolumes）

```
btrfs subvolume create /mnt/btrfs/new_subvol
btrfs subvolume snapshot /mnt/btrfs /mnt/btrfs/snapshot_of_root
```

* 挂载子卷

```
mount -t btrfs -o subvol=new_subvol /dev/sdb /mnt/new_subvol
mount -t btrfs -o subvol=snapshot_of_root /dev/sdb /mnt/snap
```

* 打印所有的文件系统metadata

sudo btrfs-debug-tree /dev/sdb | less

## Raid相关命令

* 创建RAID1阵列，需要先umount被操作的磁盘，如果是已有文件系统的，需要加-f选项

RAID 1通过磁盘数据镜像实现数据冗余，在成对的独立磁盘上产生互为备份的数据。当一个磁盘失效时，系统可以自动切换到镜像磁盘上读写，而不需要重组失效的数据。

```
mkfs.btrfs -m raid1 -d raid1 /dev/sdb /dev/sdc
```

结果如下
```
Label:              (null)
UUID:               ff22ad9f-de13-4430-9a51-b776bff0162e
Node size:          16384
Sector size:        4096
Filesystem size:    20.00GiB
Block group profiles:
Data:             RAID1             1.01GiB
Metadata:         RAID1             1.01GiB
System:           RAID1            12.00MiB
SSD detected:       no
Incompat features:  extref, skinny-metadata
Number of devices:  2
Devices:
ID        SIZE  PATH
1    10.00GiB  /dev/sdb
2    10.00GiB  /dev/sdc
```

* 创建RAID10阵列，需要至少四个盘

RAID10也被称为镜象阵列条带。像RAID0一样，数据跨磁盘抽取；像RAID1一样，每个磁盘都有一个镜象磁盘

```
mkfs.btrfs -m raid10 -d raid10 /dev/sdc /dev/sdd /dev/sde /dev/sdf
```

结果如下
```
Label:              (null)
UUID:               5f1e8ab4-bcd7-42f6-9aee-53acabfdce8c
Node size:          16384
Sector size:        4096
Filesystem size:    40.00GiB
Block group profiles:
Data:             RAID10            2.01GiB
Metadata:         RAID10            2.01GiB
System:           RAID10           20.00MiB
SSD detected:       no
Incompat features:  extref, skinny-metadata
Number of devices:  4
Devices:
ID        SIZE  PATH
1    10.00GiB  /dev/sdb
2    10.00GiB  /dev/sdd
3    10.00GiB  /dev/sde
4    10.00GiB  /dev/sdf

```

* 查看所有磁盘挂载情况

```
lsblk
```

* 查看当前阵列的Raid的使用情况

```
btrfs fi show
btrfs fi df /mnt
```

结果如下
```
Data, RAID1: total=1.00GiB, used=512.00KiB
System, RAID1: total=8.00MiB, used=16.00KiB
Metadata, RAID1: total=1.00GiB, used=112.00KiB
GlobalReserve, single: total=16.00MiB, used=0.00B
```

* 磁盘缺失时，`btrfs fi show`会报错 Some devices missing

```
warning, device 2 is missing
warning devid 2 not found already
Label: none  uuid: 5f1e8ab4-bcd7-42f6-9aee-53acabfdce8c
Total devices 2 FS bytes used 1.38MiB
devid    1 size 10.00GiB used 2.04GiB path /dev/sdb
*** Some devices missing

```
* 磁盘缺失的情况，同时mount时会报错

```
mount: wrong fs type, bad option, bad superblock on /dev/sdb,
missing codepage or helper program, or other error

In some cases useful info is found in syslog - try
dmesg | tail or so.
```

* 出现磁盘缺失的情况，需要在降级模式下挂载raid1或raid10阵列，

```
mount -odegraded /dev/sdb /mnt
```

* 加入新盘替代missing的device, start 后面指定missing的磁盘序列号（如何在复杂情况下找到实际缺失的序列号是个问题）

```
btrfs replace start 2 -f /dev/sdf /mnt
```

* 添加新盘后，metadata等只在一个盘上，故需要balance

```
btrfs filesystem balance /mnt
```

* 出现磁盘缺失时，也可以先添加新的替代盘，再删除missing的磁盘

```
btrfs dev add -f /dev/sdc /mnt
btrfs device delete missing /mnt
btrfs filesystem balance /mnt
```

* 单纯添加新的盘入磁盘阵列

```
btrfs dev add -f /dev/sdc /mnt
btrfs filesystem balance /mnt
```

* 删除磁盘阵列中的磁盘

```
btrfs device delete /dev/sdc /mnt
```

* 将一个single的disk转化为raid1阵列

```
mount /dev/sdb /mnt
btrfs device add /dev/sdc /mnt
btrfs balance start -dconvert=raid1 -mconvert=raid1 /mnt
```

* 从损坏的btrfs文件系统中restore数据

```
btrfs restore /dev/sdd ~/pathToRestoreFile
```