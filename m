Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:34683 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdCFNyc (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Mar 2017 08:54:32 -0500
Received: by mail-io0-f172.google.com with SMTP id 90so113222118ios.1
        for <linux-wpan@vger.kernel.org>; Mon, 06 Mar 2017 05:53:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8cb57735-9131-3f70-02f2-771c88cc3519@osg.samsung.com>
References: <CAJuUDwuKQvpXhZKKAmBLReUd4+LOqS3+5CaGjRR6DNcRkQgrVw@mail.gmail.com>
 <28517.1487255767@obiwan.sandelman.ca> <b004df9c-7170-7b01-eb59-f10bf57d6662@posteo.de>
 <CAJuUDwterYxSvL3BdaJNTSKJYnMz9ZWi=rmo=KLiyvnYbWjeaA@mail.gmail.com> <8cb57735-9131-3f70-02f2-771c88cc3519@osg.samsung.com>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Mon, 6 Mar 2017 14:53:04 +0100
Message-ID: <CAJuUDwuZgyAz6xCwh1tN7E09Mkrqqd3Q80_Sm0QVn+ykjx52PA@mail.gmail.com>
Subject: Re: Register two 802.15.4 devices/interfaces in one driver
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Johann Fischer <johann_fischer@posteo.de>, linux-wpan@vger.kernel.org

2017-03-01 18:14 GMT+01:00 Stefan Schmidt <stefan@osg.samsung.com>:
> Hello.
>
> On 02/17/2017 12:05 PM, Xue Liu wrote:
>>
>> Hello Johann,
>>
>> 2017-02-16 16:55 GMT+01:00 Johann Fischer <johann_fischer@posteo.de>:
>>>
>>> Hi Xue,
>>>
>>>> Now I am working on a driver for MCR20A radio chip from NXP. This chip
>>>> has a special feature: support two PAN networks. It means it can
>>>> operate on two different or the same channels with different PAN IDs,
>>>> short addresses and extended addresses. I suppose to add two 802.15.4
>>>> interfaces for this feature. And I have two questions:
>>>>
>>>> 1. how to add 802.15.4 devices ? Call ieee802154_register_hw() twice
>>>> with different struct ieee802154_hw ?
>>>>
>>>> 2. how to deal with tx and rx regarding two interfaces.
>>>>
>>>> Thanks.
>>>>
>>>
>>> Dual PAN is something like nice to have.
>>> I suggest initialy to implement only PAN ID 0 support. It is easier and
>>> you
>>> would have fewer problems with the sequence manager. If the driver is
>>> stable
>>> and tested, then you can expand it and add support for dual PAN.
>>>
>> I forgot to post my current work on Github.
>> https://github.com/xueliu/mcr20a-linux
>>
>> Now it is somehow working for only one PAN. Now I am cleaning it and
>> testing other functions.
>
>
> Nice, so you have something already.
>
> I agree with Johann here that getting a basic driver in (without dual PAN
> support) makes most sense. This will allow us to get the driver reviewed and
> mainlined to have basic hardware support working. Once that is done more
> exotic features like dual PAN can be supported.
> This approach will also make sure that you are not stuck alone with this for
> ages. :)
OK. I upload my dirty code to https://github.com/xueliu/mcr20a-linux.
It is working but I need more tests and clean.

>
> Might I ask what kind of hardware you are working with? Is there a board
> running Linux with this transceiver hooked up directly or are you using a
> off the shelf module with the MCR20A and attached it over SPI and GPIOs to a
> board you are working with?
I am working with Raspberry Pi 3, a Arduino shiled and FRDM-CR20A.

>
> A cheap and easy to order source for a a MCR20A module would be appreciated.
> The only board I found was the Freedom Development Board for MCR20A at
> Mouser for 84 EUR which looks expensive for the transceiver and some led and
> buttons only.
>
Truly, this board costs 95,85 EUR with VAT. As far as I know there is
no alternative board.
> regards
> Stefan Schmidt
