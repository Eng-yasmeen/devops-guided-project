# LAB-04 Logging Dashboard

## Goal

Use Grafana Explore and CLI logs to investigate real requests.

## Problem Scenario

Traffic is hitting the system, but you need request-level visibility.

## Files Used

- `monitoring/loki/loki-config.yml`
- `monitoring/promtail/promtail-config.yml`
- `app/src/logger.js`
- `logs/nginx/access.log`
- `logs/nginx/error.log`

## Commands to Run

```bash
docker compose logs app --tail=50
docker compose logs nginx --tail=50
docker compose logs postgres --tail=50
docker compose logs redis --tail=50
tail -f logs/nginx/access.log
tail -f logs/nginx/error.log
bash scripts/validate-observability.sh
```

## GUI Actions to Click

- Generate Slow Request
- Generate Error
- Load Items from PostgreSQL
- Test Redis Cache

## Expected Output

- app logs appear in Grafana Explore
- Nginx access/error logs appear in Grafana Explore
- `/error` creates status code 500
- `/slow` creates visible latency

## Checkpoint Questions

- Which GUI action generated the 500 error?
- Which request was slow?
- Did the request reach Nginx?
- Did the request reach the app?
- What did Grafana Explore make easier than CLI logs?
- What did CLI logs make more precise than the UI?

## Common Issues

- Grafana Explore opens before Promtail catches up
- `logs/app/app.log` not created yet because no request was sent

## Team Task Split

- Student 1 generates traffic from the GUI
- Student 2 uses Grafana Explore
- Student 3 uses CLI logs
- Student 4 compares the findings

## Instructor Checkpoint

Ask every team to show one slow request and one 500 request in both the UI and the CLI.

## Next Step

Read [Monitoring](../docs/monitoring.md), then continue to [LAB-05 Metrics and Grafana](LAB-05-metrics-and-grafana.md).
