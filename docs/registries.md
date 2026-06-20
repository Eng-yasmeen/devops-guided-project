# Registries

This project fully implements **Azure Container Registry (ACR)**.

Other registries are documented for comparison only.

For the main guided path:

- build and publish the app image to ACR
- deploy that image to the VM
- use Azure Key Vault or GitHub Secrets to provide the runtime secrets needed during deployment

## Azure ACR

Use when:

- the project deploys to Azure-hosted training infrastructure
- you want one consistent registry story for CI and VM deployment

Image format:

```text
<registry>.azurecr.io/devops-mini-app:latest
<registry>.azurecr.io/devops-mini-app:sha-<short-sha>
```

Secrets:

- `REGISTRY_LOGIN_SERVER`
- `REGISTRY_USERNAME`
- `REGISTRY_PASSWORD`

Student verification:

- check the `CI Build Push` workflow logs for the final image names
- check the ACR repository tags for `latest` and `sha-<short-sha>`

Login example:

```yaml
- name: Log in to ACR
  uses: docker/login-action@v3
  with:
    registry: ${{ secrets.REGISTRY_LOGIN_SERVER }}
    username: ${{ secrets.REGISTRY_USERNAME }}
    password: ${{ secrets.REGISTRY_PASSWORD }}
```

Pros:

- aligns naturally with Azure VM training
- keeps the registry story consistent with Azure Key Vault usage
- works well for a guided enterprise-style path

Cons:

- requires registry credentials
- is more cloud-specific than GHCR

## GHCR

Use when:

- your code is already in GitHub
- you want a GitHub-native alternative

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

- simple when the whole course stays inside GitHub

Cons:

- less aligned if the training deployment target and secret story are already Azure-based

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

## Next Step

Read [Azure Key Vault and Secrets Flow](secrets-and-azure-key-vault.md).
