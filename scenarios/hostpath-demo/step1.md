# Step 1: Create the Pod

Apply this YAML:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: neo-web
spec:
  containers:
    - name: neo-web-container
      image: busybox
      command:
        - sh
        - -c
        - |
          mkdir -p /hostdata/www;

          # Append new line every 5 seconds
          while true; do
            echo "Thank you from neokloud $(date)" >> /hostdata/www/index.html;
            sleep 5;
          done &

          # Start BusyBox web server
          httpd -f -p 80 -h /hostdata/www;
      ports:
        - containerPort: 80
      volumeMounts:
        - name: neo-storage
          mountPath: /hostdata

  volumes:
    - name: neo-storage
      hostPath:
        path: /data/neo-website
        type: DirectoryOrCreate
```

Apply it:

```
kubectl apply -f pod.yaml
```
