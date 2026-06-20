# Documentation Guide

Read these documents in this order as you move through the guided project.

## 1. Before You Start

- [Prerequisites and Validation](01-prerequisites-and-validation.md)

Use this first.
It explains what to install, what to check before LAB-01, and which validation script to run.

## 2. Understand the Stack

- [Architecture](architecture.md)
- [Runtime Stack](runtime-stack.md)
- [App GUI](app-gui.md)
- [Request And Data Flow](request-and-data-flow.md)

Read these before or during LAB-00 and LAB-01.
They explain the service layout, the Compose files, the role of each component, how requests and data move, and what each GUI request does.

## 3. Follow the Observability Story

- [Logging](logging.md)
- [Monitoring](monitoring.md)

Read these during LAB-04 and LAB-05.
They explain how logs, metrics, request IDs, and the request cycle fit together.

## 4. Learn the Delivery Path

- [Registries](registries.md)
- [Azure Key Vault and Secrets Flow](secrets-and-azure-key-vault.md)
- [VM Deployment](vm-deployment.md)

Read these during LAB-06 and LAB-07.
They explain image publishing, how Azure Key Vault feeds the deployment workflow, and how the VM stack is exposed.

## 5. Use When Something Breaks

- [Troubleshooting](troubleshooting.md)

Keep this open during LAB-08 and during instructor checkpoints.

## 6. Review Improvement Notes

- [Trainee Validation Findings](trainee-validation-findings.md)

Use this after a full dry run.
It captures real friction points found while following the project like a student.

## Milestone Validation Scripts

Run these at the matching points in the journey:

- `bash scripts/validate-prerequisites.sh`
- `bash scripts/validate-local-stack.sh`
- `bash scripts/validate-observability.sh`
- `bash scripts/validate-vm-deployment.sh http://YOUR_VM_OR_LOCAL_URL`
- `bash scripts/validate-project.sh`
