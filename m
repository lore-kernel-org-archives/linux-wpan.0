Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:52594 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbbEYMJl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 25 May 2015 08:09:41 -0400
Date: Mon, 25 May 2015 15:09:40 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCHv2 bluetooth-next 1/4] mac802154: fix hold rtnl while ioctl
Message-ID: <20150525120940.GA21258@wantstofly.org>
References: <1432309434-8215-1-git-send-email-alex.aring@gmail.com>
 <1432309434-8215-2-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432309434-8215-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Marcel Holtmann <marcel@holtmann.org>

On Fri, May 22, 2015 at 05:43:51PM +0200, Alexander Aring wrote:

> This patch fixes an issue to set address configuration with ioctl.
> Accessing the mib requires rtnl lock and the ndo_do_ioctl doesn't hold
> the rtnl lock while this callback is called. This patch do that
> manually.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Reported-by: Matteo Petracca <matteo.petracca@sssup.it>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  net/mac802154/iface.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index 91b75ab..2a58788 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -62,8 +62,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>  		(struct sockaddr_ieee802154 *)&ifr->ifr_addr;
>  	int err = -ENOIOCTLCMD;
>  
> -	ASSERT_RTNL();
> -
> +	rtnl_lock();
>  	spin_lock_bh(&sdata->mib_lock);
>  
>  	switch (cmd) {
> @@ -90,6 +89,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>  	case SIOCSIFADDR:
>  		if (netif_running(dev)) {
>  			spin_unlock_bh(&sdata->mib_lock);
> +			rtnl_unlock();
>  			return -EBUSY;
>  		}
>  
> @@ -112,6 +112,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>  	}
>  
>  	spin_unlock_bh(&sdata->mib_lock);
> +	rtnl_unlock();
>  	return err;
>  }

This patch is causing rtnl recursion and deadlocks on my system.

A daemon running on my system (NetworkManager) tries calling
various wext ioctls on newly registered network interfaces,
including 802.15.4 interfaces, which are dispatched from dev_ioctl()
in net/core/dev_ioctl.c via wext_handle_ioctl() in
net/wireless/wext-core.c to wireless_process_ioctl() to
ioctl_standard_call() to ioctl_standard_iw_point() to
mac802154_wpan_ioctl(), and wext_ioctl_dispatch() does: 

static int wext_ioctl_dispatch(struct net *net, struct ifreq *ifr,
                               unsigned int cmd, struct iw_request_info *info,
                               wext_ioctl_func standard,
                               wext_ioctl_func private)
{
        int ret = wext_permission_check(cmd);

        if (ret)
                return ret;

        dev_load(net, ifr->ifr_name);
        rtnl_lock();
        ret = wireless_process_ioctl(net, ifr, cmd, info, standard, private);
        rtnl_unlock();

        return ret;
}

leading to a double rtnl lock in mac802154_wpan_ioctl().

The easy fix would be to have mac802154_wpan_ioctl() check the ioctl
cmd before taking the rtnl -- I'm not too happy about the rtnl being
held or not held upon entry to a device ioctl depending on the ioctl
cmd and/or on who the caller is, but we might not be easily able to
change this...
