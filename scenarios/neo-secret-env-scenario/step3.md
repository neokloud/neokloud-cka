# Step 3 — Create the Pod and verify environment variables

```
apiVersion: v1
kind: Pod
metadata:
  name: neo-env-pod
  namespace: neo-lab
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["sh", "-c", "sleep 4000"]
    env:
    - name: APP_USER
      valueFrom:
        secretKeyRef:
          name: neo-db-secret
          key: dbuser
    - name: APP_TOKEN
      valueFrom:
        secretKeyRef:
          name: neo-db-secret
          key: dbtoken
```

**Command (copyable) — apply pod manifest**

```bash
kubectl apply -f pod.yaml
```

**Check pod status**

```bash
kubectl -n neo-lab get pod neo-env-pod -o wide
```

**Open a shell inside the running container**

```bash
kubectl -n neo-lab exec -it neo-env-pod -- sh
```

**Inside the container, verify environment variables**

Run these commands inside the container shell:

```bash
echo "$APP_USER"
echo "$APP_TOKEN"
```

Expected output:

```
neokloud
N3o@Secure!55
```

If the variables are empty, check:

- That the Secret exists in `neo-lab`
- That the `valueFrom.secretKeyRef.name` and `key` values are correct in `pod.yaml`
