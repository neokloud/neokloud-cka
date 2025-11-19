# Step 1: Fix the CronJob
A CronJob manifest exists but is missing the `schedule` field.
Students should recreate this manifest from the markdown.

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: log-crusher
  namespace: production
spec:
  jobTemplate:
    spec:
      completions: 2
      backoffLimit: 3
      activeDeadlineSeconds: 30
      template:
        spec:
          containers:
          - name: log
            image: busybox
            command: ["date"]
          restartPolicy: OnFailure
```
Students must add:
`schedule: "*/15 * * * *"`
under `spec:`.
