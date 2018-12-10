Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45958 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeLJPqT (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Dec 2018 10:46:19 -0500
From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ieee802154: at86rf230: convert to DEFINE_SHOW_ATTRIBUTE
Date: Mon, 10 Dec 2018 10:46:03 -0500
Message-Id: <20181210154603.20520-1-tiny.windzz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com, stefan@datenfreihafen.org, davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 3d9e91579866..0253eb502153 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1632,18 +1632,7 @@ static int at86rf230_stats_show(struct seq_file *file, void *offset)
 	seq_printf(file, "INVALID:\t\t%8llu\n", lp->trac.invalid);
 	return 0;
 }
-
-static int at86rf230_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, at86rf230_stats_show, inode->i_private);
-}
-
-static const struct file_operations at86rf230_stats_fops = {
-	.open		= at86rf230_stats_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(at86rf230_stats);
 
 static int at86rf230_debugfs_init(struct at86rf230_local *lp)
 {
-- 
2.17.0
