Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:35870 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932851AbeBUQbN (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 21 Feb 2018 11:31:13 -0500
Subject: Re: [PATCH] ieee802154: assembly of 6LoWPAN fragments improvement
References: <20180221113540.GA54319@Rafael-Mac.intra.sownet.nl>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <60c224d2-17e5-eaf8-2d1b-763ae4cd92db@osg.samsung.com>
Date: Wed, 21 Feb 2018 17:31:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180221113540.GA54319@Rafael-Mac.intra.sownet.nl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Rafael Vuijk <r.vuijk@sownet.nl>, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello.


First of all thanks for digging into the problem and actually submitting your fix back upstream, very much appreciated. :)

On 02/21/2018 12:35 PM, Rafael Vuijk wrote:
> Hi,
>
> We have tested the 6LoWPAN modules in the Linux kernel and came to some issue regarding fragmentation. We have seen aborted SCP transfers ("message authentication code incorrect") and tested TCP transfers as well and saw corruption on fragment-sized intervals. The current fragment assembling functions do not check enough for corrupted L2 packets that might slip through L2 CRC check. (in our case IEEE802.15.4 which has only 16-bit CRC).
> As a result, overlapping fragments due to offset corruption are not detected and assembled incorrectly. Part of packets may have old data. At TCP-level, there is only a simple TCP-checksum which is not enough in this case as the corruption occurs frequently (once every few minutes).
>
> After quickly analysing the code we saw some potential issues and created a patch that adds additional overlap checks and simplifies some conditional statements. After running tests again, TCP corruption was not seen again. The test was performed with SCP and keeps transferring large files now without error.
>
> Rafael Vuijk

For a real patch submission you would remove the "Hi" and "Rafael Vuijik" parts here as they will end up in the commits message.
Please also make sure your lines wrap at 72 characters so the commit message is easily readable in the various git tools.


Coming the the technical part now. Can you describe your test setup a bit more? Do you only have CONFIG_6LOWPAN enabled or also some of the
CONFIG_6LOWPAN_NHC* options?
The traffic patterns is simple scp file transfer between to nodes? Noisy network with other nodes on the same channel?

The reason I ask is that I would like to reproduce this problem here and add it to my test scenario.

> Signed-off-by: Rafael Vuijk <r.vuijk@sownet.nl>
> --- ./net/ieee802154/6lowpan/reassembly.c	2018-02-20 11:10:06.000000000 +0100
> +++ ./net/ieee802154/6lowpan/reassembly.c	2018-02-21 09:13:29.000000000 +0100
> @@ -140,23 +140,14 @@ static int lowpan_frag_queue(struct lowp
>  	offset = lowpan_802154_cb(skb)->d_offset << 3;
>  	end = lowpan_802154_cb(skb)->d_size;
>  
> +	if (fq->q.len == 0)
> +		fq->q.len = end;
> +	if (fq->q.len != end)
> +		goto err;
> +
>  	/* Is this the final fragment? */
>  	if (offset + skb->len == end) {
> -		/* If we already have some bits beyond end
> -		 * or have different end, the segment is corrupted.
> -		 */
> -		if (end < fq->q.len ||
> -		    ((fq->q.flags & INET_FRAG_LAST_IN) && end != fq->q.len))
> -			goto err;
>  		fq->q.flags |= INET_FRAG_LAST_IN;
> -		fq->q.len = end;
> -	} else {
> -		if (end > fq->q.len) {
> -			/* Some bits beyond end -> corruption. */
> -			if (fq->q.flags & INET_FRAG_LAST_IN)
> -				goto err;
> -			fq->q.len = end;
> -		}
>  	}
>  

I might need to look at the context of this code, but I assume the hunks above are the simplifications your refer to?


>  	/* Find out which fragments are in front and at the back of us
> @@ -179,6 +170,13 @@ static int lowpan_frag_queue(struct lowp
>  	}
>  
>  found:
> +	/* Current fragment overlaps with previous fragment? */
> +	if (prev && (lowpan_802154_cb(prev)->d_offset << 3) + prev->len > offset)
> +		goto err;
> +	/* Current fragment overlaps with next fragment? */
> +	if (next && offset + skb->len > lowpan_802154_cb(next)->d_offset << 3)
> +		goto err;
> +
>  	/* Insert this fragment in the chain of fragments. */
>  	skb->next = next;
>  	if (!next)

And this hunk is the actual fragment overlap check.

To me this looks like to distinguished things to fix and thus being fixed in two separate commits.

regards
Stefan Schmidt
