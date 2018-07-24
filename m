Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:35497 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388308AbeGXOPF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Jul 2018 10:15:05 -0400
Subject: Re: [PATCH 2/2 v2] ieee802154: assembly of 6LoWPAN fragments
 improvement
References: <20180717152620.GB22664@Rafael-Mac.intra.sownet.nl>
 <20180718143015.y32gl5sesuwwb2ux@x220t>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <d389ceea-dac2-2068-963b-711c6cb9a6b7@datenfreihafen.org>
Date: Tue, 24 Jul 2018 15:08:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180718143015.y32gl5sesuwwb2ux@x220t>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>, Rafael Vuijk <r.vuijk@sownet.nl>
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello.

On 18.07.2018 16:30, Alexander Aring wrote:
> Hi,
> 
> On Tue, Jul 17, 2018 at 05:26:20PM +0200, Rafael Vuijk wrote:
>> 6LoWPAN reassembly fragment overlap checks.
>>
>> Signed-off-by: Rafael Vuijk <r.vuijk@sownet.nl>
>> --- ./net/ieee802154/6lowpan/reassembly.c	2018-02-20 11:10:06.000000000 +0100
>> +++ ./net/ieee802154/6lowpan/reassembly.c	2018-02-21 09:13:29.000000000 +0100
>> @@ -179,6 +170,13 @@ static int lowpan_frag_queue(struct lowp
>>  	}
>>  
>>  found:
>> +	/* Current fragment overlaps with previous fragment? */
>> +	if (prev && (lowpan_802154_cb(prev)->d_offset << 3) + prev->len > offset)
>> +		goto err;
>> +	/* Current fragment overlaps with next fragment? */
>> +	if (next && offset + skb->len > lowpan_802154_cb(next)->d_offset << 3)
>> +		goto err;
>> +
> 
> I have some thought of mine when seeing this code. The function is
> separated into two phases:
> 
> phase 0:
>  - finding the missing piece of fragment skb in the right order
>  - if found goto found:
> 
> phase 1:
>  - everything after found to reassemble everything if we have everything
>    together.
> 
> 
> This patch moves parts which are belongs to "phase 0" to "phase 1". I
> think the general idea in this algorithmn is to simple don't make checks
> on invalid things at all. If "broken" fragments are inside the "fragment
> bucket" then simple leave it there. There exists a garbage collector,
> controlled by some expire parameter to drop them then (60 seconds by
> default).

I think Rafael looked around for the best place of these checks. The
algorithm is buggy in this regard as they have seen in their testing and
packet traces. If you have a better place for this check I am pretty
sure they would be happy to test it and come back to you if it fixes
their issue.

If we find no better place I will just use this patch and move forward
to have at least the practical issue fixed.

regards
Stefan Schmidt
