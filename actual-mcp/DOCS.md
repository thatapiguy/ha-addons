# Actual Budget MCP Server

Runs [actual-mcp-server](https://github.com/agigante80/actual-mcp-server) as a Home Assistant app so
Claude (or any MCP client) can query and manage your Actual Budget.

## Configuration

| Option | Description |
|---|---|
| `actual_server_url` | Where the app reaches Actual. Default is the internal hostname of the "Actual Budget Stable" app. |
| `actual_password` | Your Actual server password. |
| `budget_sync_id` | Actual > Settings > Show advanced settings > Sync ID. |
| `budget_encryption_password` | Only if the budget has end-to-end encryption. |
| `auth_token` | Bearer token clients must send. At least 32 characters (`openssl rand -hex 32`). The app refuses to start without one. |
| `read_only` | `true` (default) hides every write tool. Set to `false` to allow edits. |

## Connecting a client

- MCP endpoint: `https://<your-hostname>/http`
- Header: `Authorization: Bearer <auth_token>`
- Health check: `/health` (no auth)

Expose it with a Cloudflared additional host, for example `actual-mcp.example.com` -> `http://<HA-IP>:3600`.

## Notes

- The MCP server's Actual API version should match your Actual server version. If you see sync/version
  errors, update the Actual app or pin an older `ACTUAL_MCP_VERSION` in the Dockerfile.
- Budget data is cached under `/data/actual-data` and is included in HA backups.
