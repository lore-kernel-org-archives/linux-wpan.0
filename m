Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:60332 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbaHNAkX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Aug 2014 20:40:23 -0400
Received: by mail-we0-f176.google.com with SMTP id q58so432442wes.7
        for <linux-wpan@vger.kernel.org>; Wed, 13 Aug 2014 17:40:21 -0700 (PDT)
Date: Thu, 14 Aug 2014 02:40:16 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140814004013.GA2127@omega>
References: <BLU437-SMTP953B598AADB36D1E05A85AF7EB0@phx.gbl>
 <20140813204803.GC19527@omega>
 <BLU437-SMTP12A2EB954408C4FD54C241F7EB0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BLU437-SMTP12A2EB954408C4FD54C241F7EB0@phx.gbl>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [Linux-zigbee-devel] Old wiki updated but issues pinging fake
 nodes with relatively large payloads (> 93 octets)
To: Cristiano <cristiano_dealti@hotmail.com>
Cc: linux-zigbee-devel <linux-zigbee-devel@lists.sourceforge.net>, linux-wpan@vger.kernel.org

On Wed, Aug 13, 2014 at 11:42:46PM +0200, Cristiano wrote:
> Thanks Alex,
>   Yes the two commits:
> 
> http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=eb06481d69c60f6f9318e935053dce13fe3e8951
> and
> http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=51263fffadee28c99152fb78a2d41e3d10c9b0b5
> 
> 
> are in my kernel tree.
> 

ok. Sorry, was just a try.

> I merged the rpi kernel with net-next maybe one week ago, just before 3.16
> was released.
> Merging them was quite easy. I had three small conflicts, related to the
> 802.11 stack.
> 

Do you mean 802.11 or 802.15.4? :-)

> I will try net-next on qemu.
> 

ok.

> What ARCH/platform are you compiling the kernel for?
> 

I have two beaglebones white and each of them has a atben (at86rf231) via
spi conntected.

Another setup are two atusb sticks which I use in two qemu vm's.

Additional I have some contiki nodes which laying in my room around.
There I have the avr raven development kit and some Feuerwhere msp430
nodes (I ported it to contiki, there is no mainline support for the
Feuerwhere nodes).

I never used the fakelb driver. Mhhh, I dropped this driver now and I
will add a rework of this after doing the mac802154 like mac80211
stuff.

- Alex
