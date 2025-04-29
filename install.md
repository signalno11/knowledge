---
title: Installing Fedora KDE
layout: default
nav_order: 2
---

# Installing Fedora KDE

## Creating a bootable USB drive.

1. (Windows) Disable AutoPlay in Settings > Bluetooth & devices > AutoPlay.
1. (Windows) In an Admin command prompt, run `diskpart automount disable`.
1. Download [Fedora Media Writer](https://github.com/FedoraQt/MediaWriter/releases/latest) and install it.
1. Open Fedora Media Writer.
1. Select "Download automatically" and click Next.
1. Select "Spins" and then "Fedora KDE Plasma Desktop."
1. Choose the latest version, the architecture you want to install for, and select your USB drive.
1. Click "Download & Write."
1. Boot into your USB drive. Some systems may do this automatically after a reboot, but on some systems, you may need to change the boot order settings.

## Installing
1. Before continuing, test all your important hardware to make sure it functions properly on Linux.
1. Open up the installer.
1. Select the language you want to use during installation.
1. First, select the keyboard layout your keyboard uses.
1. Set the correct time zone.
1. Select "Installation destination."
1. Choose the disk you want to install to. (WARNING: The disk with the blue highlight is *not* the selected disk. The selected disk is indicated with a checkmark.)
1. If you are not installing to an empty drive, check the "Free up space by removing or shrinking existing partitions" button.
1. Click Done. If prompted to reclaim space, select "Delete all," and then, "reclaim space."
1. Under Network and Hostname, give your computer a name. Click Apply, then Done.
1. Select Root Account. If you want to be able to directly log in to the superuser account, enable the root account. The root account needn't be enabled to do administrator tasks.
1. Select User Account, and create a user account.
1. Select "Begin installation," and wait for the system to finish installing.
1. Once done, reboot your system.
1. After installation, open Discover, and apply any pending updates.
1. Follow the post-setup steps.
