Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60285 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbbH0J6t (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 27 Aug 2015 05:58:49 -0400
Subject: Re: [RFC bluetooth-next 0/2] at86rf230: trac debugfs support (for
 testing aret changes patch-serie)
References: <1438874501-19971-1-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55DEDF56.20005@osg.samsung.com>
Date: Thu, 27 Aug 2015 11:58:46 +0200
MIME-Version: 1.0
In-Reply-To: <1438874501-19971-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 06/08/15 17:21, Alexander Aring wrote:
> Hi,
>
> this patch series based on:
>
>   "[RFCv5 bluetooth-next 0/4] ieee802154: aret handling changes"
>
> and can be used for testing the ARET/NO ARET mode with ARET_ON state only.
> I add support for debugfs to check the trac status statistics.
>
> In the previously patch series I said that the at86rf2xx transceivers
> checks automatically if ack request is set or not in a 802.15.4 frame.
>
> There exists two cases:
>
> 1. When the ackrequest bit is set and using STATE_ARET_ON the transceiver
>     will wait for an ack frame after transmit. If ack is received then
>     the transceiver logic is "SUCCESS" otherwise "NO_ACK".
> 2. When the ackrequest bit isn't set and using the STATE_ARET_ON the
>     transceiver will not wait for an ack frame and the transceiver logic
>     is "SUCCESS".
>
> The transceiver logic is in this case the error code from transmit
> algorithmn.
>
> To the test (802.15.4 6LoWPAN):
>
> 1. Create some imagine 6LoWPAN node by using:
>
> ip -6 neigh add fe80::abcd lladdr 02:01:02:03:04:05:06:07 dev lowpan0
>
> This will create some neighbor discovery entry for some node which isn't
> there in your network. We wan't just test some 802.15.4 unicast addressing.
> This unicast addressing will not answer with an ACK frame, because there is
> no node with this address.
>
> 2. Set ackrequest bit to 0 by using:
>
> iwpan dev wpan0 set ackreq_default 0
>
> 3. Ping node:
>
> ping6 fe80::abcd%lowpan0
>
> 4. Check trac status stats.
>
> You will see that only "SUCCESS" will be increased, which is the behaviour
> on no aret functionality.
>
> 5. Do it again but with ackrequest bit to 1 by using:
>
> iwpan dev wpan0 set ackreq_default 1
>
> 6. Ping node again.
>
> ping6 fe80::abcd%lowpan0
>
> 7. Check the trac status again.
>
> Now, "SUCCESS" isn't increased (it could be for broadcast frames only). But
> now you will see that "NO ACK" is increased which is the trac status that
> no ack frames was received when using aret functionality.

I looked over them and had some feedback. Testing is still pending.

>
> Some additional notes:
>
> I think the registration of debugfs failed when two at86rf230 will be probed,
> because the debugfs "at86rf230" already exists. Is there some way to add a
> number to it like the name "at86rf230%d"? Or we just leave it as it is, it's
> just a debugging feature and should be disabled then when using two at86rf230
> transceivers.
I commented on this in the actual patch. Maybe we could re-use the spi 
dev name here as this one would be unique. Like at86rf2xx-spi-XXX

regards
Stefan Schmidt
