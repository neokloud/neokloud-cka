# Neo: Secret to Environment Variable (neo-lab)

Task Description
You are working in the neo-lab namespace.
Your application needs to read sensitive values from a Kubernetes Secret.

Create a Secret named neo-db-secret in the neo-lab namespace.
The Secret must contain:
dbuser = neokloud
dbtoken = N3o@Secure!55

Create a Pod named neo-env-pod using the busybox image.
The container should keep running using:
sleep 4000

Expose the Secret values as environment variables:
APP_USER → value of dbuser
APP_TOKEN → value of dbtoken

After the pod starts, open a shell inside the container and verify that both variables are set correctly.

