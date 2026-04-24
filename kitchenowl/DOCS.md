# KitchenOwl Add-on

KitchenOwl is a self-hosted grocery list and recipe manager. This add-on runs the official KitchenOwl all-in-one container inside Home Assistant.

## Installation

1. Add this repository to your Home Assistant add-on store.
2. Install the **KitchenOwl** add-on.
3. Configure options (see below).
4. Start the add-on.
5. Open the Web UI on port **8080**.

## Configuration

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `jwt_secret_key` | string | `""` | Secret key used to sign authentication tokens. If left empty, a random key is auto-generated and persisted in `/data/.jwt_secret`. **Set this explicitly if you ever need to reinstall the add-on without logging everyone out.** |
| `debug` | bool | `false` | Enable Flask debug mode. Not recommended in production. |
| `mcp_enabled` | bool | `false` | Expose the KitchenOwl MCP endpoint at `/mcp`. |

## Data Storage

All persistent data (SQLite database, uploaded images) is stored in the add-on's `/data` directory, which survives add-on restarts and updates.

## First Run

On first start, KitchenOwl will run database migrations automatically. Open `http://<your-ha-ip>:8080` and create your admin account.

## Updating

Update the `version` field in `build.yaml` and `config.yaml` to a newer `tombursch/kitchenowl` image tag, then rebuild.
