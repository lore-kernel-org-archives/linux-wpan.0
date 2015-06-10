Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:41019 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078AbbFJM2I (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 10 Jun 2015 08:28:08 -0400
Message-ID: <55782D54.2030508@osg.samsung.com>
Date: Wed, 10 Jun 2015 14:28:04 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Strategy for permament extended/EUI64 address writing and updating
 in atusb
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Cc: Werner Almesberger <werner@almesberger.net>, Alexander Aring <alex.aring@gmail.com>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>

Hello.

Background:
With the atusb device we have the possibility to store some data in 
EEPROM as non-volatile memory. Qi hardware as the company behind this 
devices also has an IEEE OUI assigned which we can use for a range of 
valiud and unique EUI64 addresses we can use as permanent extended 
addresses in IEEE 802.15.4

http://en.qi-hardware.com/wiki/IEEE_OUI_assignments

Status:
o I enhanced the firmware to access the EEPROM to allow write and 
update/read operations
o A new command allows the reading of the whole EUI64 over usb (ATUSB_EUI64)
o The ATUSB_EUI64 command is used in the atusb driver to read the 
address during probe and set it correctly for the default wpan0 
interface. This basically replaces the
ieee802154_random_extended_addr() call.
o The above is tested and works fine with a device being unplugged and 
re-plugged and still showing the permanent address read from EEPROM.

Update/Write Strategy:
Right now i changed the firmware to intercept write to the IEEE_ADDR 
register which gets updated whenever the hardware address filter 
callback fires. (adding a new interface with extended address and 
bringing it up is such a case). This is hacky and comes with some side 
effects like your "permanent" address gets overridden by bringing up an 
interface :)

I also thought about exposing a sysfs entry to write the new address. 
This would allow an easy way to change it right through the kernel 
driver. Easy to use but also kind of violates the idea of having a 
"permanent" address which is not touched by the driver at all. I chatted 
a bit with Phobe on IRC about it and really the solution that seems to 
make most sense is to have a small host utility that uses libusb to read 
and write the EUI64 to the device. It would be combined with a simple 
list of known serial numbers and their mapped allocated address.

For this I will remove the intercepting part of the firmware and expose 
the writes through another ATUSB command over USB.

Let me know if you think this goes into the wrong direction. I will be 
working on this over the next days.

regards
Stefan Schmidt
