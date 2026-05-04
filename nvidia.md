---
title: NVIDIA Setup
layout: default
parent: Post-install tasks
nav_order: 2
---

# Installing NVIDIA drivers

Prerequisites:\
[Enabling RPMFusion]({% link rpmfusion.md %})\
[Enrolling a signing key for Secure Boot]({% link nvidia_secboot.md %})

{: .important }
Check if your GPU is considered legacy. Find your GPU on [this page](https://www.nvidia.com/en-us/drivers/unix/legacy-gpu/), and if it is listed, follow the instructions for the driver series it is listed under (i.e 470.xx). Otherwise, continue with the modern drivers below.

{: .warning }
> If your system is using Secure Boot, you must enroll a key before doing this. If you are not sure, run the command below.
> ```
mokutil --sb-state
```
If Secure Boot is enabled, you must follow the steps [here]({% link nvidia_secboot.md %}) before proceeding.

## Modern NVIDIA:
First, update your system, `rpm-ostree upgrade`, and reboot.

Install the NVIDIA drivers and CUDA/NV(ENC/DEC) support.
```
rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda
```

Add kargs:
```
sudo rpm-ostree kargs --append=rd.driver.blacklist=nouveau,nova_core --append=modprobe.blacklist=nouveau,nova_core
```
{: .important }
Wait for the kmod to be built. This can take up to 5 minutes.

{: .important }
> On Turing (GTX 16/20) and later, NVIDIA now recommends you use the open source drivers. If this is you, enable the open source drivers by running
> ```
sudo sh -c 'echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod' && sudo akmods --kernels $(uname -r) --rebuild
```
> and then continue with the instructions below.

Reboot your system, and check that is it installed. That is, `modinfo -F version nvidia` should not ERROR.
## Legacy NVIDIA:
<details markdown=1>
<summary>NVIDIA 470.xx Legacy Drivers</summary>
First, update your system, `rpm-ostree upgrade`, and reboot.

Install the NVIDIA drivers and CUDA (11.4) support.
```
rpm-ostree install akmod-nvidia-470xx xorg-x11-drv-nvidia-470xx xorg-x11-drv-nvidia-470xx-cuda
``` 
{: .important }
Wait for the kmod to be built. This can take up to 5 minutes.

Reboot your system, and check that is it installed. That is, `modinfo -F version nvidia` should not ERROR.
</details>
<details markdown=1>
<summary>NVIDIA 390.xx Legacy Drivers</summary>

{: .warning }
This driver is end-of-life. It may break at any time.

First, update your system, `rpm-ostreee upgrade`, and reboot.

Install the NVIDIA drivers and CUDA (9.2) support.
```
rpm-ostree install akmod-nvidia-390xx xorg-x11-drv-nvidia-390xx xorg-x11-drv-nvidia-390xx-cuda
```

{: .important }
Wait for the kmod to be built. This can take up to 5 minutes.

Reboot your system, and check that is it installed. That is, `modinfo -F version nvidia` should not ERROR.
</details>

<details markdown=1>
<summary>NVIDIA 340.xx Legacy Drivers</summary>
<details markdown=1>
<summary>Optional: 3rd Party Patch</summary>

This driver is currently outside of the scope for this guide.

</details>

{: important }
Any older NVIDIA devices are no longer supported on Fedora.

References:\
[RPMFusion - NVIDIA How-to](https://rpmfusion.org/Howto/NVIDIA)\
[Fedora Docs - Working with Kernel Modules](https://docs.fedoraproject.org/en-US/fedora/latest/system-administrators-guide/kernel-module-driver-configuration/Working_with_Kernel_Modules/)
