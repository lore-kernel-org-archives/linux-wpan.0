Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35805 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbbCQJdA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 17 Mar 2015 05:33:00 -0400
Received: by wibdy8 with SMTP id dy8so58092462wib.0
        for <linux-wpan@vger.kernel.org>; Tue, 17 Mar 2015 02:32:59 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] at86rf230: fix at86rf230_read_subreg succeed handling
Date: Tue, 17 Mar 2015 10:32:39 +0100
Message-Id: <1426584759-29501-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fix an issue when at86rf230_read_subreg was successful. The
function at86rf230_read_subreg will directly call regmap_read which
returns zero on successful. Nobody figured out issues yet because it was
only necessary to evaluate dvdd state while probing. This could make
trouble because the stack variable could have an random value.

The function is also used by reset the irq line before requesting irq, but
the value isn't evaluated afterwards.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index b64c5c7..cc5efa1 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -325,7 +325,7 @@ at86rf230_read_subreg(struct at86rf230_local *lp,
 	int rc;
 
 	rc = __at86rf230_read(lp, addr, data);
-	if (rc > 0)
+	if (!rc)
 		*data = (*data & mask) >> shift;
 
 	return rc;
-- 
2.3.2

