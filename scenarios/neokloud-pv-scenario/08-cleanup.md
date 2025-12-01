# Step 7 – Cleanup

```bash
kubectl delete pod task-pv-pod
kubectl delete pvc neokloud-pvc-hostpath
kubectl delete pv neokloud-pv-hostpath
rm -rf /mnt/data/*
```
