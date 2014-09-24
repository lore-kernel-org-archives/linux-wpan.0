Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:54992 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbaIXKWH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Sep 2014 06:22:07 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/4] mrf24j40: remove unnecessary return statement
Date: Wed, 24 Sep 2014 12:21:31 +0200
Message-Id: <1411554093-14976-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1411554093-14976-1-git-send-email-alex.aring@gmail.com>
References: <1411554093-14976-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Varka Bhadram <varkabhadram@gmail.com>, Varka Bhadram <varkab@cdac.in>, Alexander Aring <alex.aring@gmail.com>

From: Varka Bhadram <varkabhadram@gmail.com>

Remove the return statement in the void function.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
Acked-by: Alan Ott <alan@signal11.us>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 466da57..2c617e3 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -420,8 +420,6 @@ static void mrf24j40_stop(struct ieee802154_dev *dev)
 		return;
 	val |= 0x1|0x8; /* Set TXNIE and RXIE. Disable Interrupts */
 	write_short_reg(devrec, REG_INTCON, val);
-
-	return;
 }
 
 static int mrf24j40_set_channel(struct ieee802154_dev *dev,
-- 
2.1.0

