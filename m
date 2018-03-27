Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35555 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbeC0Nqg (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 27 Mar 2018 09:46:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id r82so21990010wme.0
        for <linux-wpan@vger.kernel.org>; Tue, 27 Mar 2018 06:46:35 -0700 (PDT)
From: harrymorris12@gmail.com
Subject: [PATCH 1/1] ieee802154: ca8210: fix uninitialised data read
Date: Tue, 27 Mar 2018 14:45:44 +0100
Message-Id: <20180327134544.16986-2-h.morris@cascoda.com>
In-Reply-To: <20180327134544.16986-1-h.morris@cascoda.com>
References: <20180327134544.16986-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: stefan@osg.samsung.com, aring@mojatatu.com, Harry Morris <h.morris@cascoda.com>

From: Harry Morris <h.morris@cascoda.com>

In ca8210_test_int_user_write() a user can request the transfer of a
frame with a length field (command.length) that is longer than the
actual buffer provided (len). In this scenario the driver will copy
the buffer contents into the uninitialised command[] buffer, then
transfer <data.length> bytes over the SPI even though only <len> bytes
had been populated, potentially leaking sensitive kernel memory.

Reported-by: Domen Puncer Kugler <domen.puncer@samsung.com>
Signed-off-by: Harry Morris <h.morris@cascoda.com>
Tested-by: Harry Morris <h.morris@cascoda.com>
---
 drivers/net/ieee802154/ca8210.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 377af43b8..06cac8d3f 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2511,6 +2511,13 @@ static ssize_t ca8210_test_int_user_write(
 		);
 		return -EIO;
 	}
+	if (len != command[1] + 2) {
+		dev_err(
+			&priv->spi->dev,
+			"write len does not match packet length field\n"
+		);
+		return -EMSGSIZE;
+	}
 
 	ret = ca8210_test_check_upstream(command, priv->spi);
 	if (ret == 0) {
-- 
2.11.0

