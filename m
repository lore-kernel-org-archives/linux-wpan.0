Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-bl2on0105.outbound.protection.outlook.com ([65.55.169.105]:39432
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751078AbaLQVsK (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 17 Dec 2014 16:48:10 -0500
From: Andrey Yurovsky <andrey@snupi.com>
Subject: [PATCH] at86rf230: fix register read for part version
Date: Wed, 17 Dec 2014 13:14:42 -0800
Message-ID: <1418850882-4234-1-git-send-email-andrey@snupi.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Andrey Yurovsky <andrey@snupi.com>, alex.aring@gmail.com

The driver was reading the PART_NUM register for both the part number
(type of device) and the part version, the version is actually in
register 0x1D, VERSION_NUM.  I believe that this was a copy-paste error.

Tested on AT86RF212B where the part is detected to be the expected part
number (0x07) and version (0x03 on mine).

Signed-off-by: Andrey Yurovsky <andrey@snupi.com>
---
 drivers/net/ieee802154/at86rf230.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 1c01356..aa1005f 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1400,7 +1400,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 	if (rc)
 		return rc;
 
-	rc = __at86rf230_read(lp, RG_PART_NUM, &version);
+	rc = __at86rf230_read(lp, RG_VERSION_NUM, &version);
 	if (rc)
 		return rc;
 
-- 
2.1.0

