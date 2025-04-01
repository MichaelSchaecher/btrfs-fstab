#!/bin/env make -f

PACKAGE = $(shell basename $(shell pwd))
VERSION = $(shell bash scripts/set-version)

MAINTAINER = $(shell git config user.name) <$(shell git config user.email)>

INSTALL = dpkg-dev, git
BUILD = debhelper (>= 11), git, make (>= 4.1), dpkg-dev

HOMEPAGE = https://github.com/MichaelSchaecher/ddns

ARCH = $(shell dpkg --print-architecture)

PACKAGE_DIR = package

WORKING_DIR = $(shell pwd)

DESCRIPTION = Generate a fstab file for BTRFS subvolumes -
LONG_DESCRIPTION = Us for creating a fstab file for BTRFS filesystems with multiple subvolumes.

export PACKAGE VERSION MAINTAINER INSTALL BUILD HOMEPAGE ARCH PACKAGE_DIR WORKING_DIR DESCRIPTION LONG_DESCRIPTION

# Phony targets
.PHONY: all debian install clean help

# Default target
all: install

debian:

	@echo "Building package $(PACKAGE) version $(VERSION)"

	@echo "$(VERSION)" > $(PACKAGE_DIR)/usr/share/doc/$(PACKAGE)/version

ifeq ($(MANPAGE),yes)
	@pandoc -s -t man man/$(PACKAGE).8.md -o \
		$(PACKAGE_DIR)/usr/share/man/man8/$(PACKAGE).8
	@gzip --best -nvf $(PACKAGE_DIR)/usr/share/man/man8/$(PACKAGE).8
endif

	@dpkg-changelog $(PACKAGE_DIR)/DEBIAN/changelog
	@dpkg-changelog $(PACKAGE_DIR)/usr/share/doc/$(PACKAGE)/changelog
	@gzip -d $(PACKAGE_DIR)/DEBIAN/*.gz
	@mv $(PACKAGE_DIR)/DEBIAN/changelog.DEBIAN $(PACKAGE_DIR)/DEBIAN/changelog

	@scripts/set-control
	@scripts/gen-chsums

ifeq ($(FORCE_DEB),yes)
	@scripts/mkdeb --force
else
	@scripts/mkdeb
endif

install:

	@if test "$(shell id -u)" != "0"; then \
		echo "This target requires root privileges. Please run as root or use sudo."; \
		exit 1; \
	fi

	@cp -av $(PACKAGE_DIR)/usr /usr
	@echo "$(VERSION)" > /usr/share/doc/$(PACKAGE)/version

clean:
	@rm -vf $(PACKAGE_DIR)/DEBIAN/control \
		$(PACKAGE_DIR)/DEBIAN/changelog \
		$(PACKAGE_DIR)/DEBIAN/md5sums \
		$(PACKAGE_DIR)/usr/share/doc/$(PACKAGE)/*.gz \
		$(PACKAGE_DIR)/usr/share/man/man8/$(PACKAGE).8.gz \

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
