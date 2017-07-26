#!/bin/sh

# Setup Subnets
INSTANCE=`hostname | cut -d"-" -f 3`
CNI_IPV6_DEFAULT_CIDR="2001:${INSTANCE}::/64"
CNI_IPV6_DEFAULT_GW="2001::${INSTANCE}::1"
CNI_IPV4_DEFAULT_CIDR="10.244.${INSTANCE}.0/24"
CNI_IPV4_DEFAULT_GW="10.244.${INSTANCE}.1"
CNI_IPV6_CIDR="${CNI_IPV6_CIDR:-$CNI_IPV6_DEFAULT_CIDR}"
CNI_IPV6_GW="${CNI_IPV6_GW:-$CNI_IPV6_DEFAULT_GW}"
CNI_IPV4_CIDR="${CNI_IPV4_CIDR:-$CNI_IPV4_DEFAULT_CIDR}"
CNI_IPV4_GW="${CNI_IPV4_GW:-$CNI_IPV4_DEFAULT_GW}"

# Install binaries
set -xeu
set -o pipefail

curl -sSL --retry 5 https://github.com/containernetworking/plugins/releases/download/v0.6.0-rc1/cni-plugins-amd64-v0.6.0-rc1.tgz | \
    tar -C /opt/cni/bin -xz

# Install .conf file
curl --retry 5 https://raw.githubusercontent.com/pmichali/k8s-tools/master/10-bridge.conf > /etc/cni/net.d/10-bridge.conf

# Enable IPv6
sysctl -w net.ipv6.conf.all.disable_ipv6=0

# Modify config file
sed -i'' "s@%subnet_1%@${CNI_IPV4_CIDR}@g" "/etc/cni/net.d/10-bridge.conf"
sed -i'' "s@%gateway_1%@${CNI_IPV4_GW}@g" "/etc/cni/net.d/10-bridge.conf"
sed -i'' "s@%subnet_2%@${CNI_IPV6_CIDR}@g" "/etc/cni/net.d/10-bridge.conf"
sed -i'' "s@%gateway_2%@${CNI_IPV6_GW}@g" "/etc/cni/net.d/10-bridge.conf"


set +x

while true
do
      sleep 10
done
