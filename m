Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:35566 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbbF2HBT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Jun 2015 03:01:19 -0400
Received: by lagh6 with SMTP id h6so42006645lag.2
        for <linux-wpan@vger.kernel.org>; Mon, 29 Jun 2015 00:01:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPpUg6PQZ8aYabugqr1jL=yfE1HmWinCzy1JN4LCv1QXbfw6dQ@mail.gmail.com>
References: <CAPpUg6NdCLUL=Ht5pDF-panVzDsPY1mKXt0T4xPzxoyVB7X91Q@mail.gmail.com>
	<20150625171557.GB3653@omega>
	<20150625173032.GC3653@omega>
	<CAPpUg6PSO41hy8BkAkzZFJRsQWOkjA2wXv5gjF1NdC0F0hBLsQ@mail.gmail.com>
	<CAPpUg6ODFfRpaM9EtL0YY4iHNbgOtgZ4QLVzGpSYkC-zRGY+7w@mail.gmail.com>
	<20150626080338.GB959@omega>
	<CAPpUg6PQZ8aYabugqr1jL=yfE1HmWinCzy1JN4LCv1QXbfw6dQ@mail.gmail.com>
Date: Mon, 29 Jun 2015 09:01:18 +0200
Message-ID: <CAPpUg6O61HyVEiTXD7r-14dVp-G3thy_YSG06PSUDooDEPHEFw@mail.gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

2015-06-26 10:24 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
> 2015-06-26 10:03 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>> On Fri, Jun 26, 2015 at 09:20:14AM +0200, Baptiste Clenet wrote:
>>> 2015-06-26 9:17 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
>>> > 2015-06-25 19:30 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>>> >> On Thu, Jun 25, 2015 at 07:15:57PM +0200, Alexander Aring wrote:
>>> >>> On Thu, Jun 25, 2015 at 06:52:35PM +0200, Baptiste Clenet wrote:
>>> >>> > Hi,
>>> >>> >
>>> >>> > Following is how I configure the network:
>>> >>> > modprobe at86rf230
>>> >>> > iwpan phy wpan-phy0 interface add wpan0 type node
>>> >>> > iwpan dev wpan0 set pan_id 0xbeef
>>> >>> > ip link set wpan0 up
>>> >>> > ip link add link wpan0 name lowpan0 type lowpan
>>> >>> > ip link set lowpan0 up
>>> >>> >
>>> >>> > Then I try to ping6 my second board with:
>>> >>> > ping6 -I lowpan0 fe80::a8af:ac69:e53e:c7f1
>>> >>> >
>>> >>> > I'm observing no changes over the SPI between my board and the
>>> >>> > at86rf230. But if I change the channel with:
>>> >>> > iwpan phy wpan-phy0 set channel 0 0
>>> >>>
>>> >>> this change should not be possible with the at86rf230.
>>> >>>
>>> >>
>>> >> ah, with the at86rf212 it's possible to set page/channel to 0. But I
>>> >> have still no idea why you having this issues right now.
>>> >
>>> > Yes I use the at86rf212B so 0 is available to use 868.3MHz.
>>> >
>>
>> ok.
>>
>>> >>
>>> >> Everything which you did seems to be correct. Which kernel version do
>>> >> you use
>>> > Linux 4.0.4, should I use bluetooth-next or wpan-next? (Which is the
>>> > difference btw?)
>>> >
>>> >
>>
>> Use bluetooth-next, the wpan-next ist just some development branch
>> currently.
>>
>>> > and why you do a:
>>> >>
>>> >> iwpan phy wpan-phy0 interface add wpan0 type node
>>> >
>>> > It's to create wpan0 in order to be able to create lowpan0 afterwards.
>>> >
>>> >>
>>> >> there should be a wpan0 node interface by default.
>>> >
>>> > After the modprobe at86rf230, I have neither wpan0 or lowpan0 created.
>>> > (ifconfig)
>>> >
>>> > And wpan-phy0 is created.
>>> > root@OpenWrt:/# iwpan list
>>> > wpan_phy wpan-phy0
>>> > supported channels:
>>> >         page 0: 0,1,2,3,4,5,6,7,8,9,10
>>> >         page 2: 0,1,2,3,4,5,6,7,8,9,10
>>> > current_page: 0
>>> > current_channel: 5
>>> > cca_mode: 1
>>> > tx_power: 0
>>> >
>>
>> On kernel 4.0 a default interface registration should be available.
>> Don't know why you have not a default wpan0 interface by default. :-/
>>
>>>
>>> >Do you have maybe the fakelb driver running? Please look for that, if
>>> >yes you have more than one phy. try "iwpan phy".
>>> fakelb? I'm running this one:
>>> /*
>>>  * AT86RF230/RF231 driver
>>>  * .....
>>>  *
>>>  * Written by:
>>>  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>>  * Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
>>>  * Alexander Aring <aar@pengutronix.de>
>>>  */
>>>
>>> iwpan phy return one phy as mentioned above.
>>>
>>
>> Yea, I just thought about that you having more than just one phy and
>> wpan0 was some interface on the fakelb phy's. This could be the reason
>> why you didn't see any traffic on the spi bus.
>>
>> Try to use bluetooth-next and see if you still having the issues.
>>
>> - Alex
>
> Might be OPENWRT on top of it which doesn't create the default
> interface wpan. I'll try with bluetooth-next as soon as it is DL.
>
> Thanks,
>
> --
> Baptiste

Alexander, which version of Linux bluetooth-next tree is based on?

-- 
Baptiste
