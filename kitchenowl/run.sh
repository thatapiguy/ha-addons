#!/usr/bin/env bash
set -e

OPTIONS="/data/options.json"

_opt() { python3 -c "import json; d=json.load(open('${OPTIONS}')); print(d.get('$1', ''))" ; }
_bool() { python3 -c "import json; d=json.load(open('${OPTIONS}')); print(str(d.get('$1', False)).lower())" ; }

jwt_secret=$(_opt 'jwt_secret_key')
if [ -z "${jwt_secret}" ]; then
    KEY_FILE="/data/.jwt_secret"
    if [ ! -f "${KEY_FILE}" ]; then
        python3 -c "import uuid; print(uuid.uuid4().hex)" > "${KEY_FILE}"
        echo "WARNING: No JWT secret key configured. Generated and saved to /data/.jwt_secret. Set it explicitly in add-on config for portability across reinstalls."
    fi
    jwt_secret=$(cat "${KEY_FILE}")
fi

export JWT_SECRET_KEY="${jwt_secret}"
export STORAGE_PATH="/data"
export DEBUG=$(_bool 'debug')

if [ "$(_bool 'mcp_enabled')" = "true" ]; then
    export KITCHENOWL_MCP_ENABLED="true"
fi

echo "INFO: Starting KitchenOwl..."
cd /usr/src/kitchenowl
exec ./entrypoint.sh --ini wsgi.ini:web --gevent 200 --max-fd 1048576
