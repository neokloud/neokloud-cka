# Step 1 – Prepare hostPath directory

## 1.1 List nodes
```bash
kubectl get nodes -o wide
```

## 1.2 Access worker node
```bash
ssh node01
```

## 1.3 Ensure /mnt/data exists
```bash
mkdir -p /mnt/data
ls /mnt/data
```
