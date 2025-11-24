# Neo NodePort Service Scenario

You are working in the `neokloud` namespace.

A Deployment named `neo-depl` already exists (or will be created by you in this scenario).  
Your task is to update it and expose it using a NodePort Service.

---

## 1. Create Namespace

```bash
kubectl create namespace neokloud
```

Verify:

```bash
kubectl get ns | grep neokloud
```

---

## 2. Create the initial Deployment (lab starting point)

This simulates the state described in the exam-style question.

```bash
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
```

Check deployment and pods:

```bash
kubectl -n neokloud get deploy neo-depl
kubectl -n neokloud get pods -o wide
```

---

## 3. Save original Deployment YAML (no-touch copy)

```bash
kubectl -n neokloud get deployments.apps neo-depl -o yaml > bc-5-ntouch.yaml
cat bc-5-ntouch.yaml
```

This file represents the original, untouched state.

---

## 4. Save editable Deployment YAML (touch copy)

```bash
kubectl -n neokloud get deployments.apps neo-depl -o yaml > bc-5-touch.yaml
cat bc-5-touch.yaml
```

You can use this as a working copy if needed.

---

## 5. Edit the live Deployment as per the task

Requirement recap:

- The pod template must include the label `app=neo`
- The Deployment must run **4 replicas**

Edit the live deployment:

```bash
kubectl -n neokloud edit deployments.apps neo-depl
```

Inside the editor, make sure your Deployment spec has:

```yaml
spec:
  replicas: 4
  selector:
    matchLabels:
      app-front: nginx     # selector must stay the same, immutable
  template:
    metadata:
      labels:
        app-front: nginx   # original label
        app: neo           # required new label
```

Save and exit the editor.

Verify:

```bash
kubectl -n neokloud get deploy neo-depl
kubectl -n neokloud get pods -n neokloud -o wide
```

You should now see 4 replicas.

---

## 6. Create NodePort Service manifest

Create a file named `nodeport.yaml`:

```bash
vi nodeport.yaml
```

Put the following content:

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

This service:

- Is named `neo-app`
- Is in namespace `neokloud`
- Is of type `NodePort`
- Listens on TCP port `8080`
- Selects pods from the updated `neo-depl` Deployment via `app-front: nginx`

Apply the service:

```bash
kubectl apply -f nodeport.yaml
```

Verify:

```bash
kubectl get svc -n neokloud neo-app
```

You should see output similar to:

```text
neo-app   NodePort   10.98.161.126   <none>   8080:30869/TCP   10s
```

Here `30869` is the auto-assigned NodePort.

---

## 7. Get the Node IP

```bash
kubectl get nodes -o wide
```

Example output:

```text
NAME           STATUS   ROLES           AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
controlplane   Ready    control-plane   6d23h   v1.34.1   172.30.1.2    <none>        Ubuntu 24.04.3 LTS   6.8.0-51-generic   containerd://1.7.28
```

So the Node IP is: `172.30.1.2` (in this example).

---

## 8. Test the Service via Node IP + NodePort

Use `curl` from the node:

```bash
curl http://172.30.1.2:30869
```

You should see the default nginx welcome page HTML, something like:

```html
<h1>Welcome to nginx!</h1>
```

This confirms that:

- The Deployment is scaled to 4 replicas
- The `app=neo` label is added on the pod template
- The NodePort service `neo-app` works correctly using the node IP and NodePort

---

## End of Scenario

You have successfully:

- Updated an existing Deployment (`neo-depl`) in namespace `neokloud`
- Added the required label `app=neo`
- Scaled the Deployment to 4 replicas
- Created and tested a NodePort Service `neo-app` that exposes it on TCP port 8080
