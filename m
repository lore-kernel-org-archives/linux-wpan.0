Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:34573 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496AbbFJP3d (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Jun 2015 11:29:33 -0400
Received: by wgv5 with SMTP id 5so38652110wgv.1
        for <linux-wpan@vger.kernel.org>; Wed, 10 Jun 2015 08:29:31 -0700 (PDT)
Date: Wed, 10 Jun 2015 17:29:29 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Strategy for permament extended/EUI64 address writing and
 updating in atusb
Message-ID: <20150610152925.GD6647@omega>
References: <55782D54.2030508@osg.samsung.com>
 <00F27E6C-BEA0-42C5-8AF4-06A3CCEE320F@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00F27E6C-BEA0-42C5-8AF4-06A3CCEE320F@holtmann.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, Werner Almesberger <werner@almesberger.net>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>

On Wed, Jun 10, 2015 at 04:49:17PM +0200, Marcel Holtmann wrote:
> Hi Stefan,
> 
> > Background:
> > With the atusb device we have the possibility to store some data in EEPROM as non-volatile memory. Qi hardware as the company behind this devices also has an IEEE OUI assigned which we can use for a range of valiud and unique EUI64 addresses we can use as permanent extended addresses in IEEE 802.15.4
> > 
> > http://en.qi-hardware.com/wiki/IEEE_OUI_assignments
> > 
> > Status:
> > o I enhanced the firmware to access the EEPROM to allow write and update/read operations
> > o A new command allows the reading of the whole EUI64 over usb (ATUSB_EUI64)
> > o The ATUSB_EUI64 command is used in the atusb driver to read the address during probe and set it correctly for the default wpan0 interface. This basically replaces the
> > ieee802154_random_extended_addr() call.
> > o The above is tested and works fine with a device being unplugged and re-plugged and still showing the permanent address read from EEPROM.
> > 
> > Update/Write Strategy:
> > Right now i changed the firmware to intercept write to the IEEE_ADDR register which gets updated whenever the hardware address filter callback fires. (adding a new interface with extended address and bringing it up is such a case). This is hacky and comes with some side effects like your "permanent" address gets overridden by bringing up an interface :)
> > 
> > I also thought about exposing a sysfs entry to write the new address. This would allow an easy way to change it right through the kernel driver. Easy to use but also kind of violates the idea of having a "permanent" address which is not touched by the driver at all. I chatted a bit with Phobe on IRC about it and really the solution that seems to make most sense is to have a small host utility that uses libusb to read and write the EUI64 to the device. It would be combined with a simple list of known serial numbers and their mapped allocated address.
> 
> I am against sysfs entries for drivers to do some setting of their addresses. Especially if these are permanent and change the EEPROM data.
> 
> > For this I will remove the intercepting part of the firmware and expose the writes through another ATUSB command over USB.
> > 
> > Let me know if you think this goes into the wrong direction. I will be working on this over the next days.
> 
> I have the feeling that you might want to push that device into a special mode to allow programming of these settings and not allow this at runtime. Same as we do not allow DFU based firmware upgrade at runtime. So maybe you want it to go into DFU upgrade mode and have extra support for certain control messages to allow configuration.
> 

I think the endpoint 0 is different between bootloader (dfu) and the
application (atusb). Maybe then add this functionality for the
bootloader only.

Then it should fine when the userspace tool sends a reset and then
having some timeslot (before atusb starts)  to send the permanent address
settings over the usb bus.

Not sure if this is true and that's how dfu works.

> For runtime based device address configuration (in case a device does not have one at all), I prefer looking at doc/mgmt-api.txt in BlueZ and our unconfigured state and Set Public Address commands. We solved this problem nicely in case the host OS has access to some sort of one-time non-volatile memory area.
> 

I look right now into [0]. What do you mean with 'host OS has access to
some sort of one-time non-volatile memory area.', is this really the
host OS. Means I can connect a eeprom at my i2c bus and store some
public address which is read out by some userspace tool and sets the address
to the specific "controller"?

I was think about to implement such thing like ethernet it does. The
bootloader set's some parameter/device tree argument and then the driver
"could" parse it, if the driver cares about that. See [1], which adds
the device-tree binding. This can be overwritten by the bootloader and
the bootloader, which probably has an enviornment can set this addrss
then. Maybe this behaviour is some outdated and there exists some better
solution. Anyway this is also right now for non plug&play transceivers
like the SPI ones. For USB, the transceiver should store the permanent
address.

- Alex

[0] http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/mgmt-api.txt#n2180
[1] http://www.spinics.net/lists/linux-wpan/msg01504.html
