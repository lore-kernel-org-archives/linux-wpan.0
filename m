Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:47623 "EHLO
        photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935289AbcLOKjc (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 15 Dec 2016 05:39:32 -0500
Received: from honk.sigxcpu.org (localhost [127.0.0.1])
        by photon.sigxcpu.org (Postfix) with ESMTPS id AADD321E
        for <linux-wpan@vger.kernel.org>; Thu, 15 Dec 2016 10:46:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 51431FB04
        for <linux-wpan@vger.kernel.org>; Thu, 15 Dec 2016 10:46:06 +0100 (CET)
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wp54_TtfDohz for <linux-wpan@vger.kernel.org>;
        Thu, 15 Dec 2016 10:46:05 +0100 (CET)
Date: Thu, 15 Dec 2016 10:45:34 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Flashing firmware onto atusb
Message-ID: <20161215094534.sc5awrane6eeud6f@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,
I'm trying to flash firmware onto a new atusb dongle but:

    # lsusb  | grep Qi
    Bus 001 Device 014: ID 20b7:1540 Qi Hardware ben-wpan, AT86RF230-based

    # dfu-util -d 20b7:1540 -D atusb-0.3.dfu
    dfu-util 0.9

    Copyright 2005-2009 Weston Schmidt, Harald Welte and OpenMoko Inc.
    Copyright 2010-2016 Tormod Volden and Stefan Schmidt
    This program is Free Software and has ABSOLUTELY NO WARRANTY
    Please report bugs to http://sourceforge.net/p/dfu-util/tickets/

    dfu-util: Invalid DFU suffix signature
    dfu-util: A valid DFU suffix will be required in a future dfu-util release!!!
    dfu-util: Device has DFU interface, but has no DFU functional descriptor
    Deducing device DFU version from functional descriptor length
    Opening DFU capable USB device...
    ID 20b7:1540
    Run-time device DFU version 0100
    Claiming USB DFU Runtime Interface...
    Determining device status: state = appIDLE, status = 0
    Device really in Runtime Mode, send DFU detach request...
    Resetting USB...
    dfu-util: Device has DFU interface, but has no DFU functional descriptor
    Deducing device DFU version from functional descriptor length
    dfu-util: Lost device after RESET?
    # echo $?
    74

dmesg has:

    # dmesg
    [ 2802.216273] usb 1-1: reset full-speed USB device number 14 using xhci_hcd
    [ 2807.496177] usb 1-1: USB disconnect, device number 14
    [ 2807.760001] usb 1-1: new full-speed USB device number 15 using xhci_hcd
    [ 2807.901993] usb 1-1: New USB device found, idVendor=20b7, idProduct=1540
    [ 2807.901997] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=1
    [ 2807.902000] usb 1-1: SerialNumber: 47303530353015102717

Is there anything obvious I am missing?
Cheers,
 -- Guido
