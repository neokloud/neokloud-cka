# Steps.md – Fix Pod Logging RBAC Errors (CKAD Style)

1. **Check the current logs of the application pod**  
   ```bash
   kubectl logs -n neo -l app=neo-app --tail=50
→ You will see repeated Forbidden errors about deployments.apps

Confirm you see the Forbidden error about deployments.apps
Just type: yes (or observe the error)
Create a Role in neo namespace that allows listing deploymentsBashcat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: deployment-lister
  namespace: neo
rules:
- apiGroups: ["apps"]
  resources: ["deployments"]
  verbs: ["get", "list"]
EOF
Create a RoleBinding to bind the default ServiceAccount to this RoleBashcat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: default-deployment-lister
  namespace: neo
subjects:
- kind: ServiceAccount
  name: default
  namespace: neo
roleRef:
  kind: Role
  name: deployment-lister
  apiGroup: rbac.authorization.k8s.io
EOF
Restart the Deployment so the pod picks up the new permissions cleanly
(CKAD examiners love this command)Bashkubectl rollout restart deployment neo-depl -n neo
Wait for the new pod to be ReadyBashkubectl get pods -n neo -l app=neo-app -w(Press Ctrl+C once you see 1/1 Running)
Check the logs again — they must now show successful output
Best CKAD way: show only fresh logs and stream new onesBashkubectl logs -n neo -l app=neo-app --tail=20 -f
Final verification — no more Forbidden errorsBashkubectl logs -n neo -l app=neo-app --tail=30→ You should only see:textChecking deployments...
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
neo-depl   1/1     1            1           ...
