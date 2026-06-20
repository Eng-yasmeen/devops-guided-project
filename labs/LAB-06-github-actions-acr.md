# LAB-06 GitHub Actions ACR

## Goal

See how the app becomes a reusable image in Azure Container Registry.

## Why This Lab Matters

Running locally proves the app works on one machine. CI/CD turns that into a repeatable build and publish path that teams can trust and reuse for deployment or recovery.

## Before You Start

Make sure students already understand:

- what the app image contains
- why we want tagged images
- why deployment should consume an image instead of rebuilding on the VM

Read [Registries](../docs/08-registries.md) before or during this lab.

## Files Used

- `.github/workflows/ci-build-push.yml`
- `docker/app.Dockerfile`
- `docs/08-registries.md`

## Commands to Run

```bash
git status
```

Then do these guided checks:

1. Open the Actions tab and inspect the latest `CI Build Push` run.
2. If you have registry access, inspect the `devops-mini-app` repository in ACR.

## What To Do

1. Read the workflow triggers.
2. Identify which path runs on pull request.
3. Identify which path builds and pushes on `main`.
4. Open a successful run and find the final pushed image names.
5. Find one `sha-<short-sha>` tag that could be redeployed later.

## Expected Output

- pull requests run tests only
- push to `main` builds and pushes the image
- image tags include `latest` and `sha-<short-sha>`
- students can point to one run that only validated and one run that published
- students can identify the exact SHA tag that would be used for recovery

## Checkpoint Questions

- Why do pull requests test but not push?
- Why is the SHA tag useful for recovery?
- Where in the workflow logs do you confirm the final pushed image names?
- Where in ACR do you confirm that the image was actually published?

## Common Issues

- ACR credentials missing
- workflow not running on the expected branch
- students read the YAML but never verify the real workflow outcome
- students confuse a successful test run with a published image

## Team Task Split

- Student 1 reads workflow triggers
- Student 2 reads build and test steps
- Student 3 verifies the published image names from the workflow run
- Student 4 verifies the matching image tags in ACR and explains which secrets make the push path work

## Instructor Checkpoint

Have teams explain the difference between validation and publishing, then show:

- one workflow run that tested only
- one workflow run that published
- one SHA tag they could redeploy later

## Validation

There is no separate lab-only script here.

Validation for this lab is:

- a successful `CI Build Push` workflow run
- visible image tags in ACR
- a team explanation of which tag should be deployed next

## Next Step

Read [Registries](../docs/08-registries.md), then [Azure Key Vault and Secrets Flow](../docs/09-secrets-and-azure-key-vault.md), then continue to [LAB-07 Deploy to VM](LAB-07-deploy-to-vm.md).
