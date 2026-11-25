SRC_NAME = MIHOMO
THISDIR = $(shell pwd)
MIHOMO_VER = 1.19.34
MIHOMO_GZ = mihomo-linux-arm64-v$(MIHOMO_VER).gz
MIHOMO_URL = https://github.com/MetaCubeX/mihomo/releases/download/v$(MIHOMO_VER)/$(MIHOMO_GZ)

all:

download_test:

extract_test:

config_test:

clean:
	rm -f $(THISDIR)/$(MIHOMO_GZ) $(THISDIR)/$(MIHOMO_GZ).tmp

romfs:
	@mkdir -p $(THISDIR)
	@if [ ! -s $(THISDIR)/$(MIHOMO_GZ) ]; then \
		curl -fsSL --retry 5 --retry-delay 2 -o $(THISDIR)/$(MIHOMO_GZ).tmp "$(MIHOMO_URL)" && \
		mv -f $(THISDIR)/$(MIHOMO_GZ).tmp $(THISDIR)/$(MIHOMO_GZ); \
	fi
	@echo "daaf78a6240a282cdfd75bcbf98fe321f6bd52765cc29e79f344191198f0b50f  $(THISDIR)/$(MIHOMO_GZ)" | sha256sum -c -
	$(ROMFSINST) $(THISDIR)/$(MIHOMO_GZ) /usr/bin/mihomo.gz
	$(ROMFSINST) $(THISDIR)/mihomo.sh /usr/bin/mihomo.sh
