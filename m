Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54226 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750975AbcGLURD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 12 Jul 2016 16:17:03 -0400
Subject: Re: [RFC bluetooth-next 16/20] ipv6: addrconf: fix 48 bit 6lowpan
 autoconfiguration
References: <20160711195044.25343-1-aar@pengutronix.de>
 <20160711195044.25343-17-aar@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <8b4e7905-95a0-0fde-a035-87aff73b0fe4@pengutronix.de>
Date: Tue, 12 Jul 2016 22:16:55 +0200
MIME-Version: 1.0
In-Reply-To: <20160711195044.25343-17-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com


Hi,

own review notes to lookup for next run, otherwise I will forget them.

On 07/11/2016 09:50 PM, Alexander Aring wrote:
> This patch adds support for 48 bit 6LoWPAN address length
> autoconfiguration which is the case for BTLE 6LoWPAN.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>  net/ipv6/addrconf.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index a1f6b7b..aab9b0d 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2007,12 +2007,21 @@ static void addrconf_leave_anycast(struct inet6_ifaddr *ifp)
>  	__ipv6_dev_ac_dec(ifp->idev, &addr);
>  }
>  
> -static int addrconf_ifid_eui64(u8 *eui, struct net_device *dev)
> +static int addrconf_ifid_6lowpan(u8 *eui, struct net_device *dev)
>  {
> -	if (dev->addr_len != EUI64_ADDR_LEN)
> +	switch (dev->addr_len) {
> +	case ETH_ALEN:
> +		return addrconf_ifid_eui48(eui, dev);
> +	case EUI64_ADDR_LEN:
> +		if (dev->addr_len != EUI64_ADDR_LEN)
> +			return -1;

this if branch should be removed.

The idea is here now to not check on "link layer type". Now we check on
address length type and do some usually stuff which all others
link-layers does which such address length. This works now for btle and
802.15.4 but maybe there will exists another 8 byte or 6 byte address
length link-layer where we cannot use the same stuff here.

If that will be the case we can still figure out the link-layer type and
do different handling.

btw: this should also be switched then in iphc code, where we evaluate
the link-layer type to do uncompress. We can switch to evaluate addr_len
there as well.

OR we introduce some callbacks which must be set from link-layer 6lowpan
implementation for compress or decompress L3 addresses (which based on
L2 address bits). I need to think about here what will be the best fit.

This callback can be used here also then.

> +		memcpy(eui, dev->dev_addr, EUI64_ADDR_LEN);
> +		eui[0] ^= 2;
> +		break;
> +	default:
>  		return -1;
> -	memcpy(eui, dev->dev_addr, EUI64_ADDR_LEN);
> -	eui[0] ^= 2;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -2103,7 +2112,7 @@ static int ipv6_generate_eui64(u8 *eui, struct net_device *dev)
>  	case ARPHRD_IPGRE:
>  		return addrconf_ifid_gre(eui, dev);
>  	case ARPHRD_6LOWPAN:
> -		return addrconf_ifid_eui64(eui, dev);
> +		return addrconf_ifid_6lowpan(eui, dev);
>  	case ARPHRD_IEEE1394:
>  		return addrconf_ifid_ieee1394(eui, dev);
>  	case ARPHRD_TUNNEL6:
> 

- Alex
