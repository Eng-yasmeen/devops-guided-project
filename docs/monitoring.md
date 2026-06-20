# Monitoring

This project uses:

- Prometheus for metrics
- Grafana for dashboards
- Grafana Explore for logs from Loki

## Metrics Teach One Kind of Truth

Metrics answer questions like:

- is the service up?
- are requests increasing?
- are errors rising?
- is latency getting worse?
- is the database ready?
- is Redis ready?

## Logs Teach Another Kind of Truth

Logs answer questions like:

- which request failed?
- which path was slow?
- did the request reach Nginx?
- did the request reach the app?
- what status code was returned?
- which request ID should we search for in logs after the GUI action?

## Main Student Message

- metrics show that something happened
- logs show what request happened and why

## Service Views Students Should Learn

- Grafana dashboard:
  use this first to see whether request rate, errors, latency, or readiness changed
- Grafana Explore:
  use this second to find the exact request and request ID
- CLI logs:
  use this when you need container-specific detail from PostgreSQL or Redis

## Good Monitoring Questions In This Project

- Did request rate change after I clicked a GUI action?
- Did latency rise after `/slow`?
- Did error count rise after `/error`?
- Did readiness fall when Redis or PostgreSQL was unavailable?
- Which logs explain the metric change I just saw?

## Next Step

Move to [LAB-06 GitHub Actions GHCR](../labs/LAB-06-github-actions-ghcr.md).
