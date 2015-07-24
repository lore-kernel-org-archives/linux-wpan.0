Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35932 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbbGXIbK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2015 04:31:10 -0400
Received: by wicgb10 with SMTP id gb10so18121632wic.1
        for <linux-wpan@vger.kernel.org>; Fri, 24 Jul 2015 01:31:09 -0700 (PDT)
Date: Fri, 24 Jul 2015 10:31:10 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not
 supported"
Message-ID: <20150724083106.GA2655@omega>
References: <CAPpUg6PNNipdf-kXvy9EOo6_8HtauGXMR0WAjXG_gY82DQEY_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6PNNipdf-kXvy9EOo6_8HtauGXMR0WAjXG_gY82DQEY_g@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Fri, Jul 24, 2015 at 09:56:49AM +0200, Baptiste Clenet wrote:
> Hi,
> 
> What is SAM value? I got "ieee802154 phy0 wpan0: SAM value 0x3 not
> supported" when I receive a ping from another board.
> 

I think you hit [0]. You got that because we received some 6LoWPAN frame
with context based address compression (the source address). See also [1].

Your options are:

 - That the other board use stateless (means SAC = 0, see [1]) address
   compression.

 - Implement context based address compression, there was recently a
   RFC patch series which implemented it. This maybe depends also for
   handling 6CO field correctly.

- Alex

[0] http://lxr.free-electrons.com/source/net/6lowpan/iphc.c#L147
[1] https://tools.ietf.org/html/rfc6282#section-3.1
