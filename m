Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34360 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbbE2F2q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 01:28:46 -0400
Received: by pabru16 with SMTP id ru16so43212432pab.1
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 22:28:45 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 1/5] cc2520: fix in default tx power setting
Date: Fri, 29 May 2015 10:56:54 +0530
Message-Id: <1432877218-12537-2-git-send-email-varkab@cdac.in>
In-Reply-To: <1432877218-12537-1-git-send-email-varkab@cdac.in>
References: <1432877218-12537-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: bradjc5@gmail.com, Varka Bhadram <varkab@cdac.in>

Initially we dont have the tx power settings from the user-space.
Now we have the support for seeting the tx power level.

So lets use the default tx power setting for the radio.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
Cc: Brad Campbell <bradjc5@gmail.com>
---
 drivers/net/ieee802154/cc2520.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 84b28a0..ea280d4 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -782,10 +782,6 @@ static int cc2520_hw_init(struct cc2520_private *priv)
 	 * http://www.ti.com/lit/an/swra229a/swra229a.pdf
 	 */
 	if (pdata.amplified) {
-		ret = cc2520_write_register(priv, CC2520_TXPOWER, 0xF9);
-		if (ret)
-			goto err_ret;
-
 		ret = cc2520_write_register(priv, CC2520_AGCCTRL1, 0x16);
 		if (ret)
 			goto err_ret;
@@ -806,10 +802,6 @@ static int cc2520_hw_init(struct cc2520_private *priv)
 		if (ret)
 			goto err_ret;
 	} else {
-		ret = cc2520_write_register(priv, CC2520_TXPOWER, 0xF7);
-		if (ret)
-			goto err_ret;
-
 		ret = cc2520_write_register(priv, CC2520_AGCCTRL1, 0x11);
 		if (ret)
 			goto err_ret;
-- 
1.7.9.5

