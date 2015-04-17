Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36365 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbDQLuT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Apr 2015 07:50:19 -0400
Received: by pdea3 with SMTP id a3so125957273pde.3
        for <linux-wpan@vger.kernel.org>; Fri, 17 Apr 2015 04:50:19 -0700 (PDT)
Message-ID: <5530F366.4030407@gmail.com>
Date: Fri, 17 Apr 2015 17:19:58 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH] ieee802154: Add trace events for rdev->ops
References: <20150412120733.GA6181@bogon.m.sigxcpu.org>
In-Reply-To: <20150412120733.GA6181@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?windows-1252?Q?Guido_G=FCnther?= <agx@sigxcpu.org>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On 04/12/2015 05:37 PM, Guido Günther wrote:
> This is based on the rdev->ops tracing code from net/wireless/.

Instead of writing the above commit message its better to write
what exactly this code is for and how can we use this from
the user space (if possible with commands).

If you want to write your above commit message put it in trace.c/h file 

> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  net/ieee802154/Makefile   |   4 +-
>  net/ieee802154/rdev-ops.h |  77 ++++++++++++---
>  net/ieee802154/trace.c    |   7 ++
>  net/ieee802154/trace.h    | 243 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 319 insertions(+), 12 deletions(-)
>  create mode 100644 net/ieee802154/trace.c
>  create mode 100644 net/ieee802154/trace.h
>
> diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
> index 05dab29..4adfd4d 100644
> --- a/net/ieee802154/Makefile
> +++ b/net/ieee802154/Makefile
> @@ -3,7 +3,9 @@ obj-$(CONFIG_IEEE802154_SOCKET) += ieee802154_socket.o
>  obj-y += 6lowpan/
>  
>  ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
> -                header_ops.o sysfs.o nl802154.o
> +                header_ops.o sysfs.o nl802154.o trace.o
>  ieee802154_socket-y := socket.o
>  
> +CFLAGS_trace.o := -I$(src)

What is this for..? 


-- 
Varka Bhadram

