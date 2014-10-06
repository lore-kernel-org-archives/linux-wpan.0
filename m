Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46355 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbaJFRQB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Oct 2014 13:16:01 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so5660803pad.29
        for <linux-wpan@vger.kernel.org>; Mon, 06 Oct 2014 10:16:01 -0700 (PDT)
Message-ID: <5432CE4B.7080209@exegin.com>
Date: Mon, 06 Oct 2014 10:15:55 -0700
From: Owen Kirby <osk@exegin.com>
MIME-Version: 1.0
Subject: Re: [Linux-zigbee-devel] Linux WPAN sources for ZigBee porting
References: <CAAdqeRSU=irjdpERicLhZ=cT_cBBfsDEXWeVr7V4z0=OgB2xYw@mail.gmail.com> <20141002084013.GA18438@omega> <CAAdqeRQu3-uYVHP-OE7eT839btnf8VmuaEuTr9kx3M_pRMXTWg@mail.gmail.com> <20141002102717.GB19732@omega> <20141002102941.GC19732@omega> <542EBCD1.8030609@exegin.com> <20141004031115.GA16788@omega>
In-Reply-To: <20141004031115.GA16788@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-wpan@vger.kernel.org

Hi,

On 14-10-03 08:11 PM, Alexander Aring wrote:
> Hi,
>
> On Fri, Oct 03, 2014 at 08:12:17AM -0700, Owen Kirby wrote:
>> A while ago, we were also interested in porting our ZigBee stack to use
>> the linux-wpan interface, and we came to the same conclusion. The API is
>> missing too much of the IEEE 802.15.4 MLME components to provide support
>> for a workable ZigBee stack. In the end, we wound up implementing our
>> IEEE 802.15.4 driver in userspace along with the ZigBee stack; It works
>> quite well, but one of these days I would still like to port it to
>> linux-wpan.
>>
> mhhh, what do you using right now? The old linux-zigbee kernel sources?
> Or mainline state? linux-wpan is mainline state.
We're just using the mainline kernel without any IEEE 802.15.4 support. 
Our boards are using the AT86RF2xx family of transcievers which we're 
controlling from userspace with the spidev interface. These chips offer 
enough hardware acceleration that the driver runs quite well from 
userspace. The ZigBee stack itself communicates with the AT86RF2xx 
driver using a serial protocol over a pty.

The system looks something like this:

+-----------+             +--------------+ 
+-------------+                     +-------------------------+
| AT86RF2xx | <== SPI ==> | Linux Kernel | <== /dev/spidev0.1 ==> | Wpan 
Driver | <== /dev/pts/XX ==> | ZigBee or 6LoWPAN Stack |
+-----------+             +--------------+ 
+-------------+                     +-------------------------+
>
> But, great I heard the first time that this stack is in some commercial
> product (sounds like it).
>
>> The three major compoenents that are missing from the API are:
>>       * MLME-ASSOCIATE
>>       * MLME-SCAN (and generation of beacons).
>>       * Indirect packet transmission.
>>
> ah indirect packet transmission. Some part of 802.15.4 which I don't
> looked right now at it, because we are far away to support it. ;-)
>
>> In theory, you could cobble something together that does association and
>> scanning from userspace with a raw socket, but there would probably be
>> enough hacking necessary to get it working correctly that it would be
>> much cleaner to implement it in kernelspace with a netlink command.
>>
> Yes, this should something like mac80211 association/deassociation. Like
> 802.11 this is part of MLME. The kernel implementation for looks like
> [0]. This can be triggered over netlink. 802.15.4 should have similar
> things.
Yes, there are a lot of similarities with IEEE 802.11, and I think the 
wireless LAN interfaces have turned into a fairly good example to follow.
>
>> Indirect packet transmission is something that needs kernel support (and
>> sometimes even hardware support), since it relies on fiddling with the
>> ack packets.
>>
> Ack handling via kernelspace... sounds problematic. I need to dig into
> this how the phy could handling this ack handling, if possible.
Indirect packet transmission relies on setting the frame-pending bit in 
the header of the ack packets. Ideally, this bit would be set depending 
on the source address of the packet being acknowledged (which would 
require some address lookups during the ack turnaround period), but it's 
also perfectly valid to set the frame-pending bit globally for all acks 
(though, it's less efficient to do so). Most of the transceivers we've 
seen only allow you to set the frame-pending bit globally.

Doing this without hardware acceleration has often proven to be 
challenging, since IEEE 802.15.4 specifies some very aggressive 
turnaround times.
> I don't know if you already know about it but I try to make a full
> rework of mac802154 and ieee802154 [4]. The current netlink interface is in
> a very awful state, kernel headers which should be uapi have some
> "extern" keywords, etc... don't know why. In the rework I will mainly
> orient to mac80211/wireless stack, to have the likely frameworks.
I've been mostly lurking on these mailing lists, since we opted not to 
use the linux-zigbee framework for our boards, but I appreciate all the 
hard work you've been doing to try and get things into a workable shape.

Thanks,
Owen
