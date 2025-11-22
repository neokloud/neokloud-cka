# HostPath Persistence Demo

This scenario teaches how HostPath volumes preserve data even after a Pod is deleted and recreated.

You will deploy a Pod that:
- Appends a line every 5 seconds:  
  `Thank you from neokloud <date>`
- Serves the file over a tiny BusyBox HTTP server
- Stores data in a HostPath folder so it persists across restarts
