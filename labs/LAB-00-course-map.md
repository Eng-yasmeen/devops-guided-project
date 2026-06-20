# LAB-00 Course Map

## Goal

Understand the full project story before touching commands.

## Problem Scenario

A team wants one small service that can be:

- run locally
- observed
- packaged
- pushed
- deployed
- verified
- recovered after simple failures

## Files Used

- `README.md`
- `docs/architecture.md`

## Commands to Run

No commands yet.

## GUI Actions to Click

None yet.

## Expected Output

Students can explain:

`code -> GUI -> container -> compose -> DB -> cache -> reverse proxy -> logs -> metrics -> registry -> VM -> smoke test -> recovery`

## Checkpoint Questions

- Why do we have both logs and metrics?
- Why is Nginx the public entry point?
- Why do we keep the app simple?

## Common Issues

- students jump too early into tooling details

## Team Task Split

- Student 1: app and GUI
- Student 2: compose, DB, Redis
- Student 3: Nginx and observability
- Student 4: CI/CD and deployment

## Instructor Checkpoint

Ask each team to explain the story in one sentence.

## Next Step

Read [Architecture](../docs/architecture.md), then continue to [LAB-01 Run Locally and Use GUI](LAB-01-run-locally-and-use-gui.md).
