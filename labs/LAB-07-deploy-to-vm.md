# LAB-07 Deploy to VM

## Goal

Deploy the selected app image to one Ubuntu VM.

## Problem Scenario

The image exists, but now it must run as a small service outside the laptop.

## Files Used

- `deploy/vm-setup.sh`
- `deploy/deploy.sh`
- `deploy/example.env`
- `deploy/example.secrets.env`
- `.github/workflows/deploy-vm.yml`
- `docker-compose.vm.yml`

## Commands to Run

```bash
bash deploy/vm-setup.sh /opt/devops-guided-project
bash deploy/deploy.sh latest
ssh -L 3000:localhost:3000 USER@VM_PUBLIC_IP
bash scripts/validate-vm-deployment.sh http://YOUR_VM_PUBLIC_IP
```

## GUI Actions to Click

Open the deployed app and:

- Check Health
- Check Readiness

## Expected Output

- app is reachable on port `80`
- `/health` succeeds
- `/ready` succeeds
- Grafana reachable through SSH tunnel

## Checkpoint Questions

- Why do we keep only the app public by default?
- Why is Grafana behind an SSH tunnel?

## Common Issues

- `.env` missing on the VM
- `.env.secrets` missing when Azure Key Vault and GitHub Secrets fallback are both unavailable
- missing `POSTGRES_PASSWORD` or `GRAFANA_ADMIN_PASSWORD` in GitHub Secrets fallback mode
- VM firewall missing port `80`
- wrong image tag
- Azure Key Vault access not configured or missing keys

## Team Task Split

- Student 1 checks VM app path
- Student 2 checks compose env
- Student 3 checks tunnel and Grafana
- Student 4 checks GitHub Actions inputs and secrets

## Instructor Checkpoint

Ask each team to explain how the selected image tag reaches the VM and where the runtime secrets came from.

## Next Step

Open [Troubleshooting](../docs/troubleshooting.md), then continue to [LAB-08 Failure and Recovery](LAB-08-failure-and-recovery.md).
