Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:48523 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbaJDDLY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 3 Oct 2014 23:11:24 -0400
Received: by mail-wi0-f181.google.com with SMTP id hi2so400844wib.14
        for <linux-wpan@vger.kernel.org>; Fri, 03 Oct 2014 20:11:22 -0700 (PDT)
Date: Sat, 4 Oct 2014 05:11:17 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Linux-zigbee-devel] Linux WPAN sources for ZigBee porting
Message-ID: <20141004031115.GA16788@omega>
References: <CAAdqeRSU=irjdpERicLhZ=cT_cBBfsDEXWeVr7V4z0=OgB2xYw@mail.gmail.com>
 <20141002084013.GA18438@omega>
 <CAAdqeRQu3-uYVHP-OE7eT839btnf8VmuaEuTr9kx3M_pRMXTWg@mail.gmail.com>
 <20141002102717.GB19732@omega>
 <20141002102941.GC19732@omega>
 <542EBCD1.8030609@exegin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <542EBCD1.8030609@exegin.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Owen Kirby <osk@exegin.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-wpan@vger.kernel.org

Hi,

On Fri, Oct 03, 2014 at 08:12:17AM -0700, Owen Kirby wrote:
> Hi,
> 
> On 14-10-02 03:29 AM, Alexander Aring wrote:
> > On Thu, Oct 02, 2014 at 12:27:17PM +0200, Alexander Aring wrote:
> >> Hi,
> >>
> >>
> >>> I know... For now it looks like not using Linux wpan is simpler than use it.
> >>>
> >> correct.
> A while ago, we were also interested in porting our ZigBee stack to use 
> the linux-wpan interface, and we came to the same conclusion. The API is 
> missing too much of the IEEE 802.15.4 MLME components to provide support 
> for a workable ZigBee stack. In the end, we wound up implementing our 
> IEEE 802.15.4 driver in userspace along with the ZigBee stack; It works 
> quite well, but one of these days I would still like to port it to 
> linux-wpan.
> 

mhhh, what do you using right now? The old linux-zigbee kernel sources?
Or mainline state? linux-wpan is mainline state.

But, great I heard the first time that this stack is in some commercial
product (sounds like it).

> The three major compoenents that are missing from the API are:
>      * MLME-ASSOCIATE
>      * MLME-SCAN (and generation of beacons).
>      * Indirect packet transmission.
> 

ah indirect packet transmission. Some part of 802.15.4 which I don't
looked right now at it, because we are far away to support it. ;-)

> In theory, you could cobble something together that does association and 
> scanning from userspace with a raw socket, but there would probably be 
> enough hacking necessary to get it working correctly that it would be 
> much cleaner to implement it in kernelspace with a netlink command.
> 

Yes, this should something like mac80211 association/deassociation. Like
802.11 this is part of MLME. The kernel implementation for looks like
[0]. This can be triggered over netlink. 802.15.4 should have similar
things.

> Indirect packet transmission is something that needs kernel support (and 
> sometimes even hardware support), since it relies on fiddling with the 
> ack packets.
> 

Ack handling via kernelspace... sounds problematic. I need to dig into
this how the phy could handling this ack handling, if possible.




I don't know if you already know about it but I try to make a full
rework of mac802154 and ieee802154 [4]. The current netlink interface is in
a very awful state, kernel headers which should be uapi have some
"extern" keywords, etc... don't know why. In the rework I will mainly
orient to mac80211/wireless stack, to have the likely frameworks.

Also there exists now three interface types:

- NODE
- MONITOR
- COORD

For running as node, monitor or coordinator. Maybe we could merge NODE
and COORD, but I can't overlook this at this moment so we should offer
to make runtime decisions at kernelspace for node or coordinator.

Also this could be simple handling for FFD and RFD. FFD's could only
create a COORD interface.

Coordinator isn't supported right now, in the rework branch I will add
support like current mainline state, then we can thing about "how to
send it mainline".

Netlink interface will completely new, you as user of this stack will be
shocked right now. But I don't see that we can still use the current
behaviour.

New netlink, looks like [2]. I didn't implement a mlme ops yet but for
bring mainlining and to have a direction how it should work I will try
implement a channel scan, don't know right now which one
passive/active/etc... So we should have some minimal coordinator
functionality.

For the new netlink interface, simple add new netlink ops into
nl802154_ops struct. It's like wireless.

For the rework branch you need wpan-tools, not the lowpan-tools
anymore. [3]

I know, I didn't much documented what I did there. When I will bring
this rework mainline, then I will show the changes. At the moment I am
still try to experiment a little bit to see what we can do better.


btw. mailinglist changed to [1].

- Alex

[0] http://lxr.free-electrons.com/source/net/mac80211/mlme.c#L577
[1] http://vger.kernel.org/vger-lists.html#linux-wpan
[2] https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee802154/nl802154.c
[3] https://github.com/linux-wpan/wpan-tools
[4] https://github.com/linux-wpan/linux-wpan-next/tree/wpan_rework_rfc
