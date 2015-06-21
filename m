Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:58287 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbbFUSTX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 21 Jun 2015 14:19:23 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next] mac802154: add llsec address update workaround
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434897920-28271-1-git-send-email-alex.aring@gmail.com>
Date: Sun, 21 Jun 2015 20:19:16 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <2B96A969-9FCA-486E-A80D-3392A42F16BF@holtmann.org>
References: <1434897920-28271-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, simon.vincent@xsilon.com, phoebe.buckheister@itwm.fraunhofer.de

Hi Alex,

> This patch adds a workaround for using the new nl802154 netlink
> interface with the old ieee802154 netlink interface togehter. The
> nl802154 currently supports no access for llsec layer, currently there
> are users outside which are using both interfaces at the same time. This
> patch adds a necessary call when addresses are updated.
> 
> Reported-by: Simon Vincent <simon.vincent@xsilon.com>
> Suggested-by: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> There is surely a better way for getting/setting the address in llsec now,
> this is a workaround for just let it work with the old interface. We will
> see what we can do when nl802154 supports accessing llsec.
> 
> net/mac802154/cfg.c          | 9 +++++++--
> net/mac802154/ieee802154_i.h | 2 ++
> net/mac802154/iface.c        | 7 ++++++-
> 3 files changed, 15 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
