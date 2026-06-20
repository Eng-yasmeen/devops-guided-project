# LAB-07 Deploy to VM

## Goal

Deploy the selected app image to one Ubuntu VM.

## Why This Lab Matters

Students now move from local proof to a small real deployment target. The main lesson is not cloud complexity. It is understanding how an already-built image, runtime configuration, and simple smoke tests come together on a VM.

## Before You Start

Make sure these are ready:

- a working published image in ACR
- VM access
- the deployment environment files on the VM
- the required secrets path, using Azure Key Vault or the documented fallback

Read [VM Deployment](../docs/vm-deployment.md) before starting the commands.

## Files Used

- `deploy/vm-setup.sh`
- `deploy/deploy.sh`
- `deploy/example.env`
- `deploy/example.secrets.env`
- `.github/workflows/deploy-vm.yml`
- `docker-compose.vm.yml`
- `scripts/package-vm-source.sh`

## Commands to Run

```bash
bash deploy/vm-setup.sh /opt/devops-guided-project
bash deploy/deploy.sh latest
ssh -L 3000:localhost:3000 USER@VM_PUBLIC_IP
bash scripts/validate-vm-deployment.sh http://YOUR_VM_PUBLIC_IP
```

## What To Do

1. Prepare the VM with the setup script.
2. If the VM cannot clone the repository directly, package and copy the source with `bash scripts/package-vm-source.sh`.
3. Confirm the runtime environment files exist on the VM.
4. Deploy a selected image tag.
5. Open the deployed app in a browser.
6. Click `Check Health` and `Check Readiness`.
7. Open Grafana through the SSH tunnel and confirm the observability stack is reachable.

## Expected Output

- the app is reachable on port `80`
- `/health` succeeds
- `/ready` succeeds
- Grafana is reachable through the SSH tunnel
- students can explain which image tag is running and where its secrets came from

## Checkpoint Questions

- Why do we keep only the app public by default?
- Why is Grafana behind an SSH tunnel?
- Why deploy an image tag instead of rebuilding on the VM?
- Which part of the flow proves that deployment actually succeeded?

## Common Issues

- `.env` missing on the VM
- `.env.secrets` missing when Azure Key Vault and GitHub Secrets fallback are both unavailable
- missing `POSTGRES_PASSWORD` or `GRAFANA_ADMIN_PASSWORD` in fallback mode
- `VM_SSH_KEY_B64` missing or built from the wrong content in GitHub Secrets
- VM firewall missing port `80`
- wrong image tag selected
- Azure Key Vault access not configured or missing keys

## Team Task Split

- Student 1 checks the VM app path
- Student 2 checks compose environment files
- Student 3 checks the SSH tunnel and Grafana
- Student 4 checks GitHub Actions inputs, secrets, and the selected image tag

## Instructor Checkpoint

Ask each team to explain how the selected image tag reached the VM, how runtime configuration was supplied, and which checks prove the deploy worked.

## Validation

Run:

```bash
bash scripts/validate-vm-deployment.sh http://YOUR_VM_PUBLIC_IP
```

## Next Step

Open [Troubleshooting](../docs/troubleshooting.md), then continue to [LAB-08 Failure and Recovery](LAB-08-failure-and-recovery.md).
