# Step 4: Delete and Recreate Pod

Delete the Pod:

```
kubectl delete pod neo-web
```

Recreate:

```
kubectl apply -f pod.yaml
```

This tests persistence of HostPath.
