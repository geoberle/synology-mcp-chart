FROM ghcr.io/sparfenyuk/mcp-proxy:v0.12.0

RUN pip install --no-cache-dir uv

ENTRYPOINT ["mcp-proxy"]
