# Step-by-step Checklist

1. Verify the cluster and that `neokloud` namespace exists.
2. Confirm the starting Deployment `neo-depl` with label `app-front=nginx` and 1 replica.
3. Save a backup of the Deployment to `bc-5-ntouch.yaml`.
4. Edit the live Deployment using `kubectl edit`:
   - Set `spec.replicas` to `4`.
   - Keep `spec.selector.matchLabels.app-front: nginx` (do not change selector).
   - Add label `app: neo` under `spec.template.metadata.labels`.
5. Create `nodeport.yaml` for a `NodePort` Service named `neo-app` on port `8080` with selector `app-front=nginx`.
6. Apply the Service and confirm it exists with `kubectl get svc -n neokloud neo-app`.
7. Get the node IP using `kubectl get nodes -o wide`.
8. Use `curl http://<NODE-IP>:<NODEPORT>` to confirm nginx is reachable via the NodePort Service.
