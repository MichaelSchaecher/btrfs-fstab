#!/bin/env make -f

# NOTE: The use of the Make command is well change in the future, going with a
# more intuitive build system once it is completed. Removing the need for the
# use of messy helper shell scripts.

PACKAGE = $(shell basename $(shell pwd))
VERSION = $(shell dpkg-version)

MAINTAINER = $(shell git config user.name) <$(shell git config user.email)>

INSTALL = dpkg-dev, git
BUILD = debhelper (>= 11), git, make (>= 4.1), dpkg-dev

HOMEPAGE = https:\/\/github.com\/MichaelSchaecher\/$(PACKAGE)

ARCH = $(shell dpkg --print-architecture)

WORKING_DIR = $(shell pwd)
BUILD_DIR = $(WORKING_DIR)/build

export PACKAGE VERSION MAINTAINER INSTALL BUILD HOMEPAGE ARCH BUILD_DIR WORKING_DIR

# Phony targets
.PHONY: all debian install clean help

FORCE_DEB := yes

# Default target
all: install

debian:

	@mkdir -vp $(BUILD_DIR)/DEBIAN \
		$(BUILD_DIR)/usr/share/doc/$(PACKAGE) \
		$(BUILD_DIR)/usr/bin \

	@cp -av $(WORKING_DIR)/debian/* $(BUILD_DIR)/DEBIAN/

	@sed -i 's/Version:/Version: $(VERSION)/' \
		$(BUILD_DIR)/DEBIAN/control

	@sed -i 's/Maintainer:/Maintainer: $(MAINTAINER)/' \
		$(BUILD_DIR)/DEBIAN/control

	@sed -i 's/Homepage:/Homepage: $(HOMEPAGE)/' \
		$(BUILD_DIR)/DEBIAN/control

	@echo "Building package $(PACKAGE) version $(VERSION)"

	@echo "$(VERSION)" > $(BUILD_DIR)/usr/share/doc/$(PACKAGE)/version

ifeq ($(MANPAGE),yes)
	@pandoc -s -t man man/$(PACKAGE).8.md -o \
		$(BUILD_DIR)/usr/share/man/man8/$(PACKAGE).8
	@gzip --best -nvf $(BUILD_DIR)/usr/share/man/man8/$(PACKAGE).8
endif

# TODO: Change this to use the correct command once available.
	@dpkg-changelog

	@cp -av $(WORKING_DIR)/doc/* $(BUILD_DIR)/usr/share/doc/$(PACKAGE)/
	@cp -av bin/$(PACKAGE) $(BUILD_DIR)/usr/bin/$(PACKAGE)
	@chmod 755 $(BUILD_DIR)/usr/bin/$(PACKAGE)

	@scripts/dpkg-size
	@scripts/dpkg-chsums

ifeq ($(FORCE_DEB),yes)
	@scripts/dpkg-mkdeb --force
else
	@scripts/dpkg-mkdeb
endif

install:

	@if test "$(shell id -u)" != "0"; then \
		echo "This target requires root privileges. Please run as root or use sudo."; \
		exit 1; \
	fi

	@cp -av $(BUILD_DIR)/usr /usr
	@echo "$(VERSION)" > /usr/share/doc/$(PACKAGE)/version

clean:
	@rm -rvf $(BUILD_DIR)

help:
	@echo "Usage: make [target] <variables>"
	@echo ""
	@echo "Targets:"
	@echo "  all       		- Default target (basic install)"
	@echo "  debian    		- Build the debian package"
	@echo "  install   		- Install the basic file (requires root privileges)"
	@echo "  clean     		- Clean up build files"
	@echo "  help      		- Display this help message"
	@echo ""
	@echo "Variables:"
	@echo "  FORCE_DEB		- (Default=no) yes = force build debian package even if it exists"	@echo "
