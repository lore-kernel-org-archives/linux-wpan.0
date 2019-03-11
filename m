Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:47300 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbfCKHdT (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 11 Mar 2019 03:33:19 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id C63F1AEE
        for <linux-wpan@vger.kernel.org>; Mon, 11 Mar 2019 07:25:23 +0000 (UTC)
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S_7ObY7_ssdG for <linux-wpan@vger.kernel.org>;
        Mon, 11 Mar 2019 02:25:23 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 98739AEF
        for <linux-wpan@vger.kernel.org>; Mon, 11 Mar 2019 02:25:23 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id b14so3525412ioh.1
        for <linux-wpan@vger.kernel.org>; Mon, 11 Mar 2019 00:25:23 -0700 (PDT)
From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] net: ieee802154: fix a potential NULL pointer dereference
Date: Mon, 11 Mar 2019 02:25:17 -0500
Message-Id: <20190311072517.29740-1-kjlu@umn.edu>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Michael Hennerich <michael.hennerich@analog.com>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, "David S. Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

In case alloc_ordered_workqueue fails, the fix releases
sources and returns -ENOMEM to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ieee802154/adf7242.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index cd1d8faccca5..cd6b95e673a5 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1268,6 +1268,10 @@ static int adf7242_probe(struct spi_device *spi)
 	INIT_DELAYED_WORK(&lp->work, adf7242_rx_cal_work);
 	lp->wqueue = alloc_ordered_workqueue(dev_name(&spi->dev),
 					     WQ_MEM_RECLAIM);
+	if (unlikely(!lp->wqueue)) {
+		ret = -ENOMEM;
+		goto err_hw_init;
+	}
 
 	ret = adf7242_hw_init(lp);
 	if (ret)
-- 
2.17.1
