#!/bin/sh
# Mihomo / Meta core simplified service for 360T7 Padavan-ARM
CONF=/etc/storage/mihomo/config.yaml
BIN=/etc/storage/bin/mihomo
GZ=/usr/bin/mihomo.gz
LOG=/tmp/mihomo.log

default_conf() {
	mkdir -p /etc/storage/mihomo /etc/storage/bin
	[ -f "$CONF" ] && return
	cat > "$CONF" <<'EOF'
mixed-port: 7890
socks-port: 7891
port: 7890
allow-lan: true
mode: rule
log-level: info
ipv6: true
external-controller: 127.0.0.1:9090
dns:
  enable: true
  listen: 0.0.0.0:1053
  enhanced-mode: fake-ip
  fake-ip-range: 198.18.0.1/16
  nameserver:
    - 223.5.5.5
    - 119.29.29.29
  fallback:
    - https://223.5.5.5/dns-query
    - https://doh.pub/dns-query
proxies: []
proxy-groups:
  - name: PROXY
    type: select
    proxies:
      - DIRECT
rules:
  - GEOIP,private,DIRECT,no-resolve
  - GEOSITE,cn,DIRECT
  - GEOIP,cn,DIRECT
  - MATCH,PROXY
EOF
}

prepare_bin() {
	mkdir -p /etc/storage/bin
	if [ ! -x "$BIN" ]; then
		gunzip -c "$GZ" > "$BIN"
		chmod +x "$BIN"
	fi
}

start() {
	default_conf
	prepare_bin
	killall mihomo >/dev/null 2>&1
	sleep 1
	"$BIN" -d /etc/storage/mihomo -f "$CONF" > "$LOG" 2>&1 &
	sleep 3
	pidof mihomo >/dev/null 2>&1
}

stop() {
	killall mihomo >/dev/null 2>&1
}

case "$1" in
	start) start ;;
	stop) stop ;;
	restart) stop; sleep 1; start ;;
	*) echo "usage: $0 {start|stop|restart}" ;;
esac
