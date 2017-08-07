Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:32962 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbdHGRkv (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 7 Aug 2017 13:40:51 -0400
Received: by mail-qk0-f179.google.com with SMTP id a77so6733385qkb.0
        for <linux-wpan@vger.kernel.org>; Mon, 07 Aug 2017 10:40:50 -0700 (PDT)
From: Diogenes Pereira <dvnp@cesar.org.br>
Subject: [PATCH v0 1/2] mac802154: fix header and payload encrypted
Date: Mon,  7 Aug 2017 14:22:39 -0300
Message-Id: <1502126560-24462-1-git-send-email-dvnp@cesar.org.br>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de, stefan@osg.samsung.com, Diogenes Pereira <dvnp@cesar.org.br>

According to 802.15.4-2015 specification (section 9.2.1 Outgoing frame
security procedure) just the outgoing payload is encrypted. The header
carries security parameters to destination address, so is not encrypted.

Signed-off-by: Diogenes Pereira <dvnp@cesar.org.br>
---
 net/mac802154/llsec.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 1e1c9b2..3c8ae3f 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -623,13 +623,18 @@ llsec_do_encrypt_unauth(struct sk_buff *skb, const struct mac802154_llsec *sec,
 	u8 iv[16];
 	struct scatterlist src;
 	SKCIPHER_REQUEST_ON_STACK(req, key->tfm0);
-	int err;
+	int err, datalen;
+	unsigned char *data;
 
 	llsec_geniv(iv, sec->params.hwaddr, &hdr->sec);
-	sg_init_one(&src, skb->data, skb->len);
+
+	data = skb_mac_header(skb) + skb->mac_len;
+	datalen = skb_tail_pointer(skb) - data;
+
+	sg_init_one(&src, data, datalen);
 	skcipher_request_set_tfm(req, key->tfm0);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
-	skcipher_request_set_crypt(req, &src, &src, skb->len, iv);
+	skcipher_request_set_crypt(req, &src, &src, datalen, iv);
 	err = crypto_skcipher_encrypt(req);
 	skcipher_request_zero(req);
 	return err;
-- 
2.7.4

