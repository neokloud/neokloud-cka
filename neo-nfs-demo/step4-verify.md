# Step 4: Verify

```
kubectl exec -it neo-nfs-demo -c writer -- sh
ls /data
cat /data/index.html
```

```
kubectl exec -it neo-nfs-demo -c web -- sh
ls /usr/share/nginx/html
cat /usr/share/nginx/html/index.html
```

```
cat /srv/nfs/demo/index.html
mount | grep nfs
```