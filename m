Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:57761 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751808AbcF0GKN (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 27 Jun 2016 02:10:13 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RESEND bluetooth-next 3/3] ieee802154: allow netns create of lowpan interface
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160618084535.4699-3-aar@pengutronix.de>
Date: Mon, 27 Jun 2016 08:10:07 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <F6E26E8C-ED47-47EB-847A-CFE0895E16BF@holtmann.org>
References: <20160618084535.4699-1-aar@pengutronix.de> <20160618084535.4699-3-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Nicolas Dichtel <nicolas.dichtel@6wind.com>

Hi Alex,

> This patch reverts commit f9d1ce8f81eb ("ieee802154: fix netns settings").
> The lowpan interface need to be created inside the net namespace where
> the wpan interface is available. The wpan namespace can be changed only
> by nl802154 before. Without this patch it's not possible to create a
> lowpan interface for a wpan interface which isn't inside init_net
> namespace.
> 
> Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> net/ieee802154/6lowpan/core.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

