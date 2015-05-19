Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:50615 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbbEST4i (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 May 2015 15:56:38 -0400
Date: Tue, 19 May 2015 22:50:18 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 7/8] mac802154: mac802154_header_create() optimisation.
Message-ID: <20150519195018.GS11014@wantstofly.org>
References: <cover.1432064518.git.buytenh@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1432064518.git.buytenh@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

mac802154_header_create() calls ieee802154_mlme_ops(dev)->get_dsn(dev),
but 'dev' is always a mac802154 device, therefore we can just call
mac802154_dev_get_dsn() instead directly.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 net/mac802154/iface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 91b75ab..f59cc87 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -374,7 +374,7 @@ static int mac802154_header_create(struct sk_buff *skb,
 	hdr.fc.type = cb->type;
 	hdr.fc.security_enabled = cb->secen;
 	hdr.fc.ack_request = cb->ackreq;
-	hdr.seq = ieee802154_mlme_ops(dev)->get_dsn(dev);
+	hdr.seq = mac802154_dev_get_dsn(dev);
 
 	if (mac802154_set_header_security(sdata, &hdr, cb) < 0)
 		return -EINVAL;
-- 
2.1.0

