---
title: Installing Common Software
layout: default
nav_order: 4
---
# Installing Common Software

Below you'll find guides for common software you may be looking for, and how to install and set them up.
You should look at the guides below, but generally, software can be installed like this:
```
sudo dnf in <package_name>
```
The package name is usually intuitive, but you can also search for packages using
```
sudo dnf se <package name>
```

{: .note }
> Checking for understanding
> - `sudo` is a very powerful command, but when run plainly, it allows the user to run a command as root (administrator)
> 
> {: .important }
> While you should avoid running graphical apps as root, always use `sudo -H` when doing so. Most KDE apps have built in Polkit integration and do not need to be ran as root, ever.
> 
> - `dnf` is the package manager for Fedora. It manages all RPM software on your system. Flatpak applications are managed with the `flatpak` command.
> - `in` is short for `install`, and this argument tells dnf to install the package provided.
> - `se` is short for `search`, and this argument tells dnf to search for a package with this name. 
