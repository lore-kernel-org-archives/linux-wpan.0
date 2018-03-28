Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55461 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbeC1Kyi (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 28 Mar 2018 06:54:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id b127so3238234wmf.5
        for <linux-wpan@vger.kernel.org>; Wed, 28 Mar 2018 03:54:38 -0700 (PDT)
From: harrymorris12@gmail.com
Subject: [PATCH v2 1/1] ieee802154: ca8210: fix uninitialised data read
Date: Wed, 28 Mar 2018 11:54:27 +0100
Message-Id: <20180328105427.34812-2-h.morris@cascoda.com>
In-Reply-To: <20180328105427.34812-1-h.morris@cascoda.com>
References: <20180328105427.34812-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: stefan@osg.samsung.com, aring@mojatatu.com, domen.puncer@samsung.com, Harry Morris <h.morris@cascoda.com>

From: Harry Morris <h.morris@cascoda.com>

In ca8210_test_int_user_write() a user can request the transfer of a
frame with a length field (command.length) that is longer than the
actual buffer provided (len). In this scenario the driver will copy
the buffer contents into the uninitialised command[] buffer, then
transfer <data.length> bytes over the SPI even though only <len> bytes
had been populated, potentially leaking sensitive kernel memory.

Also the first 6 bytes of the command buffer must be initialised in case
a malformed, short packet is written and the uninitialised bytes are
read in ca8210_test_check_upstream.

Reported-by: Domen Puncer Kugler <domen.puncer@samsung.com>
Signed-off-by: Harry Morris <h.morris@cascoda.com>
Tested-by: Harry Morris <h.morris@cascoda.com>
---
 drivers/net/ieee802154/ca8210.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 377af43b8..58299fb66 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2493,13 +2493,14 @@ static ssize_t ca8210_test_int_user_write(
 	struct ca8210_priv *priv = filp->private_data;
 	u8 command[CA8210_SPI_BUF_SIZE];
 
-	if (len > CA8210_SPI_BUF_SIZE) {
+	memset(command, SPI_IDLE, 6);
+	if (len > CA8210_SPI_BUF_SIZE || len < 2) {
 		dev_warn(
 			&priv->spi->dev,
-			"userspace requested erroneously long write (%zu)\n",
+			"userspace requested erroneous write length (%zu)\n",
 			len
 		);
-		return -EMSGSIZE;
+		return -EBADE;
 	}
 
 	ret = copy_from_user(command, in_buf, len);
@@ -2511,6 +2512,13 @@ static ssize_t ca8210_test_int_user_write(
 		);
 		return -EIO;
 	}
+	if (len != command[1] + 2) {
+		dev_err(
+			&priv->spi->dev,
+			"write len does not match packet length field\n"
+		);
+		return -EBADE;
+	}
 
 	ret = ca8210_test_check_upstream(command, priv->spi);
 	if (ret == 0) {
-- 
2.11.0

