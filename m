Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:41911 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613AbcDKQzF (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Apr 2016 12:55:05 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH bluetooth-next 10/11] 6lowpan: add lowpan_is_ll function
References: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
 <1460365464-12435-11-git-send-email-aar@pengutronix.de>
Message-ID: <570BD6E5.4080807@osg.samsung.com>
Date: Mon, 11 Apr 2016 18:55:01 +0200
MIME-Version: 1.0
In-Reply-To: <1460365464-12435-11-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com

Hello.

On 11/04/16 11:04, Alexander Aring wrote:
> This patch adds the lowpan_is_ll function, which can be used to make a
> special 6lowpan linklayer handling for a specific 6lowpan linklayer
> type.
>
> Signed-off-by: Alexander Aring<aar@pengutronix.de>
> ---
>   net/6lowpan/6lowpan_i.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/net/6lowpan/6lowpan_i.h b/net/6lowpan/6lowpan_i.h
> index d16bb4b..97ecc27 100644
> --- a/net/6lowpan/6lowpan_i.h
> +++ b/net/6lowpan/6lowpan_i.h
> @@ -3,6 +3,15 @@
>   
>   #include <linux/netdevice.h>
>   
> +#include <net/6lowpan.h>
> +
> +/* caller need to be sure it's dev->type is ARPHRD_6LOWPAN */
> +static inline bool lowpan_is_ll(const struct net_device *dev,
> +				enum lowpan_lltypes lltype)
> +{
> +	return lowpan_dev(dev)->lltype == lltype;
> +}
> +
>   #ifdef CONFIG_6LOWPAN_DEBUGFS
>   int lowpan_dev_debugfs_init(struct net_device *dev);
>   void lowpan_dev_debugfs_exit(struct net_device *dev);

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>

regards
Stefan Schmidt


