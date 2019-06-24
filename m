Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44328 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbfFXOsP (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 24 Jun 2019 10:48:15 -0400
From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] 6lowpan: fix off-by-one comparison of index id with LOWPAN_IPHC_CTX_TABLE_SIZE
Date: Mon, 24 Jun 2019 15:47:57 +0100
Message-Id: <20190624144757.1285-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The WARN_ON_ONCE check on id is off-by-one, it should be greater or equal
to LOWPAN_IPHC_CTX_TABLE_SIZE and not greater than. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/6lowpan/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 1c140af06d52..a510bed8165b 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -170,7 +170,7 @@ static void lowpan_dev_debugfs_ctx_init(struct net_device *dev,
 	struct dentry *root;
 	char buf[32];
 
-	WARN_ON_ONCE(id > LOWPAN_IPHC_CTX_TABLE_SIZE);
+	WARN_ON_ONCE(id >= LOWPAN_IPHC_CTX_TABLE_SIZE);
 
 	sprintf(buf, "%d", id);
 
-- 
2.20.1
