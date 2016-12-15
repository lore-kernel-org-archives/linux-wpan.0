Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:47673 "EHLO
        photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752661AbcLOL0L (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 15 Dec 2016 06:26:11 -0500
Date: Thu, 15 Dec 2016 12:25:29 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: Flashing firmware onto atusb
Message-ID: <20161215112529.bkvkhtvj3ufpc6in@bogon.m.sigxcpu.org>
References: <20161215094534.sc5awrane6eeud6f@bogon.m.sigxcpu.org>
 <6fb4e9b3-75f7-751c-01df-3e1551a3d619@osg.samsung.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="53w2xts6wfikzuet"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fb4e9b3-75f7-751c-01df-3e1551a3d619@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org


--53w2xts6wfikzuet
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Stefan,

On Thu, Dec 15, 2016 at 11:44:53AM +0100, Stefan Schmidt wrote:
> Hello.
> 
> On 15/12/16 10:45, Guido Günther wrote:
> > Hi,
> > I'm trying to flash firmware onto a new atusb dongle but:
> 
> 
> Is this one of the dongles from the recent builds or is it an old one?
> The new ones already come with version 0.3 of the firmware. :-)

...but I want to be able to flash my own in the future ;)

> 
> > 
> >     # lsusb  | grep Qi
> >     Bus 001 Device 014: ID 20b7:1540 Qi Hardware ben-wpan, AT86RF230-based
> > 
> >     # dfu-util -d 20b7:1540 -D atusb-0.3.dfu
> >     dfu-util 0.9
> > 
> >     Copyright 2005-2009 Weston Schmidt, Harald Welte and OpenMoko Inc.
> >     Copyright 2010-2016 Tormod Volden and Stefan Schmidt
> >     This program is Free Software and has ABSOLUTELY NO WARRANTY
> >     Please report bugs to http://sourceforge.net/p/dfu-util/tickets/
> > 
> >     dfu-util: Invalid DFU suffix signature
> >     dfu-util: A valid DFU suffix will be required in a future dfu-util release!!!
> >     dfu-util: Device has DFU interface, but has no DFU functional descriptor
> >     Deducing device DFU version from functional descriptor length
> >     Opening DFU capable USB device...
> >     ID 20b7:1540
> >     Run-time device DFU version 0100
> >     Claiming USB DFU Runtime Interface...
> >     Determining device status: state = appIDLE, status = 0
> >     Device really in Runtime Mode, send DFU detach request...
> >     Resetting USB...
> >     dfu-util: Device has DFU interface, but has no DFU functional descriptor
> >     Deducing device DFU version from functional descriptor length
> >     dfu-util: Lost device after RESET?
> >     # echo $?
> >     74
> > 
> > dmesg has:
> > 
> >     # dmesg
> >     [ 2802.216273] usb 1-1: reset full-speed USB device number 14 using xhci_hcd
> >     [ 2807.496177] usb 1-1: USB disconnect, device number 14
> >     [ 2807.760001] usb 1-1: new full-speed USB device number 15 using xhci_hcd
> >     [ 2807.901993] usb 1-1: New USB device found, idVendor=20b7, idProduct=1540
> >     [ 2807.901997] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=1
> >     [ 2807.902000] usb 1-1: SerialNumber: 47303530353015102717
> > 
> > Is there anything obvious I am missing?
> 
> Seems you tried to flash the device when already out of the bootloader mode.
> Please try the above command again when inserting the dongle. The device is
> in the bootloader, waiting for firmware updates, as long as the red LED is
> on after insertion.

That worked:

    # dfu-util -d 20b7:1540 -D atusb-0.3.dfu
    dfu-util 0.9

    Copyright 2005-2009 Weston Schmidt, Harald Welte and OpenMoko Inc.
    Copyright 2010-2016 Tormod Volden and Stefan Schmidt
    This program is Free Software and has ABSOLUTELY NO WARRANTY
    Please report bugs to http://sourceforge.net/p/dfu-util/tickets/

    Opening DFU capable USB device...
    ID 20b7:1540
    Run-time device DFU version 0101
    Claiming USB DFU Interface...
    Setting Alternate Setting #0 ...
    Determining device status: state = dfuDNLOAD-IDLE, status = 8
    aborting previous incomplete transfer
    Determining device status: state = dfuIDLE, status = 0
    dfuIDLE, continuing
    DFU mode device DFU version 0101
    Device returned transfer size 64
    Copying data from PC to DFU device
    Download	[=========================] 100%         6026 bytes
    Download done.
    state(2) = dfuIDLE, status(0) = No error condition is present
    Done!

I was thinking about s.th. like bootloader mode in the first place but
this deceived me:

    Device really in Runtime Mode, send DFU detach request...
    Resetting USB...
    dfu-util: Device has DFU interface, but has no DFU functional descriptor

so I thought dfu-util would be able to get the device back into
bootloader mode. And in fact if the device is in runtime mode already I
do see a device reset (the red led turns back on) but it the fails. Is
this a bug in dfu-util or expected? If so should it be documented like
in the attache patch?
Cheers,
 -- Guido

--53w2xts6wfikzuet
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-atusb-Document-that-dfu-util-needs-to-be-run-before-.patch"

 From 9b4fb09336535a50752f31c2d5e649f17e76ea9b Mon Sep 17 00:00:00 2001
Message-Id: <9b4fb09336535a50752f31c2d5e649f17e76ea9b.1481801063.git.agx@sigxcpu.org>
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Date: Thu, 15 Dec 2016 12:23:09 +0100
Subject: [PATCH] atusb: Document that dfu-util needs to be run before device
 enters runtime mode

---
 atusb/ChangeLog | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/atusb/ChangeLog b/atusb/ChangeLog
index 62b7cef..7e1d96d 100644
--- a/atusb/ChangeLog
+++ b/atusb/ChangeLog
@@ -7,8 +7,12 @@ ChangeLog:
 		* Remove FCS frame check from firmware and leave it to the driver
 		* Use extended operation mode for TX for automatic ACK handling
 
-To flash the firmware you need dfu-util on the host:
-dfu-util -d 20b7:1540 -D atusb-0.3.dfu
+To flash the firmware you need dfu-util on the host. Issue
+
+    dfu-util -d 20b7:1540 -D atusb-0.3.dfu
+
+right after plugging the device into the USB port while the red led is still
+on.
 
 For the Atmel Raven USB dongle a full JTAG setup is needed to flash the
 firmware as no DFU bootloader is available there.
-- 
2.10.2


--53w2xts6wfikzuet--
