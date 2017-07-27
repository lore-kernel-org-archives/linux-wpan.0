Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36622 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbdG0Ndf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 27 Jul 2017 09:33:35 -0400
Received: by mail-wm0-f45.google.com with SMTP id t201so99537192wmt.1
        for <linux-wpan@vger.kernel.org>; Thu, 27 Jul 2017 06:33:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170727123925.Horde.wOM_gZTTS3ppRvU-NkGUfQ1@webmail.cnit.it>
References: <20170727123925.Horde.wOM_gZTTS3ppRvU-NkGUfQ1@webmail.cnit.it>
From: Alexander Aring <aring@mojatatu.com>
Date: Thu, 27 Jul 2017 09:33:33 -0400
Message-ID: <CAOHTApg2Xt1vRbqZpMamQCuHxby5p7E4TA2ctx0sjR387PfHgQ@mail.gmail.com>
Subject: Re: IEEE80154 sockets problem with kernel 4.1.15
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luca Di Mauro <ldimauro@cnit.it>
Cc: linux-wpan@vger.kernel.org

Hi,

On Thu, Jul 27, 2017 at 8:39 AM, Luca Di Mauro <ldimauro@cnit.it> wrote:
>
...
>
> But when I execute this code, kernel says to me following error messages:
> RTNL: assertion failed at net/mac802154/iface.c (65)
> CPU: 1 PID: 2023 Comm: main Not tainted 4.1.15-224528-gc28c3ac-dirty #3
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [<8001691c>] (unwind_backtrace) from [<80012748>] (show_stack+0x10/0x14)
> [<80012748>] (show_stack) from [<807577a8>] (dump_stack+0x84/0xc4)
> [<807577a8>] (dump_stack) from [<8074e41c>]
> (mac802154_wpan_ioctl+0xf0/0x154)
> [<8074e41c>] (mac802154_wpan_ioctl) from [<7f039744>]
> (ieee802154_sock_ioctl+0x184/0x1f0 [ieee802154_socket])
> [<7f039744>] (ieee802154_sock_ioctl [ieee802154_socket]) from [<805fcbf4>]
> (sock_ioctl+0x1c0/0x294)
> [<805fcbf4>] (sock_ioctl) from [<800f9dd0>] (do_vfs_ioctl+0x40c/0x5fc)
> [<800f9dd0>] (do_vfs_ioctl) from [<800f9ff4>] (SyS_ioctl+0x34/0x5c)
> [<800f9ff4>] (SyS_ioctl) from [<8000f480>] (ret_fast_syscall+0x0/0x3c)
>
> Do you have some tips to solve the problem?
>

Fixed by:

4a669f7d72535017dd03cbcdf5af6e85edfdf90c

> I'm using Debian Jessie (downloaded here
> http://www.variwiki.com/index.php?title=VAR-SOM-MX6_Debian_R2) with kernel
> 4.1.15-224528-gc28c3ac-dirty.
>

Some patches didn't got into stable tree, we are still some
experimental stack implementation.
We don't recommended to run such old kernel.

You maybe want to run git log $FILE on linus/master tree to see and
maybe cherry-pick patches... don't report bugs/issues if you didn't
test it on current bluetooth-next/master kernel before.
Thank you.

- Alex
