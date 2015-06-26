Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:35466 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbFZHRO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 26 Jun 2015 03:17:14 -0400
Received: by lagi2 with SMTP id i2so58397427lag.2
        for <linux-wpan@vger.kernel.org>; Fri, 26 Jun 2015 00:17:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150625173032.GC3653@omega>
References: <CAPpUg6NdCLUL=Ht5pDF-panVzDsPY1mKXt0T4xPzxoyVB7X91Q@mail.gmail.com>
	<20150625171557.GB3653@omega>
	<20150625173032.GC3653@omega>
Date: Fri, 26 Jun 2015 09:17:12 +0200
Message-ID: <CAPpUg6PSO41hy8BkAkzZFJRsQWOkjA2wXv5gjF1NdC0F0hBLsQ@mail.gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

2015-06-25 19:30 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> On Thu, Jun 25, 2015 at 07:15:57PM +0200, Alexander Aring wrote:
>> On Thu, Jun 25, 2015 at 06:52:35PM +0200, Baptiste Clenet wrote:
>> > Hi,
>> >
>> > Following is how I configure the network:
>> > modprobe at86rf230
>> > iwpan phy wpan-phy0 interface add wpan0 type node
>> > iwpan dev wpan0 set pan_id 0xbeef
>> > ip link set wpan0 up
>> > ip link add link wpan0 name lowpan0 type lowpan
>> > ip link set lowpan0 up
>> >
>> > Then I try to ping6 my second board with:
>> > ping6 -I lowpan0 fe80::a8af:ac69:e53e:c7f1
>> >
>> > I'm observing no changes over the SPI between my board and the
>> > at86rf230. But if I change the channel with:
>> > iwpan phy wpan-phy0 set channel 0 0
>>
>> this change should not be possible with the at86rf230.
>>
>
> ah, with the at86rf212 it's possible to set page/channel to 0. But I
> have still no idea why you having this issues right now.

Yes I use the at86rf212B so 0 is available to use 868.3MHz.

>
> Everything which you did seems to be correct. Which kernel version do
> you use
Linux 4.0.4, should I use bluetooth-next or wpan-next? (Which is the
difference btw?)


and why you do a:
>
> iwpan phy wpan-phy0 interface add wpan0 type node

It's to create wpan0 in order to be able to create lowpan0 afterwards.

>
> there should be a wpan0 node interface by default.

After the modprobe at86rf230, I have neither wpan0 or lowpan0 created.
(ifconfig)

And wpan-phy0 is created.
root@OpenWrt:/# iwpan list
wpan_phy wpan-phy0
supported channels:
        page 0: 0,1,2,3,4,5,6,7,8,9,10
        page 2: 0,1,2,3,4,5,6,7,8,9,10
current_page: 0
current_channel: 5
cca_mode: 1
tx_power: 0

-- 
Baptiste


>
> - Alex
