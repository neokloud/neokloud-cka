# Lab 1: Fix Broken kube-apiserver TLS Configuration

🎯 **Scenario**  
You are troubleshooting a control plane node where the `kube-apiserver` is not starting.  
The issue is related to incorrect TLS certificate configuration.

📌 **Task**  
Fix the kube-apiserver configuration so that:

- It uses the correct certificate file  
- It uses the correct private key  
- The API server becomes healthy

🔍 **Current (Broken) Configuration**  
Inside the kube-apiserver manifest:

```yaml
--tls-cert-file=/etc/kubernetes/pki/apiserver.key
--tls-private-key-file=/etc/kubernetes/pki/apiserver.crt
