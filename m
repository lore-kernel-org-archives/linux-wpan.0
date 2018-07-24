Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:35449 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeGXOG3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Jul 2018 10:06:29 -0400
Subject: Re: [PATCH 1/2 v2] ieee802154: assembly of 6LoWPAN fragments
 improvement
References: <20180717152546.GA22664@Rafael-Mac.intra.sownet.nl>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <78e7773b-c2b8-5070-d940-df0d8e35ae32@datenfreihafen.org>
Date: Tue, 24 Jul 2018 15:00:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180717152546.GA22664@Rafael-Mac.intra.sownet.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Rafael Vuijk <r.vuijk@sownet.nl>, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello.

On 17.07.2018 17:25, Rafael Vuijk wrote:
> 6LoWPAN reassembly length check matching first known packet length.


Your original commit log had way more information on the problem.

"We have tested the 6LoWPAN modules in the Linux kernel and came to some
issue regarding fragmentation. We have seen aborted SCP transfers
("message authentication code incorrect") and tested TCP transfers as
well and saw corruption on fragment-sized intervals. The current
fragment assembling functions do not check enough for corrupted L2
packets that might slip through L2 CRC check. (in our case IEEE802.15.4
which has only 16-bit CRC).
As a result, overlapping fragments due to offset corruption are not
detected and assembled incorrectly. Part of packets may have old data.
At TCP-level, there is only a simple TCP-checksum which is not enough in
this case as the corruption occurs frequently (once every few minutes).

After quickly analysing the code we saw some potential issues and
created a patch that adds additional overlap checks and simplifies some
conditional statements. After running tests again, TCP corruption was
not seen again. The test was performed with SCP and keeps transferring
large files now without error."

It would be great if some of this finds it way into the commit log of
these two patches. At a minimum I would require them to not have the
same commit summary line.


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

Some basic testing on my side has not revealed any issues on this. I
will give it some longer testing with SCP now.

regards
Stefan Schmidt
