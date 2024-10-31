---
title: OBS Studio
layout: default
parent: Installing Common Software
---
# Installing OBS Studio
You can simply install OBS Studio with the following command
```
sudo dnf in obs-studio
```

Install media codecs with
```
sudo dnf obs-studio-freeworld
```
This is required for features like H.264 software encoding. You may still use hardware encoding or AV1 encoding without this package.