# Step 1 — Create the namespace `neo-lab`

** lets hammer brain **
In this lab you'll create a Kubernetes Secret and consume its data as environment variables inside a Pod.
The lab is split into three steps. Each step includes copyable commands and embedded YAML where appropriate.

Namespace used: `neo-lab`
Secret name: `neo-db-secret`
Pod name: `neo-env-pod`

Follow the steps in order. Do **not** skip steps.




**Explanation**

We create an isolated namespace to keep this lab's resources separate from other clusters resources.

**Command (copyable)**

```bash
kubectl create namespace neo-lab
```

Run the command above. When you're ready, proceed to Step 2.
