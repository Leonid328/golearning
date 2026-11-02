# MLOps Sprint 1 — текст для LMS (Leonid328)

## Задание A — Telco Churn Synthetic (70 баллов)

**Репозиторий:** https://github.com/Leonid328/telco-churn-synthetic  
**VPS:** Docker + Python 3.13, каталог `/opt/mlops-hw/telco-churn-synthetic`  
**Лог на VM:** https://github.com/Leonid328/telco-churn-synthetic/blob/docs/vps-run-log/docs/VPS_RUN_LOG.md (ветка `docs/vps-run-log`, можно смержить в main)

Добре. На VPS клонировал свой репозиторий из шаблона, создал venv, установил зависимости, сгенерировал синтетический датасет (`generate_dataset.py` — 10k строк; `generate_dataset_ext.py` — customers + support + knowledge base). Поднял Jupyter через `docker compose up -d jupyter` (порт 8888, токен в compose). Проверил ноутбук `notebooks/explore_data.ipynb` (nbconvert execute в контейнере). Скриншоты: docker ps / генерация / Jupyter UI — в Google Drive (папка MLOps-Telco-Leonid328).

---

## Задание B — E-commerce Start (+30 баллов)

**Репозиторий:** https://github.com/Leonid328/ecommerce-start  
**Pull Request (Module 01):** создать после push — см. `gh pr list --repo Leonid328/ecommerce-start`

Добре. Принял шаблон `ecommerce-start`, на VPS `/opt/mlops-hw/ecommerce-start` запускал `./scripts/setup/init_project.sh --quick` и `docker compose up -d --build`. Домашка модуля 1: ветка `homework/module-01/leonid328`, файлы в `homework/module-01/submission/` (architecture, test_services.sh, performance, troubleshooting). Streamlit на порту 8501. Скриншоты compose ps и UI — Drive (MLOps-Ecommerce-Leonid328).

---

## VPS (когда SSH снова отвечает)

```bash
# Telco
cd /opt/mlops-hw/telco-churn-synthetic && docker compose ps
curl -sI http://127.0.0.1:8888/ | head -1

# Ecommerce
cd /opt/mlops-hw/ecommerce-start && docker compose ps
curl -s -o /dev/null -w '%{http_code}\n' http://127.0.0.1:8501/
```

Если SSH «висит» — остановить Jupyter, дождаться окончания build, `docker system prune -f`.
