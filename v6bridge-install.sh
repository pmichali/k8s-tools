#!/bin/sh

# Install binaries
set -x
curl -sSL --retry 5 https://github.com/containernetworking/plugins/releases/download/v0.6.0-rc1/cni-plugins-amd64-v0.6.0-rc1.tgz | \
    tar -C /opt/cni/bin -xz

# Install .conf file
curl --retry 5 https://github.com/pmichali/k8s-tools/blob/master/10-bridge.conf > /etc/cni/net.d/10-bridge.conf

# Enable IPv6
sysctl -w net.ipv6.conf.all.disable_ipv6=0

set +x

while true
do
      sleep 10
done
