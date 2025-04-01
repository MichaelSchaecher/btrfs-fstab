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

### Using DPKG/APT

You can install the project using the following command on Debian/Ubuntu based distributions add the repository.

Add the source list:

```bash
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/HowToNebie.gpg] https://michaelschaecher.github.io/mls stable main" |
sudo tee /etc/apt/sources.list.d/howtonebie.list
```

Add the repository key:

```bash
wget -qO - https://raw.githubusercontent.com/MichaelSchaecher/mls/refs/heads/main/key/HowToNebie.gpg |
gpg --dearmor | sudo dd of=/usr/share/keyrings/HowToNebie.gpg
```

Update the package list and install: `sudo apt update` & `sudo apt install btrfs-fstab`



### Other Linux Distributions

Installing the project is straightforward. Follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/MichaelMure/btrfs-fstab.git
   ```

2. Install the project:

   ```bash
   sudo make install
   ```

## Usage

The package is meant to be used from a live environment and is used to generate the fstab file from mounted btrfs subvolumes. to learn more about how to manually install Ubuntu follow the steps on [How I Installed Kubuntu 24.04 using BTFS as the Filesystem](https://howtonebie-com.pages.dev/posts/how-i-installed-kubuntu-24.04-using-btrfs-as-the-filesystem/). Depending on the OS and/or version some steps may differ, but the general idea is the same.
