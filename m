Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60678 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbbH1ISk (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 28 Aug 2015 04:18:40 -0400
Subject: Re: [PATCH bluetooth-next 0/4] at86rf230: trac debugfs support
References: <1440704960-10515-1-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55E0195C.4000904@osg.samsung.com>
Date: Fri, 28 Aug 2015 10:18:36 +0200
MIME-Version: 1.0
In-Reply-To: <1440704960-10515-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 27/08/15 21:49, Alexander Aring wrote:
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
>
>
> Some additional notes:
>
> I think the registration of debugfs failed when two at86rf230 will be probed,
> because the debugfs "at86rf230" already exists. Is there some way to add a
> number to it like the name "at86rf230%d"? Or we just leave it as it is, it's
> just a debugging feature and should be disabled then when using two at86rf230
> transceivers.

root@pi3:~# cat /sys/kernel/debug/at86rf230-spi32766.0/trac_stats
SUCCESS:                    3634
SUCCESS_DATA_PENDING:          0
SUCCESS_WAIT_FOR_ACK:       1259
CHANNEL_ACCESS_FAILURE:      147
NO_ACK:                      206
INVALID:                       0


Gave it a go here and testing worked fine so far. You can add my

Tested-by: Stefan Schmidt <stefan@osg.samsung.com>

for the whole series as well.

regards
Stefan Schmidt
