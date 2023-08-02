# Import python libraries
import csv, time
import requests

# Check if string is float
def is_float(string):
  try:
    float(string)
    return True
  except ValueError:
    return False

# Load metrics from input CSV file
metrics = next(csv.DictReader(open("inputs/metrics.csv")))

# Convert total runtime string to seconds float
metrics["total_runtime"] = float(metrics["total_runtime"].split("h")[0]) * 3600 + float(metrics["total_runtime"].split("h")[1].split("m")[0]) * 60 + float(metrics["total_runtime"].split("m")[1].split("s")[0]) + float(metrics["total_runtime"].split("s")[1].split("m")[0]) / 1000

# Convert numerical metrics to list of dicts
metrics = [{
  "design_name": metrics["design_name"],
  "flow": metrics["design"].split("/")[-1],
  "run": metrics["config"].split("/")[0],
  "step": metrics["config"].split("/")[1],
  "time": time.time() * 1000,
  "metric": metric,
  "value": float(value)
} for metric, value in metrics.items() if is_float(value)]

# Post metrics to API for storage in database
requests.post("http://localhost/api/metrics/", json=metrics)
