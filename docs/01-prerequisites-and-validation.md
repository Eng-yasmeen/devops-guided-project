# Prerequisites and Validation

Use this document before LAB-01.

## Goal

Make sure the trainee laptop is ready before the guided project starts.

## Required Tools

- Docker Engine with the Docker Compose v2 plugin
- Git
- Node.js 20 or later
- npm
- curl

## Recommended Install Paths

### macOS and Windows

- install Docker Desktop
- install Git
- install Node.js 20 LTS

### Ubuntu or other Linux distributions

- install Docker Engine
- install the Docker Compose v2 plugin
- install Git
- install Node.js 20 LTS
- install curl

After adding your Linux user to the `docker` group, open a new terminal or SSH session before running the validation script.

## Preflight Commands

Run:

```bash
docker --version
docker compose version
docker ps
git --version
node --version
npm --version
curl --version
```

What good looks like:

- Docker is installed
- Docker Compose v2 is available
- Docker daemon is reachable
- Git is installed
- Node and npm are installed
- curl is installed

## Validation Script

Run:

```bash
bash scripts/validate-prerequisites.sh
```

This script checks:

- Docker
- Docker Compose
- Docker daemon reachability
- Git
- Node
- npm
- curl

## If Something Fails

- if `docker compose version` fails, install Docker Compose v2 or Docker Desktop
- if `docker ps` fails, start Docker Desktop or the Docker service
- on Linux, if Docker is running but `docker ps` still fails, add your user to the `docker` group and start a new shell
- if `node --version` fails, install Node.js 20 or later
- if `curl --version` fails, install curl

Do not continue to LAB-01 until the prerequisite script passes.

## Next Step

Move to [LAB-00 Course Map](../labs/LAB-00-course-map.md).
