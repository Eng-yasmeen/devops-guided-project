# LAB-00 Course Map

## Goal

Understand the full project story before you start running commands.

## Why This Lab Matters

This project is not mainly about app code. It is about learning how one small service moves through a realistic DevOps journey:

`code -> run -> observe -> package -> push -> deploy -> verify -> recover`

If students understand that story first, the later labs feel connected instead of scattered.

## Before You Start

Have the root [README](../README.md) open.

If you have not checked your machine yet, read [Prerequisites and Validation](../docs/01-prerequisites-and-validation.md) before moving into LAB-01.

## Files Used

- `README.md`
- `docs/architecture.md`
- `docs/runtime-stack.md`
- `docs/request-and-data-flow.md`

## What To Review

Read these in order:

1. [Architecture](../docs/architecture.md)
2. [Runtime Stack](../docs/runtime-stack.md)
3. [Request And Data Flow](../docs/request-and-data-flow.md)

As you read, make sure you can point to:

- where the browser connects first
- where the app runs
- where PostgreSQL and Redis fit
- where logs go
- where metrics go
- how the image reaches the VM later

## Expected Output

Students can explain the project in one short sentence, for example:

`A small app runs behind Nginx, uses PostgreSQL and Redis, sends logs and metrics to the observability stack, then gets packaged and deployed to a VM.`

## Checkpoint Questions

- Why do we have both logs and metrics?
- Why is Nginx the public entry point?
- Why do we keep the app simple?
- Why does the course teach local validation before VM deployment?

## Common Issues

- students jump into commands before understanding the stack
- students treat Grafana, Prometheus, Loki, and Nginx as separate tools instead of one system
- students do not yet know which components are public and which stay private

## Team Task Split

- Student 1 explains the app and GUI
- Student 2 explains Docker Compose, PostgreSQL, and Redis
- Student 3 explains Nginx, logs, and metrics
- Student 4 explains CI/CD, registry, and VM deployment

## Instructor Checkpoint

Ask each team to describe the full system story in one sentence and point to the architecture diagram while explaining it.

## Validation

Before LAB-01, complete the prerequisite validator:

```bash
bash scripts/validate-prerequisites.sh
```

## Next Step

Read [Architecture](../docs/architecture.md), then continue to [LAB-01 Run Locally and Use GUI](LAB-01-run-locally-and-use-gui.md).
