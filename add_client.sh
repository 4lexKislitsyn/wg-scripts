#!/bin/bash
echo "Generating keys for $1 client"

wg genkey | tee /etc/wireguard/$1_privatekey | wg pubkey | tee /etc/wireguard/$1_publickey

echo "Adding peer into wg config"
cat << EOF >> /etc/wireguard/wg0.conf
[Peer]
#$1
PublicKey = $(cat /etc/wireguard/$1_publickey)
AllowedIPs = 10.0.0.$((2 + $(grep -o '\[Peer\]' /etc/wireguard/wg0.conf | wc -l)))/32
EOF

echo "Rrestart wg service"
systemctl restart wg-quick@wg0
systemctl status wg-quick@wg0 | grep 'Active' --color=never

echo "Client was added and service was restarted"
