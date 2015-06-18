Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:59839 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100AbbFRPzZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Jun 2015 11:55:25 -0400
From: Simon Vincent <simon.vincent@xsilon.com>
Subject: [PATCH bluetooth-next] mac802154: fix llsec authentication without encryption BUG 
Date: Thu, 18 Jun 2015 16:55:01 +0100
Message-Id: <1434642901-11646-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com
Cc: linux-wpan@vger.kernel.org, phoebe.buckheister@itwm.fraunhofer.de, Simon Vincent <simon.vincent@xsilon.com>

 802.15.4 security levels 1,2,3 provide data authenticity but
 no encryption. Currently the llsec implementation hits a BUG() if these modes
 are used. This is due to the scatterlist length being set to 0 when
 encryption is not used. This patch fixes this issue.

Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
---
 net/mac802154/llsec.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 5b2be12..f8081f0 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -648,7 +648,8 @@ llsec_do_encrypt_auth(struct sk_buff *skb, const struct mac802154_llsec *sec,
 {
 	u8 iv[16];
 	unsigned char *data;
-	int authlen, assoclen, datalen, rc;
+	int authlen, datalen, rc;
+	int assoclen = 0;
 	struct scatterlist src, assoc[2], dst[2];
 	struct aead_request *req;
 
@@ -659,26 +660,25 @@ llsec_do_encrypt_auth(struct sk_buff *skb, const struct mac802154_llsec *sec,
 	if (!req)
 		return -ENOMEM;
 
-	sg_init_table(assoc, 2);
-	sg_set_buf(&assoc[0], skb_mac_header(skb), skb->mac_len);
-	assoclen = skb->mac_len;
-
 	data = skb_mac_header(skb) + skb->mac_len;
 	datalen = skb_tail_pointer(skb) - data;
 
 	if (hdr->sec.level & IEEE802154_SCF_SECLEVEL_ENC) {
-		sg_set_buf(&assoc[1], data, 0);
+		sg_init_table(assoc, 1);
+		sg_init_table(dst, 2);
+		sg_set_buf(&dst[0], data, datalen);
+		sg_set_buf(&dst[1], skb_put(skb, authlen), authlen);
+		sg_init_one(&src, data, datalen);
 	} else {
+		sg_init_table(assoc, 2);
 		sg_set_buf(&assoc[1], data, datalen);
 		assoclen += datalen;
 		datalen = 0;
+		sg_init_one(dst, skb_put(skb, authlen), authlen);
 	}
 
-	sg_init_one(&src, data, datalen);
-
-	sg_init_table(dst, 2);
-	sg_set_buf(&dst[0], data, datalen);
-	sg_set_buf(&dst[1], skb_put(skb, authlen), authlen);
+	sg_set_buf(&assoc[0], skb_mac_header(skb), skb->mac_len);
+	assoclen += skb->mac_len;
 
 	aead_request_set_callback(req, 0, NULL, NULL);
 	aead_request_set_assoc(req, assoc, assoclen);
-- 
1.9.1

