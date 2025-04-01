<div align="center">
  <h1
    style="font-size: 3rem; font-weight: bold; color: rgb(108, 108, 108);"
   >
      Gen FSTab
   </h1>
   <h3 style="color: rgb(230, 40, 40)">
      Generate fstab file for BTRFS Subvolumes in Debian/Ubuntu
   </h3>
</div>

This script fixes the main issue that I have with Ubuntu and most distro's that are based on the OS. For some reason Ubuntu doesn't take advantage of what BTRFS has to offer in the way of subvolumes.

## Requirements

- BTRFS rootfs partition with subvolumes
- UEFI boot
- Secure boot enabled (optional)

### Recommend Subvolumes

The subvolumes are not required but are recommended should be used to help keep snapshots of the root subvolume smaller. Doing so manual is the best way, however, that can be tedious and time consuming For Ubuntu installations.

---
> **Note:** The new installer for Ubuntu 24.04 and later doesn't support BTRFS subvolumes.
---

| Subvolume Name | Mount Point               | Required |
|----------------|---------------------------|----------|
| @              | root - /                  | Yes      |
| @home          | home - /home              | Yes      |
| @snapshots     | logs - /var/log/snapshots | Yes      |
| @cache         | cache - /var/cache        | optional |
| @logs          | logs - /var/log           | No       |
| @snapd         | snapd - /var/lib/snapd    | optional |
| @tmp           | tmp - /tmp                | No       |

## Installation

### Using APT Package Manager

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

 Some parts of the guide are now available as package from [repository](#using-apt-package-manager) and can be installed using the package manager.

## License

 Copyright (c) 2023 Michael Schaecher under the MIT License.
