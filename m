Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:53036 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbbEZORE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 10:17:04 -0400
Date: Tue, 26 May 2015 14:51:00 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCHv2 bluetooth-next 1/4] mac802154: fix hold rtnl while ioctl
Message-ID: <20150526115100.GR11340@wantstofly.org>
References: <1432309434-8215-1-git-send-email-alex.aring@gmail.com>
 <1432309434-8215-2-git-send-email-alex.aring@gmail.com>
 <20150525120940.GA21258@wantstofly.org>
 <F4B0D55C-BCEE-4E58-A89D-7546F6D63724@holtmann.org>
 <20150526073641.GQ11340@wantstofly.org>
 <20150526081506.GA1033@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150526081506.GA1033@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Tue, May 26, 2015 at 10:15:07AM +0200, Alexander Aring wrote:

> Hi,

Hello!


> > > > static int wext_ioctl_dispatch(struct net *net, struct ifreq *ifr,
> > > >                               unsigned int cmd, struct iw_request_info *info,
> > > >                               wext_ioctl_func standard,
> > > >                               wext_ioctl_func private)
> > > > {
> > > >        int ret = wext_permission_check(cmd);
> > > > 
> > > >        if (ret)
> > > >                return ret;
> > > > 
> > > >        dev_load(net, ifr->ifr_name);
> > > >        rtnl_lock();
> > > >        ret = wireless_process_ioctl(net, ifr, cmd, info, standard, private);
> > > >        rtnl_unlock();
> > > > 
> > > >        return ret;
> > > > }
> > > > 
> > > > leading to a double rtnl lock in mac802154_wpan_ioctl().
> > > > 
> > > > The easy fix would be to have mac802154_wpan_ioctl() check the ioctl
> > > > cmd before taking the rtnl -- I'm not too happy about the rtnl being
> > > > held or not held upon entry to a device ioctl depending on the ioctl
> > > > cmd and/or on who the caller is, but we might not be easily able to
> > > > change this...
> > > 
> > > I think the ioctl handler should just first check which are its valid
> > > ioctl and also enforce permission in that run without the RTNL lock
> > > held. Return -EINVAL or -ENOIOCTLCMD when it gets a cmd that this
> > > function does not handle. And then have the function actually take
> > > the RTNL lock and process its two ioctl that it supports.
> > > 
> > > That way we should avoid the nasty with taking the RTNL lock for
> > > unsupported ioctl.
> > 
> > Something like the below?  (Alexander?)  (I verified that it fixes
> > the problem for me.)
> 
> I can suggest also other solutions which are:
> 
>  - Remove the ndo_do_ioctl callback? If somebody wants to set address
>    things, they should use netlink. There is also some warn notice in the
>    callback "Using DEBUGing ioctl SIOCSIFADDR isn't recommended!\n",
>    which reports the user that he is not doing the right thing when
>    setting addresses via ioctl. That's very trustful.

[...]


>    I know currently there is some function "mac802154_wpan_update_llsec"
>    which makes the security layer to work, because it's not called
>    when setting short/panid anywhere else. I would be happy if we can
>    "deactivate" the security layer -> removing old netlink interface and
>    then try to making an easy to use interface over nl802154 to access
>    the mib security entries. (I have started somewhere, but this is also
>    another thread to talk about access security attributes over
>    nl802154.

I haven't looked at this particular aspect too closely, so I'm not
really able to comment on this right now.


> - Hold the rtnl lock only when the socket code is called. I insert this
>   code because somebody tried to ioctl a 802.15.4 socket and the lock
>   wasn't held. Maybe we can hold the rtnl lock in the caller, see [0].
>   But this requires that all other callers hold the rtnl lock while
>   calling this callback and I don't know if this is true.

I think that it makes sense to keep the invariant that upon entry
of an ioctl, no locks are guaranteed to be held.  WEXT violates this
principle, but I would say that the WEXT behavior is undesirable, as
it's not a good thing to take a bunch of locks just in case a callee
might need them, and it will cause code to be written that will
(silently) depend on these assumptions and it will be hard to untangle
those dependencies later on, or even impossible to do in case it
becomes part of an API/ABI (like it is now in the WEXT case).


> Nevertheless your solutions will reduce to hold the rtnl_lock if not
> necessary and fixes the nm issue. So you get a:
> 
> Acked-by: Alexander Aring <alex.aring@gmail.com>

Cool, I'll do this and submit it.


> If you see that to remove the ioctl it's a good idea (okay that's maybe
> not a good idea because there are at least one user outside which use
> this feature) you can send a patch for it.

I agree that this ioctl is an ugly wart, and that it should probably
be scheduled to be removed entirely.  Do you have visibility into
what userspace code might be using this -- I know that there's a
zigbee stack, but I don't think we can see it?
