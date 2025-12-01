# Step 3 – Create PersistentVolumeClaim

File: `neokloud-pvc-hostpath.yaml`

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: neokloud-pvc-hostpath
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 300Mi
```

Apply:
```bash
kubectl apply -f neokloud-pvc-hostpath.yaml
kubectl get pvc -o wide
```
