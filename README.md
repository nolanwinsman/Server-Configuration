# Server-Configuration
I'm setting up a server using Proxmox to host a virtual machine (VM) running Ubuntu Server, which will serve as a Plex media server. The server will have 8 x 18TB HDDs configured in a ZFS pool for mass storage, providing redundancy in case of a single drive failure. The system will also include SSDs for caching to speed up media access and downloads. Media files will be downloaded to the SSD cache and then transferred to the ZFS storage pool for long-term storage. This setup ensures a reliable, high-capacity, and high-performance environment for hosting and streaming media while maintaining data integrity and redundancy.

## [Server Specs](docs/server_specs.md)

# Configuration Steps

## 1: Install Proxmox

## 2: [Create Ubuntu Server VM](docs/ubuntu_vm_setup.md)

## 3: [ZFS Setup on Proxmox and Ubuntun VM](docs/zfs_setup.md)

## 4: [Setup Docker on Ubuntu VM](docs/docker_setup.md)

## 5: [Qbittorrent Docker Setup with VPN](docs/)