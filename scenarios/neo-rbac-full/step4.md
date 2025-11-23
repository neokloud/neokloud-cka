Force clean logs by restarting pod
```
kubectl rollout restart deployment neo-depl -n neo
```
Check new pod
```
kubectl get pods -n neo -l app=neo-app
```
Show fresh logs
```
kubectl logs -n neo -l app=neo-app --tail=20
```
Stream fresh logs
```
kubectl logs -n neo -l app=neo-app -f
```

### Why logs become fresh  
Each pod has its own log directory:


```
/var/log/pods/<pod_uid>/<container_name>/
```

When a new pod is created:

- New UID  
- New log folder  
- Old logs disappear automatically  

### Logs for a specific pod

```
kubectl get pods -n neo -l app=neo-app
kubectl logs <pod-name> -n neo
```

### Logs from previous crashed container

```
kubectl logs <pod-name> -n neo --previous
```
