Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35489 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319AbcDNO7h (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Apr 2016 10:59:37 -0400
Received: by mail-wm0-f50.google.com with SMTP id a140so151454883wma.0
        for <linux-wpan@vger.kernel.org>; Thu, 14 Apr 2016 07:59:36 -0700 (PDT)
Date: Thu, 14 Apr 2016 16:59:27 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: UDP stress-testing
Message-ID: <20160414145921.GA6196@omega>
References: <5706C0D7.1040000@haw-hamburg.de>
 <20160407204125.GA4736@omega>
 <57075C35.5070206@haw-hamburg.de>
 <11304.1460505658@obiwan.sandelman.ca>
 <20160413082852.GA2428@omega>
 <16058.1460551822@obiwan.sandelman.ca>
 <20160413203440.GA4044@omega>
 <570F5A6E.3010009@haw-hamburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <570F5A6E.3010009@haw-hamburg.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Peter Kietzmann <peter.kietzmann@haw-hamburg.de>
Cc: Michael Richardson <mcr@sandelman.ca>, linux-wpan@vger.kernel.org

Hi,

On Thu, Apr 14, 2016 at 10:53:02AM +0200, Peter Kietzmann wrote:
> Hi,
> 
> thanks for giving this topic some informational background! As it was me
> triggering that discussion, I just wanted to give my linux-network-newie
> opinion back to you.
> 
> IMO "avoiding invalid fragments" has higher priority than "avoiding latency"
> for the reason that dropping one fragment means dropping all fragments of an
> IPv6 packet. Processing 1280B IPv6 packets leads to 14 6LoWPAN fragments
> which we'd have processed for nothing when dropping one of them fragments.
> Therefore I like Alex's proposal about queuing 6Lowpan fragments and
> checking space in the actual xmit queue. However, I currently don't know
> much about IPv6 fragmentation but probably one thing to be careful about is
> interaction between 6lo and IPv6 fragmentation and possible amplification
> effects which could affect the needed txqueue size.
> 

I think for dealing with the fragments right inside the queue we need to
use "skb_shinfo(skb)->frag_list".

A kfree_skb will then care about for releasing all other skb's which are
use for the fragment and I hope this will deal with every others skb's
which are inside the tx queue.
I need to dig more into that if using frag_list really fix this issue.

In case of IPv6 fragmentation for the wpan interface queue (lowpan
interface doesn't have any tx queue, dev_queue_xmit will direct call xmit
of lowpan interface) it's another issue and not easy because we have a
fragmentation (IPv6) over fragmentation(6LoWPAN) there and notify dropped
fragments from wpan-interface to the correct ipv6 fragments (in case of
ipv6 fragmentation) sounds more complicated.

I would try to fix at first the fragmentation for 6LoWPAN fragmentation,
which is more likely than doing IPv6 fragmentation over 6LoWPAN.

- Alex
