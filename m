Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:33168 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbcEMIPp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 13 May 2016 04:15:45 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: issue with the mrf24j40 driver
From: smlng <s@mlng.net>
In-Reply-To: <1284257734.3031397.1463123649791.JavaMail.zimbra@telecom-bretagne.eu>
Date: Fri, 13 May 2016 10:15:34 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <D674B1D3-92C5-4AB7-97AE-7151FE175A9B@mlng.net>
References: <1284257734.3031397.1463123649791.JavaMail.zimbra@telecom-bretagne.eu>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Cyrille PIATTE <cyrille.piatte@telecom-bretagne.eu>
Cc: linux-wpan@vger.kernel.org, alan@signal11.us

Hi Cyrille,

I have to look a up the details, but I had this module running with a Pi B+. But first I ran into (kind of) similar problems. You may have a look a at my DTS overlay here [1], for comparison; the pinout I used was as follows:

> MRF24J40                       RASPBERRY PI 2, PIN
> 
> INT                            P16, BCM 23
> RST                            P1, 3.3V
> CS                             P24 (CE0), BCM 8
> SCK                            P23 SCLK, BCM 11
> SDO                            P21, MISO, BCM 9
> SDI                            P19, MOSI, BCM 10
> 3.3V                           P17, 3.3V
> GND                            P20, GND

One problem I encountered, was that the MRF is expecting some input voltage (HIGH) on its reset pin, thus I connected it to P1, VCC 3.3 as a workaround. Btw. I used Raspbian with 4.1.19 Linux-Kernel, with the overlay linked in [1].

Hope this helps, best

Sebastian

[1]: https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-Raspbian-image-with-6LoWPAN-support#31-transceiver-specific-device-tree-overlays

> Am 13.05.2016 um 09:14 schrieb Cyrille PIATTE <cyrille.piatte@telecom-bretagne.eu>:
> 
> Hello,
> 
> I encounter some issues with the mrf24j40 module. I am currently trying to sniff 802.15.4 packets.
> 
> I have a mrf24j40ma ( http://www.microchip.com/wwwproducts/en/MRF24J40 ) module which is wired to a raspberry pi 2 (raspbian-jessie with linux kernel 4.1.19)
> I wired the module as follow :
> 
> http://pinout.xyz/pinout/pin1_3v3_power
> 
> MRF24J40                       RASPBERRY PI 2
> 
> INT                            BCM 22
> RST                            BCM 25
> CS                             BCM 8 (CE0)
> SCK                            BCM 11 (SCLK)
> SDO                            BCM 9 (MISO)
> SDI                            BCM 10 (MOSI)
> 3.3V                           3.3 power (physical 1)
> GND                            ground (physical 6)
> 
> I have modified the /boot/config.txt in which I have appended 'dtoverlay=mrf24j40'. I also have uncommented the line 'dtparam=spi=on'.
> Here is my code for the overlay :
> 
> //-----------------------------------------------------------------------------------------------------------------------------------------------------
> 
> /dts-v1/;  /*required header*/
> /plugin/;  /*signal to the compiler that it needs to generate linkage information (allows unresolved symbols to be patched later)*/
> 
> /*node root*/
> / {
> 
>    /*list the compatible device drivers and load the first one*/
>        compatible ="bcrm, bcm2835", "bcrm, bcm2836", "bcrm, bcm2708", "bcrm, bcm2709";
> 
>    /*
>      a fragment apply modifications to a node (defined in the compatible file.dtX loaded)
>      it is composed by a target (the node to modify) and an overlay (the modifications)
>    */
> 
>        /*modification of the SPI part*/
>        fragment@0 {
>                target = <&spi0>; /* the mrf24j40 module is linked with the spi0 (defined in bcm2XXX.dtX) branch (white wire) */
>                __overlay__ {
>                        #address-cells = <1>;
>                        #size-cells = <0>;
>                        status = "okay";
> 
>                        mrf24j40@0 {
>                                compatible = "mrf24j40";    /*load the driver*/
>                                reg = <0>;   /*because it is the spi0 ce0 which is linked with the CS (otherwise spi0 ce1 <-> CS and reg = <1>)*/
>                                interrupts = <22 0x1>;
>                                interrupt-parent = <&gpio>;
>                                spi-max-frequency = <5000000>; /*or 1000000*/
>                        };
> 
>                        spidev@0 {
>                                status = "disabled";
>                        };
> 
>                        spidev@1 {
>                                status = "disabled";
>                        };
>                };
>        };
> };
> 
> //-----------------------------------------------------------------------------------------------------------------------------------------------------
> 
> 
> When I boot the raspberry pi 2, the modules spi_bcm2835 and mrf24j40 are loaded which is okay (from the overlay). Moreover, both the physical (phy0 with 'iz listphy') and dev (wpan0 with 'iz list') interfaces are present. So I can set up my 802.15.4 network. I use lowpan-tools with 'iz set' to give an address, a pan_id and and a channel to the wpan0 interface. Then I put the interface up ('ifconfig wpan0 up').
> 
> I launch wireshark and a device that send 802.15.4 frames (that are detected by other devices with similar configuration in term of address, pan_id and channel, so the issue does not seem to come from here). Wireshark do not display any frame.
> 
> Do you have any clues about what may be wrong ?
> 
> I thank you in advance for your support.
> 
> Best regards,
> 
> Cyrille Piatte
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

 Sebastian

[mail]: s@mlng.net
[code]: https://github.com/smlng

