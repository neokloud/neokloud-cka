# Finish

You have:

- Created namespace `neo-lab`
- Created Secret `neo-db-secret` with keys `dbuser` and `dbtoken`
- Launched Pod `neo-env-pod` consuming the Secret as environment variables
- Verified the variables inside the container

This lab demonstrates how to surface Secret values to containers via environment variables.

**Clean up (optional)**

```bash
kubectl delete pod neo-env-pod -n neo-lab
kubectl delete secret neo-db-secret -n neo-lab
kubectl delete namespace neo-lab
```
