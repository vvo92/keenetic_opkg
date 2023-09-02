#!/bin/sh

[ "$1" == "hook" ] || exit 0
[ "$change" == "connected" ] || exit 0
[ "$id" == "Wireguard1" ] || exit 0

case ${id}-${change}-${connected}-${link}-${up} in
	Wireguard1-connected-no-down-down)
		ip route flush table 1000
		ip rule del from all table 1000 priority 1776 2>/dev/null
	;;
	Wireguard1-connected-yes-up-up)
		ip rule add from all table 1000 priority 1776 2>/dev/null
		/opt/bin/unblock_vpn.sh &
	;;
esac

exit 0