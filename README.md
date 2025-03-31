<div align="center">
  <h1
    style="font-size: 3rem; font-weight: bold; color: rgb(108, 108, 108);"
    >Gen FSTab</h1>
    <h3 style="color: rgb(230, 40, 40)">Generate fstab file for Ubuntu</h3>
</div>

This script fixes the main issue that I have with Ubuntu and most distro's that are based on the OS. For some reason Ubuntu doesn't take advantage of what BTRFS has to offer in the way of subvolumes.

## Requirements

- BTRFS rootfs partition with subvolumes: `@`, `@home`, `@log`, `@cache`, `@snapd`, `@tmp`, `@snapshots`
- UEFI boot
- Secure boot enabled (optional)

## Installation

The easiest way to install application is the following the steps [here](https://michaelschaecher.github.io/mls/) to add the repository and install the package.

### Alternative Installation

Is to clone the repository and run the following commands: `make debian && sudo make install`.

## Usage

The package is meant to be used from a live environment and is used to generate the fstab file from mounted btrfs subvolumes. to learn more about how to manually install Ubuntu follow the steps on [How I Installed Kubuntu 24.04 using BTFS as the Filesystem](https://howtonebie-com.pages.dev/posts/how-i-installed-kubuntu-24.04-using-btrfs-as-the-filesystem/). Depending on the OS and/or version some steps may differ, but the general idea is the same.