Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36322 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbbKETAg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 5 Nov 2015 14:00:36 -0500
Received: by wimw2 with SMTP id w2so16528091wim.1
        for <linux-wpan@vger.kernel.org>; Thu, 05 Nov 2015 11:00:35 -0800 (PST)
Date: Thu, 5 Nov 2015 20:00:23 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 802.15.4 SoftMAC devices in linux-wpan?
Message-ID: <20151105190018.GA2641@omega>
References: <563B8DAA.2050001@intec.ugent.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <563B8DAA.2050001@intec.ugent.be>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Floris Van den Abeele <floris.vandenabeele@intec.ugent.be>
Cc: linux-wpan@vger.kernel.org

Hi,

On Thu, Nov 05, 2015 at 06:11:06PM +0100, Floris Van den Abeele wrote:
> Hi all,
> 
> I am looking to get a purely PHY radio (so called SoftMAC devices) into
> Linux and up and running on an 802.15.4 network.
> 
> In linux/Documentation/networking/ieee802154.txt I read that only
> monitor mode is supported for SoftMAC devices:
>     NOTE: Currently the only monitor device type is supported - it's
> IEEE 802.15.4
>     stack interface for network sniffers (e.g. WireShark).
> 

This documentation is mostly outdated and need some update. Sorry, we
completely doesn't support HardMAC transceivers, we support SoftMAC
transceivers only.

> When browsing the source files in the linux mainline tree, I also
> couldn't find much on a kernel level CSMA/CA implementation.
> 

Some SoftMAC transceivers also support for timing critical handling
like CSMA/CA, ack handling, etc. via hardware. This is what we indicate
with the hardware flag [0].

The parameters for e.g. CSMA/CA handling can be set then over the right
callbacks.

Well we have currently the use case for it when the transceiver support
it's and the parameters are some registers inside the hardware.

> Are there any other purely PHY devices supported? I saw the cc2520
> listed, which in Contiki at least has its MAC protocol running
> externally (i.e. inside contiki, not on the cc2520).
> How does a cc2520 with linux-wpan perform CSMA/CA (this could help me on
> my way significantly)?

This is not implemented yet. When the hardware itself does not contain
CSMA/CA handling. With that I mean: running the CSMA/CA algorithm on
transceiver side and doing the starting of transmit when CSMA/CA allows
it. Then I would suggest to implement (for now) the CSMA/CA handling
inside the driver layer.

This means:

- Set the IEEE802154_HW_CSMA_PARAMS flag.
- Implement the callbacks for setting csma parameters. This will set
  some internal attributes inside the driver private data. These
  parameters will be evaluated when doing the CSMA/CA algorithm then.
- Use xmit_async callback for transmit and fill the transmit buffer.
  Check CCA status, if fail then repeat it after CCA update, solved by
  hrtimer [1] (the repeat mechanism). If CCA status is fine, then calculate
  the backoff period and starting a hrtimer [1] according the backoff period.
  The complete handler of the hrtimer need to signal the transceiver then
  to start the transmit.
  The CSMA/CA algorithm will be started then over xmit_async and it uses
  internally hrtimers. btw: you can sure there are no others xmit_async
  until calling ieee802154_xmit_complete.

This is currently my idea "how to implement a CSMA/CA handling via
software. Feel free to ask more information about this handling.

Also this handling will then be handled inside the driver-layer only.
This is for me fine, later we can think about to adding some new callbacks,
etc. to move such handling inside the transmit function of 802.15.4
SoftMAC. if the hardware doesn't support CSMA/CA handling and there is
no other chance to implement it. This will provide one CSMA/CA algorithm
for all transceivers which doesn't support such handling via hardware.

I need a more overview about transceivers which doesn't support such
handling by hardware to make a nice interface for it. At first a
driver-layer implementation is fine for me.

> If it doesn't, would it be feasible to implement CSMA/CA inside the
> kernel? I'm mainly concerned about strict timings and concurrency when
> running CSMA/CA in kernel level.
> 

This is impossible with current mainline linux. I think hrtimers is the
best use-case here. Depends also, if you need to wait > 10 usec, then
please use a simple "udelay", see [3]. It takes longer to setup a
hrtimer then.

So far I know, hrtimers/udelay (in xmit_async it's softirq context) it
can be still interrupted by a hardirq, so you can't provide strict
timings here.

- Alex

[0] http://lxr.free-electrons.com/source/include/net/mac802154.h#L138
[1] http://lxr.free-electrons.com/source/Documentation/timers/hrtimers.txt
[2] http://lxr.free-electrons.com/source/Documentation/timers/timers-howto.txt#L57
