Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34753 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbeLOHWV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 15 Dec 2018 02:22:21 -0500
From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] 6lowpan: convert to DEFINE_SHOW_ATTRIBUTE
Date: Sat, 15 Dec 2018 02:22:17 -0500
Message-Id: <20181215072217.26085-1-tiny.windzz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com, jukka.rissanen@linux.intel.com, davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 net/6lowpan/debugfs.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 24915e0bb9ea..6c152f9ea26e 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -232,18 +232,7 @@ static int lowpan_context_show(struct seq_file *file, void *offset)
 
 	return 0;
 }
-
-static int lowpan_context_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, lowpan_context_show, inode->i_private);
-}
-
-static const struct file_operations lowpan_context_fops = {
-	.open		= lowpan_context_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(lowpan_context);
 
 static int lowpan_short_addr_get(void *data, u64 *val)
 {
-- 
2.17.0
