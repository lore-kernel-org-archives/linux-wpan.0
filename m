Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39298 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751900AbdB0WV7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 27 Feb 2017 17:21:59 -0500
Subject: Re: Review request: add pseudo-hardware timestamps to mrf24j40 driver
References: <20170222192032.22360-1-web+oss@zopieux.com>
 <0e2a6d8f-f34c-44a0-4045-28874c5d19e6@pengutronix.de>
From: Alan Ott <alan@signal11.us>
Message-ID: <7158cd71-232a-5fef-18a7-34c053b706f6@signal11.us>
Date: Mon, 27 Feb 2017 16:37:41 -0500
MIME-Version: 1.0
In-Reply-To: <0e2a6d8f-f34c-44a0-4045-28874c5d19e6@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, Alexandre Macabies <web+oss@zopieux.com>
Cc: linux-wpan@vger.kernel.org

On 02/26/2017 12:51 AM, Alexander Aring wrote:
> On 02/22/2017 08:20 PM, Alexandre Macabies wrote:
>> Hello,
>>
>> This is not a formal patch. I am trying to add timestamping support to
>> the drivers/net/ieee802154/mrf24j40.c driver. I need more precise
>> timestamps that the software ones attached to the packets when
>> entering/leaving the kernel.
>>
>> As far as I am aware, the MRF24J40 has no registers[1] to retrieve
>> hardware timestamps. Thus the idea is to use ktime_get() timestamps at
>> the proper places in the driver -- hence the *pseudo*-hardware.
>>
> Sometimes e.g. at86rf230 has interrupts for that.
>
>> - for incoming packets, call ktime_get() in the interrupt handler and
>> store it for later user. Then push it to skb_hwtstamps just before
>> sending the skb to ieee802154_rx_irqsafe().
>> - for outgoing packets, call ktime_get() in the "TX complete"
>> interrupt handler. This interrupt will only be triggered if the packet
>> is indeed going out the physical radio, which may no always be the
>> case, eg. if we send raw garbage on the wpan interface. But I guess
>> this is fine.
>>
>> I implemented these changes according to [2] and by looking at existing
>> timestamping code in other (mostly ethernet) drivers.
>>
>> Does this method make any sense? Could you do a review of my changes?
>> Would you be interested in up-streaming these changes once reviewed and
>> cleaned up?
>>
> question: does it work for you use case? :-)
>
> I think it's looking small enough to fit make a minimal implementation
> for such tx timestamping for all other users which looking for such
> feature.

It seems fairly device-specific. I'm not sure what you mean here or how 
it would work.

> My question would also be:
>
> Do you can move such handling into ieee802154 subsystem?
>
> Add some functions to mac802154/util.c (should be fine at first, maybe
> we need another file if we get hardmac support).
>
> Then offer some API that others driver know when calling timestamp
> function (in a very abstract way).
>
> For me:
>
> TX start is when you set some bit to transmit finally the frame.
>
> TX end if when you know that the interrupt was a "tx done" irq.
>
> That's what I see you currently have done in the driver and makes sense
> to me.
>
> (Adding alan, the maintainer of the driver)

Thanks for the heads-up Alex.

I think as far as making it generic, timestamping is generic at the 
skb-level, which is where it makes sense (since this is not something 
specific to 802154, but done on other types of network interfaces as well.

Depending on what kind of precision you need, you might need to get the 
timestamping into the actual ISR (which is right now given to (spi->isr)).

Alan.

