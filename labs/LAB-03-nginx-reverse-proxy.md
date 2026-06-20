# LAB-03 Nginx Reverse Proxy

## Goal

Understand Nginx as the public entry point.

## Problem Scenario

You want one clean public path instead of exposing the app container directly.

## Files Used

- `docker/nginx/nginx.conf`
- `docker-compose.yml`

## Commands to Run

```bash
docker compose logs nginx --tail=50
tail -f logs/nginx/access.log
```

## GUI Actions to Click

- Check Health
- Load Items from PostgreSQL

## Expected Output

- requests come through `http://localhost:8080`
- access log entries appear in `logs/nginx/access.log`

## Checkpoint Questions

- What problem does Nginx solve here?
- Why is `/metrics` not exposed publicly through Nginx?

## Common Issues

- Nginx started before the app was healthy
- config was edited incorrectly

## Team Task Split

- Student 1 uses GUI
- Student 2 tails Nginx access log
- Student 3 reads Nginx config
- Student 4 explains request path from browser to app

## Instructor Checkpoint

Have one team narrate the full path of a request through Nginx to the app.

## Next Step

Read [Logging](../docs/logging.md), then continue to [LAB-04 Logging Dashboard](LAB-04-logging-dashboard.md).
