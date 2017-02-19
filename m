Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55865 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750789AbdBSHJu (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 19 Feb 2017 02:09:50 -0500
Subject: Re: Register two 802.15.4 devices/interfaces in one driver
References: <CAJuUDwuKQvpXhZKKAmBLReUd4+LOqS3+5CaGjRR6DNcRkQgrVw@mail.gmail.com>
 <28517.1487255767@obiwan.sandelman.ca>
 <193c0df2-d259-9076-c442-5731f6124e50@pengutronix.de>
 <32430.1487274266@obiwan.sandelman.ca>
 <7eae598a-c56e-2aac-c0f4-cef9b92dc23b@pengutronix.de>
 <CAJuUDwvpQ+9dWiyG2f6uE4EJu0NA8+Hz5sWRqFpDutY4Kue_sA@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <94a8fff1-abac-2f85-0402-38cc4a07f1d7@pengutronix.de>
Date: Sun, 19 Feb 2017 08:09:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAJuUDwvpQ+9dWiyG2f6uE4EJu0NA8+Hz5sWRqFpDutY4Kue_sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: Michael Richardson <mcr@sandelman.ca>, linux-wpan@vger.kernel.org

Hi,

On 02/17/2017 12:01 PM, Xue Liu wrote:
> At first, thanks for all help
> 
> 2017-02-17 8:26 GMT+01:00 Alexander Aring <aar@pengutronix.de>:
>>
>> Hi,
>>
>> On 02/16/2017 08:44 PM, Michael Richardson wrote:
>>>
>>> Alexander Aring <aar@pengutronix.de> wrote:
>>>     > I think the important thing is here (I suppose) the device can somehow
>>>     > handle TWO address filters. Meaning you can operate on TWO source
>>>     > pan-ids and having address filtering on.
>>>
>>> I imagine that yes, this is what the device is offering.
>>>
>>
>> Yes, but inclusive some channel hopping feature when switching the PAN,
>> so far I see... But it's still one phy. :-/
>>
>> For me this is already some "out of spec" specification because the PHY
>> PIB of 802.15.4 doesn't describe such handling to save it there, for one
>> PHY.
>>
> 
> It means, we should add new feature to handle this in
> ieee802154_register_hw(), right ?
> 

Mhhh, not sure. :-/

You can provide a new phy flag and add some handling to a vendor
specific nl802154 command to whatever you want (please lookup vendor
specific nl80211 stuff in wireless).

If you want not to use these channel hopping feature then try to add
support to allow two interfaces on one phy. Then other transceivers can
follow to add support for that.

---

What I think "calling ieee802154_register_hw twice, will register two
phy's" but original you have still _one_ phy. One phy with a crazy
channel hopping feature which I don't see in IEEE 802.15.4 to provide
such handling. :-)

First idea is: Try one phy and run two interfaces with two address
filtering on it, seems that the transceiver supports such handling...

How to implement it, don't know look driver_ops driver_flags and then
think about how to handle it in 802.15.4, then implement it somehow
that's mainline acceptable if you want.

_If_ you really need that "channel hopping" feature, what's the exact
use-case for that and look for a vendor specific nl802154 command. :-/

- Alex
