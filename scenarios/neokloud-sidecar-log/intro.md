## Task: Add Sidecar Container to Tail Logs

You have a Deployment named `neokloud-deployment` with a container writing logs to `/var/log/neokloud.log`.

---

### Goal

Update the existing deployment to add a **sidecar container**:
- **Name**: `sidecar`
- **Image**: `busybox:stable`
- **Command**: `tail -f /var/log/neokloud.log`
- **Volume**: `emptyDir`
- **Mount Path**: `/var/log` (shared between both containers)

---

### Step 1: Make Scenario 

Since the deployment YAML may not be preloaded, download it manually:

```bash
wget https://raw.githubusercontent.com/neokloud/argocd-lab/main/scenarios/neokloud-sidecar-log/deploy/initial-deployment.yaml -O /root/initial-deployment.yaml
kubectl apply -f /root/initial-deployment.yaml
```

### Your Step Now Start your goal

```bash
kubectl get pods
```

### Step 2: Take a Backup (Recommended)
Before editing the deployment, take a backup of the current spec:

```bash
kubectl get deploy neokloud-deployment -o yaml > /root/deploy-backup.yaml

```

### Step 3: Edit the Deployment to Add Sidecar

Edit the deployment using the following command:

```bash
kubectl edit deploy neokloud-deployment

```

### Changes to do

Inside the editor:

Add this sidecar container under `spec.template.spec.containers`:

```yaml
- name: sidecar
  image: busybox:stable
  command: ["/bin/sh", "-c", "tail -f /var/log/neokloud.log"]
  volumeMounts:
    - name: shared-logs
      mountPath: /var/log
```
Add this volumeMounts block to the existing container (e.g., monitor):

```yaml
volumeMounts:
  - name: shared-logs
    mountPath: /var/log
```

Add this volumes block under `spec.template.spec`:

```yaml
volumes:
  - name: shared-logs
    emptyDir: {}
```
Save and exit from the editor.

Step 4: Verify Your Changes

Check if the updated pod is running:

```bash
kubectl get pods
```

Get the exact pod name, then:

```bash
kubectl describe pod <pod-name>
kubectl logs -f <pod-name> -c sidecar
```

You should now see the sidecar container tailing `/var/log/neokloud.log`.
