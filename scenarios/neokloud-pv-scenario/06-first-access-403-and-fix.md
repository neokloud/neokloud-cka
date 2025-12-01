# Step 5 – Test NGINX & Fix 403 Forbidden

Test:
```bash
curl <NODE_IP>:8090
```

Create index.html:
```bash
kubectl exec -it task-pv-pod -- bash
echo "<h1>Welcome to NeoKloud PV Session !!!</h1>" > /usr/share/nginx/html/index.html
exit
```

Test again:
```bash
curl <NODE_IP>:8090
```
