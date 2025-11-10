#!/bin/bash
# Initialize Kubernetes environment for NodePort scenario
echo "Waiting for Kubernetes cluster to be ready..."
while ! kubectl get nodes &>/dev/null; do
  sleep 2
done

echo "Cluster is ready!"
echo "Scenario files available in /root/"
