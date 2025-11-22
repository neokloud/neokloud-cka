# Step 2: Verify Pod Status

Check if the Pod is running:

```
kubectl get pods -o wide
```

Output shows the node where the Pod is scheduled.  
Copy the **NODE IP** — you will curl it next.
