Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38029 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbbEaNXD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 31 May 2015 09:23:03 -0400
Received: by wizo1 with SMTP id o1so74548079wiz.1
        for <linux-wpan@vger.kernel.org>; Sun, 31 May 2015 06:23:01 -0700 (PDT)
Date: Sun, 31 May 2015 15:22:57 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next] mac802154: add trace functionality for
 driver ops
Message-ID: <20150531132256.GD1476@omega>
References: <1432715090-23345-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1432715090-23345-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi,

I test it now and it works perfectly. Nice to have for complex userspace
applications.

I saw something which would be maybe to handle the output better.

802154_rdev_set_tx_power: phy0, power: -1200
802154_drv_set_tx_power: phy0, power: -1200

Maybe the parameter should not be shown as "power", we should use the
same naming convention like in the code which is "mbm".

I know I did it wrong in rdev trace, but we could change it now.

The same for:

802154_drv_set_csma_params: phy0, min be: 3, max be: 5, max csma bo: 4

"max csma bo" should be "max csma backoffs" then. If you like you can
fix it, it's just a nitpick.


On Wed, May 27, 2015 at 01:54:50PM +0530, Varka Bhadram wrote:
> This patch adds trace events for driver operations.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  net/mac802154/Makefile     |    4 +-
>  net/mac802154/driver-ops.h |   92 ++++++++++++---
>  net/mac802154/trace.c      |    9 ++
>  net/mac802154/trace.h      |  272 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 362 insertions(+), 15 deletions(-)
>  create mode 100644 net/mac802154/trace.c
>  create mode 100644 net/mac802154/trace.h
> 
> diff --git a/net/mac802154/Makefile b/net/mac802154/Makefile
> index 702d8b4..17a51e8 100644
> --- a/net/mac802154/Makefile
> +++ b/net/mac802154/Makefile
> @@ -1,5 +1,7 @@
>  obj-$(CONFIG_MAC802154)	+= mac802154.o
>  mac802154-objs		:= main.o rx.o tx.o mac_cmd.o mib.o \
> -			   iface.o llsec.o util.o cfg.o
> +			   iface.o llsec.o util.o cfg.o trace.o
> +
> +CFLAGS_trace.o := -I$(src)
>  
...
> +
> +TRACE_EVENT(802154_drv_set_pan_id,
> +	TP_PROTO(struct ieee802154_local *local, __le16 pan_id),
> +	TP_ARGS(local, pan_id),
> +	TP_STRUCT__entry(
> +		LOCAL_ENTRY
> +		__field(__le16, pan_id)
> +	),
> +	TP_fast_assign(
> +		LOCAL_ASSIGN;
> +		__entry->pan_id = pan_id;
> +	),
> +	TP_printk(LOCAL_PR_FMT ", pan id: 0x%04x", LOCAL_PR_ARG,
> +		  __entry->pan_id)
> +);
> +
> +TRACE_EVENT(802154_drv_set_extended_addr,
> +	TP_PROTO(struct ieee802154_local *local, __le64 extended_addr),
> +	TP_ARGS(local, extended_addr),
> +	TP_STRUCT__entry(
> +		LOCAL_ENTRY
> +		__field(__le64, extended_addr)
> +	),
> +	TP_fast_assign(
> +		LOCAL_ASSIGN;
> +		__entry->extended_addr = extended_addr;
> +	),
> +	TP_printk(LOCAL_PR_FMT ", extended addr %llx", LOCAL_PR_ARG,

add here a "0x"? I know this is also wrong in the rdev ops, maybe fix
this too in a patch for "rdev-ops trace fixes".

But this is something which is a good example for keeping the naming
convention the same:

When I do:

iwpan dev wpan0 interface add wpan1 type node ca:fe:fa:ce:de:ad:be:ef

will end in:

802154_rdev_add_virtual_intf: phy0, virtual intf name: wpan1, type: 0, ea cafefacedeadbeef

the extended_addr is here shown as "ea".

here it is shown as "extended addr". I like more to use "extended addr"
than "ea". But what we should have is the same naming convention for
meaning of the same parameter (orient you at the driver_ops declaration
maybe).

- Alex
