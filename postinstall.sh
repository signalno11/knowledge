#!/bin/bash

## Written by Moon (@signalno11)
## Version 0.2
## SOURCES
# ArchWiki contributors. “Hardware Video Acceleration.” ArchWiki. Last modified May 7, 2025.
#         https://wiki.archlinux.org/title/Hardware_video_acceleration.
# ———. “NVIDIA.” ArchWiki. Last modified May 15, 2025.
#         https://wiki.archlinux.org/title/NVIDIA.
# freedesktop.org. “CodeNames.” freedeskto.org. Last modified April 25, 2025.
#         https://nouveau.freedesktop.org/CodeNames.html.
# Intel. “Intel/Media-driver: Intel Graphics Media Driver to Support Hardware Decode,
#         Encode and Video Processing.” GitHub. Accessed May 18, 2025.
#         https://github.com/intel/media-driver.
# ———. “Intel® Processors.” Accessed May 18, 2025.
#         https://www.intel.com/content/www/us/en/products/details/processors.html.
# Moon [signalno11]. “Home.” Moon’s Linux Knowledge Base. Accessed May 18, 2025.
#         https://signalno11.github.io/knowledge.
# PCI Lookup developers. “PCI Lookup.” PCI Lookup. Accessed May 18, 2025.
#         https://www.pcilookup.com/.
# RPM Fusion contributors. “Configuration.” RPM Fusion. Last modified April 18, 2025.
#         https://rpmfusion.org/Configuration.
# ———. “Howto/Multimedia.” RPM Fusion. Last modified October 24, 2024.
#         https://rpmfusion.org/Howto/Multimedia.
# ———. “Howto/NVIDIA.” RPM Fusion. Last modified March 23, 2025.
#         https://rpmfusion.org/Howto/NVIDIA.
# TechPowerUp, ed. “GPU Specs.” Accessed May 18, 2025.
#         https://www.techpowerup.com/gpu-specs/.
# ———, ed. “Intel GMA X4500 Specs.” Accessed May 18, 2025.
#         https://www.techpowerup.com/gpu-specs/gma-x4500.c3116.
# The PCI ID Repository contributors. “The PCI ID Repository” The PCI ID
#         Respository. Accessed May 18, 2025. https://admin.pci-ids.ucw.cz/.
# Torvalds, Linus [torvalds]. “Linux/Arch/X86/Include/Asm/intel-family.h at Master ·
#         Torvalds/Linux.” GitHub. Accessed May 18, 2025.
#         https://github.com/torvalds/linux/blob/master/arch/x86/include/asm/intel-family.h.
# WikiChip contributors. “CPUID - Intel.” WikiChip. Last modified April 25, 2025.
#         https://en.wikichip.org/wiki/intel/cpuid.
# Wikipedia contributors. “Intel Core.” Wikipedia. Last modified April 10, 2025.
#         https://en.wikipedia.org/wiki/Intel_Core.
# ———. “Intel GMA.” Wikipedia. Last modified March 2, 2025.
#         https://en.wikipedia.org/wiki/Intel_GMA.
# ———. “List of Intel Chipsets.” Wikipedia. Last modified April 29, 2025.
#         https://en.wikipedia.org/wiki/List_of_Intel_chipsets#Core.
# ———. “List of Intel Processors.” Wikipedia. Last modified May 14, 2025.
#         https://en.wikipedia.org/wiki/List_of_Intel_processors.


# https://en.wikipedia.org/wiki/TeraScale_(microarchitecture)
# https://en.wikipedia.org/wiki/List_of_AMD_graphics_processing_units

check_if_root()
{
    if [[ $EUID -ne 0 ]]; then
        printf "You must run this script with 'sudo'.\n"
        exit 1
    fi
}

run_update()
{
    printf "Checking for updates...\n"
    dnf up -y
    if dnf needs-restarting; then
        printf "Rebooting in 10 seconds for updates...RUN THIS SCRIPT AGAIN WHEN YOU LOG BACK IN!"
        sleep 10
        reboot
    fi
}

check_gpu_vendor()
{
    case $(lspci -nmd ::0300 | awk '{ gsub(/"/, "", $3); print $3 }' ) in
        1002)
            gpu=amd
            check_amd_gpu
            ;;
        8086)
            gpu=intel
            check_intel_gpu
            ;;
        10de)
            gpu=nvidia
            check_nvidia_gpu
            ;;
        *)
            prinf "Unknown GPU\n"
            exit 1
            ;;
    esac
}

check_amd_gpu()
{
    case $(lspci -md ::0300 | awk -F'"' '{print $6}') in
        # R200
        R200* | RV250* | RV280* | RS300* | RS350* | RC350*) ;&
        # R100
        RV100* | R100* | RV200* | RS100* | RS200*)
            read -rp "Your GPU requires Mesa Amber, which Fedora does not support. In order for your GPU to work, you'll need to switch to another distro. Would you like to continue with software rendering anyway? (y/n) " amd_amber_yn; if [[ "${amd_amber_yn,,}" = 'y'* ]]; then gpu=skip; else exit 1; fi
            ;;
        # Pre-Radeon cards
        Mach64* | "Rage 2*" | "Rage 3*" | "Rage 4*" | "*Rage*")
        read -rp "Pre-radeon cards are not supported. Would you like continue with software rendering anyway? (y/n) " amd_unsup_yn; if [[ "${amd_unsup_yn,,}" = 'y'* ]]; then gpu=skip; else exit 1; fi
        ;;
    esac
}

check_nvidia_gpu()
{
    if [[ $(mokutil --sb-state) = *enabled* ]]; then
        printf "You have secure boot enabled. Because you have a NVIDIA card, you must either disable secure boot, or self-sign the NVIDIA driver. https://signalno11.github.io/knowledge/nvidia_secboot.html.\n"
        exit 1
    fi
    case $(lspci -md ::0300 | awk -F'"' '{print $6}') in
        ## NVIDIA Open supported (Turing and later)
        # Turing
        *TU[0-9][0-9][0-9]*) ;&
        # Ampere
        *GA[0-9][0-9][0-9]*) ;&
        # Ada Lovelace
        *AD[0-9][0-9][0-9]*) ;&
        # Blackwell / 2.0
        *GB[0-9][0-9][0-9]*)
            nvidia=open
            ;;
        ## NVIDIA Supported (Maxwell and later) [Turing and later is not targeted, this script will install NVIDIA Open instead]
        # Maxwell
        *GM[0-9][0-9][0-9]*) ;&
        # Pascal
        *GP[0-9][0-9][0-9]*) ;&
        # Volta
        *GV[0-9][0-9][0-9]*)
            nvidia=current
            ;;
        ## NVIDIA Legacy 470 (Kepler)
        *GK[0-9][0-9][0-9]*)
            nvidia=470
            ;;
        ## NVIDIA Legacy 390 (Fermi)
        *EXMF104* | *GF[0-9][0-9][0-9]*)
            nvidia=390
            ;;
        ## NVIDIA Legacy 340 (Tesla)
        *ION* | *C77* | *C79* | *C89* | *G80* | *G84* | *G86* | *G92* | *G94* | *G96* | *G98* | *GT200* | *GT215* | *GT216* | *GT218* | *MCP77* | *MCP78* | *MCP79* | *MCP7A* | *MCP89*)
            nvidia=340
            ;;
        *)
            read -rp "Either your GPU is newer than RTX 5000 series, or it is very old. If it is newer than RTX 5000, type y. Otherwise, type n." nvidia_unknown_input; if [[ "${nvidia_unknown_input,,}" = 'y'* ]]; then nvidia=open; else nvidia=unsupported; fi
            ;;
    esac
}

check_intel_igp()
{
    case $(awk '$1 == "cpu" && $2 == "family" && $3 == ":" {print $4; exit}' /proc/cpuinfo) in
            6)
        case $(awk '$1 == "model" && $2 == ":" {print $3; exit}' /proc/cpuinfo) in
            ### Case: Legacy Intel driver
            ## Desktop CPUs
            # Haswell
            70 | 69 | 60) ;&
            # Ivy Bridge
            58) ;&
            # Sandy Bridge
            42) ;&
            # Westmere
            37)
                printf "Warning: Westmere, GPU support a little unclear\n"
                ;&
            # Nehalem -- maybe is unclear if has GPU
            31 | 30)
                printf "Warning: Nehalem, GPU support a little unclear\n"
                ;&
            ## Server CPUs
            # Haswell
            63) ;&
            # Ivy Bridge
            62) ;&
            # Sandy Bridge
            45) ;&
            # Westmere
            47 | 44)
                printf "Warning: Westmere, GPU support a little unclear\n"
                ;&
            # Nehalem
            46 | 30 | 26 | 29)
                printf "Warning: Nehalem, GPU support a little unclear\n"
                ;&
            ## Laptop CPUs
            # Silvermont
            93 | 90 | 77 | 74 | 55) ;&
            # Airmont
            76 | 117)
                intel=legacy
                ;;
            ### Chipset supported CPUs -- ask the user for now
            ## Desktop
            # Penryn
            23) ;&
            # Core
            22 | 15) ;&
            ## Server
            # Penryn
            29 | 23) ;&
            ## Laptop
            # Bonnel
            38 | 28) ;&
            # Saltwell
            54 | 53 | 39)
                printf "Currently, we don't autodetect GPU drivers for hardware as old as yours. The script will print out your motherboard and your GPU.\n Anything newer than the GMA 4500 will work.\n"
                dmidecode -t 2
                lspci -d ::0300
                printf "If you have Intel HD graphics or newer, you're good. If you have GMA graphics, as far as I can tell, only the GMA 4500 (found on B43, Q43, and Q45), GMA X4500/HD (found on G41, G43, and G45), GMA 4500MHD (found on GM45), and GMA X4700MHD (found in GM47), you should also be good. If you have older GMA graphics, they may not correctly work."
                read -rp "Is your GPU supported? (y/n): " support; if [[ "${support,,}" = 'y'* ]]; then support=yes; else support=no; fi
                if [[ $support = yes ]]; then
                    lspci -d ::0300
                    grep "model name" < /proc/cpuinfo | head -1
                    read -rp "Are you using a deticated Intel Arc GPU, or a 5th gen Core CPU or later? (y/n): " recent; if [[ "${recent,,}" = 'y'* ]]; then intel=modern; else intel=legacy; fi
                else
                    intel=none
                fi
                ;;
            *)
                intel=modern
                ;;
        esac
    ;;
    *)
        printf "Non family-6 CPUs currently cannot be autodetected. Intel drivers WILL NOT BE INSTALLED!!! Ask an advisor on PCHH which one you should install.\n"
        intel=none
        ;;
    esac
}

check_intel_gpu()
{
    # Check if dedicated
    case $(lspci -md ::0300 | awk -F'"' '{print $6}') in
        # Intel Arc & Xe
        *DG2* | *G21* | *DG1*) ;&
        # Intel Datacenter
        *"Arctic Sound*"* | *"Ponte Vecchio"* )
            intel=modern
            ;;
        *Integrated* | *"HD Graphics"* | *"Xe Graphics"* )
            check_intel_igp
            ;;
        *)
            printf "WARNING: GPU not known. Assuming IGP...now checking CPU...\n"
            sleep 3
            check_intel_igp
            ;;
    esac
}

enable_rpmfusion()
{
    dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm -y
    dnf config-manager setopt fedora-cisco-openh264.enabled=1 -y
    dnf update @core -y
}

check_dvd()
{
    printf "Read the following from VLC:\n\n"
    printf 'libdvdcss is a library that can find and guess keys from a DVD in order to decrypt it. This method is authorized by a French law decision \e]8;;https://www.legifrance.gouv.fr/ceta/id/CETATEXT000019216315/\e\\CE 10e et 9e sous-sect., 16 juillet 2008, n° 301843 on interoperability.\e]8;;\e\\\n\nNB: In the USA, you should check out the \e]8;;https://www.copyright.gov/1201/\e\\US Copyright Office decision\e]8;;\e\\ that allows circumvention in some cases. VideoLAN is NOT a US-based organization and is therefore outside US jurisdiction.\n'
    read -rp "Would you like to enable DVD support? (y/n): " dvd; if [[ "${dvd,,}" = 'y'* ]]; then dvd=yes; else dvd=no; fi
}

install_dvd()
{
    dnf in rpmfusion-free-release-tainted -y
    dnf in libdvdcss -y
}

enable_full_codec_support()
{
    dnf swap ffmpeg-free ffmpeg --allowerasing -y
    sudo dnf up @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
}

install_intel_codecs()
{
    case $intel in
        legacy)
            dnf in libva-intel-driver -y
            ;;
        modern)
            dnf in intel-media-driver -y
            ;;
        none)
            printf "WARNING: Skipping Intel driver..."
            sleep 3
            ;;
    esac
}

install_amd_codecs()
{
    dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y
    dnf swap mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686 -y
    dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y
    dnf swap mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686 -y
}

install_nvidia_driver()
{
    case $nvidia in
        open)
            if [ -e /etc/rpm/macros.nvidia-kmod ]; then
                if ! (grep -q "%_with_kmod_nvidia_open 1" "/etc/rpm/macros.nvidia-kmod"); then
                    echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod
                fi
            else
                echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod
            fi
            dnf in akmod-nvidia xorg-x11-drv-nvidia-cuda -y
            dnf mark user akmod-nvidia -y
            ;;
        current)
            if [ -e /etc/rpm/macros.nvidia-kmod ]; then
                if grep -q "%_with_kmod_nvidia_open 1" "/etc/rpm/macros.nvidia-kmod"; then
                    sed -i '/%_with_kmod_nvidia_open 1/d' "/etc/rpm/macros.nvidia-kmod"
                fi
            fi
            dnf in akmod-nvidia xorg-x11-drv-nvidia-cuda -y
            dnf mark user akmod-nvidia -y
            ;;
        470)
            printf "WARNING: This driver (NVIDIA 470.xx) is EOL. It may break at any time. Also installing the X11 session; Wayland will not work.\n"
            printf "Remember to switch to Plasma (X11) at the bottom left of the login screen.\n"
            sleep 2
            dnf in akmod-nvidia-470xx xorg-x11-drv-nvidia-470xx xorg-x11-drv-nvidia-470xx-cuda plasma-workspace-x11 -y
            dnf mark user akmod-nvidia-470xx -y
            ;;
        390)
            printf "WARNING: This driver (NVIDIA 390.xx) is EOL. It may break at any time. Also installing the X11 session; Wayland will not work.\n"
            printf "Remember to switch to Plasma (X11) at the bottom left of the login screen.\n"
            sleep 2
            dnf in akmod-nvidia-390xx xorg-x11-drv-nvidia-390xx xorg-x11-drv-nvidia-390xx-cuda plasma-workspace-x11 -y
            dnf mark user akmod-nvidia-390xx -y
            ;;
        340)
            printf "WARNING: This driver (NVIDIA 340.xx) is EOL. It may break at any time. Also installing the X11 session; Wayland will not work.\n"
            printf "Remember to switch to Plasma (X11) at the bottom left of the login screen.\n"
            sleep 2
            dnf in akmod-nvidia-340xx xorg-x11-drv-nvidia-340xx xorg-x11-drv-nvidia-340xx-cuda plasma-workspace-x11 -y
            dnf mark user akmod-nvidia-390xx -y
            ;;
        unsupported)
            printf "There are no supported proprietary drivers for your GPU. You'll have to settle for nouveau, unforunately.\n"
            ;;
    esac
}

check_multi_gpu()
{
    if [ "$(lspci -nmd ::0300 | awk '{ gsub(/"/, "", $3); print $3 }' | wc - l)" = 1 ]; then
        printf "Currently, this script doesn't support multi-GPU systems. Ask an advisor what to do.\n"
        exit 1
    fi
}

prep()
{
    check_if_root
    run_update
    check_multi_gpu
    check_dvd
    check_gpu_vendor
}

main()
{
    enable_rpmfusion
    enable_full_codec_support
    install_dvd
    case $gpu in
        intel)
            install_intel_codecs
            ;;
        amd)
            install_amd_codecs
            ;;
        nvidia)
            install_nvidia_driver
            ;;
    esac
}

prep
main
