Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35778 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbbFGDYD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Jun 2015 23:24:03 -0400
Received: by pacyx8 with SMTP id yx8so35061170pac.2
        for <linux-wpan@vger.kernel.org>; Sat, 06 Jun 2015 20:24:02 -0700 (PDT)
Message-ID: <5573B94A.3020406@gmail.com>
Date: Sun, 07 Jun 2015 08:53:54 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 0/8] mac802154: several cleanups
References: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Stefan Schmidt <s.schmidt@samsung.com>, Varka Bhadram <varkab@cdac.in>, Alan Ott <alan@signal11.us>, Lennert Buytenhek <buytenh@wantstofly.org>

Hi,

On Saturday 06 June 2015 09:00 PM, Alexander Aring wrote:

> Hi,
>
> this patch series contains various cleanups for mac802154 header. Also
> I cleanup a little bit the comments for several structs and flag
> definitions. This also prepares for handling a API documentation
> generation via docbook. The flags are enums now which is similar like
> mac80211 handling.
>
> - Alex
>
> Cc: Stefan Schmidt <s.schmidt@samsung.com>
> Cc: Varka Bhadram <varkab@cdac.in>
> Cc: Alan Ott <alan@signal11.us>
> Cc: Lennert Buytenhek <buytenh@wantstofly.org>
>
> Alexander Aring (8):
>    mac802154: remove unneeded vif struct
>    mac802154: cleanup address filtering flags
>    mac802154: remove aack hw flag
>    mac802154: cleanup ieee802154 hardware flags
>    mac802154: remove unused hw_filt attribute
>    mac802154: rearrange attribute in ieee802154_hw
>    mac802154: add missing structure comments
>    mac802154: change pan_coord type to bool
>
>   drivers/net/ieee802154/at86rf230.c |   3 +-
>   drivers/net/ieee802154/atusb.c     |   2 +-
>   drivers/net/ieee802154/cc2520.c    |   4 +-
>   drivers/net/ieee802154/mrf24j40.c  |   3 +-
>   include/net/mac802154.h            | 136 ++++++++++++++++++++++++-------------
>   net/mac802154/ieee802154_i.h       |   2 -
>   net/mac802154/iface.c              |   9 ++-
>   net/mac802154/rx.c                 |   4 +-
>   8 files changed, 97 insertions(+), 66 deletions(-)
>
Reviewed-by: Varka Bhadram <varkabhadram@gmail.com>

-- 
Varka Bhadram.

