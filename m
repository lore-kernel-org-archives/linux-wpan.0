Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37998 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbbGWGHf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Jul 2015 02:07:35 -0400
Date: Thu, 23 Jul 2015 08:07:33 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC v2 1/4] 6lowpan: Introduce debugfs entry for 6lowpan module
Message-ID: <20150723060730.GA1941@omega>
References: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
 <1436788233-13960-2-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1436788233-13960-2-git-send-email-lukasz.duda@nordicsemi.no>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lukasz Duda <lukasz.duda@nordicsemi.no>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>

Hi,

I will try add review notes to your patch series at first.

On Mon, Jul 13, 2015 at 01:50:30PM +0200, Lukasz Duda wrote:
> Creating "6lowpan" debugfs entry (/sys/kernel/debugfs/6lowpan) for usage
> by 6lowpan module.
> 
> Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
> Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
> ---
>  include/net/6lowpan.h |  2 ++
>  net/6lowpan/iphc.c    | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
> index dc03d77..37ddbdf 100644
> --- a/include/net/6lowpan.h
> +++ b/include/net/6lowpan.h
> @@ -197,6 +197,8 @@
>  #define LOWPAN_NHC_UDP_CS_P_11	0xF3 /* source & dest = 0xF0B + 4bit inline */
>  #define LOWPAN_NHC_UDP_CS_C	0x04 /* checksum elided */
>  
> +extern struct dentry *lowpan_debugfs;
> +
>  #ifdef DEBUG
>  /* print data in line */
>  static inline void raw_dump_inline(const char *caller, char *msg,
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 9055d7b..c845a8a 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -50,12 +50,16 @@
>  #include <linux/if_arp.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
> +#include <linux/debugfs.h>
>  #include <net/6lowpan.h>
>  #include <net/ipv6.h>
>  #include <net/af_ieee802154.h>
>  
>  #include "nhc.h"
>  
> +struct dentry *lowpan_debugfs;
> +EXPORT_SYMBOL_GPL(lowpan_debugfs);
> +
>  /* Uncompress address function for source and
>   * destination address(non-multicast).
>   *
> @@ -613,6 +617,8 @@ EXPORT_SYMBOL_GPL(lowpan_header_compress);
>  
>  static int __init lowpan_module_init(void)
>  {
> +	lowpan_debugfs = debugfs_create_dir("6lowpan", NULL);
> +

add error handling here please.

>  	request_module_nowait("ipv6");
>  
>  	request_module_nowait("nhc_dest");
> @@ -625,6 +631,13 @@ static int __init lowpan_module_init(void)
>  
>  	return 0;
>  }
> +
> +static void __exit lowpan_module_exit(void)
> +{
> +	debugfs_remove(lowpan_debugfs);
> +}
> +
>  module_init(lowpan_module_init);
> +module_exit(lowpan_module_exit);
>  
>  MODULE_LICENSE("GPL");
> -- 
> 2.1.4
> 
