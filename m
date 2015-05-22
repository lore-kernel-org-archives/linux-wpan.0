Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:52978 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756375AbbEVMPp (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 22 May 2015 08:15:45 -0400
Message-ID: <555F1DED.7080003@osg.samsung.com>
Date: Fri, 22 May 2015 14:15:41 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 1/4] mac802154: fix hold rtnl while ioctl
References: <1432285031-3360-1-git-send-email-alex.aring@gmail.com> <1432285031-3360-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1432285031-3360-2-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 22/05/15 10:57, Alexander Aring wrote:
> This patch fixes an issue to set address configuration with ioctl.
> Accessing the mib requires rtnl lock and the ndo_do_ioctl doesn't hold
> the rtnl lock while this callback is called. This patch do that
> manually.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Reported-by: Matteo Petracca <matteo.petracca@sssup.it>
> ---
>   net/mac802154/iface.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index 91b75ab..2a58788 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -62,8 +62,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>   		(struct sockaddr_ieee802154 *)&ifr->ifr_addr;
>   	int err = -ENOIOCTLCMD;
>   
> -	ASSERT_RTNL();
> -
> +	rtnl_lock();
>   	spin_lock_bh(&sdata->mib_lock);
>   
>   	switch (cmd) {
> @@ -90,6 +89,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>   	case SIOCSIFADDR:
>   		if (netif_running(dev)) {
>   			spin_unlock_bh(&sdata->mib_lock);
> +			rtnl_unlock();
>   			return -EBUSY;
>   		}
>   
> @@ -112,6 +112,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>   	}
>   
>   	spin_unlock_bh(&sdata->mib_lock);
> +	rtnl_unlock();
>   	return err;
>   }
>   
Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

This includes some smoke testing between two nodes (atusb and 
at86rf233), Basically ping6 with various sizes and a count of 1000 
pings. No problem showed up with these patches during the testing.

regards
Stefan Schmidt
