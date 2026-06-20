# Azure Key Vault and Secrets Flow

This guided project uses **Azure Key Vault** as the primary runtime secret source for CI/CD deployment.

GitHub Secrets remain the fallback path so classes can still complete the project if Azure Key Vault is not ready yet.

## Why This Matters

The app needs runtime values such as:

- `POSTGRES_PASSWORD`
- `GRAFANA_ADMIN_PASSWORD`
- `REGISTRY_LOGIN_SERVER`
- `REGISTRY_USERNAME`
- `REGISTRY_PASSWORD`

These values should not be committed to the repository.

## Preferred Secret Flow

1. GitHub Actions authenticates to Azure with OIDC.
2. GitHub Actions reads runtime secrets from Azure Key Vault.
3. The workflow exports those values to the deployment job environment.
4. `deploy/deploy.sh` writes them into `.env.secrets` on the VM.
5. Docker Compose starts the VM stack with those runtime secrets.

## Fallback Secret Flow

If Azure Key Vault is not configured yet:

1. Store the same values in GitHub Secrets.
2. The deploy workflow loads those GitHub Secrets first.
3. If Azure Key Vault later returns a value for the same key, the Key Vault value overrides the fallback.

This keeps the training path unblocked while still teaching the preferred cloud secret path.

## GitHub Secrets Needed For Azure Login

- `VM_HOST`
- `VM_USER`
- `VM_APP_DIR`
- `VM_SSH_KEY_B64` preferred, or `VM_SSH_KEY`
- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`
- `AZURE_KEYVAULT_NAME`

## GitHub Secrets Kept As Fallback

- `POSTGRES_PASSWORD`
- `GRAFANA_ADMIN_PASSWORD`
- `REGISTRY_LOGIN_SERVER`
- `REGISTRY_USERNAME`
- `REGISTRY_PASSWORD`

## Required Azure Key Vault Secret Names

Use these exact secret names in Azure Key Vault:

- `POSTGRES_PASSWORD`
- `GRAFANA_ADMIN_PASSWORD`
- `REGISTRY_LOGIN_SERVER`
- `REGISTRY_USERNAME`
- `REGISTRY_PASSWORD`

## Azure Access Requirements

The GitHub Actions identity needs permission to read secrets from the Key Vault.

Typical requirement:

- assign the identity a role such as **Key Vault Secrets User**

## Teaching Message

Students should leave with this mental model:

- application configuration is split into non-secret and secret values
- GitHub Actions can retrieve secrets from a cloud secret manager
- a fallback path can keep delivery moving without changing the app itself
- VM access secrets are separate from runtime app secrets, and both must be configured for the deploy workflow to succeed

## Next Step

Continue to [VM Deployment](vm-deployment.md), then run [LAB-07 Deploy to VM](../labs/LAB-07-deploy-to-vm.md).
