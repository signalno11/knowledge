---
title: DaVinci Resolve
parent: Installing Common Software
layout: default
---
# Installing Blackmagic Design's DaVinci Resolve

1. Download the program for Linux on the [Blackmagic Design website](https://www.blackmagicdesign.com/products/davinciresolve).
1. Extract the .zip file (Right Click > Extract > Extract here and delete archive).
1. Open the newly extracted folder, and type <kbd>Alt</kbd>+<kbd>Shift</kbd>+<kbd>F4</kbd> to open a terminal at that folder.
1. Mark the installer as executable
```
chmod +x DaVinci_Resolve_19.0.3_Linux/DaVinci_Resolve_19.0.3_Linux.run
```
1. Execute the installer
```
SKIP_PACKAGE_CHECK=1 ./DaVinci_Resolve_19.0.3_Linux/DaVinci_Resolve_19.0.3_Linux.run
```
1. Step through the GUI installer.
1. Install libxcrypt compatibility module
```
sudo dnf in libxcrypt-compat
```
1. Blackmagic ships broken libraries that prevent the application from launching[^forum]
1. Create user override of .desktop file
```
sudo cp /usr/share/applications/com.blackmagicdesign.resolve.desktop ~/.local/share/applications
```
1. Edit the .desktop file
```
xdg-open ~/.local/share/applications/com.blackmagicdesign.resolve.desktop
```
Replace the Exec= line with
```
Exec=LD_PRELOAD=/usr/lib64/libglib-2.0.so.0:/usr/lib64/libgio-2.0.so.0:/usr/lib64/libgmodule-2.0.so.0 /opt/resolve/bin/resolve %u
```
1. Finally, open the program.

{: .important }
Make sure you have an OpenCL or CUDA backend installed. 

[^forum]: Solution provided by [this user on the Blackmagic forum](https://forum.blackmagicdesign.com/viewtopic.php?f=21&t=199682). Much love.
