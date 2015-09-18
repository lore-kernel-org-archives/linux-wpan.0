Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33917 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbbIRVuc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 18 Sep 2015 17:50:32 -0400
Date: Fri, 18 Sep 2015 23:50:29 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 3/4] 6lowpan: add nhc module for GHC UDP
 detection
Message-ID: <20150918215025.GB6872@omega>
References: <1442577168-23183-1-git-send-email-stefan@osg.samsung.com>
 <1442577168-23183-4-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1442577168-23183-4-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org

On Fri, Sep 18, 2015 at 01:52:47PM +0200, Stefan Schmidt wrote:
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  net/6lowpan/Kconfig       |  5 +++++
>  net/6lowpan/Makefile      |  1 +
>  net/6lowpan/nhc_ghc_udp.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+)
>  create mode 100644 net/6lowpan/nhc_ghc_udp.c
> 
> diff --git a/net/6lowpan/Kconfig b/net/6lowpan/Kconfig
> index f541f50..67a786b 100644
> --- a/net/6lowpan/Kconfig
> +++ b/net/6lowpan/Kconfig
> @@ -64,4 +64,9 @@ config 6LOWPAN_GHC_EXTENSION_HEADER
>  	default y
>  	---help---
>  
> +config 6LOWPAN_GHC_UDP
> +	tristate "GHC UDP Support"
> +	default y
> +	---help---
> +
>  endif
> diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
> index 2b42bd0..fc65efb 100644
> --- a/net/6lowpan/Makefile
> +++ b/net/6lowpan/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_6LOWPAN_NHC_UDP) += nhc_udp.o
>  
>  #rfc7400 ghcs
>  obj-$(CONFIG_6LOWPAN_GHC_EXTENSION_HEADER) += nhc_ghc_extension_header.o
> +obj-$(CONFIG_6LOWPAN_GHC_UDP) += nhc_ghc_udp.o
> diff --git a/net/6lowpan/nhc_ghc_udp.c b/net/6lowpan/nhc_ghc_udp.c
> new file mode 100644
> index 0000000..2675683
> --- /dev/null
> +++ b/net/6lowpan/nhc_ghc_udp.c
> @@ -0,0 +1,27 @@
> +/*
> + *	6LoWPAN UDP compression according to RFC7400
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#include "nhc.h"
> +
> +#define LOWPAN_GHC_UDP_IDLEN	1
> +#define LOWPAN_GHC_UDP_ID_0	0xd0
> +#define LOWPAN_GHC_UDP_MASK_0	0xf8
> +
> +static void udp_ghid_setup(struct lowpan_nhc *nhc)
> +{
> +	nhc->id[0] = LOWPAN_GHC_UDP_ID_0;
> +	nhc->idmask[0] = LOWPAN_GHC_UDP_MASK_0;
> +}
> +
> +LOWPAN_NHC(ghc_udp, "RFC7400 UDP", NEXTHDR_HOP, 0,

s/NEXTHDR_HOP/NEXTHDR_UDP/

Sadly is that we can't load two modules which contains NEXTHDR_UDP, when
another NEXTHDR_UDP is registered. But we should support all nhcid's
for receving side.

Maybe we can simple remove the check if nexthdr for compression
(tranmsit side) is already registered, actually this returns -EBUSY. We
prior for compression then the first loaded module (which should have a
compression method).

The real solution would be some configurable netlink framework. :-)

- Alex
