Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:41920 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbcDKRAP (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Apr 2016 13:00:15 -0400
Subject: Re: [RFC bluetooth-next 07/19] 6lowpan: iphc: rename add lowpan
 prefix
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
 <1458652515-7862-8-git-send-email-aar@pengutronix.de>
 <56F26B4E.80002@osg.samsung.com>
 <79372F03-3CD8-4ABE-B5FD-17459CA4C28C@holtmann.org>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <570BD81A.40507@osg.samsung.com>
Date: Mon, 11 Apr 2016 19:00:10 +0200
MIME-Version: 1.0
In-Reply-To: <79372F03-3CD8-4ABE-B5FD-17459CA4C28C@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, mcr@sandelman.ca, werner@almesberger.net

Hello.

On 08/04/16 19:36, Marcel Holtmann wrote:
> Hi Alex,
>
>>> This patch adds a lowpan prefix to each functions which doesn't have
>>> such prefix currently.
>>>
>>> Signed-off-by: Alexander Aring <aar@pengutronix.de>
>>> ---
>>>   net/6lowpan/iphc.c | 56 ++++++++++++++++++++++++++++++------------------------
>>>   1 file changed, 31 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
>>> index 798d5b2..d5a72e3 100644
>>> --- a/net/6lowpan/iphc.c
>>> +++ b/net/6lowpan/iphc.c
>>> @@ -151,8 +151,8 @@
>>>   #define LOWPAN_IPHC_CID_DCI(cid)	(cid & 0x0f)
>>>   #define LOWPAN_IPHC_CID_SCI(cid)	((cid & 0xf0) >> 4)
>>>   -static inline void iphc_uncompress_eui64_lladdr(struct in6_addr *ipaddr,
>>> -						const void *lladdr)
>>> +static inline void lowpan_iphc_uncompress_eui64_lladdr(struct in6_addr *ipaddr,
>>> +						       const void *lladdr)
>>>   {
>>>   	/* fe:80::XXXX:XXXX:XXXX:XXXX
>>>   	 *        \_________________/
>>> @@ -167,8 +167,9 @@ static inline void iphc_uncompress_eui64_lladdr(struct in6_addr *ipaddr,
>>>   	ipaddr->s6_addr[8] ^= 0x02;
>>>   }
>>>   -static inline void iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
>>> -						 const void *lladdr)
>>> +static inline void
>>> +lowpan_iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
>>> +				     const void *lladdr)
>>>   {
>>>   	const struct ieee802154_addr *addr = lladdr;
>>>   	u8 eui64[EUI64_ADDR_LEN] = { };
>>> @@ -176,7 +177,7 @@ static inline void iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
>>>   	switch (addr->mode) {
>>>   	case IEEE802154_ADDR_LONG:
>>>   		ieee802154_le64_to_be64(eui64, &addr->extended_addr);
>>> -		iphc_uncompress_eui64_lladdr(ipaddr, eui64);
>>> +		lowpan_iphc_uncompress_eui64_lladdr(ipaddr, eui64);
>>>   		break;
>>>   	case IEEE802154_ADDR_SHORT:
>>>   		/* fe:80::ff:fe00:XXXX
>>> @@ -296,9 +297,10 @@ lowpan_iphc_ctx_get_by_mcast_addr(const struct net_device *dev,
>>>    *
>>>    * address_mode is the masked value for sam or dam value
>>>    */
>>> -static int uncompress_addr(struct sk_buff *skb, const struct net_device *dev,
>>> -			   struct in6_addr *ipaddr, u8 address_mode,
>>> -			   const void *lladdr)
>>> +static int lowpan_iphc_uncompress_addr(struct sk_buff *skb,
>>> +				       const struct net_device *dev,
>>> +				       struct in6_addr *ipaddr,
>>> +				       u8 address_mode, const void *lladdr)
>>>   {
>>>   	bool fail;
>>>   @@ -329,10 +331,10 @@ static int uncompress_addr(struct sk_buff *skb, const struct net_device *dev,
>>>   		fail = false;
>>>   		switch (lowpan_dev(dev)->lltype) {
>>>   		case LOWPAN_LLTYPE_IEEE802154:
>>> -			iphc_uncompress_802154_lladdr(ipaddr, lladdr);
>>> +			lowpan_iphc_uncompress_802154_lladdr(ipaddr, lladdr);
>>>   			break;
>>>   		default:
>>> -			iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
>>> +			lowpan_iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
>>>   			break;
>>>   		}
>>>   		break;
>>> @@ -355,11 +357,11 @@ static int uncompress_addr(struct sk_buff *skb, const struct net_device *dev,
>>>   /* Uncompress address function for source context
>>>    * based address(non-multicast).
>>>    */
>>> -static int uncompress_ctx_addr(struct sk_buff *skb,
>>> -			       const struct net_device *dev,
>>> -			       const struct lowpan_iphc_ctx *ctx,
>>> -			       struct in6_addr *ipaddr, u8 address_mode,
>>> -			       const void *lladdr)
>>> +static int lowpan_iphc_uncompress_ctx_addr(struct sk_buff *skb,
>>> +					   const struct net_device *dev,
>>> +					   const struct lowpan_iphc_ctx *ctx,
>>> +					   struct in6_addr *ipaddr,
>>> +					   u8 address_mode, const void *lladdr)
>>>   {
>>>   	bool fail;
>>>   @@ -390,10 +392,10 @@ static int uncompress_ctx_addr(struct sk_buff *skb,
>>>   		fail = false;
>>>   		switch (lowpan_dev(dev)->lltype) {
>>>   		case LOWPAN_LLTYPE_IEEE802154:
>>> -			iphc_uncompress_802154_lladdr(ipaddr, lladdr);
>>> +			lowpan_iphc_uncompress_802154_lladdr(ipaddr, lladdr);
>>>   			break;
>>>   		default:
>>> -			iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
>>> +			lowpan_iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
>>>   			break;
>>>   		}
>>>   		ipv6_addr_prefix_copy(ipaddr, &ctx->pfx, ctx->plen);
>>> @@ -660,14 +662,16 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
>>>   		}
>>>     		pr_debug("SAC bit is set. Handle context based source address.\n");
>>> -		err = uncompress_ctx_addr(skb, dev, ci, &hdr.saddr,
>>> -					  iphc1 & LOWPAN_IPHC_SAM_MASK, saddr);
>>> +		err = lowpan_iphc_uncompress_ctx_addr(skb, dev, ci, &hdr.saddr,
>>> +						      iphc1 & LOWPAN_IPHC_SAM_MASK,
>>> +						      saddr);
>>>   		spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
>>>   	} else {
>>>   		/* Source address uncompression */
>>>   		pr_debug("source address stateless compression\n");
>>> -		err = uncompress_addr(skb, dev, &hdr.saddr,
>>> -				      iphc1 & LOWPAN_IPHC_SAM_MASK, saddr);
>>> +		err = lowpan_iphc_uncompress_addr(skb, dev, &hdr.saddr,
>>> +						  iphc1 & LOWPAN_IPHC_SAM_MASK,
>>> +						  saddr);
>>>   	}
>>>     	/* Check on error of previous branch */
>>> @@ -705,13 +709,15 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
>>>     		/* Destination address context based uncompression */
>>>   		pr_debug("DAC bit is set. Handle context based destination address.\n");
>>> -		err = uncompress_ctx_addr(skb, dev, ci, &hdr.daddr,
>>> -					  iphc1 & LOWPAN_IPHC_DAM_MASK, daddr);
>>> +		err = lowpan_iphc_uncompress_ctx_addr(skb, dev, ci, &hdr.daddr,
>>> +						      iphc1 & LOWPAN_IPHC_DAM_MASK,
>>> +						      daddr);
>>>   		spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
>>>   		break;
>>>   	default:
>>> -		err = uncompress_addr(skb, dev, &hdr.daddr,
>>> -				      iphc1 & LOWPAN_IPHC_DAM_MASK, daddr);
>>> +		err = lowpan_iphc_uncompress_addr(skb, dev, &hdr.daddr,
>>> +						  iphc1 & LOWPAN_IPHC_DAM_MASK,
>>> +						  daddr);
>>>   		pr_debug("dest: stateless compression mode %d dest %pI6c\n",
>>>   			 iphc1 & LOWPAN_IPHC_DAM_MASK, &hdr.daddr);
>>>   		break;
>> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> if these are good to be merged, then I need a patch series without the RFC designation.

The beginning of the patchset was ready but the ndisc changes might need 
another RFC round.
Alex did split out the patches which are ready to be merged and sent 
them as a separate patchset now to make it easier for you to pick them up.
See "6lowpan: prepare for 6lowpan ndisc implementation" from today.

I just finished up reviewed the ones I did not have so far and the whole 
series is good to go from my point of view.

The rest will follow later.

regards
Stefan Schmidt
