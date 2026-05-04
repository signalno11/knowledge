---
title: Self-signing the NVIDIA driver
layout: default
parent: NVIDIA Setup
---
# Self-signing the NVIDIA driver

Prerequisites:\
[Enabling RPMFusion]({% link rpmfusion.md %})

{: .important }
This is required if you wish to use Secure Boot.

{: .note }
> If you aren't dual booting Windows, you may simply disable secure boot.
> 
> However, disabling Secure Boot has security implications. See [here](https://en.wikipedia.org/wiki/UEFI#SECURE-BOOT).

{: .warning }
Your signing key is available in `/etc/pki/akmods-keys`, and you should take measures to secure it. Full drive encryption is a simple solution, but you may also move it to a second drive or store it in an encrypted folder instead, like Plasma Vaults or VeraCrypt. You may also encrypt your drive *and* the folder.

Follow [this guide](https://github.com/CheariX/silverblue-akmods-keys).

{: .note }
The keyboard is always QWERTY in this menu. If your keyboard is not QWERTY, you may refer to [this image](https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/KB_United_States.svg/1920px-KB_United_States.svg.png).

[^kmodgenca]: I beleive this is a macro for openssl -- advanced users looking to *distribute* drivers should read the full Fedora [documentation about signing kmods](https://docs.fedoraproject.org/en-US/fedora/latest/system-administrators-guide/kernel-module-driver-configuration/Working_with_Kernel_Modules/#sect-signing-kernel-modules-for-secure-boot).

References:\
[RPMFusion - NVIDIA How-to](https://rpmfusion.org/Howto/NVIDIA)\
[RPMFusion - Secure Boot How-to](https://rpmfusion.org/Howto/Secure%20Boot)
