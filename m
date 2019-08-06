Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387815AbfHFQMA (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 6 Aug 2019 12:12:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 17/17] ieee802154: no need to check return value of debugfs_create functions
Date: Tue,  6 Aug 2019 18:11:28 +0200
Message-Id: <20190806161128.31232-18-gregkh@linuxfoundation.org>
In-Reply-To: <20190806161128.31232-1-gregkh@linuxfoundation.org>
References: <20190806161128.31232-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Hennerich <michael.hennerich@analog.com>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, "David S. Miller" <davem@davemloft.net>, Harry Morris <h.morris@cascoda.com>, linux-wpan@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Harry Morris <h.morris@cascoda.com>
Cc: linux-wpan@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ieee802154/adf7242.c   | 12 +++---------
 drivers/net/ieee802154/at86rf230.c | 20 +++++---------------
 drivers/net/ieee802154/ca8210.c    |  9 +--------
 3 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index c9392d70e639..7b95add2235a 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1158,7 +1158,7 @@ static int adf7242_stats_show(struct seq_file *file, void *offset)
 	return 0;
 }
 
-static int adf7242_debugfs_init(struct adf7242_local *lp)
+static void adf7242_debugfs_init(struct adf7242_local *lp)
 {
 	char debugfs_dir_name[DNAME_INLINE_LEN + 1] = "adf7242-";
 	struct dentry *stats;
@@ -1166,15 +1166,9 @@ static int adf7242_debugfs_init(struct adf7242_local *lp)
 	strncat(debugfs_dir_name, dev_name(&lp->spi->dev), DNAME_INLINE_LEN);
 
 	lp->debugfs_root = debugfs_create_dir(debugfs_dir_name, NULL);
-	if (IS_ERR_OR_NULL(lp->debugfs_root))
-		return PTR_ERR_OR_ZERO(lp->debugfs_root);
 
-	stats = debugfs_create_devm_seqfile(&lp->spi->dev, "status",
-					    lp->debugfs_root,
-					    adf7242_stats_show);
-	return PTR_ERR_OR_ZERO(stats);
-
-	return 0;
+	debugfs_create_devm_seqfile(&lp->spi->dev, "status", lp->debugfs_root,
+				    adf7242_stats_show);
 }
 
 static const s32 adf7242_powers[] = {
diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 595cf7e2a651..7d67f41387f5 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1626,24 +1626,16 @@ static int at86rf230_stats_show(struct seq_file *file, void *offset)
 }
 DEFINE_SHOW_ATTRIBUTE(at86rf230_stats);
 
-static int at86rf230_debugfs_init(struct at86rf230_local *lp)
+static void at86rf230_debugfs_init(struct at86rf230_local *lp)
 {
 	char debugfs_dir_name[DNAME_INLINE_LEN + 1] = "at86rf230-";
-	struct dentry *stats;
 
 	strncat(debugfs_dir_name, dev_name(&lp->spi->dev), DNAME_INLINE_LEN);
 
 	at86rf230_debugfs_root = debugfs_create_dir(debugfs_dir_name, NULL);
-	if (!at86rf230_debugfs_root)
-		return -ENOMEM;
-
-	stats = debugfs_create_file("trac_stats", 0444,
-				    at86rf230_debugfs_root, lp,
-				    &at86rf230_stats_fops);
-	if (!stats)
-		return -ENOMEM;
 
-	return 0;
+	debugfs_create_file("trac_stats", 0444, at86rf230_debugfs_root, lp,
+			    &at86rf230_stats_fops);
 }
 
 static void at86rf230_debugfs_remove(void)
@@ -1651,7 +1643,7 @@ static void at86rf230_debugfs_remove(void)
 	debugfs_remove_recursive(at86rf230_debugfs_root);
 }
 #else
-static int at86rf230_debugfs_init(struct at86rf230_local *lp) { return 0; }
+static void at86rf230_debugfs_init(struct at86rf230_local *lp) { }
 static void at86rf230_debugfs_remove(void) { }
 #endif
 
@@ -1751,9 +1743,7 @@ static int at86rf230_probe(struct spi_device *spi)
 	/* going into sleep by default */
 	at86rf230_sleep(lp);
 
-	rc = at86rf230_debugfs_init(lp);
-	if (rc)
-		goto free_dev;
+	at86rf230_debugfs_init(lp);
 
 	rc = ieee802154_register_hw(lp->hw);
 	if (rc)
diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index b188fce3f641..11402dc347db 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -3019,14 +3019,7 @@ static int ca8210_test_interface_init(struct ca8210_priv *priv)
 		priv,
 		&test_int_fops
 	);
-	if (IS_ERR(test->ca8210_dfs_spi_int)) {
-		dev_err(
-			&priv->spi->dev,
-			"Error %ld when creating debugfs node\n",
-			PTR_ERR(test->ca8210_dfs_spi_int)
-		);
-		return PTR_ERR(test->ca8210_dfs_spi_int);
-	}
+
 	debugfs_create_symlink("ca8210", NULL, node_name);
 	init_waitqueue_head(&test->readq);
 	return kfifo_alloc(
-- 
2.22.0
