Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36446 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbdHGRk6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 7 Aug 2017 13:40:58 -0400
Received: by mail-qt0-f170.google.com with SMTP id v29so6734157qtv.3
        for <linux-wpan@vger.kernel.org>; Mon, 07 Aug 2017 10:40:58 -0700 (PDT)
From: Diogenes Pereira <dvnp@cesar.org.br>
Subject: [PATCH v0 2/2] mac802154: replace hardcoded value with macro
Date: Mon,  7 Aug 2017 14:22:40 -0300
Message-Id: <1502126560-24462-2-git-send-email-dvnp@cesar.org.br>
In-Reply-To: <1502126560-24462-1-git-send-email-dvnp@cesar.org.br>
References: <1502126560-24462-1-git-send-email-dvnp@cesar.org.br>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de, stefan@osg.samsung.com, Diogenes Pereira <dvnp@cesar.org.br>

Use IEEE802154_SCF_SECLEVEL_NONE macro defined at ieee802154.h file.

Signed-off-by: Diogenes Pereira <dvnp@cesar.org.br>
---
 net/mac802154/llsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 3c8ae3f..f51093e 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -718,7 +718,8 @@ int mac802154_llsec_encrypt(struct mac802154_llsec *sec, struct sk_buff *skb)
 	if (hlen < 0 || hdr.fc.type != IEEE802154_FC_TYPE_DATA)
 		return -EINVAL;
 
-	if (!hdr.fc.security_enabled || hdr.sec.level == 0) {
+	if (!hdr.fc.security_enabled ||
+		hdr.sec.level == IEEE802154_SCF_SECLEVEL_NONE) {
 		skb_push(skb, hlen);
 		return 0;
 	}
-- 
2.7.4

