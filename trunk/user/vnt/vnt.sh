#!/bin/sh
# VNT 1.2.16 simplified service for 360T7 Padavan-ARM
CONF=/etc/storage/vnt/vnt.conf
BIN=/usr/bin/vnt-cli
LOG=/tmp/vnt-cli.log
INFO=/tmp/vnt-info.log
TUN=vnt-tun

default_conf() {
	mkdir -p /etc/storage/vnt
	[ -f "$CONF" ] && return
	cat > "$CONF" <<'EOF'
token: 19871
ip: 10.26.0.20
device_name: 360T7-Padavan
in-ip: 192.168.1.0/24
out-ip: 192.168.1.0/24
cipher_model: aes_ecb
finger: false
punch_model: ipv4
port: 0
cmd: false
no_proxy: false
EOF
}

fw_add() {
	iptables -I INPUT -i "$TUN" -j ACCEPT 2>/dev/null
	iptables -I FORWARD -i "$TUN" -j ACCEPT 2>/dev/null
	iptables -I FORWARD -o "$TUN" -j ACCEPT 2>/dev/null
	iptables -t nat -I POSTROUTING -o "$TUN" -j MASQUERADE 2>/dev/null
}

fw_del() {
	iptables -D INPUT -i "$TUN" -j ACCEPT 2>/dev/null
	iptables -D FORWARD -i "$TUN" -j ACCEPT 2>/dev/null
	iptables -D FORWARD -o "$TUN" -j ACCEPT 2>/dev/null
	iptables -t nat -D POSTROUTING -o "$TUN" -j MASQUERADE 2>/dev/null
}

start() {
	default_conf
	TOKEN=$(grep -E '^[[:space:]]*token:' "$CONF" | head -n1 | sed 's/^[^:]*:[[:space:]]*//; s/["'"'"']//g')
	if [ -z "$TOKEN" ] || [ "$TOKEN" = "YOUR_TOKEN" ]; then
		echo "VNT token is empty" > "$LOG"
		return 1
	fi
	chmod +x "$BIN"
	killall vnt-cli >/dev/null 2>&1
	sleep 1
	"$BIN" -f "$CONF" --disable-stats > "$LOG" 2>&1 &
	sleep 3
	if pidof vnt-cli >/dev/null; then
		fw_add
		return 0
	fi
	return 1
}

stop() {
	"$BIN" --stop >> "$LOG" 2>&1
	killall vnt-cli >/dev/null 2>&1
	fw_del
}

info() {
	if pidof vnt-cli >/dev/null; then
		"$BIN" --info > "$INFO" 2>&1
	else
		echo "vnt-cli is not running" > "$INFO"
	fi
}

case "$1" in
	start) start ;;
	stop) stop ;;
	restart) stop; sleep 1; start ;;
	info) info ;;
	*) echo "usage: $0 {start|stop|restart|info}" ;;
esac
