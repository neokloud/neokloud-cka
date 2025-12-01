# NeoKloud HostPath PV Scenario – Static PV, PVC, Pod & Persistence

## Goal

In this scenario you will:

1. Use the **hostPath** volume plugin.
2. Create a **static PersistentVolume (PV)**.
3. Create a **PersistentVolumeClaim (PVC)** that binds to the PV.
4. Create a **Pod** running NGINX that:
   - Mounts the PVC at `/usr/share/nginx/html`
   - Uses `hostPort` to expose NGINX without a Service
5. Understand **403 Forbidden** when no `index.html` exists.
6. Create `index.html` in the mounted path and **see persistence** even after Pod deletion.

## High-level flow

1. Check node & create `/mnt/data` path.
2. Create **PV**.
3. Create **PVC**.
4. Create **Pod** with PVC + hostPort.
5. Test NGINX.
6. Persistence demo.
