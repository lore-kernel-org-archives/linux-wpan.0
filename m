Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41945 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755643AbdBQHk2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 17 Feb 2017 02:40:28 -0500
Subject: Re: [PATCH v2 5/5] 6lowpan: Use netdev addr_len to determine lladdr
 len
References: <20170216171946.5105-1-luiz.dentz@gmail.com>
 <20170216171946.5105-6-luiz.dentz@gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <bea07c45-dccf-d0fa-c12b-3478e368cf93@pengutronix.de>
Date: Fri, 17 Feb 2017 08:40:26 +0100
MIME-Version: 1.0
In-Reply-To: <20170216171946.5105-6-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, patrik.flykt@linux.intel.com, linux-wpan@vger.kernel.org


Hi Luiz,

iphc code looks fine and better as before so far I see. Thanks!

On 02/16/2017 06:19 PM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This allow technologies such as Bluetooth to use its native lladdr which
> is eui48 instead of eui64 which was expected by functions like
> lowpan_header_decompress and lowpan_header_compress.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/6lowpan.h   | 19 +++++++++++++++++++
>  net/6lowpan/iphc.c      | 49 +++++++++++++++++++++++++++++++++++++------------
>  net/bluetooth/6lowpan.c | 43 ++++++++++---------------------------------
>  3 files changed, 66 insertions(+), 45 deletions(-)
> 
> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
> index 5ab4c99..c5792cb 100644
> --- a/include/net/6lowpan.h
> +++ b/include/net/6lowpan.h
> @@ -198,6 +198,25 @@ static inline void lowpan_iphc_uncompress_eui64_lladdr(struct in6_addr *ipaddr,
>  	ipaddr->s6_addr[8] ^= 0x02;
>  }
>  
> +static inline void lowpan_iphc_uncompress_eui48_lladdr(struct in6_addr *ipaddr,
> +						       const void *lladdr)
> +{
> +	/* fe:80::XXXX:XXff:feXX:XXXX
> +	 *        \_________________/
> +	 *              hwaddr
> +	 */
> +	ipaddr->s6_addr[0] = 0xFE;
> +	ipaddr->s6_addr[1] = 0x80;
> +	memcpy(&ipaddr->s6_addr[8], lladdr, 3);
> +	ipaddr->s6_addr[11] = 0xFF;
> +	ipaddr->s6_addr[12] = 0xFE;
> +	memcpy(&ipaddr->s6_addr[13], lladdr + 3, 3);
> +	/* second bit-flip (Universe/Local)
> +	 * is done according RFC2464
> +	 */
> +	ipaddr->s6_addr[8] ^= 0x02;
> +}
> +
>  #ifdef DEBUG
>  /* print data in line */
>  static inline void raw_dump_inline(const char *caller, char *msg,
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index fb5f6fa..ddbeeb7 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -278,6 +278,22 @@ lowpan_iphc_ctx_get_by_mcast_addr(const struct net_device *dev,
>  	return ret;
>  }
>  
> +static void lowpan_iphc_uncompress_lladdr(const struct net_device *dev,
> +					  struct in6_addr *ipaddr,
> +					  const void *lladdr)
> +{
> +	switch (dev->addr_len) {
> +	case ETH_ALEN:
> +		lowpan_iphc_uncompress_eui48_lladdr(ipaddr, lladdr);
> +		break;
> +	case EUI64_ADDR_LEN:
> +		lowpan_iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +	}
> +}
> +
>  /* Uncompress address function for source and
>   * destination address(non-multicast).
>   *
> @@ -320,8 +336,7 @@ static int lowpan_iphc_uncompress_addr(struct sk_buff *skb,
>  			lowpan_iphc_uncompress_802154_lladdr(ipaddr, lladdr);
>  			break;
>  		default:
> -			lowpan_iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
> -			break;

why removing this break?

> +			lowpan_iphc_uncompress_lladdr(dev, ipaddr, lladdr);
>  		}
>  		break;
>  	default:
> @@ -381,7 +396,7 @@ static int lowpan_iphc_uncompress_ctx_addr(struct sk_buff *skb,
>  			lowpan_iphc_uncompress_802154_lladdr(ipaddr, lladdr);
>  			break;
>  		default:
> -			lowpan_iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
> +			lowpan_iphc_uncompress_lladdr(dev, ipaddr, lladdr);
>  			break;
>  		}
>  		ipv6_addr_prefix_copy(ipaddr, &ctx->pfx, ctx->plen);
> @@ -810,6 +825,21 @@ lowpan_iphc_compress_ctx_802154_lladdr(const struct in6_addr *ipaddr,
>  	return lladdr_compress;
>  }
>  
> +static bool lowpan_iphc_addr_equal(const struct net_device *dev,
> +				   const struct lowpan_iphc_ctx *ctx,
> +				   const struct in6_addr *ipaddr,
> +				   const void *lladdr)
> +{
> +	struct in6_addr tmp = {};
> +
> +	lowpan_iphc_uncompress_lladdr(dev, &tmp, lladdr);
> +
> +	if (ctx)
> +		ipv6_addr_prefix_copy(&tmp, &ctx->pfx, ctx->plen);
> +
> +	return ipv6_addr_equal(&tmp, ipaddr);
> +}
> +
>  static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct net_device *dev,
>  				   const struct in6_addr *ipaddr,
>  				   const struct lowpan_iphc_ctx *ctx,
> @@ -827,13 +857,7 @@ static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct net_device *dev,
>  		}
>  		break;
>  	default:
> -		/* check for SAM/DAM = 11 */
> -		memcpy(&tmp.s6_addr[8], lladdr, EUI64_ADDR_LEN);
> -		/* second bit-flip (Universe/Local) is done according RFC2464 */
> -		tmp.s6_addr[8] ^= 0x02;
> -		/* context information are always used */
> -		ipv6_addr_prefix_copy(&tmp, &ctx->pfx, ctx->plen);
> -		if (ipv6_addr_equal(&tmp, ipaddr)) {
> +		if (lowpan_iphc_addr_equal(dev, ctx, ipaddr, lladdr)) {
>  			dam = LOWPAN_IPHC_DAM_11;
>  			goto out;
>  		}
> @@ -929,11 +953,12 @@ static u8 lowpan_compress_addr_64(u8 **hc_ptr, const struct net_device *dev,
>  		}
>  		break;
>  	default:
> -		if (is_addr_mac_addr_based(ipaddr, lladdr)) {
> -			dam = LOWPAN_IPHC_DAM_11; /* 0-bits */
> +		if (lowpan_iphc_addr_equal(dev, NULL, ipaddr, lladdr)) {
> +			dam = LOWPAN_IPHC_DAM_11;
>  			pr_debug("address compression 0 bits\n");
>  			goto out;
>  		}
> +
>  		break;
>  	}
>  
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 1456b01..d2a1aa5 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -64,7 +64,7 @@ struct lowpan_peer {
>  	struct l2cap_chan *chan;
>  
>  	/* peer addresses in various formats */
> -	unsigned char eui64_addr[EUI64_ADDR_LEN];
> +	unsigned char lladdr[ETH_ALEN];
>  	struct in6_addr peer_addr;
>  };
>  
> @@ -80,8 +80,6 @@ struct lowpan_btle_dev {
>  	struct delayed_work notify_peers;
>  };
>  
> -static void set_addr(u8 *eui, u8 *addr, u8 addr_type);
> -
>  static inline struct lowpan_btle_dev *
>  lowpan_btle_dev(const struct net_device *netdev)
>  {
> @@ -277,7 +275,6 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
>  	const u8 *saddr;
>  	struct lowpan_btle_dev *dev;
>  	struct lowpan_peer *peer;
> -	unsigned char eui64_daddr[EUI64_ADDR_LEN];
>  
>  	dev = lowpan_btle_dev(netdev);
>  
> @@ -287,10 +284,9 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
>  	if (!peer)
>  		return -EINVAL;
>  
> -	saddr = peer->eui64_addr;
> -	set_addr(&eui64_daddr[0], chan->src.b, chan->src_type);
> +	saddr = peer->lladdr;
>  
> -	return lowpan_header_decompress(skb, netdev, &eui64_daddr, saddr);
> +	return lowpan_header_decompress(skb, netdev, netdev->dev_addr, saddr);
>  }
> 

This is something which I don't understand.

protoype of this function:

int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
                             const void *daddr, const void *saddr)

your daddr pointer is "netdev->dev_addr", but this contains normally the L2 source
address of your transceiver.
You don't set the destination L2 address in your dev->dev_addr. (I hope)

For me it looks like daddr == saddr, or should saddr be daddr, but then
saddr (meaning here the saddr which should named daddr then, if it is daddr)
should be as 3. parameter.

>  static void ifup(struct net_device *netdev)
>  {
>  	int err;
> @@ -762,14 +737,16 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
>  	peer->chan = chan;
>  	memset(&peer->peer_addr, 0, sizeof(struct in6_addr));
>  
> +	baswap((void *)peer->lladdr, &chan->dst);
> +
>  	/* RFC 2464 ch. 5 */
>  	peer->peer_addr.s6_addr[0] = 0xFE;
>  	peer->peer_addr.s6_addr[1] = 0x80;
> -	set_addr((u8 *)&peer->peer_addr.s6_addr + 8, chan->dst.b,
> -		 chan->dst_type);
>  
> -	memcpy(&peer->eui64_addr, (u8 *)&peer->peer_addr.s6_addr + 8,
> -	       EUI64_ADDR_LEN);
> +	memcpy(&peer->peer_addr.s6_addr[8], peer->lladdr, 3);
> +	peer->peer_addr.s6_addr[11] = 0xFF;
> +	peer->peer_addr.s6_addr[12] = 0xFE;
> +	memcpy(&peer->peer_addr.s6_addr[13], peer->lladdr + 3, 3);
>  

You need to explain me why you add FFFE here again, why you need to
generate an address here on ifup?

Normally this should not be needed inside 6LoWPAN L2 implementation...
but I suppose this is a next step to fixing BTLE 6LoWPAN.

- Alex
