Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37909 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbbKLREm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 12 Nov 2015 12:04:42 -0500
Date: Thu, 12 Nov 2015 18:04:35 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 1/4] 6lowpan: add debugfs support
Message-ID: <20151112170430.GA884@omega>
References: <1447262079-2509-1-git-send-email-alex.aring@gmail.com>
 <1447262079-2509-2-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1447262079-2509-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, mcr@sandelman.ca, lukasz.duda@nordicsemi.no, martin.gergeleit@hs-rm.de

On Wed, Nov 11, 2015 at 06:14:36PM +0100, Alexander Aring wrote:
...
> +config 6LOWPAN_DEBUGFS
> +	bool "6LoWPAN debugfs support"
> +	depends on 6LOWPAN

missing:

depends on DEBUG_FS

> +	---help---
> +	  This enables 6LoWPAN debugfs support. For example to manipulate
> +	  IPHC context information at runtime.
> +
>  menuconfig 6LOWPAN_NHC
>  	tristate "Next Header Compression Support"
>  	depends on 6LOWPAN
> diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
> index c6ffc55..54cad8d 100644
> --- a/net/6lowpan/Makefile
> +++ b/net/6lowpan/Makefile
> @@ -1,6 +1,7 @@
>  obj-$(CONFIG_6LOWPAN) += 6lowpan.o
>  
>  6lowpan-y := core.o iphc.o nhc.o
> +6lowpan-$(CONFIG_6LOWPAN_DEBUGFS) += debugfs.o
...
> +
> +int lowpan_dev_debugfs_init(struct net_device *dev)
> +{
> +	static struct dentry *iface;
> +
> +	/* creating the root */
> +	iface = debugfs_create_dir(dev->name, lowpan_debugfs);
> +	if (!iface)
> +		goto fail;
> +
> +	return 0;
> +
> +fail:
> +	lowpan_debugfs_exit();

This is broken, this will delete everything also the
"$DEBUGFS_MOUNTPOINT/6lowpan" directory. What we need is a
debugfs_remove_recursive(iface); call here, which deletes everything
which is registered at iface dentry.

Also we need to call this when a lowpan interface will be unregistered,
otherwise we have still the debugfs entries when an interface doesn't
exist anymore.

I will fix this issues for the next try.

- Alex
