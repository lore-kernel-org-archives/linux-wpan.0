Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:33346 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbbGXIrF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2015 04:47:05 -0400
Received: by laah7 with SMTP id h7so10120123laa.0
        for <linux-wpan@vger.kernel.org>; Fri, 24 Jul 2015 01:47:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150724083106.GA2655@omega>
References: <CAPpUg6PNNipdf-kXvy9EOo6_8HtauGXMR0WAjXG_gY82DQEY_g@mail.gmail.com>
	<20150724083106.GA2655@omega>
Date: Fri, 24 Jul 2015 10:47:02 +0200
Message-ID: <CAPpUg6MGJ6Mevu3NGMf3RqKu7Hxphk7C+WiUwEnJzDa5x56JYg@mail.gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not supported"
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

2015-07-24 10:31 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> Hi,
>
> On Fri, Jul 24, 2015 at 09:56:49AM +0200, Baptiste Clenet wrote:
>> Hi,
>>
>> What is SAM value? I got "ieee802154 phy0 wpan0: SAM value 0x3 not
>> supported" when I receive a ping from another board.
>>
>
> I think you hit [0]. You got that because we received some 6LoWPAN frame
> with context based address compression (the source address). See also [1].
Yes for [0]

>
> Your options are:
>
>  - That the other board use stateless (means SAC = 0, see [1]) address
>    compression.
How may I check?
They use both the same settings, they are based on the same source code.

>
>  - Implement context based address compression, there was recently a
>    RFC patch series which implemented it. This maybe depends also for
>    handling 6CO field correctly.
Could you provide a link? Is that ported to Bluetooth-next branch or Linux-4.1?

>
> - Alex
>
> [0] http://lxr.free-electrons.com/source/net/6lowpan/iphc.c#L147
> [1] https://tools.ietf.org/html/rfc6282#section-3.1



-- 
Baptiste
