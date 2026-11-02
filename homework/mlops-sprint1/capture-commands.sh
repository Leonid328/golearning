#!/usr/bin/env bash
# Run ON VPS when SSH is healthy; saves text proofs under ~/mlops-captures/
set -euo pipefail
OUT=~/mlops-captures/$(date +%Y%m%d-%H%M)
mkdir -p "$OUT"

{
  echo "=== host ==="
  hostname; date; free -h
  echo "=== telco ==="
  cd /opt/mlops-hw/telco-churn-synthetic
  docker compose ps
  ls -lh data/ | head -10
  curl -sI http://127.0.0.1:8888/ | head -3
  echo "=== ecommerce ==="
  cd /opt/mlops-hw/ecommerce-start
  docker compose ps
  ls -lh data/ | head -10
  curl -s -o /dev/null -w "streamlit_http:%{http_code}\n" http://127.0.0.1:8501/
} | tee "$OUT/summary.txt"

echo "Saved: $OUT/summary.txt"
