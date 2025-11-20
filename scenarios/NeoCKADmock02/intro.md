# NeoCKADmock02 CPU & Logs Scenario

This scenario contains two CKAD-style tasks:  
1. Deploy a log-producing pod and save logs  
2. Install Metrics Server, create CPU stress pods, and write highest CPU pod name to a file

---

## ✔ TASK 1 — Deploy pod & collect logs

You have been given the following pod manifest:

### **neopod.yaml**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: neopod
spec:
  containers:
  - name: logger
    image: busybox
    command: ["sh","-c","while true; do echo 'neopod log entry'; sleep 1; done"]

Commands to run:
kubectl create -f neopod.yaml
kubectl get pod neopod
kubectl logs neopod > /var/log/pod-log.txt

✔ TASK 2 — CPU usage & write highest CPU pod name

Create namespace:

kubectl create namespace cpu-stress

stress-pod-1.yaml
apiVersion: v1
kind: Pod
metadata:
  name: stress-pod-1
  namespace: cpu-stress
spec:
  containers:
  - name: load
    image: busybox
    command: ["sh","-c","while true; do echo 'CPU Test 1'; done"]

stress-pod-2.yaml
apiVersion: v1
kind: Pod
metadata:
  name: stress-pod-2
  namespace: cpu-stress
spec:
  containers:
  - name: load
    image: busybox
    command: ["sh","-c","while true; do echo 'CPU Test 2'; done"]


Apply both:

kubectl apply -f stress-pod-1.yaml
kubectl apply -f stress-pod-2.yaml

✔ Install Metrics Server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml


Patch it:

kubectl -n kube-system patch deployment metrics-server \
  --type='json' \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'


Wait for rollout:

kubectl rollout status deployment metrics-server -n kube-system


Verify API:

kubectl get apiservice v1beta1.metrics.k8s.io

✔ Check CPU usage
kubectl top pods -n cpu-stress


Identify the pod consuming highest CPU (example: stress-pod-1)

Write its name to:

echo stress-pod-1 > /var/log/pod-log-utilization.txt

🎯 Scenario Complete!
cat /var/log/pod-log.txt
cat /var/log/pod-log-utilization.txt


You have now completed the full CKAD-style task.
