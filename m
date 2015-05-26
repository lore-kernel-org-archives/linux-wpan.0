Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33023 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbbEZIPO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 04:15:14 -0400
Received: by wicmx19 with SMTP id mx19so57132202wic.0
        for <linux-wpan@vger.kernel.org>; Tue, 26 May 2015 01:15:13 -0700 (PDT)
Date: Tue, 26 May 2015 10:15:07 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 1/4] mac802154: fix hold rtnl while ioctl
Message-ID: <20150526081506.GA1033@omega>
References: <1432309434-8215-1-git-send-email-alex.aring@gmail.com>
 <1432309434-8215-2-git-send-email-alex.aring@gmail.com>
 <20150525120940.GA21258@wantstofly.org>
 <F4B0D55C-BCEE-4E58-A89D-7546F6D63724@holtmann.org>
 <20150526073641.GQ11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150526073641.GQ11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi,

On Tue, May 26, 2015 at 10:36:41AM +0300, Lennert Buytenhek wrote:
> On Mon, May 25, 2015 at 05:14:41PM +0200, Marcel Holtmann wrote:
> 
> > Hi Lennert,
> 
> Hi Marcel,
> 
> 
> > >> This patch fixes an issue to set address configuration with ioctl.
> > >> Accessing the mib requires rtnl lock and the ndo_do_ioctl doesn't hold
> > >> the rtnl lock while this callback is called. This patch do that
> > >> manually.
> > >> 
> > >> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > >> Reported-by: Matteo Petracca <matteo.petracca@sssup.it>
> > >> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> > >> ---
> > >> net/mac802154/iface.c | 5 +++--
> > >> 1 file changed, 3 insertions(+), 2 deletions(-)
> > >> 
> > >> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> > >> index 91b75ab..2a58788 100644
> > >> --- a/net/mac802154/iface.c
> > >> +++ b/net/mac802154/iface.c
> > >> @@ -62,8 +62,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> > >> 		(struct sockaddr_ieee802154 *)&ifr->ifr_addr;
> > >> 	int err = -ENOIOCTLCMD;
> > >> 
> > >> -	ASSERT_RTNL();
> > >> -
> > >> +	rtnl_lock();
> > >> 	spin_lock_bh(&sdata->mib_lock);
> > >> 
> > >> 	switch (cmd) {
> > >> @@ -90,6 +89,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> > >> 	case SIOCSIFADDR:
> > >> 		if (netif_running(dev)) {
> > >> 			spin_unlock_bh(&sdata->mib_lock);
> > >> +			rtnl_unlock();
> > >> 			return -EBUSY;
> > >> 		}
> > >> 
> > >> @@ -112,6 +112,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> > >> 	}
> > >> 
> > >> 	spin_unlock_bh(&sdata->mib_lock);
> > >> +	rtnl_unlock();
> > >> 	return err;
> > >> }
> > > 
> > > This patch is causing rtnl recursion and deadlocks on my system.
> > > 
> > > A daemon running on my system (NetworkManager) tries calling
> > > various wext ioctls on newly registered network interfaces,
> > > including 802.15.4 interfaces, which are dispatched from dev_ioctl()
> > > in net/core/dev_ioctl.c via wext_handle_ioctl() in
> > > net/wireless/wext-core.c to wireless_process_ioctl() to
> > > ioctl_standard_call() to ioctl_standard_iw_point() to
> > > mac802154_wpan_ioctl(), and wext_ioctl_dispatch() does: 
> > 
> > I would really wish that NM stops this insanity with poking at all
> > network interfaces. No wonder that people just end up removing it.
> > First it tries to poke nl80211 and then complaints why modules are
> > auto-loaded even without WiFi cards present and now it tries to poke
> > at WEXT for non-WiFi interfaces.
> 
> I can't say that I'm a NetworkManager fan myself... well, at least it's
> helping to make the kernel more robust in this case, I suppose. :(
> 
> 
> > > static int wext_ioctl_dispatch(struct net *net, struct ifreq *ifr,
> > >                               unsigned int cmd, struct iw_request_info *info,
> > >                               wext_ioctl_func standard,
> > >                               wext_ioctl_func private)
> > > {
> > >        int ret = wext_permission_check(cmd);
> > > 
> > >        if (ret)
> > >                return ret;
> > > 
> > >        dev_load(net, ifr->ifr_name);
> > >        rtnl_lock();
> > >        ret = wireless_process_ioctl(net, ifr, cmd, info, standard, private);
> > >        rtnl_unlock();
> > > 
> > >        return ret;
> > > }
> > > 
> > > leading to a double rtnl lock in mac802154_wpan_ioctl().
> > > 
> > > The easy fix would be to have mac802154_wpan_ioctl() check the ioctl
> > > cmd before taking the rtnl -- I'm not too happy about the rtnl being
> > > held or not held upon entry to a device ioctl depending on the ioctl
> > > cmd and/or on who the caller is, but we might not be easily able to
> > > change this...
> > 
> > I think the ioctl handler should just first check which are its valid
> > ioctl and also enforce permission in that run without the RTNL lock
> > held. Return -EINVAL or -ENOIOCTLCMD when it gets a cmd that this
> > function does not handle. And then have the function actually take
> > the RTNL lock and process its two ioctl that it supports.
> > 
> > That way we should avoid the nasty with taking the RTNL lock for
> > unsupported ioctl.
> 
> Something like the below?  (Alexander?)  (I verified that it fixes
> the problem for me.)
> 

I can suggest also other solutions which are:

 - Remove the ndo_do_ioctl callback? If somebody wants to set address
   things, they should use netlink. There is also some warn notice in the
   callback "Using DEBUGing ioctl SIOCSIFADDR isn't recommended!\n",
   which reports the user that he is not doing the right thing when
   setting addresses via ioctl. That's very trustful.

   I know currently there is some function "mac802154_wpan_update_llsec"
   which makes the security layer to work, because it's not called
   when setting short/panid anywhere else. I would be happy if we can
   "deactivate" the security layer -> removing old netlink interface and
   then try to making an easy to use interface over nl802154 to access
   the mib security entries. (I have started somewhere, but this is also
   another thread to talk about access security attributes over
   nl802154.

- Hold the rtnl lock only when the socket code is called. I insert this
  code because somebody tried to ioctl a 802.15.4 socket and the lock
  wasn't held. Maybe we can hold the rtnl lock in the caller, see [0].
  But this requires that all other callers hold the rtnl lock while
  calling this callback and I don't know if this is true.


Nevertheless your solutions will reduce to hold the rtnl_lock if not
necessary and fixes the nm issue. So you get a:

Acked-by: Alexander Aring <alex.aring@gmail.com>

If you see that to remove the ioctl it's a good idea (okay that's maybe
not a good idea because there are at least one user outside which use
this feature) you can send a patch for it.

> As to adding permission checks to the 802.15.4 subsystem, that's a
> whole 'nother undertaking -- for one, I can currently snoop on any
> 802.15.4 traffic going through the box (including 6LoWPAN traffic)
> as an unprivileged user, which is somewhat crazy -- but that's
> probably something for another email (thread).
>

oh.

> 
> > And hopefully at some point we can actually remove WEXT from the
> > kernel. That it creates this nasty mess for other protocols is just
> > insane.
> 
> I totally agree that the rtnl lock being held or not being held upon
> entering an ndo ioctl depending on what the ioctl cmd is is very bad,
> as this is just conditional locking which is bad in itself because
> of multiple reasons, and WEXT should be taken out and shot for causing
> this situation to be able to arise in the first place.
> 
> 
> 
> commit f5f4876bee64af07f6733d6bdb87ecb7e6fac85d
> Author: Lennert Buytenhek <buytenh@wantstofly.org>
> Date:   Tue May 26 08:53:33 2015 +0300
> 
>     mac802154: Avoid rtnl deadlock in mac802154_wpan_ioctl().
>     
>     ->ndo_do_ioctl() can be entered with the rtnl lock already held,
>     for example when sending a wext ioctl to a device (in which case
>     the rtnl lock is taken by wext_ioctl_dispatch()), but
>     mac802154_wpan_ioctl() currently unconditionally takes the rtnl
>     lock on entry, which can cause deadlocks.
>     
>     To fix this, bail out of mac802154_wpan_ioctl() before taking the
>     rtnl lock if the ioctl cmd is not one of the cmds we implement.
>     
>     Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> 
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index f30788d..b544b5d 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -62,6 +62,9 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>  		(struct sockaddr_ieee802154 *)&ifr->ifr_addr;
>  	int err = -ENOIOCTLCMD;
>  
> +	if (cmd != SIOCGIFADDR && cmd != SIOCSIFADDR)
> +		return err;
> +
>  	rtnl_lock();
>  
>  	switch (cmd) {

- Alex

[0] http://lxr.free-electrons.com/source/net/ieee802154/socket.c#L152
