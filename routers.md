---
title: OpenWrt routers
layout: default
---
# United States OpenWrt router recommendations

## What is OpenWrt?
OpenWrt is router firmware that allows for more advanced functions and customizations. It's also always up to date, while lots of router manufacturers let their old routers go unupdated.

{: .note }
> When I refer to 2x2, I mean 2x2 MIMO. When I refer to 4x4, I mean 4x4 MU-MIMO. Additonally, 160ch means 160 MHz Channelization, and when channelization isn't referenced, assume 80 Mhz. All specs are referring to the 5GHz band unless otherwise specified.
> 
> Some of these routers come with an OpenWrt-based firmware already installed. These have been **emboldened**. You can still flash vanilla OpenWrt if you want, but the stock config fits the bill.
> 
> I've also *italisized* any devices I think are slightly tedious to install to. i.e, more than a couple easy to follow, graphical steps. Do not let these turn you away from a good router, just have an advisor help you. Additionally, any router where opening the unit is neccesary have been <u>underlined</u>. Any model where light solder work is neccessry are suffixed with a bang (!). If you are not comfortable with soldering, don't buy these routers.

### Sub $50
Amazon has some renewed E8450s in this range. It's 4x4. Otherwise, X6 is also in this price range. Specs are worse, being only 2x2, but in this price range as brand new units.

### $50-100
In this price range, there's not anything with both 4x4 and 160ch. See the glossery below for what this means for you. 
As far as 4x4 devices go, the *DL-WRX36* and E8450 are both great. The *DL-WRX36* has a faster CPU, but is not fully supported by official OpenWrt. Community efforts have gotten them working, but just keep in mind they are not official.
For 2x2 160ch devices, we have the **GL-MT3000**, TR3000, and WR3000. They pretty much all have the same specs.

### $100-150
The only Wifi 6E option on this list, the <u>*Predador Connect W6 (!)*</u> is available used on Amazon in this price range. If you don't want to buy used, the **GL-MT6000** is a good option. It doesn't support 6E, but its 2.4GHz channel is better than the W6's.

### $200+
Get the <u>*Predator Connect W6 (!)*</u>.

## Glossery
MIMO: Multi-in, multi-out - increases speed, but this is a standard feature these days
MU-MIMO: Multi-user, multi-in, multi-out
160mhz channelization: 160mhz channels are wider than 80mhz channels, so more bandwidth, but you have to fight more interference, so this is best in less crowded areas, or if you're really close to your AP. Still nice to have though.