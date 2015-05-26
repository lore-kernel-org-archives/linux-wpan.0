Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38552 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbbEZM2c (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 08:28:32 -0400
Received: by wichy4 with SMTP id hy4so79664975wic.1
        for <linux-wpan@vger.kernel.org>; Tue, 26 May 2015 05:28:11 -0700 (PDT)
Date: Tue, 26 May 2015 14:04:30 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 1/4] mac802154: fix hold rtnl while ioctl
Message-ID: <20150526120350.GA27844@omega>
References: <1432309434-8215-1-git-send-email-alex.aring@gmail.com>
 <1432309434-8215-2-git-send-email-alex.aring@gmail.com>
 <20150525120940.GA21258@wantstofly.org>
 <F4B0D55C-BCEE-4E58-A89D-7546F6D63724@holtmann.org>
 <20150526073641.GQ11340@wantstofly.org>
 <20150526081506.GA1033@omega>
 <20150526082343.GB1033@omega>
 <20150526120036.GS11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150526120036.GS11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Tue, May 26, 2015 at 03:00:36PM +0300, Lennert Buytenhek wrote:
> On Tue, May 26, 2015 at 10:23:44AM +0200, Alexander Aring wrote:
> 
> > > > > > static int wext_ioctl_dispatch(struct net *net, struct ifreq *ifr,
> > > > > >                               unsigned int cmd, struct iw_request_info *info,
> > > > > >                               wext_ioctl_func standard,
> > > > > >                               wext_ioctl_func private)
> > > > > > {
> > > > > >        int ret = wext_permission_check(cmd);
> > > > > > 
> > > > > >        if (ret)
> > > > > >                return ret;
> > > > > > 
> > > > > >        dev_load(net, ifr->ifr_name);
> > > > > >        rtnl_lock();
> > > > > >        ret = wireless_process_ioctl(net, ifr, cmd, info, standard, private);
> > > > > >        rtnl_unlock();
> > > > > > 
> > > > > >        return ret;
> > > > > > }
> > > > > > 
> > > > > > leading to a double rtnl lock in mac802154_wpan_ioctl().
> > > > > > 
> > > > > > The easy fix would be to have mac802154_wpan_ioctl() check the ioctl
> > > > > > cmd before taking the rtnl -- I'm not too happy about the rtnl being
> > > > > > held or not held upon entry to a device ioctl depending on the ioctl
> > > > > > cmd and/or on who the caller is, but we might not be easily able to
> > > > > > change this...
> > > > > 
> > > > > I think the ioctl handler should just first check which are its valid
> > > > > ioctl and also enforce permission in that run without the RTNL lock
> > > > > held. Return -EINVAL or -ENOIOCTLCMD when it gets a cmd that this
> > > > > function does not handle. And then have the function actually take
> > > > > the RTNL lock and process its two ioctl that it supports.
> > > > > 
> > > > > That way we should avoid the nasty with taking the RTNL lock for
> > > > > unsupported ioctl.
> > > > 
> > > > Something like the below?  (Alexander?)  (I verified that it fixes
> > > > the problem for me.)
> > > > 
> > > 
> > > I can suggest also other solutions which are:
> > > 
> > >  - Remove the ndo_do_ioctl callback? If somebody wants to set address
> > >    things, they should use netlink. There is also some warn notice in the
> > >    callback "Using DEBUGing ioctl SIOCSIFADDR isn't recommended!\n",
> > >    which reports the user that he is not doing the right thing when
> > >    setting addresses via ioctl. That's very trustful.
> > > 
> > >    I know currently there is some function "mac802154_wpan_update_llsec"
> > >    which makes the security layer to work, because it's not called
> > >    when setting short/panid anywhere else. I would be happy if we can
> > >    "deactivate" the security layer -> removing old netlink interface and
> > >    then try to making an easy to use interface over nl802154 to access
> > >    the mib security entries. (I have started somewhere, but this is also
> > >    another thread to talk about access security attributes over
> > >    nl802154.
> > > 
> > > - Hold the rtnl lock only when the socket code is called. I insert this
> > >   code because somebody tried to ioctl a 802.15.4 socket and the lock
> > >   wasn't held. Maybe we can hold the rtnl lock in the caller, see [0].
> > 
> > besides I don't know why they use a check on ARPHRD there, a 802.15.4
> > socket can also be created on wpan intefaces only, which should be
> > checked at creating the socket or somewhere.
> 
> If you're talking about this code in net/ieee802154/socket.c:
> 
> ===
> static int ieee802154_dev_ioctl(struct sock *sk, struct ifreq __user *arg,
>                                 unsigned int cmd)
> {
>         struct ifreq ifr;
>         int ret = -ENOIOCTLCMD;
>         struct net_device *dev;
> 
>         if (copy_from_user(&ifr, arg, sizeof(struct ifreq)))
>                 return -EFAULT;
> 
>         ifr.ifr_name[IFNAMSIZ-1] = 0;
> 
>         dev_load(sock_net(sk), ifr.ifr_name);
>         dev = dev_get_by_name(sock_net(sk), ifr.ifr_name);
> 
>         if (!dev)
>                 return -ENODEV;
> 
>         if (dev->type == ARPHRD_IEEE802154 && dev->netdev_ops->ndo_do_ioctl)
>                 ret = dev->netdev_ops->ndo_do_ioctl(dev, &ifr, cmd);
> 
>         if (!ret && copy_to_user(arg, &ifr, sizeof(struct ifreq)))
>                 ret = -EFAULT;
>         dev_put(dev);
> 
>         return ret;
> }
> 
> static int ieee802154_sock_ioctl(struct socket *sock, unsigned int cmd,
>                                  unsigned long arg)
> {
>         struct sock *sk = sock->sk;
> 
>         switch (cmd) {
>         case SIOCGSTAMP:
>                 return sock_get_timestamp(sk, (struct timeval __user *)arg);
>         case SIOCGSTAMPNS:
>                 return sock_get_timestampns(sk, (struct timespec __user *)arg);
>         case SIOCGIFADDR:
>         case SIOCSIFADDR:
>                 return ieee802154_dev_ioctl(sk, (struct ifreq __user *)arg,
>                                 cmd);
>         default:
>                 if (!sk->sk_prot->ioctl)
>                         return -ENOIOCTLCMD;
>                 return sk->sk_prot->ioctl(sk, cmd, arg);
>         }
> }
> ===
> 
> The network namespace is taken from the 802.15.4 socket, but the device
> name is taken from the struct ifreq that's passed in, which does not
> necessarily refer to a 802.15.4 device.
> 

I see, okay.

> 
> > A general question and sorry for this unknowledge is that: is it normal
> > than a socket ioctl will call the netdev ioctl?
> 
> netdevice(7) has a note about this.  I think it's probably just because
> of historical reasons, because there is no 'dedicated' way of calling a
> netdev ioctl other than going through the socket (which, historically,
> means PF_INET) layer.  Not very clean at all, but this is unlikely to
> ever change at this point. :-/

ok.

- Alex
