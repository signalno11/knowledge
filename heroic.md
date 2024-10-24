---
title: Heroic Games Launcher
parent: Installing Common Software
layout: default
---
# Installing Heroic Games Launcher
Heroic Games Launcher is an alternative client for the Epic Games Store, GOG.com, and Amazon Prime Gaming.\
It's available as a native RPM package and a Flatpak.
# Native package
1. Enable [the Copr repo](https://copr.fedorainfracloud.org/coprs/atim/heroic-games-launcher/). 
```
sudo dnf copr enable atim/heroic-games-launcher
```
1. Install the launcher
```
sudo dnf in heroic-games-launcher-bin
```
# Flatpak
Note to myself: Check if this is included in default Fedora Flatpaks repo or if Flathub instructions are needed