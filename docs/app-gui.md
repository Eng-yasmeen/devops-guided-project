# App GUI

The GUI is called **DevOps Control Panel**.

It is not a frontend project.

It is a simple helper for:

- generating traffic
- checking service behavior
- creating logs
- creating metrics
- explaining how each request is processed

## Buttons

- Check Health
- Check Readiness
- Show Version
- Load Items from PostgreSQL
- Create Demo Item
- Test Redis Cache
- Generate Slow Request
- Generate Error
- Open Grafana Dashboard
- Open Grafana Logs
- Open Prometheus

## Request Types in the GUI

| Button | Route | Main Teaching Point | Dependencies |
| --- | --- | --- | --- |
| Check Health | `GET /health` | process health only | none |
| Check Readiness | `GET /ready` | dependency readiness | PostgreSQL, Redis |
| Show Version | `GET /version` | deployment metadata | none |
| Load Items from PostgreSQL | `GET /items` | read path through database | PostgreSQL |
| Create Demo Item | `POST /items` | write path through database | PostgreSQL |
| Test Redis Cache | `GET /cache-demo` | cache miss vs cache hit | Redis |
| Generate Slow Request | `GET /slow` | latency in logs and metrics | none |
| Generate Error | `GET /error` | 500 response and error logs | none |

## Request Flow Panel

Each traffic button now explains:

- which route is called
- whether Nginx, PostgreSQL, or Redis are involved
- which logs should change
- which metrics should move
- what students should inspect next

This keeps the GUI focused on DevOps reasoning instead of only showing raw JSON responses.

## Full Request Cycle In Logs

Each request now creates a clearer cycle in the app logs:

1. `request started`
2. route-specific events such as:
   - `dependency readiness checked`
   - `postgres items loaded`
   - `postgres item created`
   - `redis cache hit`
   - `redis cache miss`
   - `slow request simulation started`
   - `slow request simulation completed`
3. `request completed` or `request failed`

This makes it easier for trainees to follow one full request from entry to outcome.

## Observability Shortcuts

The shortcut behavior changes with where the app is running:

- local stack: Grafana and Prometheus open directly on the current machine
- VM path: the shortcuts point to `localhost` so they work after the SSH tunnel is created

## Why the GUI Matters

Students can use one simple page instead of writing curl commands for every action.

That keeps the focus on:

- traffic
- logs
- metrics
- deployment

## Next Step

Start [LAB-01 Run Locally and Use GUI](../labs/LAB-01-run-locally-and-use-gui.md).
