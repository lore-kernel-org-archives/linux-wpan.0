Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:61200 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751578AbdHPPeG (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 16 Aug 2017 11:34:06 -0400
From: Josef Filzmaier <j.filzmaier@gmx.at>
Subject: Re: AT86RF212 based USB-Stick (HUL)
Date: Wed, 16 Aug 2017 17:33:57 +0200
Message-ID: <1551752.M6fFiAEvOh@hella-laptop>
In-Reply-To: <215b5391-2082-6061-5365-b693008c9c9d@osg.samsung.com>
References: <5179358.aL3rf9WXy9@hella-laptop> <3182719.nDP85ksrvE@hella-laptop> <215b5391-2082-6061-5365-b693008c9c9d@osg.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

Hello again :)

> Let me know how it goes.

I have made some progress regarding the busware hul stick support. I had two 
major problems:

1) The atusb_xmit function is only called *once* and then never again
2) Configuring page, channel and txpower did not work.

I think that i did fix 2) successfully. (Firmware Patch: [1], Kernel Patch: [2] 
(Please ignore the modified device tree)) I hopefully did not break 
compatability with rzusb and atusb, could you please verify that and give some 
comments on my code?

For 1) however, i still have some problems - and am seeking for some help.
The first time i try to send a frame i get roughly the following function 
calling sequence (bottom up):

atusb_xmit
ieee802154_tx
ieee802154_subif_start_xmit
dev_hard_start_xmit
sch_direct_xmit
__dev_xmit_skb
__dev_queue_xmit
...

However, the second time i try to send a frame i get the following sequence:

sch_direct_xmit
__dev_xmit_skb
__dev_queue_xmit
...

The reason for this is that !netif_xmit_frozen_or_stopped(txq) (see [3]) is 
false, so the dev_hard_start_xmit() function is never called.
It is returning false because the netdev_queue is in state 
QUEUE_STATE_DRV_XOFF.
As far as i can tell this state change happens in the ieee802154_tx() [4] 
method with the ieee802154_stop_queue(&local->hw) function call.

What could be wrong here? Do i have to call ieee802154_wake_queue() somewhere? 
Or where should the netdev_queue state be reset so that the queue state is 
back at 0 that new frames can be sent. Or am i missing something completely 
here?

> That would be great. I will send you my address directly.

I just realized that your email with the address was in my spam folder. I will 
send you one ASAP.

Regards,
Josef

[1] https://github.com/joseffilzmaier/ben-wpan/compare/busware-hul
[2] https://github.com/raspberrypi/linux/compare/
rpi-4.9.y...joseffilzmaier:atusb-busware-hul
[3] http://elixir.free-electrons.com/linux/v4.9.40/source/net/sched/
sch_generic.c#L181
[4] http://elixir.free-electrons.com/linux/v4.9.40/source/net/mac802154/
tx.c#L72

-- 
Josef Filzmaier
