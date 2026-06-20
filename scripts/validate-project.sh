#!/usr/bin/env bash
set -Eeuo pipefail

PROJECT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXIT_CODE=0
NODE_BIN="${NODE_BIN:-}"

pass() {
  printf '[PASS] %s\n' "$1"
}

fail() {
  printf '[FAIL] %s\n' "$1"
  EXIT_CODE=1
}

check_file() {
  local path="$1"
  if [[ -f "${PROJECT_DIR}/${path}" ]]; then
    pass "Found ${path}"
  else
    fail "Missing ${path}"
  fi
}

echo "Running guided-project sanity checks..."

if [[ -z "${NODE_BIN}" ]]; then
  if command -v node >/dev/null 2>&1; then
    NODE_BIN="$(command -v node)"
  elif [[ -x "/Applications/Codex.app/Contents/Resources/cua_node/bin/node" ]]; then
    NODE_BIN="/Applications/Codex.app/Contents/Resources/cua_node/bin/node"
  fi
fi

for path in \
  "docker-compose.yml" \
  "docker-compose.vm.yml" \
  ".github/workflows/ci-build-push.yml" \
  ".github/workflows/deploy-vm.yml" \
  "docs/README.md" \
  "docs/01-prerequisites-and-validation.md" \
  "docs/secrets-and-azure-key-vault.md" \
  "app/src/server.js" \
  "app/src/public/index.html" \
  "app/src/public/app.js" \
  "app/package.json" \
  "app/package-lock.json" \
  "scripts/validate-prerequisites.sh" \
  "scripts/validate-local-stack.sh" \
  "scripts/validate-observability.sh" \
  "scripts/validate-vm-deployment.sh" \
  "monitoring/grafana/provisioning/datasources/datasources.yml" \
  "monitoring/grafana/provisioning/dashboards/dashboards.yml" \
  "monitoring/prometheus/prometheus.yml" \
  "monitoring/promtail/promtail-config.yml"; do
  check_file "${path}"
done

if find "${PROJECT_DIR}" \( -name '._*' -o -name '.DS_Store' \) | grep -q .; then
  fail "Found macOS metadata files in the repository tree."
else
  pass "No macOS metadata files found."
fi

if command -v ruby >/dev/null 2>&1; then
  if ruby -e '
    require "yaml"
    files = ARGV
    files.each { |file| YAML.load_file(file) }
  ' \
    "${PROJECT_DIR}/docker-compose.yml" \
    "${PROJECT_DIR}/docker-compose.vm.yml" \
    "${PROJECT_DIR}/.github/workflows/ci-build-push.yml" \
    "${PROJECT_DIR}/.github/workflows/deploy-vm.yml" \
    "${PROJECT_DIR}/monitoring/prometheus/prometheus.yml" \
    "${PROJECT_DIR}/monitoring/promtail/promtail-config.yml" \
    "${PROJECT_DIR}/monitoring/grafana/provisioning/datasources/datasources.yml" \
    "${PROJECT_DIR}/monitoring/grafana/provisioning/dashboards/dashboards.yml"; then
    pass "YAML files parsed successfully."
  else
    fail "One or more YAML files failed to parse."
  fi
else
  fail "ruby is not available for YAML validation."
fi

if [[ -n "${NODE_BIN}" ]]; then
  if "${NODE_BIN}" --check "${PROJECT_DIR}/app/src/server.js" \
    && "${NODE_BIN}" --check "${PROJECT_DIR}/app/src/public/app.js" \
    && "${NODE_BIN}" --check "${PROJECT_DIR}/app/tests/app.test.js"; then
    pass "Node syntax checks passed."
  else
    fail "Node syntax checks failed."
  fi
else
  fail "node is not available for syntax validation."
fi

if [[ -z "${NODE_BIN}" ]]; then
  fail "node is not available for app test execution."
elif [[ -d "${PROJECT_DIR}/app/node_modules" ]]; then
  if (cd "${PROJECT_DIR}/app" && "${NODE_BIN}" --test tests/*.test.js); then
    pass "App test suite passed."
  else
    fail "App test suite failed."
  fi
else
  fail "app/node_modules is missing. Run npm ci in app/ before full validation."
fi

if rg -n 'data-link="http://localhost' "${PROJECT_DIR}/app/src/public/index.html" >/dev/null 2>&1; then
  fail "Found hardcoded localhost observability shortcut links in the GUI."
else
  pass "No hardcoded localhost observability shortcuts remain in the GUI."
fi

if rg -n 'uses: azure/login@v1' "${PROJECT_DIR}/.github/workflows/deploy-vm.yml" >/dev/null 2>&1 \
  && rg -n 'uses: azure/CLI@v1' "${PROJECT_DIR}/.github/workflows/deploy-vm.yml" >/dev/null 2>&1; then
  pass "Deploy workflow includes Azure login and Azure Key Vault retrieval steps."
else
  fail "Deploy workflow is missing the expected Azure login or Azure Key Vault retrieval steps."
fi

if [[ "${EXIT_CODE}" -eq 0 ]]; then
  echo "Sanity checks completed successfully."
else
  echo "Sanity checks found one or more problems."
fi

exit "${EXIT_CODE}"
