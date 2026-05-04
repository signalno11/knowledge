---
title: Media and Acceleration
layout: default
parent: Post-install tasks
---
# Media codecs and hardware acceleration
Prerequisites:\
[RPMFusion]({% link rpmfusion.md %})
## Multimedia codecs

{: .note }
Fedora ships a version of FFmpeg with support for only free codecs, and allows a package complement that supplies the nonfree codecs. However, according to RPMFusion[^ffmpeg], sometimes you can run into issues when these packages have version mismatches, and they recommend switching to their standard build of FFmpeg.

1. Install full version of FFmpeg
```
rpm-ostree override remove fdk-aac-free libavcodec-free libavdevice-free libavfilter-free libavformat-free libavutil-free libswresample-free libswscale-free ffmpeg-free --install ffmpeg
```
2. For full codec support, run the following two commands
```
rpm-ostree install gstreamer1-plugin-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly gstreamer1-vaapi --allow-inactive
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
rpm-ostree install libva-intel-driver
```
</details>
<details markdown=1>
<summary>Broadwell to Cofee Lake processors</summary>
You can use either `intel-media-driver` (nonfree) or `libva-intel-driver` (FOSS). 

{: .note }
You can try both, but `intel-media-driver` probably works better, but I have no way of verifying that statement.
```
rpm-ostree install intel-media-driver
```
or
```
rpm-ostree install libva-intel-driver
```
</details>
<details markdown=1>
<summary>Coffee Lake processors and later, including Intel Arc GPUs</summary>
Use `intel-media-driver` (nonfree)
```
rpm-ostree install intel-media-driver
```
</details>

{: .note }
> Intel does not support VDPAU, but you can get minimal VDPAU support (OpenGL and H.264) by installing `libvdpau-va-gl`. VAAPI should still be used whenever possible.
> ```
rpm-ostree install libvdpau-va-gl
```
</details>
<details markdown=1>
<summary>AMD</summary>

{: .note }
VAAPI is supported on Radeon R600 and later. VDPAU is supported on Radeon HD 2000 and later.

The default VAAPI and VDPAU drivers installed do not support proprietary codecs. To add support, run the following command
```
rpm-ostree install mesa-va-drivers-freeworld 
```
{: .note }
To use AMF, you need to use the AMDGPU PRO stack. This is not recommended for most users.
</details>
<details markdown=1>
<summary>NVIDIA</summary>
With the NVIDIA drivers [installed](/nvidia), VDPAU, NVENC, and NVDEC are already set up. For VAAPI support, run:
```
rpm-ostree install libva-nvidia-driver
```

{: .note }
VDPAU or NVENC/NVDEC should be used whenever possible
</details>

### References:\
[RPMFusion - Multimedia How-to](https://rpmfusion.org/Howto/Multimedia)\
[ArchWiki - Hardware video acceleration](https://wiki.archlinux.org/title/Hardware_video_acceleration)\
[RPMFusion - OSTree How-to](https://rpmfusion.org/Howto/OSTree)

[^ffmpeg]: See [here](https://rpmfusion.org/Howto/Multimedia).
[^vlclegal]: See [here](https://www.videolan.org/legal.html).
