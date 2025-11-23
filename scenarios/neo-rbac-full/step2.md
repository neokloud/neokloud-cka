Step 1 — Create Namespace and Directory

You are preparing the environment for a CKAD-style RBAC troubleshooting scenario.

Run these commands:

```

kubectl create namespace neo
```
```
mkdir -p /home/files/
```

Step 1 — Prepare the Deployment File

Create the file:
```
vi /home/files/neo-depl.yaml
```

Paste the full Deployment manifest exactly as below:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: neo-depl
  namespace: neo
spec:
  replicas: 1
  selector:
    matchLabels:
      app: neo-app
  template:
    metadata:
      labels:
        app: neo-app
    spec:
      serviceAccountName: default
      containers:
      - name: api-checker
        image: bitnami/kubectl:latest
        command: ["sh", "-c"]
        args:
          - while true; do
              echo "Checking deployments...";
              kubectl get deployments -n neo;
              sleep 5;
            done

```
This Deployment guarantees that the Pod logs will show RBAC errors:

User "system:serviceaccount:neo:default" cannot list resource "deployments" in API group "apps" in the namespace "neo"

Step 1 — Apply the Broken Deployment

Apply it to create the failing Pod:
```
kubectl apply -f /home/files/neo-depl.yaml
```

This creates:

• Deployment neo-depl in namespace neo
• A Pod running a loop calling kubectl get deployments
• The Pod immediately begins logging RBAC failures

Step 1 — Verify Logs

Check what the Pod is printing:
```
kubectl logs -n neo -l app=neo-app
```

You should see:

Checking deployments...
Error from server (Forbidden): deployments.apps is forbidden: 

User "system:serviceaccount:neo:default" 

cannot list resource "deployments" in API group "apps" in the namespace "neo"
