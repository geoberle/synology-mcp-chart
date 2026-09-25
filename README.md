# Synology MCP

Helm chart for deploying [mcp-server-synology](https://github.com/atom2ueki/mcp-server-synology) on Kubernetes via [mcp-proxy](https://github.com/sparfenyuk/mcp-proxy) (stdio-to-SSE bridge).

Exposes a Synology NAS MCP server over SSE that AI agents (e.g. Hermes) can use to
manage files, Download Station, Container Manager (Docker), iSCSI LUNs/targets, NFS
shares, users/groups, and system/disk/volume health (SMART).

The pod uses normal cluster networking (`ClusterIP` Service, no `hostNetwork`)
— reach it from another workload at
`http://synology-mcp-chart.<namespace>.svc.cluster.local:3002/sse`.

## Full tool surface — read before enabling

This server registers ~93 tools unconditionally; there is no allow-list or
per-module toggle upstream. Alongside health/SMART/volume monitoring it also
exposes **destructive** operations: delete files, delete Docker containers and
images, create/delete iSCSI LUNs and targets, toggle NFS, and create/delete/modify
local users and groups. Whatever client you point at this server (e.g. Hermes)
gets all of it. The DSM account also needs **administrators**-group membership
for storage/disk/user/service tools to work at all.

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
  url: "http://192.168.1.100:5000"
  username: "admin"
  password: "your-password"
```

All available values:

| Key | Default | Description |
|---|---|---|
| `image.repository` | `ghcr.io/geoberle/synology-mcp` | mcp-proxy with mcp-server-synology installed at build time (no runtime fetch) |
| `image.tag` | `latest` | Image tag |
| `service.port` | `3002` | SSE server port |
| `synology.url` | `""` | Full NAS base URL, scheme + host + port (e.g. `http://192.168.1.100:5000`) |
| `synology.username` | `""` | NAS username (needs admin-group membership for storage/disk/user tools) |
| `synology.password` | `""` | NAS password |
| `synology.verifySsl` | `false` | Verify DSM's TLS certificate (only relevant for `https://` URLs) |
| `resources.requests.cpu` | `100m` | CPU request |
| `resources.requests.memory` | `128Mi` | Memory request |
| `resources.limits.memory` | `256Mi` | Memory limit |
