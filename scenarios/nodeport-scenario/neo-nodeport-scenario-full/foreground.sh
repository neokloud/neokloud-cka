#!/bin/bash
# Lab setup script for Neo NodePort Scenario

# Create namespace if not exists
kubectl get ns neokloud >/dev/null 2>&1 || kubectl create namespace neokloud

# Create the initial Deployment with 1 replica and app-front=nginx label
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: neo-depl
  namespace: neokloud
spec:
  replicas: 1
  selector:
    matchLabels:
      app-front: nginx
  template:
    metadata:
      labels:
        app-front: nginx
    spec:
      containers:
      - name: web
        image: nginx
        ports:
        - containerPort: 80
EOF
