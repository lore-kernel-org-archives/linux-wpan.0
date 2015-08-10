Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:38459 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbbHJTaj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Aug 2015 15:30:39 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH bluetooth-next 0/8] ieee802154: pending patches
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1439234159-11630-1-git-send-email-alex.aring@gmail.com>
Date: Mon, 10 Aug 2015 12:30:29 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <661822C3-FD8B-44B7-A569-7B4EFB51E7F4@holtmann.org>
References: <1439234159-11630-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> these are currently the pending patches for ieee802154 subsystem.
> 
> There is one patch which was send before ~ 5 months ago and I dropped
> it again because the there was something wrong in the complete patch series
> and then I forget that fix. Nevertheless it seems that the RIOT people hit it,
> see:
> 
> https://github.com/RIOT-OS/RIOT/issues/3588#issuecomment-129509141
> 
> I hope the issue is fixed by PATCH "ieee802154: 6lowpan: fix error frag
> handling".
> 
> One fix from Lukasz Duda which fixes the traffic class decompression
> in 6LoWPAN code. There is indeed something wrong but I think the code needs
> a complete reqwork.
> 
> The other patches changes the aret handling in ieee802154 by removing
> the max_frame_retries "-1" value and do the ack handling per frame.
> To set the ackrequest bit for 802.15.4 6LoWPAN frames we introcued
> the ackrequest bit default handling which can set by nl802154.
> 
> Note:
> 
> There is another pending patch:
> 
> "cc2520: set the default fifo pin value from platform data"
> 
> but Varka didn't ack it yet, can you please apply this patch when Varka acked
> it, otherwise we will include them for the next "pending patches" series.
> 
> - Alex
> 
> Alexander Aring (7):
>  ieee802154: 6lowpan: remove multiple lowpan per wpan support
>  mac802154: fix wpan mac setting while lowpan is there
>  mac802154: cfg: remove test and set checks
>  mac802154: change frame_retries behaviour
>  at86rf230: use STATE_TX_ARET mode only
>  ieee802154: add ack request default handling
>  ieee802154: 6lowpan: fix error frag handling
> 
> Lukasz Duda (1):
>  6lowpan: Fix extraction of flow label field
> 
> drivers/net/ieee802154/at86rf230.c | 52 ++++++++---------------------
> include/net/cfg802154.h            |  8 +++++
> include/net/nl802154.h             |  4 +++
> net/6lowpan/iphc.c                 |  2 +-
> net/ieee802154/6lowpan/6lowpan_i.h |  8 -----
> net/ieee802154/6lowpan/core.c      | 67 +++++++++++---------------------------
> net/ieee802154/6lowpan/rx.c        | 38 +++++----------------
> net/ieee802154/6lowpan/tx.c        |  4 +--
> net/ieee802154/nl802154.c          | 33 +++++++++++++++++++
> net/ieee802154/rdev-ops.h          | 13 ++++++++
> net/ieee802154/trace.h             | 19 +++++++++++
> net/mac802154/cfg.c                | 27 +++++++--------
> net/mac802154/iface.c              | 18 ++++++++--
> net/mac802154/main.c               |  9 ++---
> 14 files changed, 151 insertions(+), 151 deletions(-)

all 8 patches have been applied to bluetooth-next tree.

Regards

Marcel

