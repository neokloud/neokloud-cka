# Step 2 — Create the Secret `neo-db-secret`

**Explanation**

Create a generic Secret with two keys. Kubernetes stores Secret data base64-encoded in the object, but `kubectl create secret --from-literal` handles that for you.

**Command (copyable)**

```bash
kubectl create secret generic neo-db-secret \
  -n neo-lab \
  --from-literal=dbuser=neokloud \
  --from-literal=dbtoken='N3o@Secure!55'
```

**Inspect the Secret**

```bash
kubectl -n neo-lab get secret neo-db-secret -o yaml
```

You should **not** see raw values in the YAML (they will be base64-encoded).
When you are ready, continue to Step 3.
