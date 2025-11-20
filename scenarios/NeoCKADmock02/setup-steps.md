# Setup Steps

1. kubectl create -f neopod.yaml
2. kubectl logs neopod > /var/log/pod-log.txt
3. kubectl create namespace cpu-stress
4. kubectl apply -f stress-pod-1.yaml
5. kubectl apply -f stress-pod-2.yaml
6. kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
7. kubectl -n kube-system patch deployment metrics-server --type='json' -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'
8. kubectl rollout status deployment metrics-server -n kube-system
9. kubectl top pods -n cpu-stress
10. echo <podname> > /var/log/pod-log-utilization.txt
