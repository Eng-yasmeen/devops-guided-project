# LAB-02 Compose Layers DB Cache

## Goal

See how the app depends on PostgreSQL and Redis.

## Problem Scenario

The service is running, but now you need to understand what happens when data and cache layers are involved.

## Files Used

- `docker-compose.yml`
- `db/init.sql`
- `app/src/db.js`
- `app/src/redis.js`

## Commands to Run

```bash
docker compose ps
docker compose logs postgres --tail=30
docker compose logs redis --tail=30
```

## GUI Actions to Click

- Load Items from PostgreSQL
- Create Demo Item
- Test Redis Cache
- Check Readiness

## Expected Output

- seed items load from PostgreSQL
- new item is created
- cache demo first shows app-generated value, then cached value
- readiness confirms DB and Redis reachability

## Checkpoint Questions

- What does `/ready` check that `/health` does not?
- What did PostgreSQL add to the story?
- What did Redis add to the story?

## Common Issues

- DB not healthy yet
- Redis not ready yet

## Team Task Split

- Student 1 uses GUI
- Student 2 explains database flow
- Student 3 explains cache flow
- Student 4 verifies service health

## Instructor Checkpoint

Ask teams to explain one request that touched PostgreSQL and one that touched Redis.

## Next Step

Continue to [LAB-03 Nginx Reverse Proxy](LAB-03-nginx-reverse-proxy.md).
