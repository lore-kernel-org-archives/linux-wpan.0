Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38091 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbbG3WXk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Jul 2015 18:23:40 -0400
Date: Fri, 31 Jul 2015 00:23:56 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] 6lowpan: Fix extraction of flow label field
Message-ID: <20150730222353.GB1037@omega>
References: <1435659892-22503-1-git-send-email-lukasz.duda@nordicsemi.no>
 <55BA8319.2000208@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55BA8319.2000208@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Lukasz Duda <lukasz.duda@nordicsemi.no>, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>, marcel@holtmann.org

On Thu, Jul 30, 2015 at 10:03:37PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 30/06/15 12:24, Lukasz Duda wrote:
> >The lowpan_fetch_skb function is used to fetch the first byte,
> >which also increments the data pointer in skb structure,
> >making subsequent array lookup of byte 0 actually being byte 1.
> >
> >To decompress the first byte of the Flow Label when the TF flag is
> >set to 0x01, the second half of the first byte is needed.
> >
> >The patch fixes the extraction of the Flow Label field.
> >
> >Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
> >Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
> >---
> >  net/6lowpan/iphc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> >index 9055d7b..74e56d7 100644
> >--- a/net/6lowpan/iphc.c
> >+++ b/net/6lowpan/iphc.c
> >@@ -284,7 +284,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
> >  		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
> >  			return -EINVAL;
> >-		hdr.flow_lbl[0] = (skb->data[0] & 0x0F) | ((tmp >> 2) & 0x30);
> >+		hdr.flow_lbl[0] = (tmp & 0x0F) | ((tmp >> 2) & 0x30);
> >  		memcpy(&hdr.flow_lbl[1], &skb->data[0], 2);
> >  		skb_pull(skb, 2);
> >  		break;
> 
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> 
> Alex, I agree that this area needs some improvements. I would still like to
> see this simple and obvious bug fix to go in now even if it gets changed
> with a refactor later on. Better have this bug fixed now. :) You acked it

I need to admit, I refactor this function multiple times and never had
time (or maybe I simple not did it, don't know why) to sending patches
for it. There is too also much things which can be optimized in the whole
iphc code. :-/

Also I remember 2-3 workarounds which we have inside IEEE 802.15.4
6LoWPAN, also having inside my queue 802.15.4 security layer and such
things. At the moment not a good idea to deal with all at the same time.

> already so I think it is fine to go in? Marcel did not apply it yet.
> 

Yes, I forget that patch and Marcel asked me today what's inside the
queue. So the pull request for net-next is already out, but I think we
can live to having this patch in the next one.

Marcel can you please apply this patch?

Jukka you are also fine with this patch? Please send your Acked-by then.

Thanks.

- Alex
