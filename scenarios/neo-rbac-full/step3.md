Step 2 – Fix RBAC: Role and RoleBinding
Create Role
```
vi role.yaml
```

Paste:


```
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
name: neo-role
namespace: neo
rules:

apiGroups: ["apps"]
resources: ["deployments"]
verbs: ["get", "list"]
```

Apply:


```
kubectl apply -f role.yaml
```
## Create RoleBinding

```
vi rolebinding.yaml
```

Paste:


```
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
name: neo-rb
namespace: neo
subjects:

kind: ServiceAccount
name: default
namespace: neo
roleRef:
kind: Role
name: neo-role
apiGroup: rbac.authorization.k8s.io

```
Apply:


```
kubectl apply -f rolebinding.yaml
```
# Step 3 – Restart Deployment and Re-check Logs

## Restart deployment

```
kubectl rollout restart deployment neo-depl -n neo
```
## Verify new pod
```
kubectl get pods -n neo -l app=neo-app
```

## Check logs again

```
kubectl logs -n neo -l app=neo-app

```
Expected output now:

vbnet
Copy code
Checking deployments...
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
neo-depl    1/1     1            1           ...
RBAC errors should be gone.

Useful log commands
Show last 20 lines:

```
kubectl logs -n neo -l app=neo-app --tail=20
```
Follow live logs:

```
kubectl logs -n neo -l app=neo-app -f
```
Tail + follow:

```
kubectl logs -n neo -l app=neo-app --tail=10 -f
```




