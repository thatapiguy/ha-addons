#!/usr/bin/env bashio

JWT_SECRET_KEY=$(bashio::config 'jwt_secret_key')
if bashio::config.is_empty 'jwt_secret_key'; then
    KEY_FILE="/data/.jwt_secret"
    if [ ! -f "${KEY_FILE}" ]; then
        cat /proc/sys/kernel/random/uuid | tr -d '-' > "${KEY_FILE}"
        bashio::log.warning "No JWT secret key configured. Generated and saved to /data/.jwt_secret. Set it explicitly in add-on config for portability across reinstalls."
    fi
    JWT_SECRET_KEY=$(cat "${KEY_FILE}")
fi

export JWT_SECRET_KEY
export STORAGE_PATH="/data"
export DEBUG=$(bashio::config 'debug')

if bashio::config.true 'mcp_enabled'; then
    export KITCHENOWL_MCP_ENABLED="true"
fi

bashio::log.info "Starting KitchenOwl..."
cd /usr/src/kitchenowl
exec ./entrypoint.sh --ini wsgi.ini:web --gevent 200 --max-fd 1048576
