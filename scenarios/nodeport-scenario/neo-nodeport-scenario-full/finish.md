# Scenario Complete

You have completed the **Neo NodePort Scenario**.

You practiced:

- Inspecting an existing Deployment and understanding its labels and selectors.
- Respecting immutable fields like `.spec.selector`.
- Safely adding new labels to the pod template without breaking the Deployment.
- Scaling a Deployment from 1 replica to 4 replicas.
- Creating a NodePort Service to expose the app on port 8080.
- Discovering the node IP and NodePort.
- Verifying access using `curl` against `http://<NODE-IP>:<NODEPORT>`.

These are common patterns in real CKA/CKAD-style Kubernetes questions.
