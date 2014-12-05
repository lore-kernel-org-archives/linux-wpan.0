Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:28727 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbaLEMEF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Dec 2014 07:04:05 -0500
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NG3004WWYZCLD70@mailout2.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Fri, 05 Dec 2014 12:06:48 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1417780150-4033-1-git-send-email-varkab@cdac.in>
In-reply-to: <1417780150-4033-1-git-send-email-varkab@cdac.in>
Subject: Re: [PATCH bluetooth-next 1/2] mac802154: use goto label on failure
Date: Fri, 05 Dec 2014 12:03:42 +0000
Message-id: <20dc01d01083$83dc56c0$8b950440$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: 'Varka Bhadram' <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, 'Varka Bhadram' <varkab@cdac.in>

Hello.

On 05/12/14 12:49, Varka Bhadram wrote:
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>   net/mac802154/rx.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index 041dbd5..c0d67b2 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -85,8 +85,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data
> *sdata,
>   	default:
>   		spin_unlock_bh(&sdata->mib_lock);
>   		pr_debug("invalid dest mode\n");
> -		kfree_skb(skb);
> -		return NET_RX_DROP;
> +		goto fail;
>   	}
>
>   	spin_unlock_bh(&sdata->mib_lock);
>

Good catch!

Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>

regards
Stefan Schmidt


