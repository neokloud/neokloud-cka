# neo-ckad
# CKAD CronJob Fix Scenario

A CronJob manifest already exists at:

`/home/log/log-crusher.yaml`

The CronJob is missing its schedule field and will not run as expected.

## Task

Fix the manifest so that the CronJob named **log-crusher** in the
**production** namespace runs **every 15 minutes**.

Do not change any other fields in the file.

Re-apply the manifest and verify that the CronJob is scheduled correctly.
This scenario introduces a CKAD-style CronJob fix exercise.
