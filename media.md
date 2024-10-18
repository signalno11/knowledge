---
title: Media and Acceleration
layout: default
---
# Media codecs and hardware acceleration
Prerequisites:\
[RPMFusion](/rpmfusion)
## Multimedia codecs

{: .note }
Fedora ships a version of FFmpeg with support for only free codecs, and allows a package complement that supplies the nonfree codecs. However, according to RPMFusion[^ffmpeg], sometimes you can run into issues when these packages have version missmatches, and they recommend switching to their standard build of FFmpeg.

1. Install full version of FFmpeg
```
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
```
2. For full codec support, run the following two commands
```
sudo dnf up @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf up @sound-and-video
```

## Hardware acceleration

{: .note }
On Linux, there are two main hardware acceleration APIs. [VAAPI](https://en.wikipedia.org/wiki/Video_Acceleration_API) is developed by Intel and used by AMD and Intel. [VDPAU](https://en.wikipedia.org/wiki/VDPAU) was developed by NVIDIA, now by freedesktop.org, and mainly used by NVIDIA. NVIDIA also has NVENC and NVDEC, AMD also has AMF.

<details markdown=1>
<summary>Intel</summary>
<details markdown=1>
<summary>GMA 4500 up to Broadwell processors</summary>
Use `libva-intel-driver` (FOSS)
```
sudo dnf in libva-intel-driver
```
</details>
<details markdown=1>
<summary>Broadwell to Cofee Lake processors</summary>
You can use either `intel-media-driver` (nonfree) or `libva-intel-driver` (FOSS). 

{: .note }
You can try both, but `intel-media-driver` probably works better, but I have no way of verifying that statement.
```
sudo dnf in intel-media-driver
```
or
```
sudo dnf in libva-intel-driver
```
</details>
<details markdown=1>
<summary>Coffee Lake processors and later, including Intel Arc GPUs</summary>
Use `intel-media-driver` (nonfree)
```
sudo dnf in intel-media-driver
```
</details>

{: .note }
> Intel does not support VDPAU, but you can get minimal VDPAU support (OpenGL and H.264) by installing `libvdpau-va-gl`. VAAPI should still be used whenever possible.
> ```
sudo dnf in libvdpau-va-gl
```
</details>
<details markdown=1>
<summary>AMD</summary>

{: .note }
VAAPI is supported on Radeon R600 and later. VDPAU is supported on Radeon HD 2000 and later.

The default VAAPI and VDPAU drivers installed do not support proprietary codecs. To add support, run the following commands

VAAPI:
```
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
sudo dnf swap mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686
```
VDPAU:
```
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
sudo dnf swap mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686
```

{: .note }
To use AMF, you need to use the AMDGPU PRO stack. This is not recommended for most users.
</details>
<details markdown=1>
<summary>NVIDIA</summary>
With the NVIDIA drivers [installed](/nvidia), VDPAU, NVENC, and NVDEC are already set up. For VAAPI support, run:
```
sudo dnf in libva-nvidia-driver.{i686,x86_64}
```

{: .note }
VDPAU or NVENC/NVDEC should be used whenever possible
</details>

## Playing DVDs

{: .note }
These instructions only apply to encrypted DVDs (i.e. movies you'd buy at the store). Your own burned DVDs aren't encrypted, and can play just like any external media device.

Due to legal restrictions, libdvdcss isn't installed by default. However, if you want to use your computer to play encrypted DVDs, it is required.

{: .important }
> Read the following legal notice[^vlclegal] from VideoLAN before continuing: 
> > libdvdcss is a library that can find and guess keys from a DVD in order to decrypt it.
> > This method is **authorized** by a French law decision [CE 10e et 9e sous­sect., 16 juillet 2008, n° 301843](https://www.legifrance.gouv.fr/ceta/id/CETATEXT000019216315/) on interoperability.
> > 
> > **NB:** In the USA, you should check out [the US Copyright Office decision](https://www.copyright.gov/1201/) that allows circumvention in some cases.
> > VideoLAN is **NOT** a US-based organization and is therefore **outside US jurisdiction**. 

To install:
```
sudo dnf in rpmfusion-free-release-tainted && sudo dnf in libdvdcss
```
### References:
https://rpmfusion.org/Howto/Multimedia
https://wiki.archlinux.org/title/Hardware_video_acceleration

[^ffmpeg]: See [here](https://rpmfusion.org/Howto/Multimedia).
[^vlclegal]: See [here](https://www.videolan.org/legal.html).