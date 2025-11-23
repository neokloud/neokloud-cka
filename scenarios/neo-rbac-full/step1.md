# Fix Application Pod That Fails Because of Missing RBAC

You are a Kubernetes administrator.

A developer applied the Deployment **neo-depl** in the **neo** namespace.

The application pod is running, but its logs are full of RBAC errors:
User "system:serviceaccount:neo:default" cannot list resource "deployments" in API group "apps" in the namespace "neo"
text**Task**

1. Look at the pod logs and confirm the exact error.
2. Fix the permissions so that the pod can successfully execute `kubectl get deployments -n neo` inside the container.
3. After the fix, the pod logs must show successful output with no Forbidden errors.

**Resources available**
- The Deployment manifest is located at **/home/files/neo-depl.yaml** (you may read it)
- You have full cluster-admin rights
- Do NOT change the container image or the command — only fix RBAC

Score: 6% of the CKAD exam (Core Concepts + Configuration)

Time starts now — good luck!
