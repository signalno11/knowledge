---
title: RPMFusion repository
layout: default
parent: Post-install tasks
nav_order: 1
---
# Enabling the RPMFusion repository
RPMFusion is a community repository that ships packages that Fedora doesn't want to (i.e. nonfree software or free software that doesn't meet their [licensing guidelines](https://docs.fedoraproject.org/en-US/legal/license-approval/)) or can't ship (i.e. software that does not explicitly allow redistribution).

{: .important }
While RPMFusion is generally recognized as a safe source for packages, it is still a 3rd party repository, and usual caution should be exercised. According to RPMFusion, most developers involved in the project "are also actively involved with the Fedora project."[^fedorainvolve]

[^fedorainvolve]: See [here](https://rpmfusion.org/FAQ#Frequently_Asked_Questions)

1. Enable RPMFusion Free and RPMFusion Nonfree
```
sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```
Then, reboot.

{: .important }
> Currently (2024), the correct key fingerprints are as follows: \
> Free:
> ```
pub   rsa4096 2019-10-21 [SC]
      Key fingerprint = E9A4 91A3 DE24 7814 E7E0 67EA E06F 8ECD D651 FF2E
uid           RPM Fusion free repository for Fedora (2020) <rpmfusion-buildsys@lists.rpmfusion.org>
```
> Nonfree:
> ```
pub   rsa4096 2019-10-21 [SC]
      Key fingerprint = 79BD B88F 9BBF 7391 0FD4 095B 6A2A F961 9484 3C65
uid           RPM Fusion nonfree repository for Fedora (2020) <rpmfusion-buildsys@lists.rpmfusion.org>
```

{: .note }
These instructions do not install the tainted repos. The `free-tainted` repository includes free software that may have some legal implications of using (i.e. libdvdcss), and `nonfree-tainted` mostly includes proprietary firmware.

##### References:
[RPMFusion - Configuration](https://rpmfusion.org/Configuration)\
[RPMFusion - Keys](https://rpmfusion.org/keys)\
[RPMFusion - FAQ](https://rpmfusion.org/FAQ)\
[RPMFUsion - OSTree](https://rpmfusion.org/Howto/OSTree)
