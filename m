Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51293 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757371AbcG1MU5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 28 Jul 2016 08:20:57 -0400
Subject: Re: [PATCH linux-wpan/radvd 6lowpan] device-linux: detect 6LoWPAN
 lltype for hwaddr length
References: <20160621144250.31650-1-aar@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <21cdff8b-9994-63ec-a9c8-6691b5820302@pengutronix.de>
Date: Thu, 28 Jul 2016 14:20:53 +0200
MIME-Version: 1.0
In-Reply-To: <20160621144250.31650-1-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, patrik.flykt@linux.intel.com, jukka.rissanen@linux.intel.com

Hi,

On 06/21/2016 04:42 PM, Alexander Aring wrote:
> This patch will change the behaviour for 6LoWPAN interface to detect the
> linklayer type via debugfs. Each L2 interface has a different address
> length and need to be detected.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> We have two choices (or even more):
> 
>  - Add lltype like this patch to detect the hwaddr length
> 
>  or
> 
>  - Add a UAPI to get the hwaddr length doesn't depend on lltype
> 
> I did the first choice now, because it works like the net core api which
> also has no UAPI for addr length. To get the address length you need to
> map it to the netdev type. But this also means that a netdev type should
> not have different hardware addresses.
> 
> In 6LoWPAN this is different, the ARPHRD_6LOWPAN can have different address
> lengths. Jukka please tell me if this is fine or not, I usually don't want
> to make things for ARPHRD_6LOWPAN link-layer specific, but we need to add
> some solution for this.
> 
> My different UAPI solution is shown above, don't know which is actually
> better. I think we need for some cases an UAPI to get the link-layer
> type anyway.
> 
> btw: as fallback it use the olf behaviour 64 bit's so if we fix btle 6lowpan
> to work with dev->addr_len = 6 and introduce the UAPI it will be fixed
> automatically.
> 
> Later we need to move this stuff to sysfs. Debugfs is also not namespace
> aware and because that it forbids me to make some special testing stuff.
> 
>  device-linux.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  pathnames.h    |  1 +
>  2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/device-linux.c b/device-linux.c
> index 55f8522..3d18071 100644
> --- a/device-linux.c
> +++ b/device-linux.c
> @@ -60,6 +60,42 @@ static uint16_t lowpan_get_short_addr(struct Interface *iface)

...

>   * this function gets the hardware type and address of an interface,
>   * determines the link layer token length and checks it against
>   * the defined prefixes
> @@ -115,7 +151,21 @@ int update_device_info(int sock, struct Interface *iface)
>  		break;
>  #endif				/* ARPHDR_ARCNET */
>  	case ARPHRD_6LOWPAN:
> -		iface->sllao.if_hwaddr_len = 64;
> +		/* hwaddr length differs on each L2 type lets detect them */
> +		switch (lowpan_get_lltype(iface)) {
> +		case LOWPAN_LLTYPE_BTLE:
> +			iface->sllao.if_hwaddr_len = 48;
> +			break;
> +		case LOWPAN_LLTYPE_IEEE802154:
> +			iface->sllao.if_hwaddr_len = 64;
> +			break;
> +		default:
> +			/* TODO change to -1 if 6LoWPAN has better UAPI for that */
> +			flog(LOG_WARNING, "WARNING, couldn't get 6LoWPAN link-layer type on %s, falling back to 64 bit hwaddr", iface->props.name);
> +			iface->sllao.if_hwaddr_len = 64;
> +			break;
> +		}
> +


I think to solve this issue, the best way currently is to evaluate:

/sys/class/net/$IFNAME/addr_len

which directly told us the dev->addr_len attribute in kernel. The only
thing that it could be that CONFIG_SYSFS isn't compiled. On 802.15.4 we
need to have SYSFS because iwpan and phy enumaration [0].

This solution should make radvd working with current mainline version
which does dev->addr_len == 8 and also with the version when we change
addr_len to 6.

Or we introduce an UAPI subtype mechanism? Maybe something which is
already set the NET_DEVTYPE stuff. Don't know I think we should go that
way, we can later still change it to some subtype (linklayer type)
evaluation if this information isn't enough for some linklayer types.

- Alex

[0] https://github.com/linux-wpan/wpan-tools/blob/master/src/iwpan.c#L221
