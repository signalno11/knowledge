---
title: Configuring Chromium
layout: default
parent: Media and Acceleration
---
# Configuring Chromium
Prerequisites:\
[Hardware acceleration]({% link media.md %})

{: .note }
Fedora KDE uses Wayland by default.

<details markdown=1>
<summary>Wayland session</summary>
1. Go to `chrome://gpu` and ensure "Ozone platform" is set to "Wayland"
If it is not, go to `chrome://flags` and set `#ozone-platform-hint` to `auto`. Do not select relaunch, instead, close the browser and reopen it.
2. However, you might notice that some of the Graphic Feature Statuses are now set to "Software only." If this is the case, open `chrome://flags` and enable the following flags: `#ignore-gpu-blocklist`, `#enable-zero-copy`
If it is still the case, follow the further instructions below:

AMD GPUs:
For video acceleration to work on AMD GPUs, you must use Vulkan rendering instead of OpenGL.
First, try enabling the following flags: `#enable-vulkan`, `#default-angle-vulkan`, and `#vulkan-from-angle`

## Massive work in progress
(Chrome hardware acceleration is a pain)