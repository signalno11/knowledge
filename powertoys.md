---
title: Microsoft PowerToys
parent: Windows Software Alternatives
layout: default
---
# PowerToys equivalent tools
Microsoft offers a collection of advanced tools called PowerToys for their Windows operating system. Equivalent or similar tools are also available on Linux.

##### Advanced Paste
Some of these functions are built into the default clipboard manager on KDE Plasma, accessed with <kbd>Super</kbd>+<kbd>V</kbd>
##### Always on Top
This functionality is built into KDE Plasma. Simply right click the window's title bar (if the window doesn't have a title bar, you may press <kbd>Alt</kbd>+<kbd>F3</kbd> to invoke the same menu) and select More Actions > Keep Above Others. You can also set a shortcut to do this in the shortcut settings.
##### Awake
Obviously you may simply disable power management (which is much easier on Plasma than it is on Windows), but if you want all the functionality, use (this is a future Moon endeavour)
##### Color Picker
Add the color picker widget to your dock or desktop, or use KColorChooser if you rather an application.
##### Command Not Found
This feature is available through PackageKit, and should be automatically set up on bash and zsh. You may need to configure it on other shells.
##### Crop and Lock
This doesn't appear to exist, but would probably be possible to implement as a Desktop Effect
##### Environment Variables
Unlike Windows, there is no central location to have environment variables. You can run `printenv` to see all applicable environment variables, and see [this ArchWiki article](https://wiki.archlinux.org/title/Environment_variables#Defining_variables) on how to define them.
##### FancyZones
This feature is built into Plasma as the "Window Tiling" Desktop Effect. It is enabled by default, and you can use it by pressing <kbd>Super</kbd>+<kbd>T</kbd>
##### File Explorer add-ons
These features are built into KDE Plasma's file manager, Dolphin.
##### File Locksmith
File locking shouldn't really happen apart from specific circumstances on Linux, but you may always just delete the lock (although this can lead to issues, especially if you're messing with your package manager for example).
##### Hosts File Editor
Simply edit `/etc/hosts`. You may use `xdg-open` on Plasma, assuming your default editor is Kate or KWrite, as they support Polkit.
##### Image Resizer
Use ReImage, a Dolphin service. Moon: Remember to try https://store.kde.org/p/2145001/ and https://github.com/irfanhakim-as/kde-service-menu-reimage
##### Keyboard Manager
The ability to use custom shortcuts is built into Plasma. See System Settings > Keyboard > Shortcuts
##### Mouse Utilities
Some features of this plugin are available through Desktop Effects on Plasma, them being: Track Mouse, Mouse Click Animation. Mouse Warp is currently not here, but it should be possible to write an effect for this. Maybe one day I'll make one.
##### Mouse Without Borders
There are a few tools that do this. Remind me to try them.
https://github.com/deskflow/deskflow
https://github.com/input-leap/input-leap
https://github.com/feschber/lan-mouse
Read https://github.com/deskflow/deskflow?tab=readme-ov-file#collaborative-projects
##### New+
Templates are natively supported in Dolphin, and use .desktop files. Read this - Moon, write a guide eventually
##### Peek
I'll find something eventually
##### PowerRename 
You may use the included KRename to do something very similar.
##### PowerToys Run
You may use KRunner, which is installed by default, and accessible with <kbd>Alt</kbd>+<kbd>Space</kbd> by default. By default, it appears at the top of the screen, but you can make it show in the center using its settings.
##### Quick Accent
See (about compose keys link - moon put this here eventually)
##### Registry Preview
Linux doesn't use a registry, so there is no registry preview tool.
##### Screen Ruler 
Use KRuler.
##### Shortcut Guide
Wayland's design probably makes this impossible unless KDE wants to add it to their compositor. Sorry.
##### Text Extractor
Note to moon: try the following and then update recommendations here
https://flathub.org/apps/com.github.tenderowl.frog
https://github.com/zendalona/lios
https://danpla.github.io/dpscreenocr/en/
https://github.com/dynobo/normcap
https://github.com/RajSolai/TextSnatcher
##### Video Conference Mute
Note to moon: explore shortcuts menu to see if this is possible