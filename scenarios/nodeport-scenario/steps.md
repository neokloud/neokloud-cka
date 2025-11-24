# Step-by-step Checklist

1. Create `neokloud` namespace.
2. Create the initial `neo-depl` Deployment with `app-front=nginx`.
3. Save `bc-5-ntouch.yaml` (original deployment) and `bc-5-touch.yaml` (working copy).
4. Edit the live Deployment:
   - Set `replicas: 4`
   - Add label `app: neo` in `spec.template.metadata.labels`
   - Do NOT change the selector (`app-front: nginx`).
5. Create `nodeport.yaml` for the `neo-app` NodePort Service.
6. Apply the service and verify it exists.
7. Get Node IP and NodePort.
8. Test using curl with `http://<NODE-IP>:<NODEPORT>`.
