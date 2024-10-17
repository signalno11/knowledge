---
title: Self-signing the NVIDIA driver
layout: default
---
# Self-signing the NVIDIA driver

Prerequisites:\
[Enabling RPMFusion](/rpmfusion)

{: .important }
This is required if you wish to use Secure Boot.

{: .note }
> If you aren't dual booting Windows, you may simply disable secure boot.
> 
> However, disabling Secure Boot has security implications. See [here](https://en.wikipedia.org/wiki/UEFI#SECURE-BOOT).

{: .warning }
Your signing key is available in `/etc/pki/akmods`, and you should take measures to secure it. Full drive encryption is a simple solution, but you may also move it to a second drive or store it in an encrypted folder instead, like Plasma Vaults or VeraCrypt. You may also encrypt your drive *and* the folder.

1. Install the needed tools:
```
sudo dnf install kmodtool akmods mokutil openssl
```
1. Generate your signing key:[^kmodgenca]
```
sudo kmodgenca -a
```
1. Enroll the key:
```
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
```
1. Reboot your system.
1. You should now see the MOK Management console, if not, revist the earlier steps. Select `Enroll MOK`, click `Continue` then `Yes`, then enter the password you set earlier. 

{: .note }
The keyboard is always QWERTY in this menu. If your keyboard is not QWERTY, you may refer to [this image](https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/KB_United_States.svg/1920px-KB_United_States.svg.png).

[^kmodgenca]: I beleive this is a macro for openssl -- advanced users looking to *distribute* drivers should read the full Fedora [documentation about signing kmods](https://docs.fedoraproject.org/en-US/fedora/latest/system-administrators-guide/kernel-module-driver-configuration/Working_with_Kernel_Modules/#sect-signing-kernel-modules-for-secure-boot).

References:
https://rpmfusion.org/Howto/NVIDIA
https://rpmfusion.org/Howto/Secure%20Boot
