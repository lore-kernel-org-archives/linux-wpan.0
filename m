Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:43641 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031177AbeBNPYF (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 14 Feb 2018 10:24:05 -0500
Subject: Re: [PATCH wpan-next] ieee802154: 6lowpan: set IFF_NO_QUEUE
References: <20180212035046.11550-1-aring@mojatatu.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <daffa08e-e961-ea62-317c-63428ef9fa70@osg.samsung.com>
Date: Wed, 14 Feb 2018 16:23:59 +0100
MIME-Version: 1.0
In-Reply-To: <20180212035046.11550-1-aring@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com

Hello.


On 02/12/2018 04:50 AM, Alexander Aring wrote:
> This patch sets the IFF_NO_QUEUE for IEEE 802.15.4 6lowpan interfaces. As
> commit 24dcbf662205 ("6lowpan: Don't set IFF_NO_QUEUE") removes it for
> "reasons" from the bluetooth 6lowpan subsystem. In IEEE 802.15.4 the lower
> interface deals with one qdisc for the real hardware, 6LoWPAN does the
> protocol adaption only and no second queuing on top.
>
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> ---
>  net/ieee802154/6lowpan/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> index 974765b7d92a..e4f305320519 100644
> --- a/net/ieee802154/6lowpan/core.c
> +++ b/net/ieee802154/6lowpan/core.c
> @@ -104,6 +104,7 @@ static void lowpan_setup(struct net_device *ldev)
>  	/* We need an ipv6hdr as minimum len when calling xmit */
>  	ldev->hard_header_len	= sizeof(struct ipv6hdr);
>  	ldev->flags		= IFF_BROADCAST | IFF_MULTICAST;
> +	ldev->priv_flags	|= IFF_NO_QUEUE;
>  
>  	ldev->netdev_ops	= &lowpan_netdev_ops;
>  	ldev->header_ops	= &lowpan_header_ops;

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
