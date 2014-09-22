Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:43173 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbaIVQV6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Sep 2014 12:21:58 -0400
Received: by mail-wi0-f177.google.com with SMTP id q5so3377474wiv.10
        for <linux-wpan@vger.kernel.org>; Mon, 22 Sep 2014 09:21:56 -0700 (PDT)
Date: Mon, 22 Sep 2014 18:21:50 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
Message-ID: <20140922162148.GA7282@omega>
References: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com, marcel@holtmann.org

Hi Simon,

grml, I overlooked something the last version. But I will fix it while
applying if all seems to be okay for all other guys/girls.

On Mon, Sep 22, 2014 at 04:52:03PM +0100, Simon Vincent wrote:
> The 6lowpan ipv6 header compression was causing problems for other interfaces
> that expected a ipv6 header to still be in place, as we were replacing the
> ipv6 header with a compressed version. This happened if you sent a packet to a
> multicast address as the packet would be output on 802.15.4, ethernet, and also
> be sent to the loopback interface. The skb data was shared between these
> interfaces so all interfaces ended up with a compressed ipv6 header.
> The solution is to ensure that before we do any header compression we are not
> sharing the skb or skb data with any other interface. If we are then we must
> take a copy of the skb and skb data before modifying the ipv6 header.
> The only place we can copy the skb is inside the xmit function so we don't
> leave dangling references to skb.
> This patch moves all the header compression to inside the xmit function. Very
> little code has been changed it has mostly been moved from lowpan_header_create
> to lowpan_xmit. At the top of the xmit function we now check if the skb is
> shared and if so copy it. In lowpan_header_create all we do now is store the
> source and destination addresses for use later when we compress the header.
> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---
> 
> v4 - fixed patch style checks
> 
> 
>  net/ieee802154/6lowpan_rtnl.c | 125 ++++++++++++++++++++++++++++++------------
>  1 file changed, 89 insertions(+), 36 deletions(-)
> 
> diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
> index 6591d27..ca7ef0e 100644
> --- a/net/ieee802154/6lowpan_rtnl.c
> +++ b/net/ieee802154/6lowpan_rtnl.c
> @@ -71,6 +71,21 @@ struct lowpan_dev_record {
>  	struct list_head list;
>  };
>  
> +/* don't save pan id, it's intra pan */
> +struct lowpan_addr {
> +	__le16 mode;

In the rework I made this __le16 because this value comes directly from
mac header and contain the masked frame control fields for the
destination address mode and source address mode and 802.15.4 header
is little byteorder. I know it's very confusing because 802.15.4 is
little endian and IPv6 is big endian, oh yes that was a very good idea
to make it little endian. ;-)

We should never ever convert this value into some host byteorder, this
cost time and netdev people doesn't like that (I already saw some
patches which came not mainline because that).

performance example:

if (__le16_mode == cpu_to_le16(IEEE802154_FCTL_DADDR_EXTENDED))

the byte ordering is determined at compile time.

Doing this like:

if (le16_to_cpu(__le16_mode) == IEEE802154_FCTL_DADDR_EXTENDED))

is determined at runtime. <-- cost time, also compiler can't detect it.
Also this is shift operation, if we do compile time determined then we
only have some compare and "maybe" mask operators. Shift operation cost
some time on several architectures which have shifts as pseudo
instruction (like mips). (converting byte order is some mixing shift and
masking operations).

And the netdev people doesn't like that because, I don't know it's
usually to keep the byteorder from protocol to avoid confusing.

Nevertheless:
this should in this case u8 because somebody converted it into some cpu
understandable value. <--- this we should not do on parsing. I
will remove the converting to any host byteorder in the rework.

See below for the example.

> +	union lowpan_addr_u {
> +		/* IPv6 needs big endian here */
> +		__be64 extended_addr;
> +		__be16 short_addr;
> +	} u;
> +};
> +
> +struct lowpan_addr_info {
> +	struct lowpan_addr daddr;
> +	struct lowpan_addr saddr;
> +};
> +
>  static inline struct
>  lowpan_dev_info *lowpan_dev_info(const struct net_device *dev)
>  {
> @@ -85,14 +100,21 @@ static inline void lowpan_address_flip(u8 *src, u8 *dest)
>  		(dest)[IEEE802154_ADDR_LEN - i - 1] = (src)[i];
>  }
>  
> +static inline struct
> +lowpan_addr_info *lowpan_skb_priv(const struct sk_buff *skb)
> +{
> +	WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct lowpan_addr_info));
> +	return (struct lowpan_addr_info *)(skb->data -
> +			sizeof(struct lowpan_addr_info));
> +}
> +
>  static int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
>  				unsigned short type, const void *_daddr,
>  				const void *_saddr, unsigned int len)
>  {
>  	const u8 *saddr = _saddr;
>  	const u8 *daddr = _daddr;
> -	struct ieee802154_addr sa, da;
> -	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
> +	struct lowpan_addr_info *info;
>  
>  	/* TODO:
>  	 * if this package isn't ipv6 one, where should it be routed?
> @@ -106,41 +128,17 @@ static int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
>  	raw_dump_inline(__func__, "saddr", (unsigned char *)saddr, 8);
>  	raw_dump_inline(__func__, "daddr", (unsigned char *)daddr, 8);
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
> -
> -	/* intra-PAN communications */
> -	da.pan_id = sa.pan_id;
> -
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
> +	info = lowpan_skb_priv(skb);
>  
> -	cb->ackreq = !lowpan_is_addr_broadcast(daddr);
> +	/* TODO: Currently we only support extended_addr */
> +	info->daddr.mode = IEEE802154_ADDR_LONG;

now IEEE802154_ADDR_LONG is no little endian value copied from mac
header. Somewhere else converted the little endian value to an host understandable
enum/define number. For the rework I will remove this value. We should never
ever convert this value for parsing.

We use it only for af_802154 and userspace specification what addresses
should be used. But the above one to make this __le16 is incorrect. For
userspace we should create some enums for declaring different address
types. Then we can use this for 802.15.4 sockets.

I will fix it while applying when all things are okay, it's only to
replace the __le16 to u8.


And I also know that 6LoWPAN GENERIC need this value for determined is EUI64
or short. I don't forget this one, wasn't full finished at rework
branch.

- Alex
