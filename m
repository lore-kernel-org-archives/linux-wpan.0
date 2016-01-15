Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:45644 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbcAOOj4 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 15 Jan 2016 09:39:56 -0500
Subject: Re: [PATCH bluetooth-next 2/2] ieee802154: 6lowpan: fix return of
 netdev notifier
References: <1452459025-13884-1-git-send-email-alex.aring@gmail.com>
 <1452459025-13884-3-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <569904B9.7080908@osg.samsung.com>
Date: Fri, 15 Jan 2016 15:39:53 +0100
MIME-Version: 1.0
In-Reply-To: <1452459025-13884-3-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, mcr@sandelman.ca, lukasz.duda@nordicsemi.no

Hello.

On 10/01/16 21:50, Alexander Aring wrote:
> This patch fixed the return value of netdev notifier. If the command is
> a don't care a NOTIFY_DONE should be returned. If the command matched a
> NOTIFY_OK should be returned.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   net/ieee802154/6lowpan/core.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> index 737c87a..0023c90 100644
> --- a/net/ieee802154/6lowpan/core.c
> +++ b/net/ieee802154/6lowpan/core.c
> @@ -207,7 +207,7 @@ static int lowpan_device_event(struct notifier_block *unused,
>   	struct net_device *wdev = netdev_notifier_info_to_dev(ptr);
>   
>   	if (wdev->type != ARPHRD_IEEE802154)
> -		goto out;
> +		return NOTIFY_DONE;
>   
>   	switch (event) {
>   	case NETDEV_UNREGISTER:
> @@ -219,11 +219,10 @@ static int lowpan_device_event(struct notifier_block *unused,
>   			lowpan_dellink(wdev->ieee802154_ptr->lowpan_dev, NULL);
>   		break;
>   	default:
> -		break;
> +		return NOTIFY_DONE;
>   	}
>   
> -out:
> -	return NOTIFY_DONE;
> +	return NOTIFY_OK;
>   }
>   
>   static struct notifier_block lowpan_dev_notifier = {

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt

