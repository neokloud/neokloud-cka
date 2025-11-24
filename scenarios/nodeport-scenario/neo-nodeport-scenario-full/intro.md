# Neo NodePort Service Practice

You are working in the `neokloud` namespace.

A Deployment named `neo-depl` already exists (or will be created by the lab).  
Your task is to update it and expose it using a NodePort Service.

---

## 1. Check the Cluster and Namespace

```bash
kubectl get nodes
kubectl get ns
```

If `neokloud` does not exist, it will be created for you by the lab script.

---

## 2. Starting State (What the Lab Provides)

The lab creates a Deployment like this:

```yaml
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
```

You can confirm with:

```bash
kubectl -n neokloud get deploy neo-depl
kubectl -n neokloud get pods -o wide
```

---

## 3. Save Deployment YAML (no-touch copy)

Create a backup of the original Deployment:

```bash
kubectl -n neokloud get deployments.apps neo-depl -o yaml > bc-5-ntouch.yaml
cat bc-5-ntouch.yaml
```

This is just for reference.

---

## 4. Task Requirements

You must:

1. **Modify the Deployment** `neo-depl` so that:
   - The pod template includes the label: `app=neo`
   - The Deployment runs **4 replicas**

2. **Create a NodePort Service** named `neo-app` in the `neokloud` namespace that:
   - Listens on TCP port `8080`
   - Selects the pods from the updated `neo-depl` Deployment
   - Uses a valid NodePort value assigned automatically by Kubernetes

You will do all of this using normal `kubectl` commands and YAML files.

---

## 5. Edit the Deployment

Use:

```bash
kubectl -n neokloud edit deployments.apps neo-depl
```

In the editor, ensure the spec looks like this (focus on these fields):

```yaml
spec:
  replicas: 4
  selector:
    matchLabels:
      app-front: nginx    # IMPORTANT: selector stays the same (immutable)
  template:
    metadata:
      labels:
        app-front: nginx  # original label
        app: neo          # new label required by the task
```

Save and exit.

Verify:

```bash
kubectl -n neokloud get deploy neo-depl
kubectl -n neokloud get pods -n neokloud -o wide
```

You should now see 4 pods running.

---

## 6. Create the NodePort Service

Create a file named `nodeport.yaml`:

```bash
vi nodeport.yaml
```

Put this content in the file:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: neo-app
  namespace: neokloud
spec:
  type: NodePort
  selector:
    app-front: nginx
  ports:
  - port: 8080
    targetPort: 80
    protocol: TCP
```

Apply it:

```bash
kubectl apply -f nodeport.yaml
```

Check the service:

```bash
kubectl get svc -n neokloud neo-app
```

Example output:

```text
neo-app   NodePort   10.98.161.126   <none>   8080:30869/TCP   10s
```

Here:
- `8080` is the Service port
- `30869` is the automatically assigned NodePort

---

## 7. Get the Node IP

```bash
kubectl get nodes -o wide
```

Example:

```text
NAME           STATUS   ROLES           AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
controlplane   Ready    control-plane   6d23h   v1.34.1   172.30.1.2    <none>        Ubuntu 24.04.3 LTS   6.8.0-51-generic   containerd://1.7.28
```

So the node IP in this example is: `172.30.1.2`.

---

## 8. Test Using Node IP + NodePort

Use curl from the node:

```bash
NODE_IP=172.30.1.2      # replace with your node IP
NODE_PORT=$(kubectl get svc neo-app -n neokloud -o jsonpath='{.spec.ports[0].nodePort}')

curl http://$NODE_IP:$NODE_PORT
```

You should see the nginx welcome page HTML:

```html
<h1>Welcome to nginx!</h1>
```

If you see that, your Deployment and Service are correctly configured.

---

## End of Introduction

Once you’ve done all of this, continue to the next tab for a brief checklist and a recap of what you practiced.
