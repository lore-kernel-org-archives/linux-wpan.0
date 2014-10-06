Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:45419 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbaJFSDN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Oct 2014 14:03:13 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH linux-wpan v4] ieee802154: mrf24j40: Add support for MRF24J40MC
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1412588385-30388-1-git-send-email-simon.vincent@xsilon.com>
Date: Mon, 6 Oct 2014 20:03:19 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <5072AF0A-A8E7-41C5-AC51-3BF15AF02EA0@holtmann.org>
References: <1412588385-30388-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, alan@signal11.us

Hi Simon,

> The MRF24J40MC module has an external amplifier which should be
> enabled. The TX power has to be lowered to meet FCC regs.
> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---
> v3 -> v4:
> * Fix mistake where was doing a write instead of a spi read.
> 
> v2 -> v3: 
> * Added extra code comments and removed check of spi return values.
> 
> drivers/net/ieee802154/mrf24j40.c | 32 ++++++++++++++++++++++++++++++--
> 1 file changed, 30 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

