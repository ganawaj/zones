# zones

## About this repository

`zones` is the location of the homelab's internal and external records. The creation of the zones uses
[octodns](https://github.com/octodns/octodns) to build zonefiles for internal use and push changes to
external providers (cloudflare).

## Components

This repository contains the following components:

| **Component**        | **Description**                         |
| -------------------- | --------------------------------------- |
| **`zones/config`**   | external dns records                    |
| **`zones/internal`** | internal dns records                    |
| **`zones/secret`**   | collection of sops encrypted dns record |

### Core

| **Name**                                                                                 | **Description**                                      |
| ---------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| [**clusters**](https://github.com/ministryofjustice/cloud-platform)                      | Flux entrypoint for Kubernetes clusters              |
| [**applications**](https://github.com/ministryofjustice/cloud-platform-environments)     | Misc. application deployments                        |
| [**infrastructure**](https://github.com/ministryofjustice/cloud-platform-infrastructure) | Core infrastructure for Kubernetes cluster           |
| [**databases**](https://github.com/ministryofjustice/cloud-platform-infrastructure)      | Standalone or non-application specefic databases     |
| [**terraform**](https://github.com/ministryofjustice/cloud-platform-user-guide)          | Core infrastrucutre for kubernetes deployment and vm |
| [**charts**](https://github.com/ministryofjustice/cloud-platform-user-guide)             | Staging area for helm charts                         |

> **Note:** `beta` and `tagged/release` charts are found in their own repo - `github.com/ganawaj/[name]-helm`
