Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38662 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbbEIQrb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 9 May 2015 12:47:31 -0400
Received: by wiun10 with SMTP id n10so56719134wiu.1
        for <linux-wpan@vger.kernel.org>; Sat, 09 May 2015 09:47:30 -0700 (PDT)
Date: Sat, 9 May 2015 18:47:27 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: IEEE802154 MRF24J40
Message-ID: <20150509164724.GB694@omega>
References: <CAGduivyV4_ckSnJrnrpefD600Z0caE60dAK-QgxtyXg1WnAk7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGduivyV4_ckSnJrnrpefD600Z0caE60dAK-QgxtyXg1WnAk7A@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Sat, May 09, 2015 at 05:12:20PM +0200, Maxime Hadjinlian wrote:
> Hi Alex,
> 
> I am currently trying to play with an MRF24J40 with the latests
> kernel, and I can't figure out how could I obtain the lqi and rssi
> value for each datagram received.
> 
> I can see in the driver that they are indeed received from the SPI
> link and I can follow along up to 'ieee802154_rx_irqsafe' (in
> net/mac802154/rx.c) where the lqi is added to the skb buffer but I
> don't seem to get them in my userspace application when I use
> recvfrom.
> 
> Did I miss something or is this a missing feature/bug ?
> 

this is a missing feature and the lqi values of the
ieee802154_rx_irqsafe function is currently garabage.

The idea to implement such use case is like in wireless a:

"iw dev wlan# station dump"

in our tool

"iwpan dev wpan node dump"

which reports all received neighbor nodes by extended/short address and
their lqi, rssi value.

This is a opentask entry at [0].

The list of neighbors is stored so far I know as rhashtable in kernel
(that's how wireless it does and we should use the same just with
802.15.4 functionality).

- Alex

[0] http://wpan.cakelab.org/
