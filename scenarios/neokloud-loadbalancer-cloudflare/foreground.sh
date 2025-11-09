#!/bin/bash
echo "🚀 Setting up Neokloud LoadBalancer (via Cloudflare) Scenario..."
kubectl cluster-info >/dev/null 2>&1

# Deploy NGINX app
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

echo "✅ NGINX app deployed. Installing MetalLB..."
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.3/config/manifests/metallb-native.yaml
echo "⏳ Waiting for MetalLB pods..."
kubectl wait --for=condition=available --timeout=90s deployment -n metallb-system controller
echo "✅ MetalLB installed."

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

echo "🎯 MetalLB configured. Run 'kubectl get svc neokloud-svc -w' to see the LoadBalancer IP."
