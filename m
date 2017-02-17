Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:34994 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbdBQLB4 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Feb 2017 06:01:56 -0500
Received: by mail-ua0-f174.google.com with SMTP id y9so28013725uae.2
        for <linux-wpan@vger.kernel.org>; Fri, 17 Feb 2017 03:01:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7eae598a-c56e-2aac-c0f4-cef9b92dc23b@pengutronix.de>
References: <CAJuUDwuKQvpXhZKKAmBLReUd4+LOqS3+5CaGjRR6DNcRkQgrVw@mail.gmail.com>
 <28517.1487255767@obiwan.sandelman.ca> <193c0df2-d259-9076-c442-5731f6124e50@pengutronix.de>
 <32430.1487274266@obiwan.sandelman.ca> <7eae598a-c56e-2aac-c0f4-cef9b92dc23b@pengutronix.de>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Fri, 17 Feb 2017 12:01:54 +0100
Message-ID: <CAJuUDwvpQ+9dWiyG2f6uE4EJu0NA8+Hz5sWRqFpDutY4Kue_sA@mail.gmail.com>
Subject: Re: Register two 802.15.4 devices/interfaces in one driver
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: Michael Richardson <mcr@sandelman.ca>, linux-wpan@vger.kernel.org

At first, thanks for all help

2017-02-17 8:26 GMT+01:00 Alexander Aring <aar@pengutronix.de>:
>
> Hi,
>
> On 02/16/2017 08:44 PM, Michael Richardson wrote:
>>
>> Alexander Aring <aar@pengutronix.de> wrote:
>>     > I think the important thing is here (I suppose) the device can somehow
>>     > handle TWO address filters. Meaning you can operate on TWO source
>>     > pan-ids and having address filtering on.
>>
>> I imagine that yes, this is what the device is offering.
>>
>
> Yes, but inclusive some channel hopping feature when switching the PAN,
> so far I see... But it's still one phy. :-/
>
> For me this is already some "out of spec" specification because the PHY
> PIB of 802.15.4 doesn't describe such handling to save it there, for one
> PHY.
>

It means, we should add new feature to handle this in
ieee802154_register_hw(), right ?

>>     > PAN is not just software if you have address filtering. Sure you can
>>     > turn off the address filter, but for some transceivers this is only
>>     > possible to go into promiscuous mode and then you disable all filters.
>>
>> I think that this is exactly the point: you can (have to) do address
>> filtering in software if you have turned on promiscuous mode.  If you have
>> hardware that does this, then you can take the PANID from the hardware.
>> We could literally overload the entire VLAN process for this as for the
>> moment, 802.15.4 does not have 802.1Q, but I understand 802.15.10 will
>> change that.
>>
>
> Yes, turn transceiver "quietly" (maybe some pr_info notice) into
> promiscuous mode or (if supported) turn off address filtering only.
> Needs some driver layer changed and subsystem changes to allow it.
>
> And this all quietly, just make a pr_info notice for networking experts
> why your interrupt load for the transceiver will be increased.
>
> On e.g. at86rf233 it will go into promiscuous mode if somebody do a
> "ifup" of a second interface where the address filtering doesn't match
> anymore. But we should go into promiscuous mode when receiving is off...
> is just some handling with checking if one interface is up or all are
> down. :-)
>
>>     > Setting Destination PAN for a 6LoWPAN 802.15.4 interface -> we can talk
>>     > about that, this is software only. But listen source PAN -> problematic
>>     > because you change address filter parameter while receiving is on. :-/
>>     > If you do so, you also could miss some frames from other PANs...
>>
>> Yes, a good point.
>> I'm not trying to be dynamic here, but rather to leverage the capabilities of
>> devices...
>>
>
> okay.
>
> ---
>
> I think for PAN handling in 6LoWPAN we need some draft what we offer and
> what's not. E.g. change destination pan for interface upto CMSG
> attribute.
>
> - Alex
