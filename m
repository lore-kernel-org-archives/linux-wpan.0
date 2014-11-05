Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39891 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbaKETwY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:24 -0500
Received: by mail-wi0-f172.google.com with SMTP id bs8so13451548wib.5
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:23 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 16/18] at86rf230: add force slotted operation bit
Date: Wed,  5 Nov 2014 20:51:27 +0100
Message-Id: <1415217089-24919-17-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a force setting of slotted operation bit. The atben
chips sometimes set these bit. The reason is unknown. Nevertheless we
don't support slotted operation so we set this bit now force while
probing.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index a6db768..a3cc7d9 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1358,6 +1358,14 @@ static int at86rf230_hw_init(struct at86rf230_local *lp)
 		return -EINVAL;
 	}
 
+	/* Force setting slotted operation bit to 0. Sometimes the atben
+	 * sets this bit and I don't know why. We set this always force
+	 * to zero while probing.
+	 */
+	rc = at86rf230_write_subreg(lp, SR_SLOTTED_OPERATION, 0);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 
-- 
2.1.3

