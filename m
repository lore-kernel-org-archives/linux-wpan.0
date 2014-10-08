Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:55434 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbaJHPJm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Oct 2014 11:09:42 -0400
Message-ID: <543553AD.9000501@xsilon.com>
Date: Wed, 08 Oct 2014 16:09:33 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
References: <1412776015-372-1-git-send-email-martin.townsend@xsilon.com> <1412776015-372-2-git-send-email-martin.townsend@xsilon.com> <20141008145917.GA23456@omega>
In-Reply-To: <20141008145917.GA23456@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com

Hi  Alex,

I completely missed it, unless reassembly can result in a shared skb? can you confirm that it doesn't then I'll remove the line.

Thanks, Martin.

On 08/10/14 15:59, Alexander Aring wrote:
> Hi Martin,
>
> On Wed, Oct 08, 2014 at 02:46:55PM +0100, Martin Townsend wrote:
>> Currently there are potentially 2 skb_copy_expand calls in IPHC
>> decompression.  This patch replaces this with one call to
>> pskb_expand_head.  It also checks to see if there is enough headroom
>> first to ensure it's only done if necessary.
>> As pskb_expand_head must only have one reference the calling code
>> now ensures this.
>>
>> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
> ...
>> --- a/net/ieee802154/6lowpan_rtnl.c
>> +++ b/net/ieee802154/6lowpan_rtnl.c
>> @@ -537,6 +537,11 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>>  		if (ret == NET_RX_DROP)
>>  			goto drop;
>>  	} else {
>> +		/* Decompression may use pskb_expand_head so no shared skb's */
>> +		skb = skb_share_check(skb, GFP_ATOMIC);
>> +		if (!skb)
>> +			goto drop;
>> +
> We do this already at [0], is it really necessary do it here again?
>
> This ensures that 6lowpan header replacing doesn't affect the af_802154
> implementation.
>
> - Alex
>
> [0] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan_rtnl.c#L466
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

