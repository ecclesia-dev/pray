PREFIX ?= /usr/local

install:
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 755 pray.sh $(DESTDIR)$(PREFIX)/bin/pray

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/pray

.PHONY: install uninstall
