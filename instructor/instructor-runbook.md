# Instructor Runbook

## 6-Hour Flow

- 0:00–0:25 course story, architecture, team roles
- 0:25–1:05 app GUI walkthrough and local tests
- 1:05–1:50 Compose layers: app, PostgreSQL, Redis
- 1:50–2:25 Nginx reverse proxy
- 2:25–3:10 logging with Grafana Explore and CLI logs
- 3:10–3:50 metrics and Grafana dashboard
- 3:50–4:45 GitHub Actions and GHCR
- 4:45–5:35 VM deployment
- 5:35–6:00 failure and recovery recap

## Demo Live

- first local stack startup
- first GUI request
- first slow request and 500 error
- first Grafana Explore search
- first GitHub Actions run
- one known-good VM deploy

## Let Teams Do

- update `.env`
- run compose
- inspect logs
- inspect metrics
- explain the architecture
- run recovery scenarios

## Skip If Time Is Short

- full team-by-team GHCR completion
- full team-by-team VM deploy
- long Grafana dashboard exploration

## Recovery Fallbacks

### If Loki or Promtail is slow or broken

- keep Grafana metrics
- use `docker compose logs`
- use Nginx file logs
- continue the class

### If GHCR permissions fail

- demo from instructor repo or known-good image

### If VM deployment fails

- complete the class locally
- demo VM deploy from known-good environment
