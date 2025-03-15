[![Build Packages Repositories](https://github.com/funwithfeatureflags/fffpkg/actions/workflows/repos.yml/badge.svg)](https://github.com/funwithfeatureflags/fffpkg/actions/workflows/repos.yml)

# Fun With Feature Flags Packages

Just a few packages for playing with Open Feature Flags.

# Repositories

## Ubuntu/Debian

To install the repository on `Ubuntu`/`Debian`:
```shell
# If you are not root
export SUDO=sudo

# Get your OS version
. /etc/os-release

# Add the GPG key
wget -qO - https://funwithfeatureflags.github.io/fffpkg//GPG-KEY.pub | \
    gpg --dearmor | ${SUDO} tee /etc/apt/trusted.gpg.d/debian-rpm-build-tools.gpg

# Add the repository
echo "deb [arch=$(dpkg --print-architecture)] \
https://funwithfeatureflags.github.io/fffpkg/deb.${VERSION_CODENAME}.$(dpkg --print-architecture)/ \
${VERSION_CODENAME} main" | ${SUDO} tee /etc/apt/sources.list.d/debian-rpm-build-tools.list

# update
apt update
```
## RHEL/Rocky

To install the repository on `RHEL`/`Rocky`:
```shell
TODO
```
