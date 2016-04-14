Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx6.haw-public.haw-hamburg.de ([141.22.6.3]:23660 "EHLO
	mx6.haw-public.haw-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754699AbcDNIxZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 14 Apr 2016 04:53:25 -0400
Subject: Re: UDP stress-testing
References: <5706C0D7.1040000@haw-hamburg.de> <20160407204125.GA4736@omega>
 <57075C35.5070206@haw-hamburg.de> <11304.1460505658@obiwan.sandelman.ca>
 <20160413082852.GA2428@omega> <16058.1460551822@obiwan.sandelman.ca>
 <20160413203440.GA4044@omega>
From: Peter Kietzmann <peter.kietzmann@haw-hamburg.de>
Message-ID: <570F5A6E.3010009@haw-hamburg.de>
Date: Thu, 14 Apr 2016 10:53:02 +0200
MIME-Version: 1.0
In-Reply-To: <20160413203440.GA4044@omega>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org

Hi,

thanks for giving this topic some informational background! As it was me 
triggering that discussion, I just wanted to give my linux-network-newie 
opinion back to you.

IMO "avoiding invalid fragments" has higher priority than "avoiding 
latency" for the reason that dropping one fragment means dropping all 
fragments of an IPv6 packet. Processing 1280B IPv6 packets leads to 14 
6LoWPAN fragments which we'd have processed for nothing when dropping 
one of them fragments. Therefore I like Alex's proposal about queuing 
6Lowpan fragments and checking space in the actual xmit queue. However, 
I currently don't know much about IPv6 fragmentation but probably one 
thing to be careful about is interaction between 6lo and IPv6 
fragmentation and possible amplification effects which could affect the 
needed txqueue size.

A simple solution for my test cases would have been an easy way to check 
the status of the transmit queue.

Best regards and thanks again for your feedback
Peter


Am 13.04.2016 um 22:34 schrieb Alexander Aring:
> Hi Michael,
>
> On Wed, Apr 13, 2016 at 08:50:22AM -0400, Michael Richardson wrote:
>>
>> Alexander Aring <alex.aring@gmail.com> wrote:
>>      > _All_ current supported transceivers have on hardware side _one_
>>      > framebuffer only.
>>
>>      > I would agree 3-4 frames should keep the transmitter buffer, because
>>      > only one framebuffer, 250kBit (even slower on sub 1-GHz) and holding
>>      > 3-4 skb's in background.
>>
>> If we are counting frames rather than packets, then I agree that 3-4 is too
>> low; we should accomodate 2-3 full-sized IPv6 packets worth of fragments.
>> 1280 / 88 = 14 * 3 = 42.
>> So I suggest somewhere between 32 and 48 as a good default.
>>
>> Well, we really ought to use the BQL to get the right number!
>>          https://lwn.net/Articles/469652/
>>
>
> ok, I looked into one example to provide BQL for some ethernet driver
> [0]. For SoftMAC we have for the flow-label stuff some helper
> functions [1].
>
> Maybe some point to start there and look what happens. :-)
>
>>      > On most systems the qdisc default is pfifo (but I remember something
>>      > that systemd changed to fq_codel as default).
>>
>> yes, fq_codel is often the default now.
>>
>>      > This will getting the queue full and with payload of 352 bytes it makes
>>      > fragments invalid because pfifo will drop some which is part of the
>>      > whole fragment.
>>
>> I had assumed that the fragmentation happened after the qdisc.
>>
>>      > What I know is, when we drop one fragment, then we could drop every
>>      > fragment inside the queue which comes from the whole fragmented 6lowpan
>>      > packet. it seems this will not be handled currently.
>>
>> This is very important, and why I had assumed that fragmentation was
>> afterwards.
>>
>
> We could implement the following:
>
> 1. Splitting fragments
> 2. While splitting don't call dev_queue_xmit directly.
>     Instead we have an own small queue where we first collect all fragments.
> 3. After all fragments are inside the queue we check if qdisc has the
>     "free slots" to store all fragments then, e.g.
>      if ((dev->tx_queue_len - qdisc_qlen(dev->qdisc) >= $FRAGMENTS)
>      then
>         for_each_skb_fragment
>            dev_queue_xmit...
>      else
>         drop;
>
> Something like that, but maybe I should look at first inside IPv6
> fragmentation deeper. I think they handled such case somehow, too. If
> not then IPv6 should handle it as well.
>
> It should be a similar issue there and we can hopefully grab some code
> from there.
>
> - Alex
>
> [0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4a89ba04ecc6377696e4e26c1abc1cb5764decb9
> [1] http://lxr.free-electrons.com/source/net/mac802154/util.c#L22
>

-- 
Peter Kietzmann

Hamburg University of Applied Sciences
Dept. Informatik, Internet Technologies Group
Berliner Tor 7, 20099 Hamburg, Germany
Fon: +49-40-42875-8426
Web: http://www.haw-hamburg.de/inet
