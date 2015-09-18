Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34304 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbbIRVvG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 18 Sep 2015 17:51:06 -0400
Date: Fri, 18 Sep 2015 23:51:01 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 4/4] 6lowpan: add nhc module for GHC
 ICMPv6 detection
Message-ID: <20150918215059.GC6872@omega>
References: <1442577168-23183-1-git-send-email-stefan@osg.samsung.com>
 <1442577168-23183-5-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1442577168-23183-5-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org

On Fri, Sep 18, 2015 at 01:52:48PM +0200, Stefan Schmidt wrote:
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  net/6lowpan/Kconfig          |  5 +++++
>  net/6lowpan/Makefile         |  1 +
>  net/6lowpan/nhc_ghc_icmpv6.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+)
>  create mode 100644 net/6lowpan/nhc_ghc_icmpv6.c
> 
> diff --git a/net/6lowpan/Kconfig b/net/6lowpan/Kconfig
> index 67a786b..a34693d 100644
> --- a/net/6lowpan/Kconfig
> +++ b/net/6lowpan/Kconfig
> @@ -69,4 +69,9 @@ config 6LOWPAN_GHC_UDP
>  	default y
>  	---help---
>  
> +config 6LOWPAN_GHC_ICMPV6
> +	tristate "GHC ICMPv6 Support"
> +	default y
> +	---help---
> +
>  endif
> diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
> index fc65efb..49256b7f 100644
> --- a/net/6lowpan/Makefile
> +++ b/net/6lowpan/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_6LOWPAN_NHC_UDP) += nhc_udp.o
>  #rfc7400 ghcs
>  obj-$(CONFIG_6LOWPAN_GHC_EXTENSION_HEADER) += nhc_ghc_extension_header.o
>  obj-$(CONFIG_6LOWPAN_GHC_UDP) += nhc_ghc_udp.o
> +obj-$(CONFIG_6LOWPAN_GHC_ICMPV6) += nhc_ghc_icmpv6.o
> diff --git a/net/6lowpan/nhc_ghc_icmpv6.c b/net/6lowpan/nhc_ghc_icmpv6.c
> new file mode 100644
> index 0000000..378ebfe
> --- /dev/null
> +++ b/net/6lowpan/nhc_ghc_icmpv6.c
> @@ -0,0 +1,27 @@
> +/*
> + *	6LoWPAN ICMPv6 compression according to RFC7400
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#include "nhc.h"
> +
> +#define LOWPAN_GHC_ICMPV6_IDLEN		1
> +#define LOWPAN_GHC_ICMPV6_ID_0		0xdf
> +#define LOWPAN_GHC_ICMPV6_MASK_0	0xff
> +
> +static void icmpv6_ghid_setup(struct lowpan_nhc *nhc)
> +{
> +	nhc->id[0] = LOWPAN_GHC_ICMPV6_ID_0;
> +	nhc->idmask[0] = LOWPAN_GHC_ICMPV6_MASK_0;
> +}
> +
> +LOWPAN_NHC(ghc_icmpv6, "RFC7400 ICMPv6", NEXTHDR_HOP, 0,

s/NEXTHDR_HOP/NEXTHDR_ICMP/

- Alex
