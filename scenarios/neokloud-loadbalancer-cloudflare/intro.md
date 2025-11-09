# LoadBalancer Service (via Cloudflare)

Welcome to this Neokloud CKA Lab scenario 🎯  
In this exercise, you'll learn how to expose an NGINX app using a **LoadBalancer Service** inside Killercoda — even though there’s no real cloud load balancer available!

We’ll use **MetalLB** to assign internal IPs and **Cloudflare Tunnel** to expose your app publicly.

---

## 🚀 Step 1 — Deploy NGINX App

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: neokloud-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: neokloud
  template:
    metadata:
      labels:
        app: neokloud
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: neokloud-svc
spec:
  type: LoadBalancer
  selector:
    app: neokloud
  ports:
  - port: 80
    targetPort: 80
EOF

kubectl get pods -l app=neokloud
```

---

## ⚙️ Step 2 — Install MetalLB

```bash
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.3/config/manifests/metallb-native.yaml
```

Wait for the controller and speaker pods to reach `1/1 Running`:

```bash
kubectl get pods -n metallb-system -w
```

---

## 🌐 Step 3 — Configure MetalLB IP Range

```bash
cat <<EOF | kubectl apply -f -
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default-pool
  namespace: metallb-system
spec:
  addresses:
  - 172.30.1.100-172.30.1.120
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default-advert
  namespace: metallb-system
EOF
```

Check the external IP:

```bash
kubectl get svc neokloud-svc -w
```

Once you see an IP like **172.30.1.100**, verify it:

```bash
curl http://172.30.1.100
```

---

## ☁️ Step 4 — Install Cloudflare Tunnel

```bash
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared-linux-amd64.deb
cloudflared --version
```

---

## 🔓 Step 5 — Expose App via Cloudflare Tunnel

```bash
cloudflared tunnel --url http://172.30.1.100
```

You’ll see output like:

```
Your quick Tunnel has been created! Visit it at:
https://<random-name>.trycloudflare.com
```

That’s your **public HTTPS endpoint** for the NGINX app 🎉

Optionally, map your DNS (e.g., `neokloud.in`) as a **CNAME → <random-name>.trycloudflare.com** for custom domain access.
