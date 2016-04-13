Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38329 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbcDMI3F (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Apr 2016 04:29:05 -0400
Received: by mail-wm0-f45.google.com with SMTP id u206so63202209wme.1
        for <linux-wpan@vger.kernel.org>; Wed, 13 Apr 2016 01:29:04 -0700 (PDT)
Date: Wed, 13 Apr 2016 10:28:57 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: UDP stress-testing
Message-ID: <20160413082852.GA2428@omega>
References: <5706C0D7.1040000@haw-hamburg.de>
 <20160407204125.GA4736@omega>
 <57075C35.5070206@haw-hamburg.de>
 <11304.1460505658@obiwan.sandelman.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11304.1460505658@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org, Peter Kietzmann <peter.kietzmann@haw-hamburg.de>

Hi Michael,

On Tue, Apr 12, 2016 at 08:00:58PM -0400, Michael Richardson wrote:
> 
> Peter Kietzmann <peter.kietzmann@haw-hamburg.de> wrote:
>     >> Change tx queue setting:
>     >>
>     >> ip link set txqueuelen 1000 dev $WPAN_DEV
> 
>     > That was the parameter I was looking for. Increasing this queue it is
>     > :-) !
> 
> assuming that you aren't sending packets faster than your essential bit rate,
> increasing the txqueuelen just increases the latency.
> 
> A queue length of 3 or 4 ought to be enough to keep the transmitter busy.
> Setting it to 1000 just causes bufferbloat.
> 

Okay I think we need to talk about this.

_All_ current supported transceivers have on hardware side _one_
framebuffer only.

I would agree 3-4 frames should keep the transmitter buffer, because
only one framebuffer, 250kBit (even slower on sub 1-GHz) and holding
3-4 skb's in background.

But the first question for me now is:

What really happens if the queue is full and we run dev_queue_xmit? e.g.
[0].

---

btw:
Error handling of dev_queue_xmit looks a little bit confused, [1]. After
running a test-grep on Kernel source, I see that some subsystems
completely ignore the return value of dev_queue_xmit. Maybe we should
think about a "correct" handling with return value of dev_queue_xmit.

---

After some digging inside the code is, that the selected qdisc will
decide what happens when the queue is full.

On most systems the qdisc default is pfifo (but I remember something
that systemd changed to fq_codel as default).

The pfifo implementation is here, you can see the implementation will
drop one (the oldest in the queue) and insert new one skb when queue is full.

Now with fragmentation and pfifo:

 - Queue length: 4
 - ~Payload per 802.15.4 frame: 88 bytes

Maximum payload 88 * 4 = 352 bytes.

The fragmentation works as following:

IPv6 packet comes ->
  Splitted into fragments ->
    dev_queue_xmit ...
    dev_queue_xmit ...
    dev_queue_xmit ...
    (Very fast, no delay or something. Will queue into wpan interface).
IPv6 packet comes ->
 ...

This will getting the queue full and with payload of 352 bytes it makes
fragments invalid because pfifo will drop some which is part of the
whole fragment.

Maybe we need some different strategy to queueing fragments into
wpan interface or we need another qdisc for wpan interface as default.

I am not an expert, but adding a delay is the same like increasing the
tx_queue_len.

We need maybe to first figure out what are the "typical, practical"
parameters which we work on.

I know that the most IoT MCU doesn't support IPv6 fragmentation yet, so
a IPv6 payload above 1280 bytes is not typical and people hit such
payloads e.g. discovery (the .well-known/core stuff) in CoAP protocols.

Don't know which points are important here "avoid latency" or "avoid invalid
fragments (because we are not fast enough and to send all of them)".

What I know is, when we drop one fragment, then we could drop every fragment
inside the queue which comes from the whole fragmented 6lowpan packet. it
seems this will not be handled currently.

- Alex

[0] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan/tx.c#L138
[1] http://lxr.free-electrons.com/source/net/core/dev.c#L3247
[2] http://lxr.free-electrons.com/source/net/sched/sch_fifo.c#L38

