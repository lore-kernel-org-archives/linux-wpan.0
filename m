Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36010 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbbGXJsI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2015 05:48:08 -0400
Received: by wicgb10 with SMTP id gb10so20928162wic.1
        for <linux-wpan@vger.kernel.org>; Fri, 24 Jul 2015 02:48:06 -0700 (PDT)
Date: Fri, 24 Jul 2015 11:48:08 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not
 supported"
Message-ID: <20150724094804.GA6561@omega>
References: <CAPpUg6PNNipdf-kXvy9EOo6_8HtauGXMR0WAjXG_gY82DQEY_g@mail.gmail.com>
 <20150724083106.GA2655@omega>
 <CAPpUg6MGJ6Mevu3NGMf3RqKu7Hxphk7C+WiUwEnJzDa5x56JYg@mail.gmail.com>
 <CAPpUg6M8rOP5mDNmFwcz1-cp=MhDhW1Yw5d2+YPCTy4sY4yGoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6M8rOP5mDNmFwcz1-cp=MhDhW1Yw5d2+YPCTy4sY4yGoQ@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Fri, Jul 24, 2015 at 11:02:30AM +0200, Baptiste Clenet wrote:
> 2015-07-24 10:47 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
> > 2015-07-24 10:31 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> >> Hi,
> >>
> >> On Fri, Jul 24, 2015 at 09:56:49AM +0200, Baptiste Clenet wrote:
> >>> Hi,
> >>>
> >>> What is SAM value? I got "ieee802154 phy0 wpan0: SAM value 0x3 not
> >>> supported" when I receive a ping from another board.
> >>>
> >>
> >> I think you hit [0]. You got that because we received some 6LoWPAN frame
> >> with context based address compression (the source address). See also [1].
> > Yes for [0]
> >
> >>
> >> Your options are:
> >>
> >>  - That the other board use stateless (means SAC = 0, see [1]) address
> >>    compression.
> > How may I check?
> > They use both the same settings, they are based on the same source code.
> SAC bit is set.

Yes SAC bit means context based address compression and we don't support
it. We should support it, that's what rfc6282 said. But we don't have
support for that now. :-)

What do you mean with "they are based on the same source code"? It's a
linux<->linux communication? Then SAC bit should not set, if you try to
communicate with another 802.15.4 6LoWPAN stack then you need to
implement SAC/DAC handling or turn it off on the other side.

> >
> >>
> >>  - Implement context based address compression, there was recently a
> >>    RFC patch series which implemented it. This maybe depends also for
> >>    handling 6CO field correctly.
> > Could you provide a link? Is that ported to Bluetooth-next branch or Linux-4.1?
> >

http://www.spinics.net/lists/linux-wpan/msg02613.html

It's based on bluetooth-next like all others patches which you like to
bring into mainline state. Read [0].

- Alex

[0] http://wpan.cakelab.org/#_developing
