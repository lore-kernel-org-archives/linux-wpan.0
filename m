Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38474 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbIRVo0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 18 Sep 2015 17:44:26 -0400
Date: Fri, 18 Sep 2015 23:44:19 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 2/4] 6lowpan: add nhc module for GHC
 extension header detection
Message-ID: <20150918214415.GA6872@omega>
References: <1442577168-23183-1-git-send-email-stefan@osg.samsung.com>
 <1442577168-23183-3-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1442577168-23183-3-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org

Hi,

On Fri, Sep 18, 2015 at 01:52:46PM +0200, Stefan Schmidt wrote:
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  net/6lowpan/Kconfig                    |  5 +++++
>  net/6lowpan/Makefile                   |  3 +++
>  net/6lowpan/nhc_ghc_extension_header.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+)
>  create mode 100644 net/6lowpan/nhc_ghc_extension_header.c
> 
> diff --git a/net/6lowpan/Kconfig b/net/6lowpan/Kconfig
> index 6af7a46..f541f50 100644
> --- a/net/6lowpan/Kconfig
> +++ b/net/6lowpan/Kconfig
> @@ -59,4 +59,9 @@ config 6LOWPAN_NHC_UDP
>  	---help---
>  	  6LoWPAN IPv6 UDP Header compression according to RFC6282.
>  
> +config 6LOWPAN_GHC_EXTENSION_HEADER
> +	tristate "GHC Extension Header Support"
> +	default y
> +	---help---
> +
>  endif
> diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
> index c6ffc55..2b42bd0 100644
> --- a/net/6lowpan/Makefile
> +++ b/net/6lowpan/Makefile
> @@ -10,3 +10,6 @@ obj-$(CONFIG_6LOWPAN_NHC_IPV6) += nhc_ipv6.o
>  obj-$(CONFIG_6LOWPAN_NHC_MOBILITY) += nhc_mobility.o
>  obj-$(CONFIG_6LOWPAN_NHC_ROUTING) += nhc_routing.o
>  obj-$(CONFIG_6LOWPAN_NHC_UDP) += nhc_udp.o
> +
> +#rfc7400 ghcs
> +obj-$(CONFIG_6LOWPAN_GHC_EXTENSION_HEADER) += nhc_ghc_extension_header.o
> diff --git a/net/6lowpan/nhc_ghc_extension_header.c b/net/6lowpan/nhc_ghc_extension_header.c
> new file mode 100644
> index 0000000..eeeabfa
> --- /dev/null
> +++ b/net/6lowpan/nhc_ghc_extension_header.c
> @@ -0,0 +1,27 @@
> +/*
> + *	6LoWPAN Extension Header compression according to RFC7400
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
> + */
> +
> +#include "nhc.h"
> +
> +#define LOWPAN_GHC_EXTENSION_HEADER_IDLEN	1
> +#define LOWPAN_GHC_EXTENSION_HEADER_ID_0	0xb0
> +#define LOWPAN_GHC_EXTENSION_HEADER_MASK_0	0xf8
> +

Sorry,

This is actually wrong.

http://tools.ietf.org/html/rfc7400#section-3.2

describes the id with:

1 0 1 1 E I D H

whereas E I D is the same like

http://tools.ietf.org/html/rfc6282#section-4.2

So this header compression should be splitted in 5 modules for each
extension header:

1 0 1 1 0 0 0 NH -> Hop-by-Hop
1 0 1 1 0 0 1 NH -> Routing
1 0 1 1 0 1 0 NH -> Fragment
....

like we have it in the others extension headers for RFC6282.

Maybe make also the name smaller

LOWPAN_GHC_EXT_HDR_HOP_XXXX

use the same coding style like the others extension header modules.

also _maybe_ change the to module name "nhc_ghc_ext_hdr_foobar".

> +static void ext_ghid_setup(struct lowpan_nhc *nhc)
> +{
> +	nhc->id[0] = LOWPAN_GHC_EXTENSION_HEADER_ID_0;
> +	nhc->idmask[0] = LOWPAN_GHC_EXTENSION_HEADER_MASK_0;
> +}
> +
> +LOWPAN_NHC(ghc_extension_header, "RFC7400 Extension Header", NEXTHDR_HOP, 0,

Care about the right NEXTHDR_FOOBAR value here.

btw:

Something is wrong at iana registration:

https://www.iana.org/assignments/_6lowpan-parameters/_6lowpan-parameters.xhtml#lowpan_nhc

For RFC6282 they did each entry for each extension header, for GHC not.

Don't know why :-(

Also iana says it's

10110EEN whereas RFC7400 says it's 1011EIDN
    ^
    |
    I don't know where this bit comes from.

- Alex
