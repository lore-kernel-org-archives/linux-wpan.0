Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35659 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755562AbdBQLFF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Feb 2017 06:05:05 -0500
Received: by mail-vk0-f42.google.com with SMTP id x75so26944810vke.2
        for <linux-wpan@vger.kernel.org>; Fri, 17 Feb 2017 03:05:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b004df9c-7170-7b01-eb59-f10bf57d6662@posteo.de>
References: <CAJuUDwuKQvpXhZKKAmBLReUd4+LOqS3+5CaGjRR6DNcRkQgrVw@mail.gmail.com>
 <28517.1487255767@obiwan.sandelman.ca> <b004df9c-7170-7b01-eb59-f10bf57d6662@posteo.de>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Fri, 17 Feb 2017 12:05:03 +0100
Message-ID: <CAJuUDwterYxSvL3BdaJNTSKJYnMz9ZWi=rmo=KLiyvnYbWjeaA@mail.gmail.com>
Subject: Re: Register two 802.15.4 devices/interfaces in one driver
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Johann Fischer <johann_fischer@posteo.de>
Cc: linux-wpan@vger.kernel.org

Hello Johann,

2017-02-16 16:55 GMT+01:00 Johann Fischer <johann_fischer@posteo.de>:
> Hi Xue,
>
>> Now I am working on a driver for MCR20A radio chip from NXP. This chip
>> has a special feature: support two PAN networks. It means it can
>> operate on two different or the same channels with different PAN IDs,
>> short addresses and extended addresses. I suppose to add two 802.15.4
>> interfaces for this feature. And I have two questions:
>>
>> 1. how to add 802.15.4 devices ? Call ieee802154_register_hw() twice
>> with different struct ieee802154_hw ?
>>
>> 2. how to deal with tx and rx regarding two interfaces.
>>
>> Thanks.
>>
>
> Dual PAN is something like nice to have.
> I suggest initialy to implement only PAN ID 0 support. It is easier and you
> would have fewer problems with the sequence manager. If the driver is stable
> and tested, then you can expand it and add support for dual PAN.
>
I forgot to post my current work on Github.
https://github.com/xueliu/mcr20a-linux

Now it is somehow working for only one PAN. Now I am cleaning it and
testing other functions.

>> It is appropriate for any driver design suggestions about this chip.
>
> Since there are some incompletenesses in the reference manual, a good help
> could be [1], also there is kw2xrf driver in RIOT-OS [2] and mcr20a driver
> in zephyr-project (drivers/ieee802154/ieee802154_mcr20a*) [3].
>
OK. Thanks.
> [1] https://developer.mbed.org/teams/NXP/code/fsl_phy_mcr20a/
> [2] https://github.com/RIOT-OS/RIOT/tree/master/drivers/kw2xrf
> [3] https://gerrit.zephyrproject.org/r/gitweb?p=zephyr.git;a=tree;hb=HEAD
