---
title: Flathub repository
layout: default
parent: Post-install tasks
nav_order: 2
---
# Enabling the Flathub repository
Flathub is the de-facto repository for Flatpaks. Fedora Flatpaks are known to be of dubious quality.

1. Enable Flathub
```
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```
1. Remove Fedora Flatpaks
```
flatpak remote-delete fedora
```

##### References:
[Flathub Setup]([https://rpmfusion.org/Configuration](https://flathub.org/setup/Fedora)
