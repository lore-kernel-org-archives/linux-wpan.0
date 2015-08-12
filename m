Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57282 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933573AbbHLIP5 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 12 Aug 2015 04:15:57 -0400
Subject: Re: [RFC 00/16] ieee802154: 6lowpan: cleanup and rework dispatch
 evaluation
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55CB00B8.8010909@osg.samsung.com>
Date: Wed, 12 Aug 2015 10:15:52 +0200
MIME-Version: 1.0
In-Reply-To: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 03/08/15 08:23, Alexander Aring wrote:
> Hi,
>
> this patch series contains a rework of 802.15.4 6LoWPAN receive handling.
> We need to check on some things before which never checked before, like
> is 802.15.4 dataframe, if we can access skb->data[0] (could be that skb->len
> is 0 then), etc.
>
> Also various bug fixes like the masking for fragmentation dispatch value which
> is currently wrong. Also we should again check the dispatch value after successful
> reassembly a fragment, we currently assume always a iphc header there. This is wrong
> it could also be a non-compressed header. This can occur if the compressed header is
> larger than lower interface MTU size, we doesn't react on this while transmit which
> is another issue. Nevertheless we also don't reach this case at worst-case compression
> currently.
>
> I introduced a complete new handling for the dispatch values based on mac80211
> datatype receive handling mechanism.

I'm going to review this set over the next days. Just as a heads up.

> This patch series based on bluetooth-next with various pending patches, I uploaded
> the branch at:
>
> https://github.com/linux-wpan/linux-wpan-next/commits/802154_6lowpan_cleanup2
>
> so everybody can test it.

I tried to apply the patches directly on bluetooth-next but they did not 
apply. Guess you want to rebase them when sending out a new round. For 
now I will review the patches here and use the branch you uploaded for 
testing. Will report back later.

regards
Stefan Schmidt
