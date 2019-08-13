Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57512 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfHMO2X (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 13 Aug 2019 10:28:23 -0400
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] net: ieee802154: remove redundant assignment to rc
Date: Tue, 13 Aug 2019 15:28:18 +0100
Message-Id: <20190813142818.15022-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, "David S . Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable rc is initialized to a value that is never read and it is
re-assigned later. The initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/ieee802154/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index dacbd58e1799..badc5cfe4dc6 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1092,7 +1092,7 @@ static struct packet_type ieee802154_packet_type = {
 
 static int __init af_ieee802154_init(void)
 {
-	int rc = -EINVAL;
+	int rc;
 
 	rc = proto_register(&ieee802154_raw_prot, 1);
 	if (rc)
-- 
2.20.1
