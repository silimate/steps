# Import python libraries
import csv, os, time
import requests

# Check if string is float
def is_float(string):
  try:
    float(string)
    return True
  except ValueError:
    return False

# Convert numerical metrics to list of dicts
metrics = [{
  "design_name": os.environ["DESIGN"],
  "flow": os.environ["DESIGN"],
  "run": os.environ["FLOW_RUNID"],
  "step": row["path"],
  "time": time.time() * 1000,
  "metric": metric + (" (" + value.split()[1] + ")") if len(value.split()) > 1 else "", # Add units to metric name if available
  "value": float(value.split()[0])
} for row in csv.DictReader(open("inputs/metrics.csv")) for metric, value in row.items() if (len(value.split()) > 0) and is_float(value.split()[0])] # Split to get units if available

print(metrics)

# Post metrics to API for storage in database
print(requests.post("http://localhost/api/metrics/", json=metrics))
