# Troubleshooting

## App GUI Does Not Open

- check `docker --version`
- check `docker compose version`
- check `docker ps`
- check `docker compose ps`
- check `docker compose logs nginx --tail=50`
- check `docker compose logs app --tail=50`

If `docker compose version` fails, install Docker Compose v2.

If `docker ps` fails, start Docker Desktop or the Docker daemon first.

If Docker is already running on Linux but `docker ps` still fails, add your user to the `docker` group, open a new shell or SSH session, and rerun the prerequisite validation script.

## `/ready` Fails

- check PostgreSQL logs
- check Redis logs
- check app logs

## Grafana Has No Data

- wait 15 to 30 seconds
- check `docker compose logs prometheus --tail=50`
- check `docker compose logs grafana --tail=50`
- check `docker compose logs promtail --tail=50`

## Loki Logs Missing

- check `docker compose logs promtail --tail=50`
- check that `logs/app/app.log` exists
- check that `logs/nginx/access.log` exists

## GitHub Actions Build Fails

- confirm `app/package.json` and lockfile are in sync
- confirm GHCR permissions are enabled
- confirm the workflow ran on the branch you expected
- confirm whether the run was a PR validation path or a `main` publish path

## VM Deploy Fails

- rerun `bash deploy/deploy.sh latest`
- inspect:
  - `docker compose -f docker-compose.vm.yml logs app --tail=50`
  - `docker compose -f docker-compose.vm.yml logs nginx --tail=50`

If the VM works locally but your laptop browser does not reach port `80`, check the cloud firewall or security group first.

If your local network or ISP redirects plain HTTP before it reaches the VM, validate the app from another network or use an SSH tunnel to reach the VM services directly.

## Observability Shortcut Confusion

- if Grafana and Prometheus are on the VM, use the app from the VM hostname or public IP so `/ui-config` switches into SSH tunnel mode
- if you are already on the VM itself, the shortcuts should point to `127.0.0.1`
- if Grafana is healthy but a shortcut still fails, create the tunnel manually:
  - `ssh -L 3000:localhost:3000 USER@VM_PUBLIC_IP`
  - `ssh -L 9090:localhost:9090 USER@VM_PUBLIC_IP`

## Azure Key Vault Secret Fetch Fails

- confirm `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`, and `AZURE_KEYVAULT_NAME` exist in GitHub Secrets
- confirm the GitHub Actions identity can read the Key Vault secrets
- confirm the Key Vault secret names match the documented names exactly
- if Azure Key Vault is temporarily unavailable, rely on the GitHub Secrets fallback or create `.env.secrets` from `deploy/example.secrets.env`

## Next Step

Return to the lab you were running and repeat the matching milestone validation script.
