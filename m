Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33395 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbbF2T6K (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Jun 2015 15:58:10 -0400
Received: by wiwl6 with SMTP id l6so110480252wiw.0
        for <linux-wpan@vger.kernel.org>; Mon, 29 Jun 2015 12:58:09 -0700 (PDT)
Date: Mon, 29 Jun 2015 21:58:03 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next] mac802154: do not export ieee802154_rx()
Message-ID: <20150629195758.GA1165@omega>
References: <1435570267-12971-1-git-send-email-varkabhadram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1435570267-12971-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Mon, Jun 29, 2015 at 03:01:07PM +0530, Varka Bhadram wrote:
> Right now there are no other users for ieee802154_rx()
> in kernel. So lets remove EXPORT_SYMBOL() for this.
> 
> Signed-off-by: Varka Bhadram <varkabhadram@gmail.com>
> ---
>  net/mac802154/rx.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index 5a258c1..7791c9b 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -290,7 +290,6 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
>  drop:
>  	kfree_skb(skb);
>  }
> -EXPORT_SYMBOL(ieee802154_rx);
>  
>  void
>  ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)

First I would ack that but please also move the function prototype from
mac802154.h to the internal header in mac802154 -> ieee802154_i.h.

Simple move [0] to [1]. Then we put it out of the drivers API.


And I have some global note about this function:

We have some use cases for drivers which, but they don't use this function.
These drivers are:

 - cc2520
 - mrf24j40

Also Alan notes this at [2] and I can confirm that the threaded irq
should be fine to use the _not_ irqsafe function. I think it slow down
the receive handling when it goes to first workqueue, then tasklet
again.

These drivers uses workqueues (or something other thing which is
preemptable and not irq context). In my opinion it should be possible
in these drivers to use ieee802154_rx instead ieee802154_rx_irqsafe.
(Didn't test it yet).


NOTE:
But even better would be that they don't use threaded/workqueues anymore
and use spi_async in the isr routines and use irqsafe then (in complete
handler of spi_async call).


The current behaviour isn't well yet, so driver which should use in
their current implementation can use ieee802154_rx but they don't use
it, but even better would be that these drivers use spi_async.


Another note would be the lqi paramater, currently this is garbage and
we should care about this paramater when we have some use case for
that. For now - leave the lqi parameter as it is. Means not in
ieee802154_rx and leave it in ieee802154_rx_irqsafe.

- Alex

[0] http://lxr.free-electrons.com/source/include/net/mac802154.h#L316
[1] http://lxr.free-electrons.com/source/net/mac802154/ieee802154_i.h
[2] http://lxr.free-electrons.com/source/drivers/net/ieee802154/mrf24j40.c#L563
