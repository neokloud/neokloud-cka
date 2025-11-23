# Task Description

A Pod inside the Deployment **neo-depl** in the **neo** namespace is generating RBAC errors when attempting to list Deployments.

Your task is to observe the logs, 

identify the RBAC issue, 

fix it by creating the correct Role and RoleBinding, 

restart the Deployment, 

and confirm that the issue is resolved.

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



Proceed to **Step 1**.
