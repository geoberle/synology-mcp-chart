# Synology MCP

Helm chart for deploying [mcp-synology](https://pypi.org/project/mcp-synology/) on Kubernetes via [mcp-proxy](https://github.com/sparfenyuk/mcp-proxy) (stdio-to-SSE bridge).

Exposes a Synology NAS MCP server over SSE that AI agents (e.g. Hermes) can use for file management and system monitoring.

## Install

```bash
helm install synology-mcp oci://ghcr.io/geoberle/synology-mcp-chart \
  -n synology-mcp --create-namespace \
  -f values.local.yaml
```

## Configuration

Create a `values.local.yaml` with your Synology NAS credentials:

```yaml
synology:
  host: "192.168.1.100"
  port: 5000
  https: false
  username: "admin"
  password: "your-password"
```

All available values:

| Key | Default | Description |
|---|---|---|
| `image.repository` | `ghcr.io/geoberle/synology-mcp` | Container image (mcp-proxy + uv) |
| `image.tag` | `latest` | Image tag |
| `service.port` | `3002` | SSE server port |
| `synology.host` | `""` | NAS hostname or IP, bare — no scheme, no port (e.g. `192.168.1.100`) |
| `synology.port` | `5000` | DSM port (`5000` HTTP, `5001` HTTPS) |
| `synology.https` | `false` | Use HTTPS to reach DSM |
| `synology.username` | `""` | NAS username |
| `synology.password` | `""` | NAS password |
| `resources.requests.cpu` | `100m` | CPU request |
| `resources.requests.memory` | `128Mi` | Memory request |
| `resources.limits.memory` | `256Mi` | Memory limit |
