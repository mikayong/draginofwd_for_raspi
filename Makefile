### Environment constants

ARCH ?=
CROSS_COMPILE ?=
export

### general build targets

.PHONY: all clean install install_conf hal fwd libmqtt

all: hal libmqtt fwd deb

hal: 
	$(MAKE) all -e -C $@

fwd: hal libmqtt
	$(MAKE) all -e -C $@

libmqtt: 
	$(MAKE) all -e -C $@

clean:
	$(MAKE) clean -e -C hal
	$(MAKE) clean -e -C fwd
	$(MAKE) clean -e -C libmqtt
	rm -rf draginofwd.deb

deb: fwd
	rm -rf pi_pkg
	mkdir -p pi_pkg/usr/bin
	mkdir -p pi_pkg/usr/lib
	mkdir -p pi_pkg/lib/systemd/system
	mkdir -p pi_pkg/etc/lora-gateway
	cp -rf DEBIAN pi_pkg
	cp -rf draginofwd.service pi_pkg/lib/systemd/system
	cp -rf config pi_pkg/etc/lora-gateway
	cp -f config/gwcfg.json pi_pkg/etc/lora-gateway
	cp -f config/sxcfg.json pi_pkg/etc/lora-gateway
	install -m 755 libmqtt/libpahomqtt3c.so pi_pkg/usr/lib
	install -m 755 fwd/fwd pi_pkg/usr/bin
	install -m 755 tools/reset_lgw.sh pi_pkg/usr/bin
	dpkg -b pi_pkg draginofwd.deb
	rm -rf pi_pkg

install:
	echo "Starting install dragino lora packages forward..."
	[ ! -d /etc/lora-gateway ] && sudo mkdir -p /etc/lora-gateway
	sudo cp -rf config /etc/lora-gateway
	sudo cp -f config/gwcfg.json /etc/lora-gateway
	sudo cp -f config/sxcfg.json /etc/lora-gateway
	sudo cp -f draginofwd.service /lib/systemd/system 
	sudo install -m 755 libmqtt/libpahomqtt3c.so /usr/lib
	sudo install -m 755 fwd/fwd /usr/bin
	sudo systemctl enable draginofwd
	sudo systemctl start draginofwd
	echo "INSTALL DONE!"

uninstall:
	echo "Starting remove dragino lora packages forward..."
	sudo rm -rf /etc/lora-gateway
	sudo rm -rf /usr/lib/libpahomqtt3c.so
	sudo rm -rf /usr/bin/fwd
	sudo systemctl disable draginofwd
	sudo systemctl stop draginofwd
	echo "UNINSTALL DONE!"

### EOF
