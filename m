Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-db5eur01on0040.outbound.protection.outlook.com ([104.47.2.40]:26675
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751775AbeBVXKP (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 22 Feb 2018 18:10:15 -0500
Date: Fri, 23 Feb 2018 00:10:07 +0100
From: Rafael Vuijk <r.vuijk@sownet.nl>
Subject: Re: [PATCH] ieee802154: assembly of 6LoWPAN fragments improvement
Message-ID: <20180222212407.GA82995@Rafael-Mac.intra.sownet.nl>
References: <20180221113540.GA54319@Rafael-Mac.intra.sownet.nl>
 <60c224d2-17e5-eaf8-2d1b-763ae4cd92db@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c224d2-17e5-eaf8-2d1b-763ae4cd92db@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

On Wed, Feb 21, 2018 at 05:31:07PM +0100, Stefan Schmidt wrote:
> Hello.
> 
> 
> First of all thanks for digging into the problem and actually submitting your fix back upstream, very much appreciated. :)
It's my first patch this way, so I try to do it right somewhat :) For now, using mutt to make Majordomo happy too.
> 
> On 02/21/2018 12:35 PM, Rafael Vuijk wrote:
> > Hi,
> >
> > We have tested the 6LoWPAN modules in the Linux kernel and came to some issue regarding fragmentation. We have seen aborted SCP transfers ("message authentication code incorrect") and tested TCP transfers as well and saw corruption on fragment-sized intervals. The current fragment assembling functions do not check enough for corrupted L2 packets that might slip through L2 CRC check. (in our case IEEE802.15.4 which has only 16-bit CRC).
> > As a result, overlapping fragments due to offset corruption are not detected and assembled incorrectly. Part of packets may have old data. At TCP-level, there is only a simple TCP-checksum which is not enough in this case as the corruption occurs frequently (once every few minutes).
> >
> > After quickly analysing the code we saw some potential issues and created a patch that adds additional overlap checks and simplifies some conditional statements. After running tests again, TCP corruption was not seen again. The test was performed with SCP and keeps transferring large files now without error.
> >
> > Rafael Vuijk
> 
> For a real patch submission you would remove the "Hi" and "Rafael Vuijik" parts here as they will end up in the commits message.
> Please also make sure your lines wrap at 72 characters so the commit message is easily readable in the various git tools.
Sure :)
> 
> 
> Coming the the technical part now. Can you describe your test setup a bit more? Do you only have CONFIG_6LOWPAN enabled or also some of the
> CONFIG_6LOWPAN_NHC* options?

I had all options enabled, even experimental. Loaded modules were: mrf24j40,mac802154,nhc_udp,ieee802154_6lowpan,nhc_routing,nhc_mobility,nhc_fragment,nhc_dest,nhc_hop,nhc_ipv6. But for the test I did not enable encryption, as it did not seem help much in this case.

> The traffic patterns is simple scp file transfer between to nodes? Noisy network with other nodes on the same channel?

The test was indeed a simple SCP transfer from remote to local between two machines equipped with the MRF24J40MC module (connected via SPI), the other machines (testbed) were RPi3's equipped with MRF24J40MA (no PA/LNA). The RPi3's were not doing anything and couldn't use them for this patch since it ran a too old kernel (the corruption did occur on those as well though).
Link-local addresses were used for the test.
There was a Wi-Fi router nearby though. Also, I tried interfering a channel or two away, which was noticable in throughput and I think also seemed to influence the rate this occurred.

I have also read one post of someone with an issue with this radio chip, but I don't know if that it a real issue for this. It's an ok chip. At least it has a separate RX and TX buffer, which some don't even have.

> The reason I ask is that I would like to reproduce this problem here and add it to my test scenario.

It would be nice if you have the same chip or that it occurs in other setups as well.

> > Signed-off-by: Rafael Vuijk <r.vuijk@sownet.nl>
> > --- ./net/ieee802154/6lowpan/reassembly.c	2018-02-20 11:10:06.000000000 +0100
> > +++ ./net/ieee802154/6lowpan/reassembly.c	2018-02-21 09:13:29.000000000 +0100
> > @@ -140,23 +140,14 @@ static int lowpan_frag_queue(struct lowp
> >  	offset = lowpan_802154_cb(skb)->d_offset << 3;
> >  	end = lowpan_802154_cb(skb)->d_size;
> >  
> > +	if (fq->q.len == 0)
> > +		fq->q.len = end;
> > +	if (fq->q.len != end)
> > +		goto err;
> > +
> >  	/* Is this the final fragment? */
> >  	if (offset + skb->len == end) {
> > -		/* If we already have some bits beyond end
> > -		 * or have different end, the segment is corrupted.
> > -		 */
> > -		if (end < fq->q.len ||
> > -		    ((fq->q.flags & INET_FRAG_LAST_IN) && end != fq->q.len))
> > -			goto err;
> >  		fq->q.flags |= INET_FRAG_LAST_IN;
> > -		fq->q.len = end;
> > -	} else {
> > -		if (end > fq->q.len) {
> > -			/* Some bits beyond end -> corruption. */
> > -			if (fq->q.flags & INET_FRAG_LAST_IN)
> > -				goto err;
> > -			fq->q.len = end;
> > -		}
> >  	}
> >  
> 
> I might need to look at the context of this code, but I assume the hunks above are the simplifications your refer to?

That's correct. It makes sure the total assembled fragment length is set once and other fragments contain the same length as well.

> 
> >  	/* Find out which fragments are in front and at the back of us
> > @@ -179,6 +170,13 @@ static int lowpan_frag_queue(struct lowp
> >  	}
> >  
> >  found:
> > +	/* Current fragment overlaps with previous fragment? */
> > +	if (prev && (lowpan_802154_cb(prev)->d_offset << 3) + prev->len > offset)
> > +		goto err;
> > +	/* Current fragment overlaps with next fragment? */
> > +	if (next && offset + skb->len > lowpan_802154_cb(next)->d_offset << 3)
> > +		goto err;
> > +
> >  	/* Insert this fragment in the chain of fragments. */
> >  	skb->next = next;
> >  	if (!next)
> 
> And this hunk is the actual fragment overlap check.

Yes.

> To me this looks like to distinguished things to fix and thus being fixed in two separate commits.

That makes sense. That'd be 1/2 v2 and 2/2 v2 or so?
I should split up my own commits more often too ;) (bad habit)
 
> regards
> Stefan Schmidt

regards,
Rafael
