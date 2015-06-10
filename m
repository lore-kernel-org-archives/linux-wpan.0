Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34693 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964941AbbFJQKB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Jun 2015 12:10:01 -0400
Received: by wibut5 with SMTP id ut5so53447089wib.1
        for <linux-wpan@vger.kernel.org>; Wed, 10 Jun 2015 09:09:59 -0700 (PDT)
Date: Wed, 10 Jun 2015 18:09:56 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Strategy for permament extended/EUI64 address writing and
 updating in atusb
Message-ID: <20150610160952.GE6647@omega>
References: <55782D54.2030508@osg.samsung.com>
 <00F27E6C-BEA0-42C5-8AF4-06A3CCEE320F@holtmann.org>
 <20150610152925.GD6647@omega>
 <CABCF45C-444F-4735-86F2-CBBC1B63D3CE@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABCF45C-444F-4735-86F2-CBBC1B63D3CE@holtmann.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, Werner Almesberger <werner@almesberger.net>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>

On Wed, Jun 10, 2015 at 05:38:59PM +0200, Marcel Holtmann wrote:
> Hi Alex,
> 
> >>> Background:
> >>> With the atusb device we have the possibility to store some data in EEPROM as non-volatile memory. Qi hardware as the company behind this devices also has an IEEE OUI assigned which we can use for a range of valiud and unique EUI64 addresses we can use as permanent extended addresses in IEEE 802.15.4
> >>> 
> >>> http://en.qi-hardware.com/wiki/IEEE_OUI_assignments
> >>> 
> >>> Status:
> >>> o I enhanced the firmware to access the EEPROM to allow write and update/read operations
> >>> o A new command allows the reading of the whole EUI64 over usb (ATUSB_EUI64)
> >>> o The ATUSB_EUI64 command is used in the atusb driver to read the address during probe and set it correctly for the default wpan0 interface. This basically replaces the
> >>> ieee802154_random_extended_addr() call.
> >>> o The above is tested and works fine with a device being unplugged and re-plugged and still showing the permanent address read from EEPROM.
> >>> 
> >>> Update/Write Strategy:
> >>> Right now i changed the firmware to intercept write to the IEEE_ADDR register which gets updated whenever the hardware address filter callback fires. (adding a new interface with extended address and bringing it up is such a case). This is hacky and comes with some side effects like your "permanent" address gets overridden by bringing up an interface :)
> >>> 
> >>> I also thought about exposing a sysfs entry to write the new address. This would allow an easy way to change it right through the kernel driver. Easy to use but also kind of violates the idea of having a "permanent" address which is not touched by the driver at all. I chatted a bit with Phobe on IRC about it and really the solution that seems to make most sense is to have a small host utility that uses libusb to read and write the EUI64 to the device. It would be combined with a simple list of known serial numbers and their mapped allocated address.
> >> 
> >> I am against sysfs entries for drivers to do some setting of their addresses. Especially if these are permanent and change the EEPROM data.
> >> 
> >>> For this I will remove the intercepting part of the firmware and expose the writes through another ATUSB command over USB.
> >>> 
> >>> Let me know if you think this goes into the wrong direction. I will be working on this over the next days.
> >> 
> >> I have the feeling that you might want to push that device into a special mode to allow programming of these settings and not allow this at runtime. Same as we do not allow DFU based firmware upgrade at runtime. So maybe you want it to go into DFU upgrade mode and have extra support for certain control messages to allow configuration.
> >> 
> > 
> > I think the endpoint 0 is different between bootloader (dfu) and the
> > application (atusb). Maybe then add this functionality for the
> > bootloader only.
> 
> the device resets and re-enumerates. So yes, the control endpoint will be different in DFU mode than in normal operation mode. So yes, this might be better some vendor control commands.
> 
> > Then it should fine when the userspace tool sends a reset and then
> > having some timeslot (before atusb starts)  to send the permanent address
> > settings over the usb bus.
> > 
> > Not sure if this is true and that's how dfu works.
> 
> Correct me if I am wrong, but loading the firmware is a one time thing. It is persistent. So in case of power loss (aka unplug), next time around you do not have to load firmware again.
> 

What I meant here was the "general updating procedure for the address".

1. Device resets -> going into bootloader
2. You have some timeslot that you need to tell the transceiver "I want
   to programm the address" - in this time the bootloader runs. 

This is solved by of course some libusb utility program which can do the
complete stuff for you. I just meant in the timeslot of 2 the "special"
endpoint is available to do programming stuff.

> >> For runtime based device address configuration (in case a device does not have one at all), I prefer looking at doc/mgmt-api.txt in BlueZ and our unconfigured state and Set Public Address commands. We solved this problem nicely in case the host OS has access to some sort of one-time non-volatile memory area.
> >> 
> > 
> > I look right now into [0]. What do you mean with 'host OS has access to
> > some sort of one-time non-volatile memory area.', is this really the
> > host OS. Means I can connect a eeprom at my i2c bus and store some
> > public address which is read out by some userspace tool and sets the address
> > to the specific "controller"?
> 
> If the driver can load the persistent and permanent address from somewhere, then it should do that. I am talking in the cases where it does not. And in Bluetooth a lot of manufactures just have the BD_ADDR stored in their own one-time memory or even the host filesystem.
> 

Okay, but then you could also use any network manager to do this stuff
on boot time via generic interface, which "ip" utility also use.

btw. for SPI transceivers I also don't saw any persistent storage. Also
no serial id or something else which could be used to generate an
extended address from.

> It is too keep the chips cheap since you buy them without IEEE assigned address.
> 
> > I was think about to implement such thing like ethernet it does. The
> > bootloader set's some parameter/device tree argument and then the driver
> > "could" parse it, if the driver cares about that. See [1], which adds
> > the device-tree binding. This can be overwritten by the bootloader and
> > the bootloader, which probably has an enviornment can set this addrss
> > then. Maybe this behaviour is some outdated and there exists some better
> > solution. Anyway this is also right now for non plug&play transceivers
> > like the SPI ones. For USB, the transceiver should store the permanent
> > address.
> 
> Having to update DT to change an address is stupid. It might be fine with a minimal overlay DT for just the address, but otherwise it is still stupid.
> 

Should I assume this opinion now as review comment for the device tree
patch? Or it's only the mechanism that the bootloader should overwrite
it. This works somehow "persistent" for static systems.

This mechanism also not means that the bootloader doesn't update the
device tree. It's just that the user has some possibility to add a
extended-address for this static connected SPI device, which the user
can configure over the dt.

I only know that some bootloader enviornments mechanism do the updating
on the fly before starting the kernel. Then it's just stupid that the
bootloader does that.

> If you need to operate a valid address, then it is either present when the device gets powered on or it is not. In case it is not, then let userspace program it.
> 

The current solution is more:

All driver _should_ have some permanent extended address source. Doesn't
matter where it comes frome, at last a driver can always call that a
random one can be generated. If a driver doesn't set a permanent
extended address, then I declare it as a bug inside the driver.

So we are sure that the driver always sets some valid address. After
booting then a network manager can set this address. Then the extended
address is stored on the host filesystem.

In general there should be some priority of getting the extended address
like:

1. get it from some r/w persistent storage
2. (if 1. fails). get it from some read only persistent storage
3. (if 2. fails). try to get from device tree (in case of SPI transceivers, for now)
4. (if 3. fails). generate a random one

Nevertheless the last option should be always that the driver generates
a random one.

> This clearly is for the case where an unplug/replug would loose the address. If you write it once and it is persistent, then that is different. That is outside the scope of nl802154 an hardware specific.

Yes, persistent is just when I plugged in into PC A then it's also the
same when I plug my transceiver into PC B. For SPI transceivers, you
cannot simple unplug and replug the transceiver at runtime, that's why
the above solution for device tree setting should _maybe_ come in for
SPI transceivers. The driver can deal where the persistent address
source comes from.

- Alex
