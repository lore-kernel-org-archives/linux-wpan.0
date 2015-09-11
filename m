Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33061 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbbIKJqP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 11 Sep 2015 05:46:15 -0400
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] at86rf230: fix build warning
Date: Fri, 11 Sep 2015 15:16:04 +0530
Message-Id: <1441964764-15611-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

e616a00ce786 ("drivers/net/ieee802154/at86rf230.c: seq_printf() now returns NULL")
has removed the usage of the integer "ret" but missed removing the
variable. And we were getting a build warning about "unused variable".

Fixes: e616a00ce786 ("drivers/net/ieee802154/at86rf230.c: seq_printf() now returns NULL")
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/net/ieee802154/at86rf230.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index a9f3af6..9ae98fd 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1645,7 +1645,6 @@ static struct dentry *at86rf230_debugfs_root;
 static int at86rf230_stats_show(struct seq_file *file, void *offset)
 {
 	struct at86rf230_local *lp = file->private;
-	int ret;
 
 	seq_printf(file, "SUCCESS:\t\t%8llu\n", lp->trac.success);
 	seq_printf(file, "SUCCESS_DATA_PENDING:\t%8llu\n",
-- 
1.9.1

