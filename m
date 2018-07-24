Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:35479 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388279AbeGXOKn (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Jul 2018 10:10:43 -0400
Subject: Re: [PATCH 2/2 v2] ieee802154: assembly of 6LoWPAN fragments
 improvement
References: <20180717152620.GB22664@Rafael-Mac.intra.sownet.nl>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <7d765c8d-c235-1bd5-ba3a-a5dec7f1bda8@datenfreihafen.org>
Date: Tue, 24 Jul 2018 15:04:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180717152620.GB22664@Rafael-Mac.intra.sownet.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Rafael Vuijk <r.vuijk@sownet.nl>, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello.

On 17.07.2018 17:26, Rafael Vuijk wrote:
> 6LoWPAN reassembly fragment overlap checks.

A bit more explanation would not hurd here. :-)

> Signed-off-by: Rafael Vuijk <r.vuijk@sownet.nl>
> --- ./net/ieee802154/6lowpan/reassembly.c	2018-02-20 11:10:06.000000000 +0100
> +++ ./net/ieee802154/6lowpan/reassembly.c	2018-02-21 09:13:29.000000000 +0100
> @@ -179,6 +170,13 @@ static int lowpan_frag_queue(struct lowp
>  	}
>  
>  found:
> +	/* Current fragment overlaps with previous fragment? */
> +	if (prev && (lowpan_802154_cb(prev)->d_offset << 3) + prev->len > offset)> +		goto err;
> +	/* Current fragment overlaps with next fragment? */
> +	if (next && offset + skb->len > lowpan_802154_cb(next)->d_offset << 3)

To be honest, I am not sure I would get the operator priorities right in
my head for this line without looking it up. :-) Could we get some () to
help with the operator priorities? Even if that means we need to break
this line into two.

> +		goto err;
> +
>  	/* Insert this fragment in the chain of fragments. */
>  	skb->next = next;
>  	if (!next)

regards
Stefan Schmidt
