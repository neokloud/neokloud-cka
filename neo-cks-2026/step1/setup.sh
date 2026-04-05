#!/bin/bash
FILE="/etc/kubernetes/manifests/kube-apiserver.yaml"
echo "💣 Breaking kube-apiserver TLS configuration..."
# Backup first (very important)
cp $FILE ${FILE}.bak
# Swap correct values → make it wrong
sed -i 's|--tls-cert-file=/etc/kubernetes/pki/apiserver.crt|--tls-cert-file=/etc/kubernetes/pki/apiserver.key|g' $FILE
sed -i 's|--tls-private-key-file=/etc/kubernetes/pki/apiserver.key|--tls-private-key-file=/etc/kubernetes/pki/apiserver.crt|g' $FILE
echo "❌ TLS configuration is now broken!"
echo "⏳ kubelet will restart kube-apiserver automatically"
sleep 5
echo "📉 Checking API server status..."
echo "✅ Lab 1 environment is now ready for the student."
