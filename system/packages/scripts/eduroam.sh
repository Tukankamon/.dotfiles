#!/usr/bin/env bash
# Script to reset eduroam connection

if [ $1 == "danger" ]; then
	nmcli connection modify eduroam 802-1x.ca-cert ""
	nmcli connection up eduroam --ask
	nmcli connection modify eduroam 802-1x.ca-cert $CERT
	exit 0
fi

if [ $# -lt 2 ]; then
	echo "Usage: $0 <username> <domain>"
	echo "Or use: $0 danger, for dangerous certificate skipping"
	exit 1
fi

CERT=$HOME/.dotfiles/other/ca.pem

# Only use this in emergencies, vulnerable to man in the middle / evil twin attacks
# As it skips the cert verification

echo "Using domain $2, User $1"
USER=$1
DOMAIN=$2

#sudo nmcli general logging level DEBUG domains SUPPLICANT,WIFI

nmcli connection delete eduroam 2>/dev/null

nmcli connection add \
  type wifi \
  ssid "eduroam" \
  wifi-sec.key-mgmt wpa-eap \
  wifi-sec.proto rsn \
  wifi-sec.pairwise ccmp \
  802-1x.eap ttls \
  802-1x.phase2-auth pap \
  802-1x.identity "$USER@$DOMAIN" \
  802-1x.anonymous-identity "anonymous2025h2@$DOMAIN" \
  802-1x.ca-cert $CERT \
	con-name "eduroam"
echo "Connection added"

nmcli --ask connection up eduroam && echo "Everything is fine"
#sudo nmcli general logging level INFO domains ALL
