# Registries

This project fully implements **GHCR**.

Other registries are documented for comparison only.

For the main guided path:

- build and publish the app image to GHCR
- deploy that image to the VM
- use Azure Key Vault or GitHub Secrets to provide the runtime secrets needed during deployment

## GHCR

Use when:

- your code is already in GitHub
- you want the simplest training setup

Image format:

```text
ghcr.io/<owner>/<repo>/devops-mini-app:latest
ghcr.io/<owner>/<repo>/devops-mini-app:sha-<short-sha>
```

Secrets:

- default path can use `GITHUB_TOKEN` in GitHub Actions

Student verification:

- check the `CI Build Push` workflow logs for the final image names
- check the repository package page for `latest` and `sha-<short-sha>` tags

Login example:

```yaml
- name: Log in to GHCR
  uses: docker/login-action@v3
  with:
    registry: ghcr.io
    username: ${{ github.actor }}
    password: ${{ secrets.GITHUB_TOKEN }}
```

Pros:

- simple for training
- easy permission model

Cons:

- tied to GitHub

## Docker Hub

Use when:

- you want a generic public registry

Image format:

```text
docker.io/<username>/devops-mini-app:latest
```

Secrets:

- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`

Login example:

```yaml
- name: Log in to Docker Hub
  uses: docker/login-action@v3
  with:
    username: ${{ secrets.DOCKERHUB_USERNAME }}
    password: ${{ secrets.DOCKERHUB_TOKEN }}
```

Pros:

- widely known
- easy to explain

Cons:

- separate credentials
- public naming conventions can be less convenient for classroom repos

## AWS ECR

Use when:

- you already deploy mostly in AWS

Image format:

```text
<account>.dkr.ecr.<region>.amazonaws.com/devops-mini-app:latest
```

Common secrets:

- AWS credentials
- region
- registry URL

Login step example:

```yaml
- name: Configure AWS credentials
  uses: aws-actions/configure-aws-credentials@v4
- name: Log in to ECR
  uses: aws-actions/amazon-ecr-login@v2
```

Pros:

- strong fit for AWS-first teams

Cons:

- more cloud setup than this course needs

## Azure ACR

Use when:

- you already deploy mostly in Azure

Image format:

```text
<registry>.azurecr.io/devops-mini-app:latest
```

Common secrets:

- ACR username
- ACR password or token
- registry URL

Login step example:

```yaml
- name: Log in to ACR
  uses: docker/login-action@v3
  with:
    registry: ${{ secrets.ACR_LOGIN_SERVER }}
    username: ${{ secrets.ACR_USERNAME }}
    password: ${{ secrets.ACR_PASSWORD }}
```

Pros:

- good fit for Azure-first teams

Cons:

- adds cloud-specific setup that this course intentionally avoids in the core path

## Next Step

Read [Azure Key Vault and Secrets Flow](secrets-and-azure-key-vault.md).
