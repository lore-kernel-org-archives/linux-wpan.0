Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from sssup.it ([193.205.80.95]:62621 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087AbbELIc6 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 12 May 2015 04:32:58 -0400
Message-ID: <5551BAB9.9000101@sssup.it>
Date: Tue, 12 May 2015 10:32:57 +0200
From: Matteo Petracca <matteo.petracca@sssup.it>
MIME-Version: 1.0
Subject: Re: Ieee802154 socket problem with SIOCGIFADDR
References: <554E1C92.7040306@sssup.it> <20150509164227.GA694@omega> <5550DC2D.5060909@sssup.it> <20150511175141.GA7965@omega>
In-Reply-To: <20150511175141.GA7965@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

I've applied your patch properly.

By using your example this is what I have with kernel 4.0.2 for
beagleboneblack

[   44.362497] NET: Registered protocol family 36
[   44.369646] RTNL: assertion failed at net/mac802154/iface.c (65)
[   44.375894] CPU: 0 PID: 1166 Comm: a.out Not tainted 4.0.2-bone1 #1
[   44.375917] Hardware name: Generic AM33XX (Flattened Device Tree)
[   44.376010] [<c0011f55>] (unwind_backtrace) from [<c00101c9>] 
(show_stack+0x11/0x14)
[   44.376126] [<c00101c9>] (show_stack) from [<bf8982fb>] 
(mac802154_wpan_ioctl+0xbe/0x10c [mac802154])
[   44.376237] [<bf8982fb>] (mac802154_wpan_ioctl [mac802154]) from 
[<bf8ac38f>] (ieee802154_sock_ioctl+0xf6/0x14c [ieee802154_socket])
[   44.376311] [<bf8ac38f>] (ieee802154_sock_ioctl [ieee802154_socket]) 
from [<c051996b>] (sock_ioctl+0xd3/0x1bc)
[   44.376360] [<c051996b>] (sock_ioctl) from [<c00fcad9>] 
(do_vfs_ioctl+0x2cd/0x400)
[   44.376398] [<c00fcad9>] (do_vfs_ioctl) from [<c00fcc59>] 
(SyS_ioctl+0x4d/0x58)
[   44.376436] [<c00fcc59>] (SyS_ioctl) from [<c000d641>] 
(ret_fast_syscall+0x1/0x44)

It is just using the code that you sent me yesterday.

Matteo


On 11/05/2015 19:51, Alexander Aring wrote:
> On Mon, May 11, 2015 at 06:43:25PM +0200, Matteo Petracca wrote:
>> Hi,
>> I've applied your patch, but I ma still getting error:
>>
>> .353646] Hardware name: Generic AM33XX (Flattened Device Tree)
>> [   88.353742] [<c0011f35>] (unwind_backtrace) from [<c00101b5>]
>> (show_stack+0x11/0x14)
>> [   88.353870] [<c00101b5>] (show_stack) from [<bf8292fb>]
>> (mac802154_wpan_ioctl+0xbe/0x10c [mac802154])
>> [   88.353974] [<bf8292fb>] (mac802154_wpan_ioctl [mac802154]) from
>> [<bf8a138f>] (ieee802154_sock_ioctl+0xf6/0x14c [ieee802154_socket])
>> [   88.354059] [<bf8a138f>] (ieee802154_sock_ioctl [ieee802154_socket]) from
>> [<c05195fb>] (sock_ioctl+0xd3/0x1bc)
>> [   88.354109] [<c05195fb>] (sock_ioctl) from [<c00fca4d>]
>> (do_vfs_ioctl+0x2cd/0x400)
>> [   88.354148] [<c00fca4d>] (do_vfs_ioctl) from [<c00fcbcd>]
>> (SyS_ioctl+0x4d/0x58)
>> [   88.354188] [<c00fcbcd>] (SyS_ioctl) from [<c000d641>]
>> (ret_fast_syscall+0x1/0x44)
> maybe you did the wrong order and call rtnl_lock() after
> spin_lock_bh(&sdata->mib_lock). When I do that then I get the following:
>
> [   35.581616] ------------[ cut here ]------------
> [   35.586553] WARNING: CPU: 0 PID: 1236 at kernel/locking/mutex.c:734 __mutex_unlock_slowpath+0x180/0x1a4()
> [   35.596767] DEBUG_LOCKS_WARN_ON(in_interrupt())
> [   35.601392] Modules linked in:
> [   35.604814] CPU: 0 PID: 1236 Comm: a.out Not tainted 4.1.0-rc1-00069-g1add156-dirty #856
> [   35.613322] Hardware name: Generic AM33XX (Flattened Device Tree)
> [   35.619777] [<c0016534>] (unwind_backtrace) from [<c001308c>] (show_stack+0x10/0x14)
> [   35.627906] [<c001308c>] (show_stack) from [<c0638800>] (dump_stack+0x84/0x9c)
> [   35.635542] [<c0638800>] (dump_stack) from [<c003ffc4>] (warn_slowpath_common+0x7c/0xb8)
> [   35.644069] [<c003ffc4>] (warn_slowpath_common) from [<c0040030>] (warn_slowpath_fmt+0x30/0x40)
> [   35.653237] [<c0040030>] (warn_slowpath_fmt) from [<c063d6d4>] (__mutex_unlock_slowpath+0x180/0x1a4)
> [   35.662867] [<c063d6d4>] (__mutex_unlock_slowpath) from [<c04ec874>] (netdev_run_todo+0x38/0x2a0)
> [   35.672243] [<c04ec874>] (netdev_run_todo) from [<c062c5f4>] (mac802154_wpan_ioctl+0x70/0x13c)
> [   35.681324] [<c062c5f4>] (mac802154_wpan_ioctl) from [<c0628ecc>] (ieee802154_sock_ioctl+0x194/0x204)
> [   35.691047] [<c0628ecc>] (ieee802154_sock_ioctl) from [<c04ccc54>] (sock_ioctl+0x1c8/0x2a4)
> [   35.699856] [<c04ccc54>] (sock_ioctl) from [<c0159988>] (do_vfs_ioctl+0x408/0x670)
> [   35.707799] [<c0159988>] (do_vfs_ioctl) from [<c0159c5c>] (SyS_ioctl+0x6c/0x7c)
> [   35.715527] [<c0159c5c>] (SyS_ioctl) from [<c000f520>] (ret_fast_syscall+0x0/0x4c)
> [   35.723507] ---[ end trace eba2e6f7e74c5074 ]---
>
>
> So please check that your rtnl_lock() is before spin_lock_bh(&sdata->mib_lock).
>
> I recently send patches to remove the pib/mib lock it's enough to
> locking everything is locked over rtnl (which is fix behaviour when
> somebody tries to ifup and set addresses at the same time) and the most
> mib values are readonly while ifup. I hope this will reduce the current
> locking complexity a lot.
>
> - Alex

