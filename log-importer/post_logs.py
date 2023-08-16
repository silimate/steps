# Import python libraries
import glob, os, time
import requests

# Logs
logs = [{
  "flow": os.environ["DESIGN"],
  "run": os.environ["FLOW_RUNID"],
  "name": logfile.split("inputs/")[-1],
  "time": time.time() * 1000,
  "log": line
} for logfile in glob.glob("inputs/*") for line in open(logfile)]

# Post metrics to API for storage in database
print(requests.post("http://localhost/api/logs/", json=logs))
