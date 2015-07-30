Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55222 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbbG3UDm (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 30 Jul 2015 16:03:42 -0400
Subject: Re: [PATCH] 6lowpan: Fix extraction of flow label field
References: <1435659892-22503-1-git-send-email-lukasz.duda@nordicsemi.no>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55BA8319.2000208@osg.samsung.com>
Date: Thu, 30 Jul 2015 22:03:37 +0200
MIME-Version: 1.0
In-Reply-To: <1435659892-22503-1-git-send-email-lukasz.duda@nordicsemi.no>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lukasz Duda <lukasz.duda@nordicsemi.no>, alex.aring@gmail.com
Cc: jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>

Hello.

On 30/06/15 12:24, Lukasz Duda wrote:
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
> ---
>   net/6lowpan/iphc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 9055d7b..74e56d7 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -284,7 +284,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
>   		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
>   			return -EINVAL;
>   
> -		hdr.flow_lbl[0] = (skb->data[0] & 0x0F) | ((tmp >> 2) & 0x30);
> +		hdr.flow_lbl[0] = (tmp & 0x0F) | ((tmp >> 2) & 0x30);
>   		memcpy(&hdr.flow_lbl[1], &skb->data[0], 2);
>   		skb_pull(skb, 2);
>   		break;

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

Alex, I agree that this area needs some improvements. I would still like 
to see this simple and obvious bug fix to go in now even if it gets 
changed with a refactor later on. Better have this bug fixed now. :) You 
acked it already so I think it is fine to go in? Marcel did not apply it 
yet.

regards
Stefan Schmidt
