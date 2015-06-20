Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:34776 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbbFTFTW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 20 Jun 2015 01:19:22 -0400
Date: Sat, 20 Jun 2015 08:19:20 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH bluetooth-next 1/4] mac802154: iface: fix hrtimer cancel
 on ifdown
Message-ID: <20150620051920.GJ1897@wantstofly.org>
References: <1434226554-1450-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1434226554-1450-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Sat, Jun 13, 2015 at 10:15:51PM +0200, Alexander Aring wrote:

> The interframe spacing timer is a per phy definition and is part of a
> ieee802154_local structure. If we have possible multiple interfaces
> ifdown one interface then the timer should not be cancled. First if the
> last interface is down and the receive handling is stopped we should be
> sure that the interframe spacing timer isn't run anymore.

What is the ifs timer handling in the core code needed for in the
first place?

I understand that the 802.15.4 code keeps the interface queue stopped
as long as the PHY is transmitting the packet, and this makes sense,
given that probably none of the hardware involved contains a DMA ring
or anything like that, but I don't think that a (hr)timer is the way
to do it.

The right way to trigger transmit queue waking would be to do it when
receiving a transmit completion interrupt, or if the hardware doesn't
support that, by setting up a timer and possibly doing some polling in
the driver itself, to see if the packet has gone out on the wire yet
(which can be delayed for a multitude of reasons).

Or, just have the driver xmit() function check on entry whether the
previous packet has been transmitted yet and if not, stop the queue
and set a polling timer -- this way you won't get any transmit
completion interrupts or timer expirations if the transmit rate is
low, which would save a little bit of CPU time and CPU wakeups.

The current ifs timer handling logic does not, and by definition
cannot, take into account time needed for things such as clear channel
assessment, packet retransmissions, etc, and this isn't really fixable.
--
To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
