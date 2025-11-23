# Task Description

A Pod inside the Deployment **neo-depl** in the **neo** namespace is generating RBAC errors when attempting to list Deployments. Your task is to observe the logs, identify the RBAC issue, fix it by creating the correct Role and RoleBinding, restart the Deployment, and confirm that the issue is resolved.

This scenario represents CKAD topics: **Core Concepts** + **Configuration**.

---

## What You Will Learn

- How ServiceAccounts behave inside Pods  
- How to identify RBAC errors from Pod logs  
- How to create a Role with minimal permissions  
- How to bind a Role to a ServiceAccount  
- How to restart a Deployment to refresh permissions  
- How to use `kubectl logs` effectively  

---

## Environment Summary

You will work with:

- Namespace: `neo`
- Deployment manifest at `/home/files/neo-depl.yaml`
- Role manifest: `role.yaml`
- RoleBinding manifest: `rolebinding.yaml`

The scenario begins with a **broken Deployment** already in place that produces RBAC errors.

---

## Your Tasks

1. Create the namespace and directory structure  
2. Deploy the broken Deployment  
3. Check logs and identify exact RBAC errors  
4. Create the Role and RoleBinding to fix permissions  
5. Restart the Deployment  
6. Verify that logs show successful output  

Proceed to **Step 1**.
