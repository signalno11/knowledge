---
title: NVIDIA Setup
layout: default
---

# Installing NVIDIA drivers

Prerequisites:\
[Enabling RPMFusion](/rpmfusion)\
[Enrolling a signing key for Secure Boot](/nvidia_secboot)

{: .important }
Check if your GPU is considered legacy. Find your GPU on [this page](https://www.nvidia.com/en-us/drivers/unix/legacy-gpu/), and if it is listed, follow the instructions for the driver series it is listed under (i.e 470.xx). Otherwise, continue with the modern drivers below.

{: .warning }
> If your system is using Secure Boot, you must enroll a key before doing this. If you are not sure, install `mokutil` and run the command below.
> ```
mokutil --sb-state
```
If Secure Boot is enabled, you must follow the steps [here](/nvidia_secboot) before proceeeding.

## Modern NVIDIA:
First, update your system, `sudo dnf up`, and reboot.

Install the NVIDIA drivers and CUDA/NV(ENC/DEC) support.

```
sudo dnf in akmod-nvidia xorg-x11-drv-nvidia-cuda
```

{: .important }
Wait for the kmod to be built. This can take up to 5 minutes.

Reboot your system, and check that is it installed. That is, `modinfo -F version nvidia` should not ERROR.
## Legacy NVIDIA:
<details markdown=1>
<summary>NVIDIA 470.xx Legacy Drivers</summary>
First, update your system, `sudo dnf up`, and reboot.

Install the NVIDIA drivers and CUDA (11.4) support.
```
sudo dnf in akmod-nvidia-470xx xorg-x11-drv-nvidia-470xx xorg-x11-drv-nvidia-470xx-cuda
``` 
{: .important }
Wait for the kmod to be built. This can take up to 5 minutes.

Reboot your system, and check that is it installed. That is, `modinfo -F version nvidia` should not ERROR.
</details>
<details markdown=1>
<summary>NVIDIA 390.xx Legacy Drivers</summary>

{: .warning }
This driver is end-of-life. It may break at any time.

First, update your system, `sudo dnf up`, and reboot.

Install the NVIDIA drivers and CUDA (9.2) support.
```
sudo dnf in akmod-nvidia-390xx xorg-x11-drv-nvidia-390xx xorg-x11-drv-nvidia-390xx-cuda
```

{: .important }
Wait for the kmod to be built. This can take up to 5 minutes.

Reboot your system, and check that is it installed. That is, `modinfo -F version nvidia` should not ERROR.
</details>

<details markdown=1>
<summary>NVIDIA 340.xx Legacy Drivers</summary>
<details markdown=1>
<summary>Optional: 3rd Party Patch</summary>
The goal of this driver is to increase compatibility with newer Linux kernel versions. It is recommended for more recent versions of Fedora (Linux ~6).
I cannot verify if this patch is required, because I do not have a compatibile device to test it with. 

{: .note }
As far as I can tell, this patch is intended to be used with the LTS kernel.

{: .important }
Before installing any 3rd party software, audit the repo, Copr build logs, and make sure you trust the developer.

First, update your system, `sudo dnf up`, and reboot

Then, enable the third party Copr repo:
```
sudo dnf copr enable kwizart/kernel-longterm-6.1
```
Install the needed dependencies:
```
sudo dnf in akmods gcc kernel-longterm kernel-longterm-devel
```
Follow the rest of the instructions like normal.
</details>

{: .warning }
This driver is EOL. It may break at any time, and likely won't work on newer Fedora versions. You may attempt the drivers below, but also note the 3rd party patch section.

First, update your system, `sudo dnf up`, and reboot.

Install the NVIDIA drivers and CUDA (6.5) support.
```
sudo dnf in akmod-nvidia-340xx xorg-x11-drv-nvidia-340xx xorg-x11-drv-nvidia-340xx-cuda
```
{: .important }
Wait for the kmod to build. This can take up to 5 minutes.

Reboot your system, and check that is it installed. That is, `modinfo -F version nvidia` should not ERROR.
</details>

## Other information

{: .note }
> By design, Fedora may remove akmod packages when using autoromove. You can prevent Fedora from doing this with the following command.
> 
> ```
sudo dnf mark install akmod-nvidia
```

{: important }
Any older NVIDIA devices are no longer supported on Fedora.

References:
https://rpmfusion.org/Howto/NVIDIA
https://docs.fedoraproject.org/en-US/fedora/latest/system-administrators-guide/kernel-module-driver-configuration/Working_with_Kernel_Modules/
