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
wget -qO - https://funwithfeatureflags.github.io/fffpkg/GPG-KEY.pub | \
    gpg --dearmor | ${SUDO} tee /etc/apt/trusted.gpg.d/fffpkg.gpg

# Add the repository
echo "deb [arch=$(dpkg --print-architecture)] \
https://funwithfeatureflags.github.io/fffpkg/deb.${VERSION_CODENAME}.$(dpkg --print-architecture)/ \
${VERSION_CODENAME} main" | ${SUDO} tee /etc/apt/sources.list.d/fffpkg.list

# update
apt update
```

## RHEL/Rocky/Fedora

To install the repository on `RHEL`/`Rocky`/`Fedora`:

```shell
# If you are not root
export SUDO=sudo

# Get your OS version
. /etc/os-release

# Determine distro prefix (el for RHEL/Rocky, fc for Fedora)
if [[ "$ID" == "fedora" ]]; then
    DISTRO_PREFIX="fc"
else
    DISTRO_PREFIX="el"
fi

# Create the repository file
cat << EOF | ${SUDO} tee /etc/yum.repos.d/fffpkg.repo
[fffpkg]
name=fffpkg
baseurl=https://funwithfeatureflags.github.io/fffpkg/rpm.${DISTRO_PREFIX}\$releasever.\$basearch/\$releasever/\$basearch/
enabled=1
gpgcheck=1
gpgkey=https://funwithfeatureflags.github.io/fffpkg/GPG-KEY.pub
EOF
```
