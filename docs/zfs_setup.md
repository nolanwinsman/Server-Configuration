# ZFS Setup

I'm creating a ZFS storage pool on your Proxmox server using 8 x 18TB HDDs, which will be used by an Ubuntu VM for mass storage. The ZFS setup will provide redundancy, allowing the system to tolerate the failure of one hard drive without losing data. This ensures both reliability and high capacity for storing large amounts of data while maintaining data integrity.

### Initial Setup Proxmox

### ZFS Pool

#### Create ZFS Pool on the Proxmox Host

If ZFS isn’t already installed on Proxmox, you can install it.

```sh
apt update
apt install zfsutils-linux -y
```

Identify what drives I want to use the for the ZFS pool. I have eight HDDs and I want to add them all in a raidz1 pool so that I can sustain one drive failure. I had to use the `-f` flag to force it.

```sh
zpool create pool raidz1 /dev/sda /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh -f
```

Verify the pool was created

```sh
zpool status
```

#### Share the ZFS Pool Using NFS

Use NFS to share the ZFS pool with the Ubuntu VM. Install the necessary packages:

```sh
apt install nfs-kernal-server
```

Create an export configuration for NFS by editing the `/etc/exports` file

```sh
/pool *(rw,sync,no_subtree_check,no_root_squash)
```

Apply the export settings

```sh
exportfs -a
```

#### Mount the ZFS Pool in the Ubuntu VM

1. Install NFS Client on Ubuntu VM

```sh
sudo apt install nfs-common -y
```

2. Create a directory where the ZFS pool will be mounted

```sh
sudo mkdir /mnt/hdds
```

3. Mount the NFS Share

```sh
sudo mount <Proxmox_IP>:/pool /mnt/hdds
```

4. Automate the Mount on Boot

```sh
sudo vim /etc/fstab
```


```sh
<Proxmox_IP>:/pool /mnt/hdds nfs defaults 0 0
```

5. Verify the Mount

```sh
df -h
```


