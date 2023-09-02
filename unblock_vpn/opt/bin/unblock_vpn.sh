#!/bin/sh

cut_local() {
	grep -vE 'localhost|^0\.|^127\.|^10\.|^172\.16\.|^192\.168\.|^::|^fc..:|^fd..:|^fe..:'
}

until ADDRS=$(dig +short google.com @localhost -p 53) && [ -n "$ADDRS" ] > /dev/null 2>&1; do sleep 5; done
ip route flush table 1000

while read line || [ -n "$line" ]; do

	[ -z "$line" ] && continue
	[ "${line:0:1}" = "#" ] && continue

	cidr=$(echo $line | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]{1,2}')
	if [ ! -z "$cidr" ]; then
		ip route add table 1000 $cidr via 172.16.0.1 dev nwg1 2>/dev/null
		continue
	fi

	addr=$(echo $line | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')
	if [ ! -z "$addr" ]; then
		ip route add table 1000 $addr via 172.16.0.1 dev nwg1 2>/dev/null
		continue
	fi

	dig A +short $line @localhost -p 53 | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | cut_local | awk '{system("ip route add table 1000 "$1" via 172.16.0.1 dev nwg1 2>/dev/null")}'

done < /opt/etc/unblock-vpn.txt