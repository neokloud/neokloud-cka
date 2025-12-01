# Step 6 – Persistence Demo

Delete pod:
```bash
kubectl delete pod task-pv-pod
```

Check data on node:
```bash
ls /mnt/data
cat /mnt/data/index.html
```

Recreate pod and test again.
