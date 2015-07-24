Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:33665 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565AbbGXJpu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2015 05:45:50 -0400
Received: by laah7 with SMTP id h7so10949979laa.0
        for <linux-wpan@vger.kernel.org>; Fri, 24 Jul 2015 02:45:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPpUg6M8rOP5mDNmFwcz1-cp=MhDhW1Yw5d2+YPCTy4sY4yGoQ@mail.gmail.com>
References: <CAPpUg6PNNipdf-kXvy9EOo6_8HtauGXMR0WAjXG_gY82DQEY_g@mail.gmail.com>
	<20150724083106.GA2655@omega>
	<CAPpUg6MGJ6Mevu3NGMf3RqKu7Hxphk7C+WiUwEnJzDa5x56JYg@mail.gmail.com>
	<CAPpUg6M8rOP5mDNmFwcz1-cp=MhDhW1Yw5d2+YPCTy4sY4yGoQ@mail.gmail.com>
Date: Fri, 24 Jul 2015 11:45:48 +0200
Message-ID: <CAPpUg6MVmYVFUH=Vf15ONY5hjkUgbLujDXpgbzcF1N3O7+fMgA@mail.gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not supported"
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

2015-07-24 11:02 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
> 2015-07-24 10:47 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
>> 2015-07-24 10:31 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>>> Hi,
>>>
>>> On Fri, Jul 24, 2015 at 09:56:49AM +0200, Baptiste Clenet wrote:
>>>> Hi,
>>>>
>>>> What is SAM value? I got "ieee802154 phy0 wpan0: SAM value 0x3 not
>>>> supported" when I receive a ping from another board.
>>>>
>>>
>>> I think you hit [0]. You got that because we received some 6LoWPAN frame
>>> with context based address compression (the source address). See also [1].
>> Yes for [0]
>>
>>>
>>> Your options are:
>>>
>>>  - That the other board use stateless (means SAC = 0, see [1]) address
>>>    compression.
>> How may I check?
>> They use both the same settings, they are based on the same source code.
> SAC bit is set.

            0     1   2   3    4     5    6    7   8    9        0
1   2     3    4   5
          +---+---+---+---+---+---+---+---+---+---    +---+---+---+---
 +---+---+
          | 0   | 1 | 1  |   TF   |NH |HLIM |CID|SAC|  SAM| M |DAC|  DAM |
          +---+---+---+---+---+---+---+---+---+---    +---+---+---+---
 +---+---+
Mine:    0    1    1    1    1   1    0    0   1      1      1    1
1     0     0   1
7bf9

Is something wrong?

>>
>>>
>>>  - Implement context based address compression, there was recently a
>>>    RFC patch series which implemented it. This maybe depends also for
>>>    handling 6CO field correctly.
>> Could you provide a link? Is that ported to Bluetooth-next branch or Linux-4.1?
>>
>>>
>>> - Alex
>>>
>>> [0] http://lxr.free-electrons.com/source/net/6lowpan/iphc.c#L147
>>> [1] https://tools.ietf.org/html/rfc6282#section-3.1
>>
>>
>>
>> --
>> Baptiste
>
>
>
> --
> Baptiste



-- 
Baptiste
