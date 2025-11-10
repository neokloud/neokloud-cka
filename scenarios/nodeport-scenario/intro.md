# NodePort Service Practice

Welcome to the NodePort Service Practice Lab!

In this scenario, you'll:
1. Deploy a backend NGINX deployment.
2. Expose it using a NodePort service.
3. Deploy a frontend curl pod to test connectivity.
4. Access the backend using the NodePort.

Use the YAML files already placed in `/root/` to begin:
```bash
kubectl apply -f /root/backend-deploy.yaml
kubectl apply -f /root/backend-svc.yaml
kubectl apply -f /root/frontend-deploy.yaml
```

Then test access:
```bash
kubectl exec -it deploy/frontend-deploy -- sh
curl backend-svc
```

Let's get started!
