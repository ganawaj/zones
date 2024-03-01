# zones

## About this repository

`zones` is the location of the homelab's internal and external records. The creation of the zones uses
[octodns](https://github.com/octodns/octodns) to build zonefiles for internal use and push changes to
external providers (cloudflare).

> **Note:** Nothing in this repo is inherently secret or private. I feel comfortable sharing this repo as an example of my homelab workflow. SOPS encryption is used for certain records - which are also not inherently secret or private.

## Components

This repository contains the following components:

| **Component**        | **Description**                         |
| -------------------- | --------------------------------------- |
| **[`zones/config`](./zones/config)**   | external dns records                    |
| **[`zones/internal`](./zones/internal)** | internal dns records                    |
| **[`zones/secret`](./zones/secret)**   | collection of sops encrypted dns record |

## Workflow

### Octodns

This repo makes use of [octodns](https://github.com/octodns/octodns) to build:

- [RFC 1035](https://datatracker.ietf.org/doc/html/rfc1035) bind-compliant zone files using the [octodns-bind]() provider.
- Cloudflare records using the [octodns-cloudflare]() provider

[`zones/internal`](./zones/internal) is the internal DNS records for my homelab, which are imported into CoreDNS using the [auto]() plugin. These records are merged with the external records in [`zones/config`](./zones/config)..

[`zones/internal`](./zones/internal) uses a SplitYaml format which is a collection of yaml files as opposed to the single yaml files used in [`zones/config`](./zones/config).

[`zones/secret`](./zones/secret) has a similar format to config and internal. Each file is decrpyted and placed in a corresponding location based on the `path` key in the yaml file and the filename.

### Docker
---
This repo has two types of containers a `slim` version and a `embedded` version (which is the version without `-slim`).

`slim` is a container that contains only the zones created by octodns. The purpose of this container is to be used as a base layer to copy from into another image. For example bind, or in my case, Coredns.

`zones:*` is CoreDNS containerized with the zones from `zones:*-slim` of the same version. This is the authorative DNS server I use in my homelab.

## Homelab Core

| **Name**                                                                                 | **Description**                                      |
| ---------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| [**clusters**](https://github.com/ministryofjustice/cloud-platform)                      | Flux entrypoint for Kubernetes clusters              |
| [**applications**](https://github.com/ministryofjustice/cloud-platform-environments)     | Misc. application deployments                        |
| [**infrastructure**](https://github.com/ministryofjustice/cloud-platform-infrastructure) | Core infrastructure for Kubernetes cluster           |
| [**databases**](https://github.com/ministryofjustice/cloud-platform-infrastructure)      | Standalone or non-application specefic databases     |
| [**terraform**](https://github.com/ministryofjustice/cloud-platform-user-guide)          | Core infrastrucutre for kubernetes deployment and vm |
| [**charts**](https://github.com/ministryofjustice/cloud-platform-user-guide)             | Staging area for helm charts                         |
