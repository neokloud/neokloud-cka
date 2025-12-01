# Step 4 – Create Pod using PVC and hostPort

File: `task-pv-pod.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: task-pv-pod
spec:
  volumes:
    - name: neokloud-pv-hostpath
      persistentVolumeClaim:
        claimName: neokloud-pvc-hostpath
  containers:
    - name: task-pv-container
      image: nginx
      ports:
        - containerPort: 80
          hostPort: 8090
          protocol: TCP
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: neokloud-pv-hostpath
```

Apply:
```bash
kubectl apply -f task-pv-pod.yaml
kubectl get pod -o wide
```
