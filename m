Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx6.haw-public.haw-hamburg.de ([141.22.6.3]:11152 "EHLO
	mx6.haw-public.haw-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751957AbcDHHWf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Apr 2016 03:22:35 -0400
Subject: Re: UDP stress-testing
References: <5706C0D7.1040000@haw-hamburg.de> <20160407204125.GA4736@omega>
From: Peter Kietzmann <peter.kietzmann@haw-hamburg.de>
Message-ID: <57075C35.5070206@haw-hamburg.de>
Date: Fri, 8 Apr 2016 09:22:29 +0200
MIME-Version: 1.0
In-Reply-To: <20160407204125.GA4736@omega>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

thanks for your quick reply. It helped a lot! See some comments inline.

Am 07.04.2016 um 22:41 schrieb Alexander Aring:
> On Thu, Apr 07, 2016 at 10:19:35PM +0200, Peter Kietzmann wrote:
>> Dear list,
>>
>> first of all let me say that I'm new to this list. So if I'm completely
>> wrong in my concern please excuse the noise and guide me to the right place.
>> If you can :-)!
>>
>> For some experiments I'm trying to send "great" numbers of UDP packets with
>> "great" payloads as fast as possible from a RasPi equipped with the Openlabs
>> transceiver. With another RasPi+transceiver I'm sniffing the traffic. It
>> turns out that just the first x packets are sent out correctly before the
>> outgoing packets come out irregularly. The number of correctly sent packets
>> depends on the UDP payload size and it looks like the problem occurs after
>> ~30-35 kB Bytes (gross) in total have been transmitted (fragmentation
>> overhead included). I already increased the send socket memory to a
>> reasonably high value, without success. But still I assume some buffer
>> problems. Do you have a hint which screw to adjust?
>>
>> BTW: Introducing a delay after each packet to send fixes the problem. But
>> I'd like to do stress-testing...
>
> 1.
>
> You cannot be sure that a monitor interface shows all traffic which is
> on the air. You have at least hardware limitations which begins at
> "rising IRQ" and ends at "framebuffer readed".

I totally agree. But here it was quite obvious something was going on 
after some time.

>
> 2.
>
> Try to enable ack request bit. This is default disabled because you need
> to know what you doing when you enable it. Be sure all nodes supports
> ACK handling before that.
>
> You can do that with:
>
> iwpan dev $WPAN_DEV set ackreq_default 1

Found out that my sender Pi doesn't support this option. Guess I should 
update it...

>
> 3.
>
> Change tx queue setting:
>
> ip link set txqueuelen 1000 dev $WPAN_DEV

That was the parameter I was looking for. Increasing this queue it is :-) !

>
>
>
> Please reply if that helped you otherwise we will maybe find another
> tweaks. :-)
>
> - Alex
>

Again, thanks for your quick help!

Cheers
Peter

-- 
Peter Kietzmann

Hamburg University of Applied Sciences
Dept. Informatik, Internet Technologies Group
Berliner Tor 7, 20099 Hamburg, Germany
Fon: +49-40-42875-8426
Web: http://www.haw-hamburg.de/inet
