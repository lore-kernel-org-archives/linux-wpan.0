Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34634 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbbEKRvy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 11 May 2015 13:51:54 -0400
Received: by wicmc15 with SMTP id mc15so34028363wic.1
        for <linux-wpan@vger.kernel.org>; Mon, 11 May 2015 10:51:53 -0700 (PDT)
Date: Mon, 11 May 2015 19:51:46 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Ieee802154 socket problem with SIOCGIFADDR
Message-ID: <20150511175141.GA7965@omega>
References: <554E1C92.7040306@sssup.it>
 <20150509164227.GA694@omega>
 <5550DC2D.5060909@sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5550DC2D.5060909@sssup.it>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matteo Petracca <matteo.petracca@sssup.it>
Cc: linux-wpan@vger.kernel.org

On Mon, May 11, 2015 at 06:43:25PM +0200, Matteo Petracca wrote:
> Hi,
> I've applied your patch, but I ma still getting error:
> 
> .353646] Hardware name: Generic AM33XX (Flattened Device Tree)
> [   88.353742] [<c0011f35>] (unwind_backtrace) from [<c00101b5>]
> (show_stack+0x11/0x14)
> [   88.353870] [<c00101b5>] (show_stack) from [<bf8292fb>]
> (mac802154_wpan_ioctl+0xbe/0x10c [mac802154])
> [   88.353974] [<bf8292fb>] (mac802154_wpan_ioctl [mac802154]) from
> [<bf8a138f>] (ieee802154_sock_ioctl+0xf6/0x14c [ieee802154_socket])
> [   88.354059] [<bf8a138f>] (ieee802154_sock_ioctl [ieee802154_socket]) from
> [<c05195fb>] (sock_ioctl+0xd3/0x1bc)
> [   88.354109] [<c05195fb>] (sock_ioctl) from [<c00fca4d>]
> (do_vfs_ioctl+0x2cd/0x400)
> [   88.354148] [<c00fca4d>] (do_vfs_ioctl) from [<c00fcbcd>]
> (SyS_ioctl+0x4d/0x58)
> [   88.354188] [<c00fcbcd>] (SyS_ioctl) from [<c000d641>]
> (ret_fast_syscall+0x1/0x44)

maybe you did the wrong order and call rtnl_lock() after
spin_lock_bh(&sdata->mib_lock). When I do that then I get the following:

[   35.581616] ------------[ cut here ]------------
[   35.586553] WARNING: CPU: 0 PID: 1236 at kernel/locking/mutex.c:734 __mutex_unlock_slowpath+0x180/0x1a4()
[   35.596767] DEBUG_LOCKS_WARN_ON(in_interrupt())
[   35.601392] Modules linked in:
[   35.604814] CPU: 0 PID: 1236 Comm: a.out Not tainted 4.1.0-rc1-00069-g1add156-dirty #856
[   35.613322] Hardware name: Generic AM33XX (Flattened Device Tree)
[   35.619777] [<c0016534>] (unwind_backtrace) from [<c001308c>] (show_stack+0x10/0x14)
[   35.627906] [<c001308c>] (show_stack) from [<c0638800>] (dump_stack+0x84/0x9c)
[   35.635542] [<c0638800>] (dump_stack) from [<c003ffc4>] (warn_slowpath_common+0x7c/0xb8)
[   35.644069] [<c003ffc4>] (warn_slowpath_common) from [<c0040030>] (warn_slowpath_fmt+0x30/0x40)
[   35.653237] [<c0040030>] (warn_slowpath_fmt) from [<c063d6d4>] (__mutex_unlock_slowpath+0x180/0x1a4)
[   35.662867] [<c063d6d4>] (__mutex_unlock_slowpath) from [<c04ec874>] (netdev_run_todo+0x38/0x2a0)
[   35.672243] [<c04ec874>] (netdev_run_todo) from [<c062c5f4>] (mac802154_wpan_ioctl+0x70/0x13c)
[   35.681324] [<c062c5f4>] (mac802154_wpan_ioctl) from [<c0628ecc>] (ieee802154_sock_ioctl+0x194/0x204)
[   35.691047] [<c0628ecc>] (ieee802154_sock_ioctl) from [<c04ccc54>] (sock_ioctl+0x1c8/0x2a4)
[   35.699856] [<c04ccc54>] (sock_ioctl) from [<c0159988>] (do_vfs_ioctl+0x408/0x670)
[   35.707799] [<c0159988>] (do_vfs_ioctl) from [<c0159c5c>] (SyS_ioctl+0x6c/0x7c)
[   35.715527] [<c0159c5c>] (SyS_ioctl) from [<c000f520>] (ret_fast_syscall+0x0/0x4c)
[   35.723507] ---[ end trace eba2e6f7e74c5074 ]---


So please check that your rtnl_lock() is before spin_lock_bh(&sdata->mib_lock).

I recently send patches to remove the pib/mib lock it's enough to
locking everything is locked over rtnl (which is fix behaviour when
somebody tries to ifup and set addresses at the same time) and the most
mib values are readonly while ifup. I hope this will reduce the current
locking complexity a lot.

- Alex
