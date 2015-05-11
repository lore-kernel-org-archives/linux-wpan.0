Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from sssup.it ([193.205.80.95]:33993 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422AbbEKQn1 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 May 2015 12:43:27 -0400
Message-ID: <5550DC2D.5060909@sssup.it>
Date: Mon, 11 May 2015 18:43:25 +0200
From: Matteo Petracca <matteo.petracca@sssup.it>
MIME-Version: 1.0
Subject: Re: Ieee802154 socket problem with SIOCGIFADDR
References: <554E1C92.7040306@sssup.it> <20150509164227.GA694@omega>
In-Reply-To: <20150509164227.GA694@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,
I've applied your patch, but I ma still getting error:

.353646] Hardware name: Generic AM33XX (Flattened Device Tree)
[   88.353742] [<c0011f35>] (unwind_backtrace) from [<c00101b5>] 
(show_stack+0x11/0x14)
[   88.353870] [<c00101b5>] (show_stack) from [<bf8292fb>] 
(mac802154_wpan_ioctl+0xbe/0x10c [mac802154])
[   88.353974] [<bf8292fb>] (mac802154_wpan_ioctl [mac802154]) from 
[<bf8a138f>] (ieee802154_sock_ioctl+0xf6/0x14c [ieee802154_socket])
[   88.354059] [<bf8a138f>] (ieee802154_sock_ioctl [ieee802154_socket]) 
from [<c05195fb>] (sock_ioctl+0xd3/0x1bc)
[   88.354109] [<c05195fb>] (sock_ioctl) from [<c00fca4d>] 
(do_vfs_ioctl+0x2cd/0x400)
[   88.354148] [<c00fca4d>] (do_vfs_ioctl) from [<c00fcbcd>] 
(SyS_ioctl+0x4d/0x58)
[   88.354188] [<c00fcbcd>] (SyS_ioctl) from [<c000d641>] 
(ret_fast_syscall+0x1/0x44)

Matteo

On 09/05/2015 18:42, Alexander Aring wrote:
> Hi,
>
> On Sat, May 09, 2015 at 04:41:22PM +0200, Matteo Petracca wrote:
>> Dear all,
>> I am working on a BeagleboneBlack with transceiver at86rf233.
>>
>> When using ieee802154 sockets in my code I have:
>>
>> ret = ioctl(socketfd, SIOCGIFADDR, &ifr);
>>
>> and everything works fine with kernel 3.8.13.
>>
>> In kernel 4.0.1 the request fails with the following kernel messages:
>>
>> [  846.038365] RTNL: assertion failed at net/mac802154/iface.c (65)
>> [  846.044629] CPU: 0 PID: 2350 Comm: test Not tainted 4.0.1-bone1 #1
>> [  846.044653] Hardware name: Generic AM33XX (Flattened Device Tree)
>> [  846.044747] [<c0011f35>] (unwind_backtrace) from [<c00101b5>]
>> (show_stack+0x11/0x14)
>> [  846.044876] [<c00101b5>] (show_stack) from [<bf8502f3>]
>> (mac802154_wpan_ioctl+0xb6/0x100 [mac802154])
>> [  846.044972] [<bf8502f3>] (mac802154_wpan_ioctl [mac802154]) from
>> [<bf8b738f>] (ieee802154_sock_ioctl+0xf6/0x14c [ieee802154_socket])
>> [  846.045044] [<bf8b738f>] (ieee802154_sock_ioctl [ieee802154_socket]) from
>> [<c05195fb>] (sock_ioctl+0xd3/0x1bc)
>> [  846.045094] [<c05195fb>] (sock_ioctl) from [<c00fca4d>]
>> (do_vfs_ioctl+0x2cd/0x400)
>> [  846.045133] [<c00fca4d>] (do_vfs_ioctl) from [<c00fcbcd>]
>> (SyS_ioctl+0x4d/0x58)
>> [  846.045172] [<c00fcbcd>] (SyS_ioctl) from [<c000d641>]
>> (ret_fast_syscall+0x1/0x44)
>>
>> Do you have any idea how to solve the problem?
>>
> I did this assertion there because I supposed that the rtnl lock is hold
> while calling this callback. Now I see it isn't...
>
> We need to hold the rtnl lock there because we accessing the mib values.
>
> Try this:
>
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index 91b75ab..2a58788 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -62,8 +62,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>                  (struct sockaddr_ieee802154 *)&ifr->ifr_addr;
>          int err = -ENOIOCTLCMD;
>   
> -       ASSERT_RTNL();
> -
> +       rtnl_lock();
>          spin_lock_bh(&sdata->mib_lock);
>   
>          switch (cmd) {
> @@ -90,6 +89,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>          case SIOCSIFADDR:
>                  if (netif_running(dev)) {
>                          spin_unlock_bh(&sdata->mib_lock);
> +                       rtnl_unlock();
>                          return -EBUSY;
>                  }
>   
> @@ -112,6 +112,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>          }
>   
>          spin_unlock_bh(&sdata->mib_lock);
> +       rtnl_unlock();
>          return err;
>   }
>
>
> I will put it in my queue for next patch series to remove the mib/pib
> spinlocks. We have only the rtnl lock now.
>
> - Alex

