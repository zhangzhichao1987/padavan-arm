SRC_NAME = VNT-CLI
THISDIR = $(shell pwd)
VNT_VER = 1.2.16
VNT_BIN = vnt-cli_aarch64-unknown-linux-musl
VNT_URL = https://github.com/lucktu/vnt1/releases/download/v$(VNT_VER)/$(VNT_BIN)

all:

download_test:

extract_test:

config_test:

clean:
	rm -f $(THISDIR)/vnt-cli $(THISDIR)/vnt-cli.tmp

romfs:
	@mkdir -p $(THISDIR)
	@if [ ! -s $(THISDIR)/vnt-cli ]; then \
		curl -fsSL --retry 5 --retry-delay 2 -o $(THISDIR)/vnt-cli.tmp "$(VNT_URL)" && \
		mv -f $(THISDIR)/vnt-cli.tmp $(THISDIR)/vnt-cli; \
	fi
	@echo "2adde9e351d1a11a9aa363ef58adf2ec0a706c18925141061dc0daa4d271b0b8  $(THISDIR)/vnt-cli" | sha256sum -c -
	@chmod +x $(THISDIR)/vnt-cli
	$(ROMFSINST) $(THISDIR)/vnt-cli /usr/bin/vnt-cli
	$(ROMFSINST) $(THISDIR)/vnt.sh /usr/bin/vnt.sh
