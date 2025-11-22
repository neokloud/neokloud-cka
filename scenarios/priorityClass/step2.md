# Step 2: Pod using PriorityClass
Apply:
```bash
kubectl apply -f pod.yaml
```

Pod YAML:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: highpod
spec:
  priorityClassName: high-priority
  containers:
  - name: c1
    image: nginx
```
