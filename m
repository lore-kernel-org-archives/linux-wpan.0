Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:39716 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbbEYPOr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 25 May 2015 11:14:47 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2 bluetooth-next 1/4] mac802154: fix hold rtnl while ioctl
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150525120940.GA21258@wantstofly.org>
Date: Mon, 25 May 2015 17:14:41 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <F4B0D55C-BCEE-4E58-A89D-7546F6D63724@holtmann.org>
References: <1432309434-8215-1-git-send-email-alex.aring@gmail.com> <1432309434-8215-2-git-send-email-alex.aring@gmail.com> <20150525120940.GA21258@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Lennert,

>> This patch fixes an issue to set address configuration with ioctl.
>> Accessing the mib requires rtnl lock and the ndo_do_ioctl doesn't hold
>> the rtnl lock while this callback is called. This patch do that
>> manually.
>> 
>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>> Reported-by: Matteo Petracca <matteo.petracca@sssup.it>
>> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
>> ---
>> net/mac802154/iface.c | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
>> index 91b75ab..2a58788 100644
>> --- a/net/mac802154/iface.c
>> +++ b/net/mac802154/iface.c
>> @@ -62,8 +62,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>> 		(struct sockaddr_ieee802154 *)&ifr->ifr_addr;
>> 	int err = -ENOIOCTLCMD;
>> 
>> -	ASSERT_RTNL();
>> -
>> +	rtnl_lock();
>> 	spin_lock_bh(&sdata->mib_lock);
>> 
>> 	switch (cmd) {
>> @@ -90,6 +89,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>> 	case SIOCSIFADDR:
>> 		if (netif_running(dev)) {
>> 			spin_unlock_bh(&sdata->mib_lock);
>> +			rtnl_unlock();
>> 			return -EBUSY;
>> 		}
>> 
>> @@ -112,6 +112,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>> 	}
>> 
>> 	spin_unlock_bh(&sdata->mib_lock);
>> +	rtnl_unlock();
>> 	return err;
>> }
> 
> This patch is causing rtnl recursion and deadlocks on my system.
> 
> A daemon running on my system (NetworkManager) tries calling
> various wext ioctls on newly registered network interfaces,
> including 802.15.4 interfaces, which are dispatched from dev_ioctl()
> in net/core/dev_ioctl.c via wext_handle_ioctl() in
> net/wireless/wext-core.c to wireless_process_ioctl() to
> ioctl_standard_call() to ioctl_standard_iw_point() to
> mac802154_wpan_ioctl(), and wext_ioctl_dispatch() does: 

I would really wish that NM stops this insanity with poking at all network interfaces. No wonder that people just end up removing it. First it tries to poke nl80211 and then complaints why modules are auto-loaded even without WiFi cards present and now it tries to poke at WEXT for non-WiFi interfaces.

> static int wext_ioctl_dispatch(struct net *net, struct ifreq *ifr,
>                               unsigned int cmd, struct iw_request_info *info,
>                               wext_ioctl_func standard,
>                               wext_ioctl_func private)
> {
>        int ret = wext_permission_check(cmd);
> 
>        if (ret)
>                return ret;
> 
>        dev_load(net, ifr->ifr_name);
>        rtnl_lock();
>        ret = wireless_process_ioctl(net, ifr, cmd, info, standard, private);
>        rtnl_unlock();
> 
>        return ret;
> }
> 
> leading to a double rtnl lock in mac802154_wpan_ioctl().
> 
> The easy fix would be to have mac802154_wpan_ioctl() check the ioctl
> cmd before taking the rtnl -- I'm not too happy about the rtnl being
> held or not held upon entry to a device ioctl depending on the ioctl
> cmd and/or on who the caller is, but we might not be easily able to
> change this...

I think the ioctl handler should just first check which are its valid ioctl and also enforce permission in that run without the RTNL lock held. Return -EINVAL or -ENOIOCTLCMD when it gets a cmd that this function does not handle. And then have the function actually take the RTNL lock and process its two ioctl that it supports.

That way we should avoid the nasty with taking the RTNL lock for unsupported ioctl. And hopefully at some point we can actually remove WEXT from the kernel. That it creates this nasty mess for other protocols is just insane.

Regards

Marcel

