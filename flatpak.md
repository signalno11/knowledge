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

You might want to remove Fedora Flatpak. Some of the default included apps are included as Fedora Flatpaks, to make them easy to install. This will keep their versions in sync with Fedora, but as KDE is often up to date on Fedora anyway, you might want the upstream KDE versions from Flathub. Also note that Fedora Flatpaks are unable to utilize proprietary video codecs, you will need to use Flathub packages for that functionality. To remove, run `flatpak list --columns=name,application,origin`. Note which packages are installed with Fedora, and remove them. Then run `flathub remote-delete fedora`. Then, if you desire, reinstall the packages you removed, on Flathub.

##### References:
[Flathub Setup](https://flathub.org/setup/Fedora)
