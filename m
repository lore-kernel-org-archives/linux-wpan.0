Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:63180 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbaKFKpD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 05:45:03 -0500
Message-ID: <545B512A.1070900@xsilon.com>
Date: Thu, 06 Nov 2014 10:44:58 +0000
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] 6lowpan: move skb_free from error paths
 in decompression.
References: <1415136981-13497-1-git-send-email-mtownsend1973@gmail.com> <1415270051.2918.49.camel@jrissane-mobl.ger.corp.intel.com>
In-Reply-To: <1415270051.2918.49.camel@jrissane-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, alex.aring@gmail.com, marcel@holtmann.org

Thanks for testing Jukka,

I'll respin v2 later.
Out of interest, did you have kmemleak on?

- Martin.

On 06/11/14 10:34, Jukka Rissanen wrote:
> Hi Martin,
>
> On ti, 2014-11-04 at 21:36 +0000, Martin Townsend wrote:
>> Currently we ensure that the skb is freed on every error path in IPHC
>> decompression which makes it easy to introduce skb leaks.  By centralising
>> the skb_free into the receive function it makes future decompression routines
>> easier to maintain.  It does come at the expense of ensuring that the skb
>> passed into the decompression routine must not be copied.
> Tested this with real bluetooth hw and no issues were found. Just rebase
> the patch with latest upstream (conflict had a very simple fix) so ack
> with actions to v2.
>
> Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
>
>
> Cheers,
> Jukka
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

