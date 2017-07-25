#!/bin/sh

# Install binaries
set -x
curl -sSL --retry 5 https://github.com/containernetworking/plugins/releases/download/v0.6.0-rc1/cni-plugins-amd64-v0.6.0-rc1.tgz | \
    tar -C /opt/cni/bin -xz

# Install .conf file
curl --retry 5 https://gist.githubusercontent.com/leblancd/43d527ab9d98625ca46c14a014005bd5/raw/907ce767be9dcbc30d87874420ed100441da30ec/gistfile1.txt > /etc/cni/net.d/10-bridge.conf

# Enable IPv6
# sysctl -w net.ipv6.conf.all.disable_ipv6=0

