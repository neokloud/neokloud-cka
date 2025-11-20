# PV & PVC Practice Lab

In this lab you will:

- Create a Namespace
- Create a PersistentVolume
- Create a PersistentVolumeClaim
- Attach the PVC to a Deployment

---

## Step 1 — Create Namespace

YAML (01-namespace.yaml):

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: frontend
```

Apply:

```
kubectl apply -f https://raw.githubusercontent.com/neokloud/neokloud-cka/main/scenarios/pv-scenario/assets/01-namespace.yaml
```

---

## Step 2 — Create PersistentVolume

YAML (02-pv.yaml):

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: web-pv
spec:
  capacity:
    storage: 250Mi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: "/mnt/data/web"
```

Apply:

```
kubectl apply -f https://raw.githubusercontent.com/neokloud/neokloud-cka/main/scenarios/pv-scenario/assets/02-pv.yaml
```

---

## Step 3 — Create PersistentVolumeClaim

YAML (03-pvc.yaml):

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: web-pvc
  namespace: frontend
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 250Mi
  storageClassName: manual
```

Apply:

```
kubectl apply -f https://raw.githubusercontent.com/neokloud/neokloud-cka/main/scenarios/pv-scenario/assets/03-pvc.yaml
```

---

## Step 4 — Deploy NGINX and Mount PVC

YAML (04-deployment.yaml):

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  namespace: frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
        - name: nginx
          image: nginx
          ports:
            - containerPort: 80
          volumeMounts:
            - name: web-storage
              mountPath: /usr/share/nginx/html
      volumes:
        - name: web-storage
          persistentVolumeClaim:
            claimName: web-pvc
```

Apply:

```
kubectl apply -f https://raw.githubusercontent.com/neokloud/neokloud-cka/main/scenarios/pv-scenario/assets/04-deployment.yaml
```

---
