# Neo NodePort Service Scenario

## Create Namespace

```
kubectl create namespace neokloud
```

## Create the initial Deployment

```
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: neo-depl
  namespace: neokloud
spec:
  replicas: 1
  selector:
    matchLabels:
      app-front: nginx
  template:
    metadata:
      labels:
        app-front: nginx
    spec:
      containers:
      - name: web
        image: nginx
        ports:
        - containerPort: 80
EOF
```

## Edit Deployment

```
kubectl edit -n neokloud deployments.apps neo-depl
```

Update:

- replicas: 4  
- Add label in template:
```
app: neo
```

## Create NodePort service

```
kubectl apply -f nodeport.yaml
```

nodeport.yaml:

```
apiVersion: v1
kind: Service
metadata:
  name: neo-app
  namespace: neokloud
spec:
  type: NodePort
  selector:
    app-front: nginx
  ports:
  - port: 8080
    targetPort: 80
    protocol: TCP
```

## Test

```
curl http://<NODE-IP>:<NODEPORT>
```

