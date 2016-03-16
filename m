Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:54194 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbcCPPoT (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 16 Mar 2016 11:44:19 -0400
Subject: Re: [PATCH bluetooth-next] 6lowpan: iphc: fix handling of link-local
 compression
References: <1458132761-24055-1-git-send-email-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56E97F4E.2020201@osg.samsung.com>
Date: Wed, 16 Mar 2016 16:44:14 +0100
MIME-Version: 1.0
In-Reply-To: <1458132761-24055-1-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, jukka.rissanen@linux.intel.com

Hello.

On 16/03/16 13:52, Alexander Aring wrote:
> This patch fixes handling in case of link-local address compression. A
> IPv6 link-local address is defined as fe80::/10 prefix which is also
> what ipv6_addr_type checks for link-local addresses.
>
> But IPHC compression for link-local addresses are for fe80::/64 types
> only. This patch adds additional checks for zero padded bits in case of
> link-local address compression to match on a fe80::/64 address only.
>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>   net/6lowpan/iphc.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 99bb22a..68c80f3 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -148,6 +148,11 @@
>   	 (((a)->s6_addr16[6]) == 0) &&		\
>   	 (((a)->s6_addr[14]) == 0))
>   
> +#define lowpan_is_linklocal_zero_padded(a)	\
> +	(!(hdr->saddr.s6_addr[1] & 0x3f) &&	\
> +	 !hdr->saddr.s6_addr16[1] &&		\
> +	 !hdr->saddr.s6_addr32[1])
> +
>   #define LOWPAN_IPHC_CID_DCI(cid)	(cid & 0x0f)
>   #define LOWPAN_IPHC_CID_SCI(cid)	((cid & 0xf0) >> 4)
>   
> @@ -1101,7 +1106,8 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
>   							  true);
>   			iphc1 |= LOWPAN_IPHC_SAC;
>   		} else {
> -			if (ipv6_saddr_type & IPV6_ADDR_LINKLOCAL) {
> +			if (ipv6_saddr_type & IPV6_ADDR_LINKLOCAL &&
> +			    lowpan_is_linklocal_zero_padded(hdr->saddr)) {
>   				iphc1 |= lowpan_compress_addr_64(&hc_ptr,
>   								 &hdr->saddr,
>   								 saddr, true);
> @@ -1135,7 +1141,8 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
>   							  false);
>   			iphc1 |= LOWPAN_IPHC_DAC;
>   		} else {
> -			if (ipv6_daddr_type & IPV6_ADDR_LINKLOCAL) {
> +			if (ipv6_daddr_type & IPV6_ADDR_LINKLOCAL &&
> +			    lowpan_is_linklocal_zero_padded(hdr->daddr)) {
>   				iphc1 |= lowpan_compress_addr_64(&hc_ptr,
>   								 &hdr->daddr,
>   								 daddr, false);

Nicely spotted.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
