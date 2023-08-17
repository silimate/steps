# Import python libraries
import os, re, time
import requests

# Check if string is float
def is_float(string):
  try:
    float(string)
    return True
  except ValueError:
    return False

re_tns = re.compile(r"report_tns\n-+\ntns (.+)")
re_wns = re.compile(r"report_wns\n-+\nwns (.+)")
re_area = re.compile(r"report_design_area\n-+\nDesign area (\S+) u\^2 ([^%]+)% utilization")
re_power = re.compile(r"report_power\n-+\n\S+\s+" + "(\S+)\s+"*3 + ".*\n.*\n-+\n" + ("(\S+)\s+"*4 + ".*\n")*4)

re_nwires = re.compile(r"Number of wires:\s+(\S+)")
re_nwirebits = re.compile(r"Number of wire bits:\s+(\S+)")
re_npublicwires = re.compile(r"Number of public wires:\s+(\S+)")
re_nmems = re.compile(r"Number of memories:\s+(\S+)")
re_nmembits = re.compile(r"Number of memory bits:\s+(\S+)")
re_nprocs = re.compile(r"Number of processes:\s+(\S+)")
re_ncells = re.compile(r"Number of cells:\s+(\S+)")

metrics = {}
try:    
  with open("inputs/design.rpt") as rptfile:
    rpt = rptfile.read()
    # print(rpt)
    metrics["tns"], = re_tns.search(rpt).groups()
    metrics["wns"], = re_wns.search(rpt).groups()
    metrics["area"], metrics["area_utilization_pct"] = re_area.search(rpt).groups()
    
    power = re_power.search(rpt).groups()
    powercats, powercomps, data = power[:3], power[3::4], list(filter(is_float, power[3:]))
    for i, d in enumerate(data):
      metrics[f"power_{powercats[i%3].lower()}_{powercomps[i//4].lower()}"] = d
    metrics["power"] = sum(map(float, data))
except FileNotFoundError:
  pass
try:
  with open("inputs/synth-stat.rpt") as rptfile:
    rpt = rptfile.read()
    metrics["nwires"], = re_nwires.search(rpt).groups()
    metrics["nwirebits"], = re_nwirebits.search(rpt).groups()
    metrics["npublicwires"], = re_npublicwires.search(rpt).groups()
    metrics["nmems"], = re_nmems.search(rpt).groups()
    metrics["nmembits"], = re_nmembits.search(rpt).groups()
    metrics["nprocs"], = re_nprocs.search(rpt).groups()
    metrics["ncells"], = re_ncells.search(rpt).groups()
except FileNotFoundError:
  pass

step = os.readlink("inputs/design.rpt").split("/")[-3]

# Convert metric values to floats
metrics = {k: float(v) for k, v in metrics.items()}
print(metrics)

# Convert numerical metrics to list of dicts
metrics = [{
  "design_name": os.environ["DESIGN"],
  "flow": os.environ["DESIGN"],
  "run": os.environ["FLOW_RUNID"],
  "step": step,
  "time": time.time() * 1000,
  "metric": metric,
  "value": float(value)
} for metric, value in metrics.items() if is_float(value)]

# Post metrics to API for storage in database
print(requests.post("http://localhost/api/metrics/", json=metrics))
