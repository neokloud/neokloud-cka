# Step 1: Create PriorityClass
Run:
```bash
kubectl apply -f pod.yaml
```

Example YAML:
```yaml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 100000
globalDefault: false
description: "High priority class"
```
