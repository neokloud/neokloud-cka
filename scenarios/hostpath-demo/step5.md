# Step 5: Verify HostPath Persistence

Curl again:

```
curl http://<node-ip>
```

You should now see **old lines + new lines** — this proves HostPath persists data across Pod deletion.

If you have node access:

```
sudo cat /data/neo-website/www/index.html
```

This file contains all accumulated log lines.
