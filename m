Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:35548 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752741AbdHIQTp (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Aug 2017 12:19:45 -0400
Received: by mail-qt0-f171.google.com with SMTP id p3so39338040qtg.2
        for <linux-wpan@vger.kernel.org>; Wed, 09 Aug 2017 09:19:44 -0700 (PDT)
From: Diogenes Pereira <dvnp@cesar.org.br>
Subject: [PATCH v1] mac802154: replace hardcoded value with macro
Date: Wed,  9 Aug 2017 13:19:24 -0300
Message-Id: <1502295564-20178-1-git-send-email-dvnp@cesar.org.br>
In-Reply-To: <1502126560-24462-2-git-send-email-dvnp@cesar.org.br>
References: <1502126560-24462-2-git-send-email-dvnp@cesar.org.br>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: stefan@osg.samsung.com, alex.aring@gmail.com, Diogenes Pereira <dvnp@cesar.org.br>

Use IEEE802154_SCF_SECLEVEL_NONE macro defined at ieee802154.h file.

Signed-off-by: Diogenes Pereira <dvnp@cesar.org.br>
Acked-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 net/mac802154/llsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 1e1c9b2..edec2f9 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -713,7 +713,8 @@ int mac802154_llsec_encrypt(struct mac802154_llsec *sec, struct sk_buff *skb)
 	if (hlen < 0 || hdr.fc.type != IEEE802154_FC_TYPE_DATA)
 		return -EINVAL;
 
-	if (!hdr.fc.security_enabled || hdr.sec.level == 0) {
+	if (!hdr.fc.security_enabled ||
+	    (hdr.sec.level == IEEE802154_SCF_SECLEVEL_NONE)) {
 		skb_push(skb, hlen);
 		return 0;
 	}
-- 
2.7.4

