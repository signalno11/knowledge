---
title: Firefox
layout: default
parent: Installing Common Software
---
# Installing Firefox
Firefox is preinstalled on Fedora Atomic. While you can't remove it from the base image (in that you can't recover the space that it uses, since it's part of the base image), you can mask them from impacting your system state. Firefox will act as if it is uninstalled, however, you will not recover the storage usage.
```
rpm-ostree override remove firefox firefox-langpacks
```
