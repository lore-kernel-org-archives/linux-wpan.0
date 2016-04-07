Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37583 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757595AbcDGUli (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Apr 2016 16:41:38 -0400
Received: by mail-wm0-f43.google.com with SMTP id n3so119990944wmn.0
        for <linux-wpan@vger.kernel.org>; Thu, 07 Apr 2016 13:41:37 -0700 (PDT)
Date: Thu, 7 Apr 2016 22:41:30 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: UDP stress-testing
Message-ID: <20160407204125.GA4736@omega>
References: <5706C0D7.1040000@haw-hamburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5706C0D7.1040000@haw-hamburg.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Peter Kietzmann <peter.kietzmann@haw-hamburg.de>
Cc: linux-wpan@vger.kernel.org

On Thu, Apr 07, 2016 at 10:19:35PM +0200, Peter Kietzmann wrote:
> Dear list,
> 
> first of all let me say that I'm new to this list. So if I'm completely
> wrong in my concern please excuse the noise and guide me to the right place.
> If you can :-)!
> 
> For some experiments I'm trying to send "great" numbers of UDP packets with
> "great" payloads as fast as possible from a RasPi equipped with the Openlabs
> transceiver. With another RasPi+transceiver I'm sniffing the traffic. It
> turns out that just the first x packets are sent out correctly before the
> outgoing packets come out irregularly. The number of correctly sent packets
> depends on the UDP payload size and it looks like the problem occurs after
> ~30-35 kB Bytes (gross) in total have been transmitted (fragmentation
> overhead included). I already increased the send socket memory to a
> reasonably high value, without success. But still I assume some buffer
> problems. Do you have a hint which screw to adjust?
> 
> BTW: Introducing a delay after each packet to send fixes the problem. But
> I'd like to do stress-testing...

1.

You cannot be sure that a monitor interface shows all traffic which is
on the air. You have at least hardware limitations which begins at
"rising IRQ" and ends at "framebuffer readed".

2.

Try to enable ack request bit. This is default disabled because you need
to know what you doing when you enable it. Be sure all nodes supports
ACK handling before that.

You can do that with:

iwpan dev $WPAN_DEV set ackreq_default 1

3.

Change tx queue setting:

ip link set txqueuelen 1000 dev $WPAN_DEV



Please reply if that helped you otherwise we will maybe find another
tweaks. :-)

- Alex
