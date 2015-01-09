Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41633 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805AbbAIQad (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 9 Jan 2015 11:30:33 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1420818179-18585-1-git-send-email-alex.aring@gmail.com>
 <1420818179-18585-4-git-send-email-alex.aring@gmail.com>
In-reply-to: <1420818179-18585-4-git-send-email-alex.aring@gmail.com>
Subject: Re: [PATCHv5 bluetooth-next 3/3] 6lowpan: nhc: add other known rfc6282
 compressions
Date: Fri, 09 Jan 2015 16:30:27 +0000
Message-id: <061401d02c29$93889ef0$ba99dcd0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: 'Alexander Aring' <alex.aring@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, 'Jukka Rissanen' <jukka.rissanen@linux.intel.com>, 'Martin Townsend' <mtownsend1973@gmail.com>

Hello.

On 09/01/15 16:42, Alexander Aring wrote:
> This patch adds other known rfc6282 compression formats to the nhc
> framework. These compression formats are known but not implemented yet.
> For now this is useful to printout a warning which compression format
> isn't supported.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> Cc: Martin Townsend <mtownsend1973@gmail.com>
> ---
>   net/6lowpan/Kconfig        | 38 ++++++++++++++++++++++++++++++++++++++
>   net/6lowpan/Makefile       |  6 ++++++
>   net/6lowpan/iphc.c         |  6 ++++++
>   net/6lowpan/nhc_dest.c     | 28 ++++++++++++++++++++++++++++
>   net/6lowpan/nhc_fragment.c | 27 +++++++++++++++++++++++++++
>   net/6lowpan/nhc_hop.c      | 27 +++++++++++++++++++++++++++
>   net/6lowpan/nhc_ipv6.c     | 27 +++++++++++++++++++++++++++
>   net/6lowpan/nhc_mobility.c | 27 +++++++++++++++++++++++++++
>   net/6lowpan/nhc_routing.c  | 27 +++++++++++++++++++++++++++
>   9 files changed, 213 insertions(+)
>   create mode 100644 net/6lowpan/nhc_dest.c
>   create mode 100644 net/6lowpan/nhc_fragment.c
>   create mode 100644 net/6lowpan/nhc_hop.c
>   create mode 100644 net/6lowpan/nhc_ipv6.c
>   create mode 100644 net/6lowpan/nhc_mobility.c
>   create mode 100644 net/6lowpan/nhc_routing.c
>
> diff --git a/net/6lowpan/Kconfig b/net/6lowpan/Kconfig
> index e45c963..7fa0f38 100644
> --- a/net/6lowpan/Kconfig
> +++ b/net/6lowpan/Kconfig
> @@ -14,6 +14,44 @@ menuconfig 6LOWPAN_NHC
>
>   if 6LOWPAN_NHC
>
> +config 6LOWPAN_NHC_DEST
> +	tristate "Destination Options Header Support"
> +	default y
> +	---help---
> +	  6LoWPAN IPv6 Destination Options Header compression according to
> +	  RFC6282.
> +
> +config 6LOWPAN_NHC_FRAGMENT
> +	tristate "Fragment Header Support"
> +	default y
> +	---help---
> +	  6LoWPAN IPv6 Fragment Header compression according to RFC6282.
> +
> +config 6LOWPAN_NHC_HOP
> +	tristate "Hop-by-Hop Options Header Support"
> +	default y
> +	---help---
> +	  6LoWPAN IPv6 Hop-by-Hop Options Header compression according to
> +	  RFC6282.
> +
> +config 6LOWPAN_NHC_IPV6
> +	tristate "IPv6 Header Support"
> +	default y
> +	---help---
> +	  6LoWPAN IPv6 Header compression according to RFC6282.
> +
> +config 6LOWPAN_NHC_MOBILITY
> +	tristate "Mobility Header Support"
> +	default y
> +	---help---
> +	  6LoWPAN IPv6 Mobility Header compression according to RFC6282.
> +
> +config 6LOWPAN_NHC_ROUTING
> +	tristate "Routing Header Support"
> +	default y
> +	---help---
> +	  6LoWPAN IPv6 Routing Header compression according to RFC6282.
> +
>   config 6LOWPAN_NHC_UDP
>   	tristate "UDP Header Support"
>   	default y
> diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
> index abf551d..eb8baa7 100644
> --- a/net/6lowpan/Makefile
> +++ b/net/6lowpan/Makefile
> @@ -3,4 +3,10 @@ obj-$(CONFIG_6LOWPAN) += 6lowpan.o
>   6lowpan-y := iphc.o nhc.o
>
>   #rfc6282 nhcs
> +obj-$(CONFIG_6LOWPAN_NHC_DEST) += nhc_dest.o
> +obj-$(CONFIG_6LOWPAN_NHC_FRAGMENT) += nhc_fragment.o
> +obj-$(CONFIG_6LOWPAN_NHC_HOP) += nhc_hop.o
> +obj-$(CONFIG_6LOWPAN_NHC_IPV6) += nhc_ipv6.o
> +obj-$(CONFIG_6LOWPAN_NHC_MOBILITY) += nhc_mobility.o
> +obj-$(CONFIG_6LOWPAN_NHC_ROUTING) += nhc_routing.o
>   obj-$(CONFIG_6LOWPAN_NHC_UDP) += nhc_udp.o
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 390bdd9..94a375c 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -613,6 +613,12 @@ EXPORT_SYMBOL_GPL(lowpan_header_compress);
>
>   static int __init lowpan_module_init(void)
>   {
> +	request_module_nowait("nhc_dest");
> +	request_module_nowait("nhc_fragment");
> +	request_module_nowait("nhc_hop");
> +	request_module_nowait("nhc_ipv6");
> +	request_module_nowait("nhc_mobility");
> +	request_module_nowait("nhc_routing");
>   	request_module_nowait("nhc_udp");
>
>   	return 0;
> diff --git a/net/6lowpan/nhc_dest.c b/net/6lowpan/nhc_dest.c
> new file mode 100644
> index 0000000..0b292c9
> --- /dev/null
> +++ b/net/6lowpan/nhc_dest.c
> @@ -0,0 +1,28 @@
> +/*
> + *	6LoWPAN IPv6 Destination Options Header compression according to
> + *	RFC6282
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#include "nhc.h"
> +
> +#define LOWPAN_NHC_DEST_IDLEN	1
> +#define LOWPAN_NHC_DEST_ID_0	0xe6
> +#define LOWPAN_NHC_DEST_MASK_0	0xfe
> +
> +static void dest_nhid_setup(struct lowpan_nhc *nhc)
> +{
> +	nhc->id[0] = LOWPAN_NHC_DEST_ID_0;
> +	nhc->idmask[0] = LOWPAN_NHC_DEST_MASK_0;
> +}
> +
> +LOWPAN_NHC(nhc_dest, "RFC6282 Destination Options", NEXTHDR_DEST, 0,
> +	   dest_nhid_setup, LOWPAN_NHC_DEST_IDLEN, NULL, NULL);
> +
> +module_lowpan_nhc(nhc_dest);
> +MODULE_DESCRIPTION("6LoWPAN next header RFC6282 Destination Options
> compression");
> +MODULE_LICENSE("GPL");
> diff --git a/net/6lowpan/nhc_fragment.c b/net/6lowpan/nhc_fragment.c
> new file mode 100644
> index 0000000..473dbc5
> --- /dev/null
> +++ b/net/6lowpan/nhc_fragment.c
> @@ -0,0 +1,27 @@
> +/*
> + *	6LoWPAN IPv6 Fragment Header compression according to RFC6282
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#include "nhc.h"
> +
> +#define LOWPAN_NHC_FRAGMENT_IDLEN	1
> +#define LOWPAN_NHC_FRAGMENT_ID_0	0xe4
> +#define LOWPAN_NHC_FRAGMENT_MASK_0	0xfe
> +
> +static void fragment_nhid_setup(struct lowpan_nhc *nhc)
> +{
> +	nhc->id[0] = LOWPAN_NHC_FRAGMENT_ID_0;
> +	nhc->idmask[0] = LOWPAN_NHC_FRAGMENT_MASK_0;
> +}
> +
> +LOWPAN_NHC(nhc_fragment, "RFC6282 Fragment", NEXTHDR_FRAGMENT, 0,
> +	   fragment_nhid_setup, LOWPAN_NHC_FRAGMENT_IDLEN, NULL, NULL);
> +
> +module_lowpan_nhc(nhc_fragment);
> +MODULE_DESCRIPTION("6LoWPAN next header RFC6282 Fragment compression");
> +MODULE_LICENSE("GPL");
> diff --git a/net/6lowpan/nhc_hop.c b/net/6lowpan/nhc_hop.c
> new file mode 100644
> index 0000000..1eb66be
> --- /dev/null
> +++ b/net/6lowpan/nhc_hop.c
> @@ -0,0 +1,27 @@
> +/*
> + *	6LoWPAN IPv6 Hop-by-Hop Options Header compression according to
> RFC6282
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#include "nhc.h"
> +
> +#define LOWPAN_NHC_HOP_IDLEN	1
> +#define LOWPAN_NHC_HOP_ID_0	0xe0
> +#define LOWPAN_NHC_HOP_MASK_0	0xfe
> +
> +static void hop_nhid_setup(struct lowpan_nhc *nhc)
> +{
> +	nhc->id[0] = LOWPAN_NHC_HOP_ID_0;
> +	nhc->idmask[0] = LOWPAN_NHC_HOP_MASK_0;
> +}
> +
> +LOWPAN_NHC(nhc_hop, "RFC6282 Hop-by-Hop Options", NEXTHDR_HOP, 0,
> +	   hop_nhid_setup, LOWPAN_NHC_HOP_IDLEN, NULL, NULL);
> +
> +module_lowpan_nhc(nhc_hop);
> +MODULE_DESCRIPTION("6LoWPAN next header RFC6282 Hop-by-Hop Options
> compression");
> +MODULE_LICENSE("GPL");
> diff --git a/net/6lowpan/nhc_ipv6.c b/net/6lowpan/nhc_ipv6.c
> new file mode 100644
> index 0000000..2313d16
> --- /dev/null
> +++ b/net/6lowpan/nhc_ipv6.c
> @@ -0,0 +1,27 @@
> +/*
> + *	6LoWPAN IPv6 Header compression according to RFC6282
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#include "nhc.h"
> +
> +#define LOWPAN_NHC_IPV6_IDLEN	1
> +#define LOWPAN_NHC_IPV6_ID_0	0xee
> +#define LOWPAN_NHC_IPV6_MASK_0	0xfe
> +
> +static void ipv6_nhid_setup(struct lowpan_nhc *nhc)
> +{
> +	nhc->id[0] = LOWPAN_NHC_IPV6_ID_0;
> +	nhc->idmask[0] = LOWPAN_NHC_IPV6_MASK_0;
> +}
> +
> +LOWPAN_NHC(nhc_ipv6, "RFC6282 IPv6", NEXTHDR_IPV6, 0, ipv6_nhid_setup,
> +	   LOWPAN_NHC_IPV6_IDLEN, NULL, NULL);
> +
> +module_lowpan_nhc(nhc_ipv6);
> +MODULE_DESCRIPTION("6LoWPAN next header RFC6282 IPv6 compression");
> +MODULE_LICENSE("GPL");
> diff --git a/net/6lowpan/nhc_mobility.c b/net/6lowpan/nhc_mobility.c
> new file mode 100644
> index 0000000..60d3f38
> --- /dev/null
> +++ b/net/6lowpan/nhc_mobility.c
> @@ -0,0 +1,27 @@
> +/*
> + *	6LoWPAN IPv6 Mobility Header compression according to RFC6282
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#include "nhc.h"
> +
> +#define LOWPAN_NHC_MOBILITY_IDLEN	1
> +#define LOWPAN_NHC_MOBILITY_ID_0	0xe8
> +#define LOWPAN_NHC_MOBILITY_MASK_0	0xfe
> +
> +static void mobility_nhid_setup(struct lowpan_nhc *nhc)
> +{
> +	nhc->id[0] = LOWPAN_NHC_MOBILITY_ID_0;
> +	nhc->idmask[0] = LOWPAN_NHC_MOBILITY_MASK_0;
> +}
> +
> +LOWPAN_NHC(nhc_mobility, "RFC6282 Mobility", NEXTHDR_MOBILITY, 0,
> +	   mobility_nhid_setup, LOWPAN_NHC_MOBILITY_IDLEN, NULL, NULL);
> +
> +module_lowpan_nhc(nhc_mobility);
> +MODULE_DESCRIPTION("6LoWPAN next header RFC6282 Mobility compression");
> +MODULE_LICENSE("GPL");
> diff --git a/net/6lowpan/nhc_routing.c b/net/6lowpan/nhc_routing.c
> new file mode 100644
> index 0000000..c393280
> --- /dev/null
> +++ b/net/6lowpan/nhc_routing.c
> @@ -0,0 +1,27 @@
> +/*
> + *	6LoWPAN IPv6 Routing Header compression according to RFC6282
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#include "nhc.h"
> +
> +#define LOWPAN_NHC_ROUTING_IDLEN	1
> +#define LOWPAN_NHC_ROUTING_ID_0		0xe2
> +#define LOWPAN_NHC_ROUTING_MASK_0	0xfe
> +
> +static void routing_nhid_setup(struct lowpan_nhc *nhc)
> +{
> +	nhc->id[0] = LOWPAN_NHC_ROUTING_ID_0;
> +	nhc->idmask[0] = LOWPAN_NHC_ROUTING_MASK_0;
> +}
> +
> +LOWPAN_NHC(nhc_routing, "RFC6282 Routing", NEXTHDR_ROUTING, 0,
> +	   routing_nhid_setup, LOWPAN_NHC_ROUTING_IDLEN, NULL, NULL);
> +
> +module_lowpan_nhc(nhc_routing);
> +MODULE_DESCRIPTION("6LoWPAN next header RFC6282 Routing compression");
> +MODULE_LICENSE("GPL");
>

Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>

regards
Stefan Schmidt


