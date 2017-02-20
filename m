Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:36663
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750826AbdBTWKU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Feb 2017 17:10:20 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH v3 4/5] ipv6: addrconf: fix 48 bit 6lowpan
 autoconfiguration
References: <20170217155003.4594-1-luiz.dentz@gmail.com>
 <20170217155003.4594-5-luiz.dentz@gmail.com>
Message-ID: <2ea89126-3c3b-5754-7bfc-7e8dc0f356d9@osg.samsung.com>
Date: Mon, 20 Feb 2017 23:10:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170217155003.4594-5-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Hello.

[Added netdev in cc as it touches ipv6/addrconf]

6LoWPAN handling changes only so an ACK should be ok and we could carry 
it through the bluetooth tree after the respin (see below).

David, is that ok with you?

On 02/17/2017 04:50 PM, Luiz Augusto von Dentz wrote:
> From: Alexander Aring <aar@pengutronix.de>
>
> This patch adds support for 48 bit 6LoWPAN address length
> autoconfiguration which is the case for BTLE 6LoWPAN.
>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/ipv6/addrconf.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index ac9bd56..dede33f 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2050,12 +2050,19 @@ static void addrconf_leave_anycast(struct inet6_ifaddr *ifp)
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
> @@ -2146,7 +2153,7 @@ static int ipv6_generate_eui64(u8 *eui, struct net_device *dev)
>  	case ARPHRD_IPGRE:
>  		return addrconf_ifid_gre(eui, dev);
>  	case ARPHRD_6LOWPAN:
> -		return addrconf_ifid_eui64(eui, dev);
> +		return addrconf_ifid_6lowpan(eui, dev);
>  	case ARPHRD_IEEE1394:
>  		return addrconf_ifid_ieee1394(eui, dev);
>  	case ARPHRD_TUNNEL6:
>

Against which tree did you make this patch? Seems it needs a rebase.

Applying it against bluetooth-next master branch:

Applying: ipv6: addrconf: fix 48 bit 6lowpan autoconfiguration
error: patch failed: net/ipv6/addrconf.c:2146
error: net/ipv6/addrconf.c: patch does not apply
Patch failed at 0001 ipv6: addrconf: fix 48 bit 6lowpan autoconfiguration

regards
Stefan Schmidt
