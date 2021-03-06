Verify the disk filesystem:
===========================

```
[heat-admin@compute]$ sudo df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda2       3.7T   24G  3.7T   1% /
devtmpfs        126G     0  126G   0% /dev
tmpfs           126G     0  126G   0% /dev/shm
tmpfs           126G  1.5M  126G   1% /run
tmpfs           126G     0  126G   0% /sys/fs/cgroup
tmpfs            26G     0   26G   0% /run/user/1000
```

Check the available disk:
=========================
```
[heat-admin@compute-3 /]$ sudo fdisk -l 
WARNING: fdisk GPT support is currently new, and therefore in an experimental phase. Use at your own discretion.

Disk /dev/sda: 3999.7 GB, 3999688294400 bytes, 7811891200 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: gpt
Disk identifier: DD81D434-244E-4B1B-B52D-A14F8CA9D597


#         Start          End    Size  Type            Name
 1         2048         4095      1M  Linux filesyste Linux filesystem
 2         4096   7811891166    3.7T  Linux filesyste Linux filesystem
 3           34         2047   1007K  BIOS boot parti BIOS boot partition

Disk /dev/sdb: 599.6 GB, 599550590976 bytes, 1170997248 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x37fbfa8b

   Device Boot      Start         End      Blocks   Id  System

Disk /dev/sdc: 599.6 GB, 599550590976 bytes, 1170997248 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
```

Format the block disk:-
======================
```
[heat-admin@overcloud-compute-3 ~]$ sudo fdisk /dev/sdc
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): m
Command action
   a   toggle a bootable flag
   b   edit bsd disklabel
   c   toggle the dos compatibility flag
   d   delete a partition
   g   create a new empty GPT partition table
   G   create an IRIX (SGI) partition table
   l   list known partition types
   m   print this menu
   n   add a new partition
   o   create a new empty DOS partition table
   p   print the partition table
   q   quit without saving changes
   s   create a new empty Sun disklabel
   t   change a partition's system id
   u   change display/entry units
   v   verify the partition table
   w   write table to disk and exit
   x   extra functionality (experts only)

Command (m for help): p

Disk /dev/sdc: 599.6 GB, 599550590976 bytes, 1170997248 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x736b5bde

   Device Boot      Start         End      Blocks   Id  System

Command (m for help): m
Command action
   a   toggle a bootable flag
   b   edit bsd disklabel
   c   toggle the dos compatibility flag
   d   delete a partition
   g   create a new empty GPT partition table
   G   create an IRIX (SGI) partition table
   l   list known partition types
   m   print this menu
   n   add a new partition
   o   create a new empty DOS partition table
   p   print the partition table
   q   quit without saving changes
   s   create a new empty Sun disklabel
   t   change a partition's system id
   u   change display/entry units
   v   verify the partition table
   w   write table to disk and exit
   x   extra functionality (experts only)     

Command (m for help): n
Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-1170997247, default 2048): 
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-1170997247, default 1170997247): 
Using default value 1170997247
Partition 1 of type Linux and of size 558.4 GiB is set

Command (m for help): m
Command action
   a   toggle a bootable flag
   b   edit bsd disklabel
   c   toggle the dos compatibility flag
   d   delete a partition
   g   create a new empty GPT partition table
   G   create an IRIX (SGI) partition table
   l   list known partition types
   m   print this menu
   n   add a new partition
   o   create a new empty DOS partition table
   p   print the partition table
   q   quit without saving changes
   s   create a new empty Sun disklabel
   t   change a partition's system id
   u   change display/entry units
   v   verify the partition table
   w   write table to disk and exit
   x   extra functionality (experts only)

Command (m for help): v
Remaining 2047 unallocated 512-byte sectors

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
[heat-admin@overcloud-compute-3 ~]$

```

Make File System with ext3 
==========================
```
[heat-admin@overcloud-compute-3 ~]$ sudo mkfs.ext3 /dev/sdc
mke2fs 1.42.9 (28-Dec-2013)
/dev/sdc is entire device, not just one partition!
Proceed anyway? (y,n) y
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
36593664 inodes, 146374656 blocks
7318732 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=4294967296
4467 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
	4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968, 
	102400000

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information:          
done

```

Note the Block ID of that disk 
===============================

```
[heat-admin@overcloud-compute-3 ~]$ sudo blkid /dev/sdc
/dev/sdc: UUID="942c19b5-c5d3-49e3-a097-57f431ef3034" SEC_TYPE="ext2" TYPE="ext3"
```

Create the mount point Directory:-
===================================
Directory permission need to set cinder:cinder to access the files and folders.

```
[heat-admin@overcloud-compute-3 mnt]$ sudo mkdir -p cinder_storage
```

Mount the Block Disk to mount point:-
====================================
```
[heat-admin@overcloud-compute-3 cinder_storage]$ sudo mount /dev/sdc /mnt/cinder_storage
```

Verify the disk filesystem :-
============================
```
[heat-admin@overcloud-compute-3 mnt]$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda2       3.7T   24G  3.7T   1% /
devtmpfs        126G     0  126G   0% /dev
tmpfs           126G     0  126G   0% /dev/shm
tmpfs           126G  1.5M  126G   1% /run
tmpfs           126G     0  126G   0% /sys/fs/cgroup
tmpfs            26G     0   26G   0% /run/user/1000
/dev/sdc        550G   70M  522G   1% /mnt/cinder_storage

```
NFS Server Configuration:
=========================

**Verify nfs packages are in place on Server as well as Client**

```
rpm -qa | grep nfs-utils

```

**If not install based on your Linux Distro**
```
yum -y install nfs-utils

systemctl enable nfs-server.service
systemctl start nfs-server.service

```
**Export file will allow the remote permission**

```
[heat-admin@overcloud-compute ~]$ cat /etc/exports
/mnt/cinder_storage *(rw,no_root_squash)

[heat-admin@overcloud-compute ~]$ exportfs -a

```

Mount the remote Volume in Local
==================================

Clear the iptables -F if any firewall issue that will easily mount NFS 

```
sudo mkdir -p cinder_remote

sudo mount -t nfs -o rw,nosuid 172.17.132.8:/mnt/cinder_storage /cinder_remote
```


Cinder configuration Change for NFS:- 
====================================

**verify the services in openstack related to Cinder**
```
  sudo systemctl status openstack-cinder-volume.service
  sudo systemctl status openstack-cinder-scheduler.service
  sudo systemctl status openstack-cinder-backup.service
```

```
openstack-config --set /etc/cinder/cinder.conf DEFAULT nfs_shares_config /etc/cinder/nfsshares
```
**Add the below lines in /etc/cinder/cinder.conf for NFS volumes to use Cinder**
```
enabled_backends = tripleo_iscsi,nfs

[nfs]
volume_backend_name = nfs
nfs_shares_config=/etc/cinder/nfsshares
volume_driver = cinder.volume.drivers.nfs.NfsDriver
```
**File contains the remote volume location**
```
[heat-admin@cloud-controller ~]$ sudo cat /etc/cinder/nfsshares
172.17.196.7:/mnt/cinder_storage
```


