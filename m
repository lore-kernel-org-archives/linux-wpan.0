Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35595 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbbCTHXF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Mar 2015 03:23:05 -0400
Received: by pagj4 with SMTP id j4so9428154pag.2
        for <linux-wpan@vger.kernel.org>; Fri, 20 Mar 2015 00:23:04 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 3/3] cc2520: fix in updated register settings
Date: Fri, 20 Mar 2015 12:52:20 +0530
Message-Id: <1426836141-21528-3-git-send-email-varkab@cdac.in>
In-Reply-To: <1426836141-21528-1-git-send-email-varkab@cdac.in>
References: <1426836141-21528-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch fix the updated register settings for transmit power.

As per the datasheet [section 28.1 Register Settings Update]
the transmit power register value has to be updated to 0x32 (0 dBm)
from the default value.

CC2520_TXPOWER_4 indicates the value 0x32 (0 dBm).

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/cc2520.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index f96cc50..d9135ec 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -860,7 +860,8 @@ static int cc2520_hw_init(struct cc2520_private *priv)
 		if (ret)
 			goto err_ret;
 	} else {
-		ret = cc2520_write_register(priv, CC2520_TXPOWER, 0xF7);
+		ret = cc2520_write_register(priv, CC2520_TXPOWER,
+					    CC2520_TXPOWER_4);
 		if (ret)
 			goto err_ret;
 
-- 
1.7.9.5

