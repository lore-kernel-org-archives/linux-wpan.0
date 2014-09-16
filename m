Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:36522 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbaIPG5N (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 02:57:13 -0400
Date: Tue, 16 Sep 2014 08:57:05 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v3 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140916065703.GA1244@omega>
References: <1410790194-17502-1-git-send-email-martin.townsend@xsilon.com>
 <1410790194-17502-2-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1410790194-17502-2-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, Martin Townsend <martin.townsend@xsilon.com>

Hi Martin,

On Mon, Sep 15, 2014 at 03:09:54PM +0100, Martin Townsend wrote:
> Currently there are a number of error paths in the lowpan_rcv function that
> free the skb before returning, the patch simplifies the receive path by
> ensuring that the skb is only freed from this function.
> 
> Passing the skb from 6lowpan up to the higher layers is not a
> function of IPHC.  By moving it out of IPHC we also remove the
> need to support error code returns with NET_RX codes.
> It also makes the lowpan_rcv function more extendable as we
> can support more compression schemes.
> 
> With the above 2 lowpan_rcv is refacored so eliminate incorrect return values.
> 
> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
> ---
>  include/net/6lowpan.h         |  4 +--
>  net/6lowpan/iphc.c            | 74 ++++++++++++++++++-------------------------
>  net/bluetooth/6lowpan.c       | 26 +++++++++------
>  net/ieee802154/6lowpan_rtnl.c | 55 ++++++++++++++++++++------------
>  4 files changed, 83 insertions(+), 76 deletions(-)
> 
> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
> index d184df1..450eaaf 100644
> --- a/include/net/6lowpan.h
> +++ b/include/net/6lowpan.h
> @@ -374,10 +374,10 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
>  
>  typedef int (*skb_delivery_cb)(struct sk_buff *skb, struct net_device *dev);
>  
> -int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
> +int lowpan_process_data(struct sk_buff **skb_inout, struct net_device *dev,
>  		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
>  		const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
> -		u8 iphc0, u8 iphc1, skb_delivery_cb skb_deliver);
> +		u8 iphc0, u8 iphc1);
>  int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
>  			unsigned short type, const void *_daddr,
>  			const void *_saddr, unsigned int len);
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 142eef5..d51e8bb 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -171,37 +171,6 @@ static int uncompress_context_based_src_addr(struct sk_buff *skb,
>  	return 0;
>  }
>  
> -static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
> -		       struct net_device *dev, skb_delivery_cb deliver_skb)
> -{
> -	struct sk_buff *new;
> -	int stat;
> -
> -	new = skb_copy_expand(skb, sizeof(struct ipv6hdr), skb_tailroom(skb),
> -			      GFP_ATOMIC);
> -	kfree_skb(skb);
> -
> -	if (!new)
> -		return -ENOMEM;
> -
> -	skb_push(new, sizeof(struct ipv6hdr));
> -	skb_reset_network_header(new);
> -	skb_copy_to_linear_data(new, hdr, sizeof(struct ipv6hdr));
> -
> -	new->protocol = htons(ETH_P_IPV6);
> -	new->pkt_type = PACKET_HOST;
> -	new->dev = dev;
> -
> -	raw_dump_table(__func__, "raw skb data dump before receiving",
> -		       new->data, new->len);
> -
> -	stat = deliver_skb(new, dev);
> -
> -	kfree_skb(new);
> -
> -	return stat;
> -}
> -
>  /* Uncompress function for multicast destination address,
>   * when M bit is set.
>   */
> @@ -332,14 +301,15 @@ err:
>  /* TTL uncompression values */
>  static const u8 lowpan_ttl_values[] = { 0, 1, 64, 255 };
>  
> -int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
> +int lowpan_process_data(struct sk_buff **skb_inout, struct net_device *dev,
>  			const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
>  			const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
> -			u8 iphc0, u8 iphc1, skb_delivery_cb deliver_skb)
> +			u8 iphc0, u8 iphc1)
>  {
>  	struct ipv6hdr hdr = {};
>  	u8 tmp, num_context = 0;
> -	int err;
> +	int err = -EINVAL;
> +	struct sk_buff *skb = *skb_inout;
>  
>  	raw_dump_table(__func__, "raw skb data dump uncompressed",
>  		       skb->data, skb->len);
> @@ -460,7 +430,6 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>  	/* UDP data uncompression */
>  	if (iphc0 & LOWPAN_IPHC_NH_C) {
>  		struct udphdr uh;
> -		struct sk_buff *new;
>  
>  		if (uncompress_udp_header(skb, &uh))
>  			goto drop;
> @@ -468,14 +437,15 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>  		/* replace the compressed UDP head by the uncompressed UDP
>  		 * header
>  		 */
> -		new = skb_copy_expand(skb, sizeof(struct udphdr),
> +		skb = skb_copy_expand(skb, sizeof(struct udphdr),
>  				      skb_tailroom(skb), GFP_ATOMIC);
> -		kfree_skb(skb);
> -
> -		if (!new)
> -			return -ENOMEM;
> +		if (!skb) {
> +			err = -ENOMEM;
> +			goto drop;
> +		}
>  
> -		skb = new;
> +		kfree_skb(*skb_inout);
> +		*skb_inout = skb;
>  
>  		skb_push(skb, sizeof(struct udphdr));
>  		skb_reset_transport_header(skb);
> @@ -499,11 +469,27 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
>  
>  	raw_dump_table(__func__, "raw header dump", (u8 *)&hdr, sizeof(hdr));
>  
> -	return skb_deliver(skb, &hdr, dev, deliver_skb);
> +	/* Setup skb with new uncompressed IPv6 header. */

--- snip

> +	skb = skb_copy_expand(skb, sizeof(hdr), skb_tailroom(skb),
> +			      GFP_ATOMIC);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	kfree_skb(*skb_inout);
> +	*skb_inout = skb;

--- snap

Ignore the below one, I will only note about this... that we don't
forget that.

This code should be a generic function for increasing headroom for
decompressing headers (IPv6, next hdr's). Still issues with
consume_skb/kfree_skb here.

> +
> +	skb_push(skb, sizeof(hdr));
> +	skb_reset_network_header(skb);
> +	skb_copy_to_linear_data(skb, &hdr, sizeof(hdr));
> +	skb->dev = dev;
> +
> +	raw_dump_table(__func__, "raw skb data dump before receiving",
> +		       skb->data, skb->len);
> +
> +	return 0;
>  
>  drop:
> -	kfree_skb(skb);
> -	return -EINVAL;
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(lowpan_process_data);
>  
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 206b65c..a4e340e 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -215,7 +215,7 @@ static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
>  	return ret;
>  }
>  
> -static int process_data(struct sk_buff *skb, struct net_device *netdev,
> +static int process_data(struct sk_buff **skb_inout, struct net_device *netdev,
>  			struct l2cap_chan *chan)
>  {
>  	const u8 *saddr, *daddr;
> @@ -223,6 +223,7 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
>  	struct lowpan_dev *dev;
>  	struct lowpan_peer *peer;
>  	unsigned long flags;
> +	struct sk_buff *skb = *skb_inout;
>  
>  	dev = lowpan_dev(netdev);
>  
> @@ -245,13 +246,12 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
>  	if (lowpan_fetch_skb_u8(skb, &iphc1))
>  		goto drop;
>  
> -	return lowpan_process_data(skb, netdev,
> +	return lowpan_process_data(skb_inout, netdev,
>  				   saddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
>  				   daddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
> -				   iphc0, iphc1, give_skb_to_upper);
> +				   iphc0, iphc1);
>  
>  drop:
> -	kfree_skb(skb);
>  	return -EINVAL;
>  }
>  
> @@ -280,9 +280,6 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>  		local_skb->protocol = htons(ETH_P_IPV6);
>  		local_skb->pkt_type = PACKET_HOST;
>  
> -		skb_reset_network_header(local_skb);
> -		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
> -
>  		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
>  			kfree_skb(local_skb);
>  			goto drop;
> @@ -300,9 +297,20 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>  			if (!local_skb)
>  				goto drop;
>  
> -			ret = process_data(local_skb, dev, chan);
> -			if (ret != NET_RX_SUCCESS)
> +			ret = process_data(&local_skb, dev, chan);
> +			if (ret < 0) {
> +				kfree_skb(local_skb);
>  				goto drop;
> +			}
> +
> +			local_skb->protocol = htons(ETH_P_IPV6);
> +			local_skb->pkt_type = PACKET_HOST;
> +
> +			if (give_skb_to_upper(local_skb, dev)
> +							!= NET_RX_SUCCESS) {
> +				kfree_skb(local_skb);
> +				goto drop;
> +			}
>  
>  			dev->stats.rx_bytes += skb->len;
>  			dev->stats.rx_packets++;
> diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
> index 6591d27..d39dad8 100644
> --- a/net/ieee802154/6lowpan_rtnl.c
> +++ b/net/ieee802154/6lowpan_rtnl.c
> @@ -164,14 +164,22 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb,
>  		}
>  	rcu_read_unlock();
>  
> +	if (stat < 0) {
> +		kfree_skb(skb);
> +		stat = NET_RX_DROP;
> +	} else {
> +		consume_skb(skb);
> +	}

This basically works now, but it confuse developers.

Look how stat is initzialed.
There is mixed errno and NET_RX_FOO handling here. Which is part of the
complete error handling mess. And correct freeing of skb's required a
correct error handling.

The function looks now like this:

        struct lowpan_dev_record *entry;
        struct sk_buff *skb_cp;
        int stat = NET_RX_SUCCESS;

        rcu_read_lock();
        list_for_each_entry_rcu(entry, &lowpan_devices, list)
                if (lowpan_dev_info(entry->ldev)->real_dev == skb->dev) {
                        skb_cp = skb_copy(skb, GFP_ATOMIC);
                        if (!skb_cp) {
                                stat = -ENOMEM;
Simple assign stat = NET_RX_DROP.
                                break;
                        }

                        skb_cp->dev = entry->ldev;
                        stat = netif_rx(skb_cp);
                }
        rcu_read_unlock();          
        
        if (stat < 0) {
remove brackets and check on NET_RX_DROP. or vice versa.
                kfree_skb(skb);
                stat = NET_RX_DROP;
        } else {                
                consume_skb(skb);
        }
        return stat;

Now if the list is empty we check if (stat < 0) with a NET_RX_FOO stuff,
we should avoid that. I mean the current situation is because somebody
mixed this stuff and that's why we have this now.

Another developers look of some code (that's what I did) and see, aaah
returning NET_RX_FOO so we can check on it, but at this situation he
need to think a little bit more what it is the correct handline because
there is still some errno conversion.

>  	return stat;
>  }
>  
> -static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
> +static int process_data(struct sk_buff **skb_inout,
> +			const struct ieee802154_hdr *hdr)
>  {
>  	u8 iphc0, iphc1;
>  	struct ieee802154_addr_sa sa, da;
>  	void *sap, *dap;
> +	struct sk_buff *skb = *skb_inout;
>  
>  	raw_dump_table(__func__, "raw skb data dump", skb->data, skb->len);
>  	/* at least two bytes will be used for the encoding */
> @@ -197,13 +205,11 @@ static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
>  	else
>  		dap = &da.hwaddr;
>  
> -	return lowpan_process_data(skb, skb->dev, sap, sa.addr_type,
> +	return lowpan_process_data(skb_inout, skb->dev, sap, sa.addr_type,
>  				   IEEE802154_ADDR_LEN, dap, da.addr_type,
> -				   IEEE802154_ADDR_LEN, iphc0, iphc1,
> -				   lowpan_give_skb_to_devices);
> +				   IEEE802154_ADDR_LEN, iphc0, iphc1);
>  
>  drop:
> -	kfree_skb(skb);
>  	return -EINVAL;
>  }
>  
> @@ -478,36 +484,39 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>  
>  	/* check that it's our buffer */
>  	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
> -		skb->protocol = htons(ETH_P_IPV6);
> -		skb->pkt_type = PACKET_HOST;
> -
>  		/* Pull off the 1-byte of 6lowpan header. */
>  		skb_pull(skb, 1);
>  
> -		ret = lowpan_give_skb_to_devices(skb, NULL);
> -		if (ret == NET_RX_DROP)
> -			goto drop;
> +		ret = NET_RX_SUCCESS;

We don't need to set ret here.

>  	} else {
>  		switch (skb->data[0] & 0xe0) {
>  		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
> -			ret = process_data(skb, &hdr);
> -			if (ret == NET_RX_DROP)
> -				goto drop;
> +			ret = process_data(&skb, &hdr);
> +			if (ret < 0)
> +				goto drop_skb;
>  			break;
>  		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
>  			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
>  			if (ret == 1) {
> -				ret = process_data(skb, &hdr);
> -				if (ret == NET_RX_DROP)
> -					goto drop;
> +				ret = process_data(&skb, &hdr);
> +				if (ret < 0)
> +					goto drop_skb;
> +			} else if (ret < 0) {
> +				goto drop;
> +			} else {
> +				return NET_RX_SUCCESS;
>  			}
>  			break;
>  		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
>  			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
>  			if (ret == 1) {
> -				ret = process_data(skb, &hdr);
> -				if (ret == NET_RX_DROP)
> -					goto drop;
> +				ret = process_data(&skb, &hdr);
> +				if (ret < 0)
> +					goto drop_skb;
> +			} else if (ret < 0) {
> +				goto drop;
> +			} else {
> +				return NET_RX_SUCCESS;
>  			}
>  			break;
>  		default:
> @@ -515,7 +524,11 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
>  		}
>  	}
>  
> -	return NET_RX_SUCCESS;
> +	/* Pass IPv6 packet up to next layer */
> +	skb->protocol = htons(ETH_P_IPV6);
> +	skb->pkt_type = PACKET_HOST;
> +	return lowpan_give_skb_to_devices(skb, NULL);
> +

Please ignore the above one, also a hint:

Good that we have this now, so we can do a on the fly decompression when
receiving FRAG1. This required setting skb->len here.

- Alex
