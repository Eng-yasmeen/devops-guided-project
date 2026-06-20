# VM Deployment

This project deploys to one Ubuntu VM with Docker Compose.

## Runtime Configuration Model

Keep non-secret VM settings in `.env`.

Keep secret values in `.env.secrets`, or let GitHub Actions create that file automatically from Azure Key Vault data during deployment.

Use these files:

- `.env` from `deploy/example.env`
- `.env.secrets` from `deploy/example.secrets.env` only when you are not using Azure Key Vault or GitHub Secrets fallback

`deploy/deploy.sh` uses `.env` for the stable runtime settings and `.env.secrets` for sensitive values such as:

- `POSTGRES_PASSWORD`
- `GRAFANA_ADMIN_PASSWORD`
- `REGISTRY_LOGIN_SERVER`
- `REGISTRY_USERNAME`
- `REGISTRY_PASSWORD`

## Preferred Secret Source: Azure Key Vault

For the guided project, keep the VM connection values in GitHub Secrets:

- `VM_HOST`
- `VM_USER`
- `VM_SSH_KEY`
- `VM_APP_DIR`

Use Azure Key Vault for the runtime secrets by configuring these GitHub Secrets for Azure login:

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`
- `AZURE_KEYVAULT_NAME`

The workflow logs into Azure with OIDC, reads the required secrets from Azure Key Vault, then passes them into `deploy/deploy.sh`.

Expected Azure Key Vault secret names:

- `POSTGRES_PASSWORD`
- `GRAFANA_ADMIN_PASSWORD`
- `REGISTRY_LOGIN_SERVER`
- `REGISTRY_USERNAME`
- `REGISTRY_PASSWORD`

## GitHub Secrets Fallback

For immediate validation, GitHub Actions can still supply the runtime secrets directly without Azure Key Vault.

Store these GitHub Secrets:

- `POSTGRES_PASSWORD`
- `GRAFANA_ADMIN_PASSWORD`
- `REGISTRY_LOGIN_SERVER`
- `REGISTRY_USERNAME`
- `REGISTRY_PASSWORD`

The deploy workflow passes them to `deploy/deploy.sh`, which writes `.env.secrets` on the VM automatically during deployment.

## Public and Private Services

Public by default:

- app through Nginx on port `80`

Private by default:

- Grafana
- Prometheus
- Loki
- Promtail
- PostgreSQL
- Redis

## Guided Validation

After the VM deployment completes, run:

```bash
bash scripts/validate-vm-deployment.sh http://YOUR_VM_PUBLIC_IP
```

That validation confirms:

- `/health`
- `/ready`
- `/version` deployment metadata

## Next Step

After deployment is working, move to [LAB-08 Failure and Recovery](../labs/LAB-08-failure-and-recovery.md).

## SSH Tunnel for Grafana

Use:

```bash
ssh -L 3000:localhost:3000 USER@VM_PUBLIC_IP
```

Then open:

```text
http://localhost:3000
```

## Important Reminder

This is a controlled training VM.

It is not a hardened production platform.

Do not expose Grafana, Prometheus, Loki, or Promtail publicly unless you are doing that intentionally for a supervised class demo.
