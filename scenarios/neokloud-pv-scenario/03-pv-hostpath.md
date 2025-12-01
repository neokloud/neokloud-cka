# Step 2 – Create PersistentVolume

File: `neokloud-pv-hostpath.yaml`

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: neokloud-pv-hostpath
  labels:
    type: hostpath
spec:
  storageClassName: manual
  capacity:
    storage: 500Mi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: "/mnt/data"
```

Apply:
```bash
kubectl apply -f neokloud-pv-hostpath.yaml
kubectl get pv -o wide
```
