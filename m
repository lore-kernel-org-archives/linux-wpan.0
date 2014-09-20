Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:47855 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039AbaITOzr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 20 Sep 2014 10:55:47 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH linux-wpan] 6lowpan: ensure header compression does not corrupt ipv6 header
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1411141362-12614-1-git-send-email-simon.vincent@xsilon.com>
Date: Sat, 20 Sep 2014 16:55:27 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <9ABADC32-3A37-403D-8482-6158F91F3117@holtmann.org>
References: <1411141362-12614-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com

Hi Simon,

I am missing a proper commit message with explanation here. One-line subject online commit message are really only ever acceptable if it is a dead trivial fix. And even then I prefer a proper commit message with detailed explanation what the patch changes and why.

> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---
> net/ieee802154/6lowpan_rtnl.c | 131 +++++++++++++++++++++++++++++++-----------
> 1 file changed, 97 insertions(+), 35 deletions(-)
> 
> diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
> index 6591d27..cb94504 100644
> --- a/net/ieee802154/6lowpan_rtnl.c
> +++ b/net/ieee802154/6lowpan_rtnl.c
> @@ -71,6 +71,26 @@ struct lowpan_dev_record {
> 	struct list_head list;
> };
> 
> +union lowpan_addr_u {
> +	/* IPv6 needs big endian here */
> +	__be64 extended;
> +	__be16 short_;

I do not like short_ as field name. I know why you are doing this, but why bother. You always access via u.short anyway. Then again, it seems it is not used at all.

> +};
> +
> +/* don't save pan id, it's intra pan */
> +struct lowpan_addr {
> +	/* non converted address mode bits here
> +	 * make this at first, improve memcmp on this struct
> +	 */
> +	__le16 mode;
> +	union lowpan_addr_u u;

If you do not need the union declaration by itself then you can just add it into the struct directly. No need for these extra _u declaration.

> +};
> +
> +struct lowpan_addr_info {
> +	struct lowpan_addr daddr;
> +	struct lowpan_addr saddr;
> +};
> +
> static inline struct
> lowpan_dev_info *lowpan_dev_info(const struct net_device *dev)
> {
> @@ -85,14 +104,21 @@ static inline void lowpan_address_flip(u8 *src, u8 *dest)
> 		(dest)[IEEE802154_ADDR_LEN - i - 1] = (src)[i];
> }
> 
> +static inline struct
> +lowpan_addr_info *lowpan_skb_priv(const struct sk_buff *skb)
> +{
> +	WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct lowpan_addr_info));
> +	return (struct lowpan_addr_info *)(skb->data -
> +			sizeof(struct lowpan_addr_info));
> +}
> +
> static int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
> 				unsigned short type, const void *_daddr,
> 				const void *_saddr, unsigned int len)
> {
> 	const u8 *saddr = _saddr;
> 	const u8 *daddr = _daddr;
> -	struct ieee802154_addr sa, da;
> -	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
> +	struct lowpan_addr_info *info;
> 
> 	/* TODO:
> 	 * if this package isn't ipv6 one, where should it be routed?
> @@ -106,41 +132,15 @@ static int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
> 	raw_dump_inline(__func__, "saddr", (unsigned char *)saddr, 8);
> 	raw_dump_inline(__func__, "daddr", (unsigned char *)daddr, 8);
> 
> -	lowpan_header_compress(skb, dev, type, daddr, saddr, len);
> -
> -	/* NOTE1: I'm still unsure about the fact that compression and WPAN
> -	 * header are created here and not later in the xmit. So wait for
> -	 * an opinion of net maintainers.
> -	 */
> -	/* NOTE2: to be absolutely correct, we must derive PANid information
> -	 * from MAC subif of the 'dev' and 'real_dev' network devices, but
> -	 * this isn't implemented in mainline yet, so currently we assign 0xff
> -	 */
> -	cb->type = IEEE802154_FC_TYPE_DATA;
> -
> -	/* prepare wpan address data */
> -	sa.mode = IEEE802154_ADDR_LONG;
> -	sa.pan_id = ieee802154_mlme_ops(dev)->get_pan_id(dev);
> -	sa.extended_addr = ieee802154_devaddr_from_raw(saddr);
> +	info = lowpan_skb_priv(skb);
> 
> -	/* intra-PAN communications */
> -	da.pan_id = sa.pan_id;
> +	info->daddr.mode = IEEE802154_ADDR_LONG;
> +	memcpy(&info->daddr.u.extended, daddr, sizeof(info->daddr.u.extended));
> 
> -	/* if the destination address is the broadcast address, use the
> -	 * corresponding short address
> -	 */
> -	if (lowpan_is_addr_broadcast(daddr)) {
> -		da.mode = IEEE802154_ADDR_SHORT;
> -		da.short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
> -	} else {
> -		da.mode = IEEE802154_ADDR_LONG;
> -		da.extended_addr = ieee802154_devaddr_from_raw(daddr);
> -	}
> +	info->saddr.mode = IEEE802154_ADDR_LONG;
> +	memcpy(&info->saddr.u.extended, saddr, sizeof(info->daddr.u.extended));
> 
> -	cb->ackreq = !lowpan_is_addr_broadcast(daddr);
> -
> -	return dev_hard_header(skb, lowpan_dev_info(dev)->real_dev,
> -			type, (void *)&da, (void *)&sa, 0);
> +	return 0;
> }
> 
> static int lowpan_give_skb_to_devices(struct sk_buff *skb,
> @@ -338,13 +338,74 @@ err:
> 	return rc;
> }
> 
> +static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct ieee802154_addr sa, da;
> +	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
> +	struct lowpan_addr_info info;
> +	void *daddr, *saddr;
> +
> +	memcpy(&info, lowpan_skb_priv(skb), sizeof(info));
> +
> +	/* TODO complicated bug why we support extended_addr only */

This is not a good comment. Explain why since especially only extended addresses are supported, I have no idea on why we are adding all these struct addition in the first place.

> +	daddr = &info.daddr.u.extended;
> +	saddr = &info.saddr.u.extended;
> +
> +	lowpan_header_compress(skb, dev, ETH_P_IPV6, daddr, saddr, skb->len);
> +
> +	/* NOTE1: I'm still unsure about the fact that compression and WPAN
> +	 * header are created here and not later in the xmit. So wait for
> +	 * an opinion of net maintainers.
> +	 */

Now I wonder why this has not yet been answered and you are in the need of copying around. Maybe this should have been addressed by now.

> +	/* NOTE2: to be absolutely correct, we must derive PANid information
> +	 * from MAC subif of the 'ldev' and 'wdev' network devices, but
> +	 * this isn't implemented in mainline yet, so currently we assign 0xff
> +	 */
> +	cb->type = IEEE802154_FC_TYPE_DATA;
> +
> +	/* prepare wpan address data */
> +	sa.mode = IEEE802154_ADDR_LONG;
> +	sa.pan_id = ieee802154_mlme_ops(dev)->get_pan_id(dev);
> +	sa.extended_addr = ieee802154_devaddr_from_raw(saddr);
> +
> +	/* intra-PAN communications */
> +	da.pan_id = sa.pan_id;
> +
> +	/* if the destination address is the broadcast address, use the
> +	 * corresponding short address
> +	 */
> +	if (lowpan_is_addr_broadcast((const u8 *)daddr)) {
> +		da.mode = IEEE802154_ADDR_SHORT;
> +		da.short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
> +		cb->ackreq = false;
> +	} else {
> +		da.mode = IEEE802154_ADDR_LONG;
> +		da.extended_addr = ieee802154_devaddr_from_raw(daddr);
> +		cb->ackreq = true;
> +	}
> +
> +	return dev_hard_header(skb, lowpan_dev_info(dev)->real_dev,
> +			ETH_P_IPV6, (void *)&da, (void *)&sa, 0);
> +}
> +
> static netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev)
> {
> 	struct ieee802154_hdr wpan_hdr;
> -	int max_single;
> +	int max_single, ret;
> 
> 	pr_debug("package xmit\n");
> 
> +	/* We must take a copy of the skb before we modify/replace the ipv6
> +	 * header as the header could be used elsewhere
> +	 */
> +	skb = skb_unshare(skb, GFP_KERNEL);
> +
> +	ret = lowpan_header(skb, dev);
> +	if (ret < 0) {
> +		kfree_skb(skb);
> +		return NET_XMIT_DROP;
> +	}
> +
> 	if (ieee802154_hdr_peek(skb, &wpan_hdr) < 0) {
> 		kfree_skb(skb);
> 		return NET_XMIT_DROP;

Regards

Marcel

