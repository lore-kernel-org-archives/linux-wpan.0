Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33069 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbbF3VWT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Jun 2015 17:22:19 -0400
Date: Tue, 30 Jun 2015 23:22:12 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] 6lowpan: Fix extraction of flow label field
Message-ID: <20150630212208.GA733@omega>
References: <1435659892-22503-1-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1435659892-22503-1-git-send-email-lukasz.duda@nordicsemi.no>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lukasz Duda <lukasz.duda@nordicsemi.no>
Cc: jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>

On Tue, Jun 30, 2015 at 03:24:52AM -0700, Lukasz Duda wrote:
> The lowpan_fetch_skb function is used to fetch the first byte,
> which also increments the data pointer in skb structure,
> making subsequent array lookup of byte 0 actually being byte 1.
> 
> To decompress the first byte of the Flow Label when the TF flag is
> set to 0x01, the second half of the first byte is needed.
> 
> The patch fixes the extraction of the Flow Label field.
> 
> Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
> Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>

Acked-by: Alexander Aring <alex.aring@gmail.com>

> ---
>  net/6lowpan/iphc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 9055d7b..74e56d7 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -284,7 +284,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
>  		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
>  			return -EINVAL;
>  
> -		hdr.flow_lbl[0] = (skb->data[0] & 0x0F) | ((tmp >> 2) & 0x30);
> +		hdr.flow_lbl[0] = (tmp & 0x0F) | ((tmp >> 2) & 0x30);
>  		memcpy(&hdr.flow_lbl[1], &skb->data[0], 2);
>  		skb_pull(skb, 2);
>  		break;

This code part is really hard to decrypt/understand. Nevertheless for
some historical(contiki) reasons we have this situation mainline now
and I had no time to cleanup this code. Actual it remembers me on the
early state of the iphc code.

I would recommended to cleanup the whole traffic flow decompress/compress
part (Maybe also with some magic numbers defines which is used on both sides
and some static inline functions). Really don't like the actually stuff there.
Anyway thank you for dig into this issue now.

One reason why definitly something goes wrong there is that skb->data[0]
information is used for hdr.flow_lbl[1] and hdr.flow_lbl[0] which can't
be. I didn't test it yet and trust you that this will do the right
behaviour for now. I also have no time that I can write really a testcase
for that. What I can say currently is that something is wrong here
and your good looks fine for me and makes more sense than the current behaviour.

Thanks.

- Alex
