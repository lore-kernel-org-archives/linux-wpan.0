Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from demetra.cnit.it ([217.9.64.12]:51078 "EHLO mail.cnit.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751316AbdINNK7 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 14 Sep 2017 09:10:59 -0400
Date: Thu, 14 Sep 2017 13:03:20 +0000
Message-ID: <20170914130320.Horde.V6cTm9S8-dERpl3Ztcq_oA2@webmail.cnit.it>
From: ldimauro <ldimauro@cnit.it>
Subject: Re: IEEE80154 sockets problem with kernel 4.1.15
References: <20170727123925.Horde.wOM_gZTTS3ppRvU-NkGUfQ1@webmail.cnit.it>
 <CAOHTApg2Xt1vRbqZpMamQCuHxby5p7E4TA2ctx0sjR387PfHgQ@mail.gmail.com>
In-Reply-To: <CAOHTApg2Xt1vRbqZpMamQCuHxby5p7E4TA2ctx0sjR387PfHgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org

Dear all,
i've tried to change "iface.c" file, but when i try to do a network  
shell command (like "ifconfig"), system stall and doesn't accept any  
input.
The main problem is that I'm forced to use this kernel with this OS.

Do you have any solutions to offer?

Thank you,
Luca

Alexander Aring <aring@mojatatu.com> ha scritto:

> Hi,
>
> On Thu, Jul 27, 2017 at 8:39 AM, Luca Di Mauro <ldimauro@cnit.it> wrote:
>>
> ...
>>
>> But when I execute this code, kernel says to me following error messages:
>> RTNL: assertion failed at net/mac802154/iface.c (65)
>> CPU: 1 PID: 2023 Comm: main Not tainted 4.1.15-224528-gc28c3ac-dirty #3
>> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>> [<8001691c>] (unwind_backtrace) from [<80012748>] (show_stack+0x10/0x14)
>> [<80012748>] (show_stack) from [<807577a8>] (dump_stack+0x84/0xc4)
>> [<807577a8>] (dump_stack) from [<8074e41c>]
>> (mac802154_wpan_ioctl+0xf0/0x154)
>> [<8074e41c>] (mac802154_wpan_ioctl) from [<7f039744>]
>> (ieee802154_sock_ioctl+0x184/0x1f0 [ieee802154_socket])
>> [<7f039744>] (ieee802154_sock_ioctl [ieee802154_socket]) from [<805fcbf4>]
>> (sock_ioctl+0x1c0/0x294)
>> [<805fcbf4>] (sock_ioctl) from [<800f9dd0>] (do_vfs_ioctl+0x40c/0x5fc)
>> [<800f9dd0>] (do_vfs_ioctl) from [<800f9ff4>] (SyS_ioctl+0x34/0x5c)
>> [<800f9ff4>] (SyS_ioctl) from [<8000f480>] (ret_fast_syscall+0x0/0x3c)
>>
>> Do you have some tips to solve the problem?
>>
>
> Fixed by:
>
> 4a669f7d72535017dd03cbcdf5af6e85edfdf90c
>
>> I'm using Debian Jessie (downloaded here
>> http://www.variwiki.com/index.php?title=VAR-SOM-MX6_Debian_R2) with kernel
>> 4.1.15-224528-gc28c3ac-dirty.
>>
>
> Some patches didn't got into stable tree, we are still some
> experimental stack implementation.
> We don't recommended to run such old kernel.
>
> You maybe want to run git log $FILE on linus/master tree to see and
> maybe cherry-pick patches... don't report bugs/issues if you didn't
> test it on current bluetooth-next/master kernel before.
> Thank you.
>
> - Alex



