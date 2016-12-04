Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54378 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750697AbcLDLf0 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Dec 2016 06:35:26 -0500
Received: from [IPv6:2003:48:92f:f35a:3252:cbff:fe54:190f] (p20030048092FF35A3252CBFFFE54190F.dip0.t-ipconnect.de [IPv6:2003:48:92f:f35a:3252:cbff:fe54:190f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 2C19AC51F5
        for <linux-wpan@vger.kernel.org>; Sun,  4 Dec 2016 12:35:24 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: ATUSB firmware 0.3 release
Message-ID: <df8743f2-d14d-b747-f8a2-704c664771f6@datenfreihafen.org>
Date: Sun, 4 Dec 2016 12:35:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.

Since the initial 0.2 firmware release for the ATUSB devices almost 18
months have been gone by. The firmware and the Kernel driver have been
working well together so far, but there is always room for improvement.
The work towards a new firmware release has been going slowly but we
finally made it.

Changelog
* ATUSB_EUI64_READ/WRITE for permanent EUI64 handling
* Support to run the firmware on Atmel Raven USB dongles (Alexander Aring)
* Remove FCS frame check from firmware and leave it to the driver
* Use extended operation mode for TX for automatic ACK handling

You can find the atusb as well as the newly rzusb firmware files
together with their sha256 checksum here:

http://downloads.qi-hardware.com/people/werner/wpan/web/atusb-0.3.dfu
d9333788b0eefad3f7796fccea119fe211d5540baa7da82e35406f6b35334417

http://downloads.qi-hardware.com/people/werner/wpan/web/rzusb-0.3.bin
d642eeb96ac91233960f87936864a25ee0b0e80a88d47e838cf1e15bdb02e7cd

Patches to enable some of the new functionality in the Kernel driver are
already done and I will post them this week.

If you want to get an official EUI64 permanent address for your own
ATSUB please contact me with the serial number of your device (printed
out during driver probe in dmesg) and I will assign you one. All new
devices will have an EUI64 placed into EEPROM already before shipping.

A note about flashing the rzusb firmware. You need a working JTAG setup
for this. There is no bootloader on the Raven dongles that would accept
the firmware over USB.

regards
Stefan Schmidt
