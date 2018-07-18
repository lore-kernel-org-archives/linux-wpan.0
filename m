Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:38563 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbeGRPId (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Jul 2018 11:08:33 -0400
Received: by mail-io0-f196.google.com with SMTP id v26-v6so4255518iog.5
        for <linux-wpan@vger.kernel.org>; Wed, 18 Jul 2018 07:30:22 -0700 (PDT)
Date: Wed, 18 Jul 2018 10:30:15 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH 2/2 v2] ieee802154: assembly of 6LoWPAN fragments
 improvement
Message-ID: <20180718143015.y32gl5sesuwwb2ux@x220t>
References: <20180717152620.GB22664@Rafael-Mac.intra.sownet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717152620.GB22664@Rafael-Mac.intra.sownet.nl>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Rafael Vuijk <r.vuijk@sownet.nl>
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi,

On Tue, Jul 17, 2018 at 05:26:20PM +0200, Rafael Vuijk wrote:
> 6LoWPAN reassembly fragment overlap checks.
> 
> Signed-off-by: Rafael Vuijk <r.vuijk@sownet.nl>
> --- ./net/ieee802154/6lowpan/reassembly.c	2018-02-20 11:10:06.000000000 +0100
> +++ ./net/ieee802154/6lowpan/reassembly.c	2018-02-21 09:13:29.000000000 +0100
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

I have some thought of mine when seeing this code. The function is
separated into two phases:

phase 0:
 - finding the missing piece of fragment skb in the right order
 - if found goto found:

phase 1:
 - everything after found to reassemble everything if we have everything
   together.


This patch moves parts which are belongs to "phase 0" to "phase 1". I
think the general idea in this algorithmn is to simple don't make checks
on invalid things at all. If "broken" fragments are inside the "fragment
bucket" then simple leave it there. There exists a garbage collector,
controlled by some expire parameter to drop them then (60 seconds by
default).

Important is that the code should never run lowpan_frag_reasm() when
something is not right in the fragments.

- Alex
