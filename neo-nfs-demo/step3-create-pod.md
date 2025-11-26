# Step 3: Create Pod

```
cat <<EOF > neo-nfs-demo.yaml
apiVersion: v1
kind: Pod
metadata:
  name: neo-nfs-demo
spec:
  containers:
  - name: writer
    image: alpine
    command: ["/bin/sh"]
    args:
      - -c
      - |
        while true; do
          echo "Written at: $(date)" >> /data/index.html;
          sleep 5;
        done
    volumeMounts:
      - name: shared-data
        mountPath: /data

  - name: web
    image: nginx
    ports:
      - containerPort: 80
    volumeMounts:
      - name: shared-data
        mountPath: /usr/share/nginx/html

  volumes:
  - name: shared-data
    nfs:
      server: 172.30.1.2
      path: /srv/nfs/demo
EOF

kubectl apply -f neo-nfs-demo.yaml
kubectl get pods
```
