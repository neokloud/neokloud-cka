# Scenario 4 - NodePort Service on Killercoda

## Step 1 — Create Backend Deployment
kubectl apply -f backend-deploy.yaml

## Step 2 — Create a NodePort Service
kubectl apply -f backend-svc.yaml

## Step 3 — Create Frontend Pod (curl client)
kubectl apply -f frontend-deploy.yaml

## Step 4 — Verify and Access
kubectl get deployments
kubectl get svc
kubectl exec -it <frontend-pod> -- sh
curl backend-svc

## Step 5 — Access NodePort externally
kubectl get nodes -o wide
curl http://<node-ip>:30080

Browser access not possible in Killercoda.
