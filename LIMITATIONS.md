# Limitations

## Package Availability

### APT (Debian/Ubuntu)

- Repository: `https://apt.releases.hashicorp.com`
- GPG key: `https://apt.releases.hashicorp.com/gpg`
- Ubuntu 20.04, 22.04, 24.04: amd64, arm64
- Debian 12, 13: amd64, arm64

### DNF/YUM (RHEL family)

- Repository (RHEL): `https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo`
- Repository (Fedora): `https://rpm.releases.hashicorp.com/fedora/hashicorp.repo`
- Repository (Amazon Linux): `https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo`
- AlmaLinux 8, 9, 10: amd64, arm64
- CentOS Stream 9, 10: amd64, arm64
- Fedora (latest): amd64, arm64
- Oracle Linux 8, 9: amd64, arm64
- Rocky Linux 8, 9, 10: amd64, arm64
- Amazon Linux 2023: amd64, arm64

### Zypper (SUSE)

- **No official HashiCorp zypper repository exists**
- openSUSE Leap 15: binary installation only (amd64, arm64)

## Architecture Limitations

- Official packages available for amd64 and arm64
- Binary downloads also available for 386 and arm (32-bit)
- Repository-based installation only supports amd64 and arm64

## Binary Downloads

- URL pattern: `https://releases.hashicorp.com/consul/<version>/consul_<version>_linux_<arch>.zip`
- Available architectures: 386, amd64, arm, arm64
- SHA256 checksums available at: `https://releases.hashicorp.com/consul/<version>/consul_<version>_SHA256SUMS`

## Installation Methods

| Method     | Platforms                        | Notes                                    |
|------------|----------------------------------|------------------------------------------|
| Repository | Debian, Ubuntu, RHEL, Fedora,    | Recommended. Handles updates via package |
|            | Amazon Linux, AlmaLinux, CentOS  | manager. amd64 and arm64 only.           |
|            | Stream, Oracle Linux, Rocky Linux|                                          |
| Binary     | All Linux platforms              | Manual version management. All arches.   |

## Known Issues

- openSUSE requires binary installation — no vendor repository available
- Windows support has been removed from this cookbook
- Consul versions prior to 1.0 are no longer supported
