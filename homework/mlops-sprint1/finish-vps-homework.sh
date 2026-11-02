#!/usr/bin/env bash
# Запуск на VPS от root после восстановления SSH
set -euo pipefail

echo "=== 1. Telco ==="
cd /opt/mlops-hw/telco-churn-synthetic
docker compose up -d jupyter
docker compose ps
curl -s -o /dev/null -w "jupyter HTTP %{http_code}\n" http://127.0.0.1:8888/

echo "=== 2. E-commerce (без параллели с тяжёлым build, если RAM мало) ==="
cd /opt/mlops-hw/ecommerce-start
git pull --ff-only origin main 2>/dev/null || true
export TERM=xterm
if [[ ! -f data/products.csv ]]; then
  ./scripts/setup/init_project.sh --quick
fi
docker compose up -d --build
docker compose ps
curl -s -o /dev/null -w "streamlit HTTP %{http_code}\n" http://127.0.0.1:8501/

echo "=== 3. Smoke test (если есть ветка homework) ==="
git fetch origin homework/module-01/leonid328 2>/dev/null && git checkout homework/module-01/leonid328 2>/dev/null || true
if [[ -x homework/module-01/submission/test_services.sh ]]; then
  HOST=127.0.0.1 PORT=8501 homework/module-01/submission/test_services.sh || true
fi

OUT=~/mlops-captures/$(date +%Y%m%d-%H%M)
mkdir -p "$OUT"
{
  date; free -h
  cd /opt/mlops-hw/telco-churn-synthetic && docker compose ps && ls -lh data | head -6
  cd /opt/mlops-hw/ecommerce-start && docker compose ps && ls -lh data | head -6
} | tee "$OUT/summary.txt"
echo "Готово. Лог: $OUT/summary.txt"
echo "Jupyter: http://$(curl -s ifconfig.me 2>/dev/null || hostname -I | awk '{print $1}'):8888/?token=secret123"
echo "Streamlit: http://$(curl -s ifconfig.me 2>/dev/null || hostname -I | awk '{print $1}'):8501/"
