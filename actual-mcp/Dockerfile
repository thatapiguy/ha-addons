FROM node:22-bookworm-slim

LABEL maintainer="vivekbavishi@gmail.com"

ARG ACTUAL_MCP_VERSION=0.35.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends jq ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g --no-audit --no-fund actual-mcp-server@${ACTUAL_MCP_VERSION} \
    && npm cache clean --force

COPY run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 3600
ENTRYPOINT ["/run.sh"]
