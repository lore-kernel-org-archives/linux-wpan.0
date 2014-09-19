Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:47487 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464AbaISEse (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 00:48:34 -0400
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next v2 2/3] mrf24j40: remove unnecessary return statement
Date: Fri, 19 Sep 2014 10:15:09 +0530
Message-Id: <1411101911-12462-3-git-send-email-varkab@cdac.in>
In-Reply-To: <1411101911-12462-1-git-send-email-varkab@cdac.in>
References: <1411101911-12462-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: alan@signal11.us, Varka Bhadram <varkab@cdac.in>

Remove the return statement in the void function.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/mrf24j40.c |    2 --
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
1.7.9.5

