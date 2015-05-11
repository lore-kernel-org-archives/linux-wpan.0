Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38468 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbbEKQvi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 11 May 2015 12:51:38 -0400
Received: by wiun10 with SMTP id n10so103907451wiu.1
        for <linux-wpan@vger.kernel.org>; Mon, 11 May 2015 09:51:37 -0700 (PDT)
Date: Mon, 11 May 2015 18:51:31 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Ieee802154 socket problem with SIOCGIFADDR
Message-ID: <20150511165127.GA1838@omega>
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
> 

mhh, this sounds like another issue.

1. What's your exactly ioctl call, then I can maybe reproduce your issue.

2. There are some information missing at you stacktrace, can you provide
   more information?

- Alex
