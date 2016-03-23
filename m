Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44895 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752573AbcCWKuQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 23 Mar 2016 06:50:16 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id AC2CE20C66
	for <linux-wpan@vger.kernel.org>; Wed, 23 Mar 2016 06:50:14 -0400 (EDT)
Subject: Re: [RFC bluetooth-next 13/19] addrconf: add 802.15.4 short addr
 slaac
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
 <1458652515-7862-14-git-send-email-aar@pengutronix.de>
From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Message-ID: <56F274E4.2050205@stressinduktion.org>
Date: Wed, 23 Mar 2016 11:50:12 +0100
MIME-Version: 1.0
In-Reply-To: <1458652515-7862-14-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net

On 22.03.2016 14:15, Alexander Aring wrote:
> This patch adds the autoconfiguration if a valid 802.15.4 short address
> is available for 802.15.4 6LoWPAN interfaces.
>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>   net/ipv6/addrconf.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
>
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 27aed1a..eb3e3fb 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -3058,6 +3058,37 @@ static void ipv6_gen_mode_random_init(struct inet6_dev *idev)
>   	s->initialized = true;
>   }
>
> +#ifdef CONFIG_IEEE802154_6LOWPAN
> +static int addrconf_ifid_ieee802154(u8 *eui, struct net_device *dev)
> +{
> +	struct wpan_dev *wpan_dev = lowpan_802154_dev(dev)->wdev->ieee802154_ptr;
> +
> +	/* Set short_addr autoconfiguration if short_addr is present only */
> +	if (!ieee802154_is_valid_src_short_addr(wpan_dev->short_addr))
> +		return -1;
> +
> +	/* For either address format, all zero addresses MUST NOT be used */
> +	if (wpan_dev->pan_id == cpu_to_le16(0x0000) &&
> +	    wpan_dev->short_addr == cpu_to_le16(0x0000))
> +		return -1;
> +
> +	/* Alternatively, if no PAN ID is known, 16 zero bits may be used */
> +	if (wpan_dev->pan_id == cpu_to_le16(IEEE802154_PAN_ID_BROADCAST))
> +		memset(eui, 0, 2);
> +	else
> +		ieee802154_le16_to_be16(eui, &wpan_dev->pan_id);
> +
> +	/* The "Universal/Local" (U/L) bit shall be set to zero */
> +	eui[0] &= ~2;
> +	eui[2] = 0;
> +	eui[3] = 0xFF;
> +	eui[4] = 0xFE;
> +	eui[5] = 0;
> +	ieee802154_le16_to_be16(&eui[6], &wpan_dev->short_addr);
> +	return 0;
> +}

static void configure lowpan_addrconf(idev, addr)
{
 > +			if (addrconf_ifid_ieee802154(addr.s6_addr + 8,
 > +						     idev->dev) == 0)
 > +				addrconf_add_linklocal(idev, &addr, 0);
}

#else

static void configure lowpan_addrconf(idev, addr)
{
}

> +#endif

So we don't need the ifdef in addrconf_addr_gen. I think it pretty much 
reflects what upstream wants.

> +
>   static void addrconf_addr_gen(struct inet6_dev *idev, bool prefix_route)
>   {
>   	struct in6_addr addr;
> @@ -3088,6 +3119,15 @@ static void addrconf_addr_gen(struct inet6_dev *idev, bool prefix_route)
>   			addrconf_add_linklocal(idev, &addr, 0);
>   		else if (prefix_route)
>   			addrconf_prefix_route(&addr, 64, idev->dev, 0, 0);
> +
> +		/* 802.15.4 6LoWPAN short address slaac handling */
> +		if (lowpan_is_ll(idev->dev, LOWPAN_LLTYPE_IEEE802154)) {
> +		}

Do you think it makes sense to put this under the label 
IN_ADDR_GEN_MODE_EUI64? I don't see a real issue with it, maybe it 
conflicts a little bit with the naming.

Otherwise I don't have any issue with the change.

Bye,
Hannes

