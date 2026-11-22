#!/bin/bash
set -euo pipefail

OPTIONS=/data/options.json
opt() { jq -r --arg k "$1" '.[$k] // empty' "$OPTIONS"; }

ACTUAL_SERVER_URL="$(opt actual_server_url)"
ACTUAL_PASSWORD="$(opt actual_password)"
ACTUAL_BUDGET_SYNC_ID="$(opt budget_sync_id)"
ACTUAL_BUDGET_PASSWORD="$(opt budget_encryption_password)"
AUTH_TOKEN="$(opt auth_token)"
READ_ONLY="$(opt read_only)"

fail() { echo "[actual-mcp] ERROR: $*" >&2; exit 1; }

[ -n "$ACTUAL_SERVER_URL" ]     || fail "actual_server_url is not set."
[ -n "$ACTUAL_PASSWORD" ]       || fail "actual_password is not set."
[ -n "$ACTUAL_BUDGET_SYNC_ID" ] || fail "budget_sync_id is not set (Actual > Settings > Show advanced settings > Sync ID)."

# A blank token would disable authentication entirely, so refuse to start without a strong one.
if [ "${#AUTH_TOKEN}" -lt 32 ]; then
  fail "auth_token must be at least 32 characters. Generate one with: openssl rand -hex 32"
fi

export ACTUAL_SERVER_URL ACTUAL_PASSWORD ACTUAL_BUDGET_SYNC_ID
[ -n "$ACTUAL_BUDGET_PASSWORD" ] && export ACTUAL_BUDGET_PASSWORD
export MCP_SSE_AUTHORIZATION="$AUTH_TOKEN"
export MCP_BRIDGE_PORT=3600
export MCP_BRIDGE_BIND_HOST=0.0.0.0
export MCP_BRIDGE_DATA_DIR=/data/actual-data
export NODE_ENV=production

if [ "$READ_ONLY" = "true" ]; then
  export MCP_READ_ONLY=true
  echo "[actual-mcp] Read-only mode: write tools are hidden."
else
  echo "[actual-mcp] WARNING: write tools are enabled."
fi

mkdir -p "$MCP_BRIDGE_DATA_DIR"
echo "[actual-mcp] Starting; MCP endpoint on :3600/http, health on :3600/health"
exec actual-mcp-server --http
