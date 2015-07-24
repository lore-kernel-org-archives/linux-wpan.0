Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36916 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212AbbGXJxk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2015 05:53:40 -0400
Received: by wibud3 with SMTP id ud3so20415587wib.0
        for <linux-wpan@vger.kernel.org>; Fri, 24 Jul 2015 02:53:39 -0700 (PDT)
Date: Fri, 24 Jul 2015 11:53:41 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not
 supported"
Message-ID: <20150724095338.GA7239@omega>
References: <CAPpUg6PNNipdf-kXvy9EOo6_8HtauGXMR0WAjXG_gY82DQEY_g@mail.gmail.com>
 <20150724083106.GA2655@omega>
 <CAPpUg6MGJ6Mevu3NGMf3RqKu7Hxphk7C+WiUwEnJzDa5x56JYg@mail.gmail.com>
 <CAPpUg6M8rOP5mDNmFwcz1-cp=MhDhW1Yw5d2+YPCTy4sY4yGoQ@mail.gmail.com>
 <CAPpUg6MVmYVFUH=Vf15ONY5hjkUgbLujDXpgbzcF1N3O7+fMgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6MVmYVFUH=Vf15ONY5hjkUgbLujDXpgbzcF1N3O7+fMgA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Fri, Jul 24, 2015 at 11:45:48AM +0200, Baptiste Clenet wrote:
> 2015-07-24 11:02 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
> > 2015-07-24 10:47 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
> >> 2015-07-24 10:31 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> >>> Hi,
> >>>
> >>> On Fri, Jul 24, 2015 at 09:56:49AM +0200, Baptiste Clenet wrote:
> >>>> Hi,
> >>>>
> >>>> What is SAM value? I got "ieee802154 phy0 wpan0: SAM value 0x3 not
> >>>> supported" when I receive a ping from another board.
> >>>>
> >>>
> >>> I think you hit [0]. You got that because we received some 6LoWPAN frame
> >>> with context based address compression (the source address). See also [1].
> >> Yes for [0]
> >>
> >>>
> >>> Your options are:
> >>>
> >>>  - That the other board use stateless (means SAC = 0, see [1]) address
> >>>    compression.
> >> How may I check?
> >> They use both the same settings, they are based on the same source code.
> > SAC bit is set.
> 
>             0     1   2   3    4     5    6    7   8    9        0
> 1   2     3    4   5
>           +---+---+---+---+---+---+---+---+---+---    +---+---+---+---
>  +---+---+
>           | 0   | 1 | 1  |   TF   |NH |HLIM |CID|SAC|  SAM| M |DAC|  DAM |
>           +---+---+---+---+---+---+---+---+---+---    +---+---+---+---
>  +---+---+
> Mine:    0    1    1    1    1   1    0    0   1      1      1    1
> 1     0     0   1
> 7bf9
> 
> Is something wrong?
> 

There is nothing wrong. The question is here "What does the current
6LoWPAN implementation support?" and you try do something "context based
address compression" which we don't currently support. We are not
_fully_ rfc6282 compliant.

- Alex
