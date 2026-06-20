# LAB-01 Run Locally and Use GUI

## Goal

Start the stack and use the GUI as the main traffic generator.

## Problem Scenario

You need a fast way to see whether the service is alive before you inspect deeper layers.

## Files Used

- `.env.example`
- `docker-compose.yml`
- `app/src/public/*`

## Commands to Run

First confirm the local container tools are ready:

```bash
docker --version
docker compose version
docker ps
```

Then start the stack:

```bash
cp .env.example .env
docker compose up --build
```

After the containers start, check the service state:

```bash
docker compose ps
bash scripts/validate-local-stack.sh
```

## GUI Actions to Click

- Check Health
- Show Version

## Expected Output

- GUI opens at `http://localhost:8080`
- health returns `ok`
- version shows environment and image tag
- `docker compose ps` shows healthy `postgres`, `redis`, `app`, and `nginx` services

## Checkpoint Questions

- Which container is the public entry point?
- Why is the app not exposed directly on a public port?
- Which checks tell you the issue is your laptop setup versus the project itself?

## Common Issues

- `.env` file missing
- image still building
- Docker Desktop or Docker daemon not started
- Docker Compose plugin not installed

## Team Task Split

- Student 1 opens GUI and checks responses
- Student 2 confirms compose services are healthy
- Student 3 explains Nginx role
- Student 4 records the URLs and status

## Instructor Checkpoint

Each team must show the GUI and explain the difference between `/health` and `/version`.

## Next Step

Continue to [LAB-02 Compose Layers DB Cache](LAB-02-compose-layers-db-cache.md).
