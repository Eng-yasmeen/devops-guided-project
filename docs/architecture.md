# Architecture

This project intentionally uses one small service and a few supporting layers.

## Main Components

- Express app
- PostgreSQL
- Redis
- Nginx
- Prometheus
- Grafana
- Loki
- Promtail

## Service Exposure Table

| Service | Default Port | Exposure | Why It Exists |
| --- | --- | --- | --- |
| Nginx | `8080` local / `80` VM | Public | Single public entry point for the app |
| Express app | `3000` | Internal only | Handles GUI and API requests |
| PostgreSQL | `5432` | Internal only | Stores the `items` table |
| Redis | `6379` | Internal only | Demonstrates a simple cache path |
| Prometheus | `9090` | Local public, VM localhost-only | Stores app metrics |
| Grafana | `3000` | Local public, VM localhost-only | Main observability UI |
| Loki | `3100` internal | Internal only | Stores app and Nginx logs |
| Promtail | `9080` internal | Internal only | Ships app and Nginx logs into Loki |

## Why These Parts Exist

- **App**: the service students interact with
- **PostgreSQL**: simple persistent data
- **Redis**: simple cache behavior
- **Nginx**: public entry point and reverse proxy
- **Prometheus**: metrics storage
- **Grafana**: main observability UI
- **Loki**: log storage
- **Promtail**: log shipper for app and Nginx logs

## Files That Define the Stack

Core runtime files:

- `docker-compose.yml`
- `docker-compose.vm.yml`
- `docker/app.Dockerfile`
- `docker/nginx/nginx.conf`
- `monitoring/prometheus/prometheus.yml`
- `monitoring/loki/loki-config.yml`
- `monitoring/promtail/promtail-config.yml`
- `monitoring/grafana/provisioning/...`

These files matter because:

- Compose defines which containers run
- the Dockerfile defines how the app image is built
- Nginx defines the public request path
- Prometheus, Loki, Promtail, and Grafana define the observability path

## Request Path Summary

For most trainee actions, the request path is:

1. browser sends request to Nginx
2. Nginx forwards request to the Express app
3. app may call PostgreSQL or Redis depending on the route
4. app writes structured logs to stdout and `logs/app/app.log`
5. Nginx writes access or error logs under `logs/nginx/`
6. Prometheus collects metrics from `/metrics`
7. Promtail ships app and Nginx logs to Loki
8. Grafana shows metrics dashboards and log searches

## Two Runtime Modes

### Local mode

Uses:

- `docker-compose.yml`

Behavior:

- builds the app image locally
- exposes Nginx on `localhost:8080`
- exposes Grafana on `localhost:3000`
- exposes Prometheus on `localhost:9090`

### VM mode

Uses:

- `docker-compose.vm.yml`

Behavior:

- pulls the app image from a registry
- exposes Nginx on port `80`
- keeps Grafana and Prometheus localhost-only by default
- is driven by `.env` and `.env.secrets`

## What Students Should Understand Technically

- Nginx is the only intended public entry point
- the app is not meant to be exposed directly
- PostgreSQL and Redis are support services, not public services
- Prometheus scrapes the app internally
- Loki stores only app and Nginx logs in this course
- Grafana is the single observability UI

## Next Step

Read [Runtime Stack](runtime-stack.md), then [App GUI](app-gui.md), then [Request And Data Flow](request-and-data-flow.md), then start [LAB-01 Run Locally and Use GUI](../labs/LAB-01-run-locally-and-use-gui.md).

## Integration Rule

Keep the system easy to explain:

- the GUI generates traffic
- Nginx forwards traffic
- the app handles requests
- Prometheus stores metrics
- Loki stores app and Nginx logs
- Grafana lets students inspect both
