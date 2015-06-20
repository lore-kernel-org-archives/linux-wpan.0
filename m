Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:36027 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbbFTJKa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 20 Jun 2015 05:10:30 -0400
Received: by wguu7 with SMTP id u7so33657681wgu.3
        for <linux-wpan@vger.kernel.org>; Sat, 20 Jun 2015 02:10:28 -0700 (PDT)
Date: Sat, 20 Jun 2015 11:10:25 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 1/4] mac802154: iface: fix hrtimer cancel
 on ifdown
Message-ID: <20150620091023.GB730@omega>
References: <1434226554-1450-1-git-send-email-alex.aring@gmail.com>
 <20150620051920.GJ1897@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150620051920.GJ1897@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Sat, Jun 20, 2015 at 08:19:20AM +0300, Lennert Buytenhek wrote:
> On Sat, Jun 13, 2015 at 10:15:51PM +0200, Alexander Aring wrote:
> 
> > The interframe spacing timer is a per phy definition and is part of a
> > ieee802154_local structure. If we have possible multiple interfaces
> > ifdown one interface then the timer should not be cancled. First if the
> > last interface is down and the receive handling is stopped we should be
> > sure that the interframe spacing timer isn't run anymore.
> 
> What is the ifs timer handling in the core code needed for in the
> first place?
> 

What is the ifs timer handling:

Refer 5.1.1.3 Interframe spacing (IFS) in 802.15.4-2011.


In the core mode:

Because it's a typical use case for the mode (max_frame_retries = -1).
This is what already mentioned the "transmit only" mode.

When a transceiver is in this mode it doesn't do any CSMA-CA handling
and ARET handling. In case of at86rf2xx I get heavy transmit issues when
more than one frame is transmitted. Again, this is only when
max_frame_retries = -1.

I suppose the reason is because the transceiver have no time in
"receiving mode" to detect the SFD (preamble), we going directly into tx
state again. With introducing a delay for starting the next transmit,
the problem was gone for me.


Meanwhile I asked the atmel support how the transceiver handles the
interframe spacing time and they answered with:

---
In PLL_ON state (i.e. Basic Operating mode) software have to handle
the LIFS and SIFS intervals based on the transmit frame length. In
TX_ARET_ON state transceiver waits for the ACK and based on this
retransmission is handled automatically by the transceiver.
---

This makes totally sense because we can't handle LIFS/SIFS in the middle
of ARET mode, it's fully done by transceiver. I also don't get the above
issue while turning into ARET mode.

This confirmed my experience which I had in the PLL_ON mode
(max_frame_retries = -1).

The first solution was simple to add a udelay after each transmit to do
a delayed wake queue for the next transmit. Since I got the response
from atmel and (there are for my opinion more transceivers which doesn't
care about the ifs handling on transceiver), we introduce it into core
functionality with a timer (which is definitely better than an udelay).

> I understand that the 802.15.4 code keeps the interface queue stopped
> as long as the PHY is transmitting the packet, and this makes sense,
> given that probably none of the hardware involved contains a DMA ring
> or anything like that, but I don't think that a (hr)timer is the way
> to do it.

Then send patches for a better way. Currently hrtimer is better as a udelay.

> 
> The right way to trigger transmit queue waking would be to do it when
> receiving a transmit completion interrupt, or if the hardware doesn't

That's what we doing now, see [0]. The last argument indicates the ifs
handling and this need to be done by software in non tx_aret mode.

> support that, by setting up a timer and possibly doing some polling in
> the driver itself, to see if the packet has gone out on the wire yet
> (which can be delayed for a multitude of reasons).
> 

Don't know what you exactly means using polling here. The timer should
simple delay the next transmission, by using a timer which do a delayed
wake of "all" interface queues which belongs to a phy.

> Or, just have the driver xmit() function check on entry whether the
> previous packet has been transmitted yet and if not, stop the queue
> and set a polling timer -- this way you won't get any transmit

The xmit callback _cannot_ called twice until a frame has not been transmitted.
For each xmit we stop all queues for the phy and if complete then we
awake all queues again. The main reason for doing it is because the
transceivers has one frame buffer only and I never saw any other
transceiver with more than more framebuffer.

> completion interrupts or timer expirations if the transmit rate is
> low, which would save a little bit of CPU time and CPU wakeups.
> 
> The current ifs timer handling logic does not, and by definition
> cannot, take into account time needed for things such as clear channel
> assessment, packet retransmissions, etc, and this isn't really fixable.

Yes, this is why I the IFS handling is done by transceiver when
max_frame_retries >= 0. In case of max_frame_retries = -1 this need to
be handled by software.

- Alex

[0] http://lxr.free-electrons.com/source/drivers/net/ieee802154/at86rf230.c#L717
--
To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
