<div style="text-align: center;">
  <h1
    style="font-size: 3rem; font-weight: bold; color: rgb(108, 108, 108);"
    >Gen FSTab</h1>
    <h3 style="color: rgb(230, 40, 40)">Generate fstab file for Ubuntu</h3>
</div>

This script fixes the main issue that I have with Ubuntu and most distro's that are based on the OS. For some reason Ubuntu doesn't take advantage of what BTRFS has to offer in the way of subvolumes.

### Requirements

- BTRFS rootfs partition with subvolumes: `@`, `@home`, `@log`, `@cache`, `@tmp`, `@snapshots`
- UEFI boot

