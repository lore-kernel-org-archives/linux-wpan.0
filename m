Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44715 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932694AbdBPSlw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 16 Feb 2017 13:41:52 -0500
Subject: Re: Register two 802.15.4 devices/interfaces in one driver
References: <CAJuUDwuKQvpXhZKKAmBLReUd4+LOqS3+5CaGjRR6DNcRkQgrVw@mail.gmail.com>
 <28517.1487255767@obiwan.sandelman.ca>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <193c0df2-d259-9076-c442-5731f6124e50@pengutronix.de>
Date: Thu, 16 Feb 2017 19:41:50 +0100
MIME-Version: 1.0
In-Reply-To: <28517.1487255767@obiwan.sandelman.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org


Hi,

On 02/16/2017 03:36 PM, Michael Richardson wrote:
> 
> Xue Liu <liuxuenetmail@gmail.com> wrote:
>     > Now I am working on a driver for MCR20A radio chip from NXP. This chip
>     > has a special feature: support two PAN networks. It means it can
>     > operate on two different or the same channels with different PAN IDs,
>     > short addresses and extended addresses. I suppose to add two 802.15.4
>     > interfaces for this feature. And I have two questions:
> 
> Neat. Too bad it can't operate on two channels at the same time...
> BTW: can it do 802.15.4 TSCH mode?
> 
>     > 1. how to add 802.15.4 devices ? Call ieee802154_register_hw() twice
>     > with different struct ieee802154_hw ?
> 
>     > 2. how to deal with tx and rx regarding two interfaces.
> 
> I think that at you will need to call register_hw() twice and manage two
> virtual queues, and then service them in your real driver.  Perhaps the
> fakewpan device structure will help you here.
> 

calling register_hw() twice will register two phy's but there is only one.
I think the right way to do it is to register one PHY but add two
"interfaces" on it.

This is possible, like in wireless to allow multiple Access Points on
one phy, we have the same architecture here.
We just need to allow it.

Or I am wrong and such handling allows also some "channel hoping" with
PAN change? Then maybe two phy's are the right way.

Xue:

Add a new HW flag (for MAC handling) that a PHY allows two PANID handling.
And is this really to operate on MAC layer?

> My take, however, is that the PANID processing on some devices is really just
> software, and perhaps we should be treating PANID the same way we treat
> VLANs: as something often sorted out in the stack, but sometimes coming with
> hardware acceleration.  We also have support for multiple Tx and Rx queues
> now, so this should also help.
> 

I think the important thing is here (I suppose) the device can somehow
handle TWO address filters. Meaning you can operate on TWO source
pan-ids and having address filtering on.

PAN is not just software if you have address filtering. Sure you can
turn off the address filter, but for some transceivers this is only
possible to go into promiscuous mode and then you disable all filters.

Setting Destination PAN for a 6LoWPAN 802.15.4 interface -> we can talk
about that, this is software only. But listen source PAN -> problematic
because you change address filter parameter while receiving is on. :-/ 
If you do so, you also could miss some frames from other PANs...

- Alex
