# LAB-08 Failure and Recovery

## Goal

Observe failures, find evidence, and recover the service.

## Problem Scenario

The service is deployed, but something breaks. Teams must diagnose it with GUI, logs, metrics, and service status.

## Files Used

- `docker-compose.yml`
- `docker-compose.vm.yml`
- `docker/nginx/nginx.conf`
- `docs/logging.md`
- `docs/monitoring.md`

## Commands to Run

```bash
docker compose ps
docker compose logs app --tail=50
docker compose logs nginx --tail=50
docker compose logs postgres --tail=50
docker compose logs redis --tail=50
```

## GUI Actions to Click

- Check Health
- Check Readiness
- Generate Error

## Expected Output

Teams can diagnose and recover:

1. app container stopped
2. Redis stopped
3. PostgreSQL stopped
4. Nginx config broken
5. app returns 500 from `/error`

## Checkpoint Questions

- What symptom did the GUI show first?
- What did metrics show?
- What did logs show?
- Which command or action fixed the issue?

## Common Issues

- students jump to restart before observing evidence

## Team Task Split

- Student 1 observes GUI symptom
- Student 2 checks metrics
- Student 3 checks logs
- Student 4 performs recovery step

## Instructor Checkpoint

Every team must explain one full chain:

symptom -> evidence -> root cause -> recovery

## Next Step

Run the milestone validators again for any part of the journey you want to re-check, then return to [README](../README.md) for the full project map.
