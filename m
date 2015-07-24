Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35320 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbbGXJ4J (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2015 05:56:09 -0400
Received: by lblf12 with SMTP id f12so11842703lbl.2
        for <linux-wpan@vger.kernel.org>; Fri, 24 Jul 2015 02:56:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150724094804.GA6561@omega>
References: <CAPpUg6PNNipdf-kXvy9EOo6_8HtauGXMR0WAjXG_gY82DQEY_g@mail.gmail.com>
	<20150724083106.GA2655@omega>
	<CAPpUg6MGJ6Mevu3NGMf3RqKu7Hxphk7C+WiUwEnJzDa5x56JYg@mail.gmail.com>
	<CAPpUg6M8rOP5mDNmFwcz1-cp=MhDhW1Yw5d2+YPCTy4sY4yGoQ@mail.gmail.com>
	<20150724094804.GA6561@omega>
Date: Fri, 24 Jul 2015 11:56:08 +0200
Message-ID: <CAPpUg6PKMOBkfKWZjVaRKHHFGo+GXb3csewX+1OHg7CieyuVSw@mail.gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not supported"
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

2015-07-24 11:48 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> On Fri, Jul 24, 2015 at 11:02:30AM +0200, Baptiste Clenet wrote:
>> 2015-07-24 10:47 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
>> > 2015-07-24 10:31 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>> >> Hi,
>> >>
>> >> On Fri, Jul 24, 2015 at 09:56:49AM +0200, Baptiste Clenet wrote:
>> >>> Hi,
>> >>>
>> >>> What is SAM value? I got "ieee802154 phy0 wpan0: SAM value 0x3 not
>> >>> supported" when I receive a ping from another board.
>> >>>
>> >>
>> >> I think you hit [0]. You got that because we received some 6LoWPAN frame
>> >> with context based address compression (the source address). See also [1].
>> > Yes for [0]
>> >
>> >>
>> >> Your options are:
>> >>
>> >>  - That the other board use stateless (means SAC = 0, see [1]) address
>> >>    compression.
>> > How may I check?
>> > They use both the same settings, they are based on the same source code.
>> SAC bit is set.
>
> Yes SAC bit means context based address compression and we don't support
> it. We should support it, that's what rfc6282 said. But we don't have
> support for that now. :-)
>
> What do you mean with "they are based on the same source code"? It's a
> linux<->linux communication?
Yes it is linux to linux transmission.
Yeah I understand for the support :-)
The question is now why my linux use context based address compression
if it shouldn't? Where is it (SAC) set when transmitting a message?

Then SAC bit should not set, if you try to
> communicate with another 802.15.4 6LoWPAN stack then you need to
> implement SAC/DAC handling or turn it off on the other side.
>
>> >
>> >>
>> >>  - Implement context based address compression, there was recently a
>> >>    RFC patch series which implemented it. This maybe depends also for
>> >>    handling 6CO field correctly.
>> > Could you provide a link? Is that ported to Bluetooth-next branch or Linux-4.1?
>> >
>
> http://www.spinics.net/lists/linux-wpan/msg02613.html
>
> It's based on bluetooth-next like all others patches which you like to
> bring into mainline state. Read [0].
>
> - Alex
>
> [0] http://wpan.cakelab.org/#_developing



-- 
Baptiste
