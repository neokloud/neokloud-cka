# Step 1: Set Up NFS Server

```
sudo mkdir -p /srv/nfs/demo
sudo chmod -R 777 /srv/nfs/demo
sudo apt update
sudo apt install -y nfs-kernel-server

echo "/srv/nfs/demo *(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports
sudo exportfs -rav
sudo exportfs -v
```