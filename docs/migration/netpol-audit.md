# NetworkPolicy Audit — Cilium Compatibility

**Date:** 2026-06-11
**Cluster:** nishir (RKE2 v1.34.7)
**Current CNI:** Canal (Calico + Flannel)
**Target CNI:** Cilium
**Context:** `nishir-k8s-operator.taila659a.ts.net`

---

## Executive Summary

The cluster runs **72 standard `networking.k8s.io/v1` NetworkPolicy** resources across
6 namespaces. All policies use the upstream Kubernetes API — **none use Calico-specific
CRDs** (`GlobalNetworkPolicy`, `NetworkSet`, `HostEndpoint`, etc.). The Calico CRDs
present on the cluster have **zero custom resources instantiated** (except for 3
Canal-internal ones: `default-ipv4-ippool`, `default-ipv6-ippool`, `felixconfiguration/default`,
`clusterinformation/default`).

**Verdict: Low-risk migration.** All 72 NetworkPolicies are standard Kubernetes
`networking.k8s.io/v1` and are fully compatible with Cilium's `NetworkPolicy` support.
No `CiliumNetworkPolicy` conversion is required for existing policies.

---

## Current State

### CNI

| Component | Detail |
|-----------|--------|
| CNI Plugin | Canal (`rke2-canal` DaemonSet, 3 nodes) |
| Calico CRDs | 21 CRDs installed (from Canal bundle) |
| Cilium CRDs | None |
| Cilium installed | No |

### Calico CRD Instances

| CRD | Instances | Notes |
|-----|-----------|-------|
| `ippools.crd.projectcalico.org` | 2 (`default-ipv4-ippool`, `default-ipv6-ippool`) | Canal IPAM |
| `felixconfigurations.crd.projectcalico.org` | 1 (`default`) | Canal dataplane config |
| `clusterinformations.crd.projectcalico.org` | 1 (`default`) | Canal cluster info |
| All other Calico CRDs | 0 | No custom resources |

**Action:** These 4 Canal-internal resources will be removed automatically when Canal
is replaced by Cilium. No manual migration needed.

### NetworkPolicy Inventory

| Namespace | Count | Notes |
|-----------|-------|-------|
| `shikanime` | 52 | Application workloads (Flux-managed) |
| `kube-system` | 7 | RKE2 built-in (DNS, ingress, metrics, traefik, snapshots) |
| `longhorn-system` | 7 | Longhorn Helm release |
| `flux-system` | 4 | Flux Operator + Helm release |
| `default` | 1 | RKE2 default deny |
| `kube-public` | 1 | RKE2 default deny |
| **Total** | **72** | |

### Policy Breakdown by Source

| Source | Count | Identification |
|--------|-------|----------------|
| Flux-managed (kustomize) | 52 | `kustomize.toolkit.fluxcd.io/name` label |
| Helm-managed | 8 | `meta.helm.sh/release-name` annotation (flux-operator, longhorn) |
| RKE2 built-in | 9 | `np.rke2.io` annotations |
| Unattributed | 3 | `allow-egress`, `allow-scraping`, `allow-webhooks` in flux-system |

### Policy Type Distribution

| Type | Count |
|------|-------|
| Ingress-only | 69 |
| Ingress + Egress | 3 |

#### Policies with Egress Rules

1. `flux-system/allow-egress` — full egress allow-all + ingress intra-pod
2. `shikanime/synapse-proxy` — egress to synapse + mautrix-discord + DNS
3. `shikanime/synapse-proxy-tailscale` — same egress + tailscale ingress

#### Policies with matchExpressions

1. `longhorn-system/longhorn-manager` — uses `matchExpressions` for `recurring-job.longhorn.io` and `longhorn.io/job-task` keys
2. `longhorn-system/longhorn-ui-frontend` — uses `namespaceSelector` with `matchLabels`

Both patterns are standard `networking.k8s.io/v1` and fully supported by Cilium.

---

## Cilium Compatibility Assessment

### Standard NetworkPolicy Support

Cilium fully supports `networking.k8s.io/v1` NetworkPolicy. All 72 existing policies
will work as-is after CNI migration. No conversion to `CiliumNetworkPolicy` is required.

### Features Used vs Cilium Support

| Feature | Used | Cilium Support | Notes |
|---------|------|----------------|-------|
| `podSelector` (matchLabels) | Yes (all) | Full | Core feature |
| `namespaceSelector` | Yes (several) | Full | Core feature |
| `namespaceSelector` + `matchLabels` | Yes (longhorn-ui-frontend) | Full | Core feature |
| `podSelector` (matchExpressions) | Yes (longhorn-manager) | Full | Core feature |
| `policyTypes: [Ingress]` | Yes (69) | Full | Core feature |
| `policyTypes: [Ingress, Egress]` | Yes (3) | Full | Core feature |
| Named ports | Yes (http, https, webhook, etc.) | Full | Core feature |
| `ipBlock` | No | Full | Not currently used |
| `ports.protocol: UDP` | Yes (qbittorrent-tailscale, DNS) | Full | Core feature |
| Egress `to.podSelector` | Yes (synapse-proxy) | Full | Core feature |
| Egress `to.namespaceSelector` | Yes (synapse-proxy DNS) | Full | Core feature |

### Calico-Specific CRDs — Migration Impact

| Calico CRD | Instances | Migration Action |
|------------|-----------|-----------------|
| `globalnetworkpolicies.crd.projectcalico.org` | 0 | None — no resources to convert |
| `networkpolicies.crd.projectcalico.org` | 0 | None — no resources to convert |
| `networksets.crd.projectcalico.org` | 0 | None — no resources to convert |
| `hostendpoints.crd.projectcalico.org` | 0 | None — no resources to convert |
| `stagednetworkpolicies.crd.projectcalico.org` | 0 | None — no resources to convert |
| `stagedglobalnetworkpolicies.crd.projectcalico.org` | 0 | None — no resources to convert |
| `stagedkubernetesnetworkpolicies.crd.projectcalico.org` | 0 | None — no resources to convert |
| `bgpconfigurations.crd.projectcalico.org` | 0 | None |
| `bgpfilters.crd.projectcalico.org` | 0 | None |
| `bgppeers.crd.projectcalico.org` | 0 | None |
| `ippools.crd.projectcalico.org` | 2 | Remove (Canal IPAM, replaced by Cilium IPAM) |
| `felixconfigurations.crd.projectcalico.org` | 1 | Remove (Canal dataplane config) |
| `clusterinformations.crd.projectcalico.org` | 1 | Remove (Canal cluster info) |
| All other Calico CRDs | 0 | None |

**No `CiliumNetworkPolicy` CRD resources need to be created.** The existing standard
NetworkPolicies are sufficient.

---

## Migration Recommendations

### Pre-Migration

1. **Export current policies as backup:**
   ```bash
   kubectl get netpol -A -o yaml > netpol-backup-$(date +%Y%m%d).yaml
   ```

2. **Verify no Calico CRDs are in use** (confirmed above — only Canal-internal instances exist).

3. **Document the 3 egress policies** — these are the most sensitive during CNI transition:
   - `flux-system/allow-egress` — Flux needs egress for git/helm operations
   - `shikanime/synapse-proxy` — Matrix synapse proxy needs egress to backends + DNS
   - `shikanime/synapse-proxy-tailscale` — same, via tailscale

### During Migration

4. **Install Cilium** with `kubeProxyReplacement: true` (recommended for RKE2).
   Cilium will begin enforcing existing `networking.k8s.io/v1` policies immediately.

5. **Remove Canal** — the `rke2-canal` DaemonSet and its Calico CRDs will be cleaned up.
   The 4 Canal-internal Calico CRD instances will disappear with it.

6. **Verify policy enforcement** — run connectivity tests for:
   - DNS resolution (kube-dns policy)
   - Ingress traffic (rke2-ingress-nginx policies)
   - Inter-service communication (shikanime namespace policies)
   - Egress (flux-system, synapse-proxy)

### Post-Migration (Optional Enhancements)

7. **Consider Cilium-native policies** for advanced use cases:
   - `CiliumNetworkPolicy` — adds `toCIDR`/`fromCIDR`, `toEntities`/`fromEntities`, DNS-based rules
   - `CiliumClusterwideNetworkPolicy` — cluster-wide policies (replaces the need for per-namespace default policies)
   - `CiliumEgressGatewayPolicy` — controlled egress (replaces the `allow-egress` catch-all)

8. **Consider replacing `allow-egress`** (flux-system) with a more restrictive
   `CiliumNetworkPolicy` that limits egress to specific CIDRs/domains.

9. **Consider Cilium L7 policies** for application-layer control on the shikanime
   workloads (e.g., HTTP path-based rules for the media stack).

---

## Namespace-by-Namespace Notes

### `shikanime` (52 policies)

All Flux-managed via kustomize. Standard `networking.k8s.io/v1` with `matchLabels`
podSelectors. Well-structured with consistent labeling (`app.kubernetes.io/*`).

**Patterns observed:**
- Each app has an internal policy (pod-to-pod within shikanime) and a tailscale policy
- Media stack (arr apps) follow a consistent pattern: prowlarr -> lidarr/sonarr/radarr/whisparr -> bazarr/jellyfin/seerr
- Communication stack (mautrix bridges) all connect to synapse
- Synapse-proxy is the only app with egress rules (to synapse, mautrix-discord, DNS)

**Cilium compatibility: FULL — no issues.**

### `kube-system` (7 policies)

RKE2 built-in policies for core infrastructure:
- `default-network-dns-policy` — allows DNS (53/TCP, 53/UDP) to kube-dns
- `default-network-ingress-policy` — allows HTTP/HTTPS to rke2-ingress-nginx
- `default-network-ingress-webhook-policy` — allows webhook port to ingress-nginx
- `default-network-metrics-server-policy` — allows HTTPS to metrics-server
- `default-network-snapshot-validation-webhook-policy` — allows HTTPS to snapshot webhook
- `default-network-traefik-policy` — allows web/websecure to traefik
- `default-network-policy` — default intra-pod allow

**Cilium compatibility: FULL — no issues.**

### `longhorn-system` (7 policies)

Helm-managed by Longhorn. Uses `matchExpressions` in `longhorn-manager` policy
for recurring jobs and job tasks. Uses combined `namespaceSelector` + `podSelector`
in `longhorn-ui-frontend` policy.

**Cilium compatibility: FULL — matchExpressions and combined selectors are supported.**

### `flux-system` (4 policies)

Mixed source: 1 Helm-managed (flux-operator-web), 3 unattributed (allow-egress,
allow-scraping, allow-webhooks). The `allow-egress` policy is the only one with
egress rules in this namespace.

**Cilium compatibility: FULL — no issues.**

### `default` / `kube-public` (1 policy each)

RKE2 default `networking.k8s.io/v1` allow-all ingress policies.

**Cilium compatibility: FULL — no issues.**

---

## Risk Matrix

| Risk | Level | Detail |
|------|-------|--------|
| Policy API incompatibility | **None** | All policies use standard `networking.k8s.io/v1` |
| Calico CRD migration | **Low** | Only Canal-internal instances; no user-created Calico CRDs |
| Egress policy disruption | **Low** | Only 3 policies have egress; well-defined |
| DNS disruption | **Low** | DNS policy is standard; Cilium handles DNS natively |
| Service connectivity | **Low** | All podSelectors use standard matchLabels |
| Tailscale integration | **Low** | Tailscale namespaceSelector is standard |

---

## Appendix: Full Policy List

### default
- `default-network-policy` — Ingress: allow-all intra-pod (RKE2 built-in)

### flux-system
- `allow-egress` — Ingress+Egress: allow-all (unattributed)
- `allow-scraping` — Ingress: port 8080 from all namespaces (unattributed)
- `allow-webhooks` — Ingress: notification-controller from all namespaces (unattributed)
- `flux-operator-web` — Ingress: port 9080 from all namespaces (Helm)

### kube-public
- `default-network-policy` — Ingress: allow-all intra-pod (RKE2 built-in)

### kube-system
- `default-network-dns-policy` — Ingress: DNS 53/TCP+UDP to kube-dns (RKE2)
- `default-network-ingress-policy` — Ingress: HTTP/HTTPS to ingress-nginx (RKE2)
- `default-network-ingress-webhook-policy` — Ingress: webhook to ingress-nginx (RKE2)
- `default-network-metrics-server-policy` — Ingress: HTTPS to metrics-server (RKE2)
- `default-network-policy` — Ingress: allow-all intra-pod (RKE2)
- `default-network-snapshot-validation-webhook-policy` — Ingress: HTTPS to snapshot webhook (RKE2)
- `default-network-traefik-policy` — Ingress: web/websecure to traefik (RKE2)

### longhorn-system
- `backing-image-data-source` — Ingress: from longhorn components (Helm)
- `backing-image-manager` — Ingress: from longhorn components (Helm)
- `instance-manager` — Ingress: from longhorn components (Helm)
- `longhorn-admission-webhook` — Ingress: port 9502 (Helm)
- `longhorn-manager` — Ingress: from longhorn components + matchExpressions (Helm)
- `longhorn-recovery-backend` — Ingress: port 9503 (Helm)
- `longhorn-ui-frontend` — Ingress: from kube-system ingress-nginx + tailscale (Helm)

### shikanime (52 policies)
- `bazarr` — Ingress: from prowlarr
- `bazarr-tailscale` — Ingress: from tailscale
- `chrome` — Ingress: from hermes-agent (CDP)
- `copyparty-tailscale` — Ingress: from tailscale (HTTP + FTP ports)
- `default` — Ingress: allow-all intra-pod
- `forgejo` — Ingress: from jellyfin + syncthing
- `forgejo-tailscale` — Ingress: from tailscale
- `gitea-mirror-tailscale` — Ingress: from tailscale
- `hermes-agent-dashboard-tailscale` — Ingress: from tailscale
- `hermes-agent-gateway` — Ingress: from hermes-agent
- `hermes-agent-gateway-tailscale` — Ingress: from tailscale
- `honcho` — Ingress: from hermes-agent
- `honcho-postgres` — Ingress: from honcho
- `honcho-tailscale` — Ingress: from tailscale
- `jellyfin` — Ingress: from seerr + metatube + chrome + hermes-agent
- `jellyfin-tailscale` — Ingress: from tailscale
- `lidarr` — Ingress: from bazarr + jellyfin + seerr + prowlarr
- `lidarr-tailscale` — Ingress: from tailscale
- `mautrix-discord` — Ingress: from synapse
- `mautrix-discord-tailscale` — Ingress: from tailscale
- `mautrix-googlechat` — Ingress: from synapse
- `mautrix-googlechat-tailscale` — Ingress: from tailscale
- `mautrix-linkedin` — Ingress: from synapse
- `mautrix-linkedin-tailscale` — Ingress: from tailscale
- `mautrix-meta` — Ingress: from synapse
- `mautrix-meta-tailscale` — Ingress: from tailscale
- `mautrix-signal` — Ingress: from synapse
- `mautrix-signal-tailscale` — Ingress: from tailscale
- `mautrix-slack` — Ingress: from synapse
- `mautrix-slack-tailscale` — Ingress: from tailscale
- `mautrix-twitter` — Ingress: from synapse
- `mautrix-whatsapp` — Ingress: from synapse
- `mautrix-whatsapp-tailscale` — Ingress: from tailscale
- `metatube` — Ingress: from jellyfin
- `prowlarr-allow-apps` — Ingress: from lidarr/sonarr/radarr/whisparr
- `prowlarr-tailscale` — Ingress: from tailscale
- `qbittorrent` — Ingress: from lidarr/prowlarr/radarr/sonarr/whisparr + cleanup
- `qbittorrent-tailscale` — Ingress: from tailscale (HTTP + BitTorrent TCP/UDP)
- `radarr` — Ingress: from bazarr/jellyfin/seerr/prowlarr
- `radarr-tailscale` — Ingress: from tailscale
- `seerr` — Ingress: from jellyfin
- `seerr-tailscale` — Ingress: from tailscale
- `sonarr` — Ingress: from bazarr/jellyfin/seerr/prowlarr
- `sonarr-tailscale` — Ingress: from tailscale
- `synapse` — Ingress: from all mautrix bridges + synapse-proxy
- `synapse-proxy` — Ingress+Egress: from synapse; egress to synapse/mautrix-discord/DNS
- `synapse-proxy-tailscale` — Ingress+Egress: from tailscale; egress same as above
- `synapse-tailscale` — Ingress: from tailscale
- `syncthing-tailscale` — Ingress: from tailscale
- `vaultwarden-tailscale` — Ingress: from tailscale
- `whisparr` — Ingress: from prowlarr
- `whisparr-tailscale` — Ingress: from tailscale
