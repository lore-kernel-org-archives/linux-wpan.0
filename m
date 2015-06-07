Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:52968 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbbFGHPO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Jun 2015 03:15:14 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next 0/8] mac802154: several cleanups
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
Date: Sun, 7 Jun 2015 09:15:10 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <5A3D8C1C-1FE1-4E2B-8C18-FA11C788244B@holtmann.org>
References: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Stefan Schmidt <s.schmidt@samsung.com>, Varka Bhadram <varkab@cdac.in>, Alan Ott <alan@signal11.us>, Lennert Buytenhek <buytenh@wantstofly.org>

Hi Alex,

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
>  mac802154: remove unneeded vif struct
>  mac802154: cleanup address filtering flags
>  mac802154: remove aack hw flag
>  mac802154: cleanup ieee802154 hardware flags
>  mac802154: remove unused hw_filt attribute
>  mac802154: rearrange attribute in ieee802154_hw
>  mac802154: add missing structure comments
>  mac802154: change pan_coord type to bool
> 
> drivers/net/ieee802154/at86rf230.c |   3 +-
> drivers/net/ieee802154/atusb.c     |   2 +-
> drivers/net/ieee802154/cc2520.c    |   4 +-
> drivers/net/ieee802154/mrf24j40.c  |   3 +-
> include/net/mac802154.h            | 136 ++++++++++++++++++++++++-------------
> net/mac802154/ieee802154_i.h       |   2 -
> net/mac802154/iface.c              |   9 ++-
> net/mac802154/rx.c                 |   4 +-
> 8 files changed, 97 insertions(+), 66 deletions(-)

all 8 patches have been applied to bluetooth-next tree.

Regards

Marcel

