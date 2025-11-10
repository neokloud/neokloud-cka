# NodePort Service Practice

Welcome to the **NodePort Service Practice Lab!**

In this scenario you will:

1. Deploy a backend NGINX deployment.
2. Expose it using a NodePort service.
3. Deploy a frontend curl client to test connectivity.
4. Access the backend using the NodePort.

---

## 📂 YAML Files

You can open each YAML directly from GitHub:

- [backend-deploy.yaml](https://github.com/neokloud/neokloud-cka/blob/main/scenarios/nodeport-scenario/backend-deploy.yaml)
- [backend-svc.yaml](https://github.com/neokloud/neokloud-cka/blob/main/scenarios/nodeport-scenario/backend-svc.yaml)
- [frontend-deploy.yaml](https://github.com/neokloud/neokloud-cka/blob/main/scenarios/nodeport-scenario/frontend-deploy.yaml)

---

## 🧩 Commands to Apply

```bash
kubectl apply -f https://raw.githubusercontent.com/neokloud/neokloud-cka/main/scenarios/nodeport-scenario/backend-deploy.yaml
kubectl apply -f https://raw.githubusercontent.com/neokloud/neokloud-cka/main/scenarios/nodeport-scenario/backend-svc.yaml
kubectl apply -f https://raw.githubusercontent.com/neokloud/neokloud-cka/main/scenarios/nodeport-scenario/frontend-deploy.yaml
```

---

## ✅ Verify

```bash
kubectl get pods
kubectl get svc
```

Access the backend inside the frontend pod:
```bash
kubectl exec -it deploy/frontend-deploy -- sh
curl backend-svc
```

---

When finished, check that NodePort access works:
```bash
kubectl get nodes -o wide
curl http://<node-ip>:30080
```

Happy learning!
