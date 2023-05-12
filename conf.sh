#!/bin/bash
cat << EOF
[Interface]
PrivateKey = $(cat /etc/wireguard/$1_privatekey)
Address = 10.0.0.$((1 + $(grep -o '\[Peer\]' /etc/wireguard/wg0.conf | wc -l)))/32
DNS = 8.8.8.8

[Peer]
PublicKey = $(cat /etc/wireguard/publickey)
Endpoint = 31.172.72.79:51830
AllowedIPs = 0.0.0.0/1, 128.0.0.0/1
PersistentKeepalive = 20
EOF
