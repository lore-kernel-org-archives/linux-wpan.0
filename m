Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:43556
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752547AbdCARZf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Mar 2017 12:25:35 -0500
Subject: Re: Register two 802.15.4 devices/interfaces in one driver
References: <CAJuUDwuKQvpXhZKKAmBLReUd4+LOqS3+5CaGjRR6DNcRkQgrVw@mail.gmail.com>
 <28517.1487255767@obiwan.sandelman.ca>
 <b004df9c-7170-7b01-eb59-f10bf57d6662@posteo.de>
 <CAJuUDwterYxSvL3BdaJNTSKJYnMz9ZWi=rmo=KLiyvnYbWjeaA@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <8cb57735-9131-3f70-02f2-771c88cc3519@osg.samsung.com>
Date: Wed, 1 Mar 2017 18:14:12 +0100
MIME-Version: 1.0
In-Reply-To: <CAJuUDwterYxSvL3BdaJNTSKJYnMz9ZWi=rmo=KLiyvnYbWjeaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, Johann Fischer <johann_fischer@posteo.de>
Cc: linux-wpan@vger.kernel.org

Hello.

On 02/17/2017 12:05 PM, Xue Liu wrote:
> Hello Johann,
>
> 2017-02-16 16:55 GMT+01:00 Johann Fischer <johann_fischer@posteo.de>:
>> Hi Xue,
>>
>>> Now I am working on a driver for MCR20A radio chip from NXP. This chip
>>> has a special feature: support two PAN networks. It means it can
>>> operate on two different or the same channels with different PAN IDs,
>>> short addresses and extended addresses. I suppose to add two 802.15.4
>>> interfaces for this feature. And I have two questions:
>>>
>>> 1. how to add 802.15.4 devices ? Call ieee802154_register_hw() twice
>>> with different struct ieee802154_hw ?
>>>
>>> 2. how to deal with tx and rx regarding two interfaces.
>>>
>>> Thanks.
>>>
>>
>> Dual PAN is something like nice to have.
>> I suggest initialy to implement only PAN ID 0 support. It is easier and you
>> would have fewer problems with the sequence manager. If the driver is stable
>> and tested, then you can expand it and add support for dual PAN.
>>
> I forgot to post my current work on Github.
> https://github.com/xueliu/mcr20a-linux
>
> Now it is somehow working for only one PAN. Now I am cleaning it and
> testing other functions.

Nice, so you have something already.

I agree with Johann here that getting a basic driver in (without dual 
PAN support) makes most sense. This will allow us to get the driver 
reviewed and mainlined to have basic hardware support working. Once that 
is done more exotic features like dual PAN can be supported.
This approach will also make sure that you are not stuck alone with this 
for ages. :)

Might I ask what kind of hardware you are working with? Is there a board 
running Linux with this transceiver hooked up directly or are you using 
a off the shelf module with the MCR20A and attached it over SPI and 
GPIOs to a board you are working with?

A cheap and easy to order source for a a MCR20A module would be 
appreciated. The only board I found was the Freedom Development Board 
for MCR20A at Mouser for 84 EUR which looks expensive for the 
transceiver and some led and buttons only.

regards
Stefan Schmidt
