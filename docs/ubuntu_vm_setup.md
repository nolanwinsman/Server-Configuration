# Ubuntu Server VM Install

Created an Ubuntu Server VM in Proxmox and gave it the majority of my hardware. Full CPU, Most the RAM and 1.8TB from my 2TB ssds

Then went through basic Ubuntu Server setup making sure to enable openssh.


## Packages

```sh
apt install vim
apt install tree
apt install unrar
apt install p7zip-full
apt install ffmpeg
```

## Allocate Remaining SSD Space

I had an issue where my 1.8TB SSD was configured with an LVM (Logical Volume Management) setup, but only 100GB of the available space was allocated to the logical volume used for my root filesystem (/). The remaining 1.7TB of space in the volume group was unallocated and not accessible. To fix this, the logical volume was extended to use all the free space in the volume group, and the filesystem was resized to fill the newly expanded volume. This allowed the full capacity of the SSD to be recognized and utilized.

```sh
# Extend the logical volume to use all available space
sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
```

```sh
# Resize the filesystem to use the extended space
sudo resize2fs /dev/ubuntu-vg/ubuntu-lv
```

```sh
# Verify the new disk space
df -h
```
