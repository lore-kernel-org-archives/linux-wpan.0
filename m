Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:39392
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751088AbdCGTcU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Mar 2017 14:32:20 -0500
Subject: Re: Register two 802.15.4 devices/interfaces in one driver
References: <CAJuUDwuKQvpXhZKKAmBLReUd4+LOqS3+5CaGjRR6DNcRkQgrVw@mail.gmail.com>
 <28517.1487255767@obiwan.sandelman.ca>
 <b004df9c-7170-7b01-eb59-f10bf57d6662@posteo.de>
 <CAJuUDwterYxSvL3BdaJNTSKJYnMz9ZWi=rmo=KLiyvnYbWjeaA@mail.gmail.com>
 <8cb57735-9131-3f70-02f2-771c88cc3519@osg.samsung.com>
 <CAJuUDwuZgyAz6xCwh1tN7E09Mkrqqd3Q80_Sm0QVn+ykjx52PA@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <ddb83a1b-88cf-5b24-6737-bc226bb3b2da@osg.samsung.com>
Date: Tue, 7 Mar 2017 20:04:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAJuUDwuZgyAz6xCwh1tN7E09Mkrqqd3Q80_Sm0QVn+ykjx52PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: Johann Fischer <johann_fischer@posteo.de>, linux-wpan@vger.kernel.org

Hello.

On 03/06/2017 02:53 PM, Xue Liu wrote:
> 2017-03-01 18:14 GMT+01:00 Stefan Schmidt <stefan@osg.samsung.com>:
>> Hello.
>>
>> On 02/17/2017 12:05 PM, Xue Liu wrote:
>>>
>>> Hello Johann,
>>>
>>> 2017-02-16 16:55 GMT+01:00 Johann Fischer <johann_fischer@posteo.de>:
>>>>
>>>> Hi Xue,
>>>>
>>>>> Now I am working on a driver for MCR20A radio chip from NXP. This chip
>>>>> has a special feature: support two PAN networks. It means it can
>>>>> operate on two different or the same channels with different PAN IDs,
>>>>> short addresses and extended addresses. I suppose to add two 802.15.4
>>>>> interfaces for this feature. And I have two questions:
>>>>>
>>>>> 1. how to add 802.15.4 devices ? Call ieee802154_register_hw() twice
>>>>> with different struct ieee802154_hw ?
>>>>>
>>>>> 2. how to deal with tx and rx regarding two interfaces.
>>>>>
>>>>> Thanks.
>>>>>
>>>>
>>>> Dual PAN is something like nice to have.
>>>> I suggest initialy to implement only PAN ID 0 support. It is easier and
>>>> you
>>>> would have fewer problems with the sequence manager. If the driver is
>>>> stable
>>>> and tested, then you can expand it and add support for dual PAN.
>>>>
>>> I forgot to post my current work on Github.
>>> https://github.com/xueliu/mcr20a-linux
>>>
>>> Now it is somehow working for only one PAN. Now I am cleaning it and
>>> testing other functions.
>>
>>
>> Nice, so you have something already.
>>
>> I agree with Johann here that getting a basic driver in (without dual PAN
>> support) makes most sense. This will allow us to get the driver reviewed and
>> mainlined to have basic hardware support working. Once that is done more
>> exotic features like dual PAN can be supported.
>> This approach will also make sure that you are not stuck alone with this for
>> ages. :)
> OK. I upload my dirty code to https://github.com/xueliu/mcr20a-linux.
> It is working but I need more tests and clean.

Fair enough :)

Once you think it is ready (with single PAN support) go ahead and post a 
patchset for it and we can start reviewing to get it merged into 
mainline. Looking forward to it.

>>
>> Might I ask what kind of hardware you are working with? Is there a board
>> running Linux with this transceiver hooked up directly or are you using a
>> off the shelf module with the MCR20A and attached it over SPI and GPIOs to a
>> board you are working with?
> I am working with Raspberry Pi 3, a Arduino shiled and FRDM-CR20A.

OK, so kind of the setup I also imagined. Especially with the FRDM-CR20A 
board.

regards
Stefan Schmidt
