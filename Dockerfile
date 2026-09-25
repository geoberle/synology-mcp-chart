FROM ghcr.io/sparfenyuk/mcp-proxy:v0.12.0

RUN pip install --no-cache-dir mcp-server-synology==1.7.1

ENTRYPOINT ["mcp-proxy"]
