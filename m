Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33122 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbD3PqL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Apr 2015 11:46:11 -0400
Received: by wgin8 with SMTP id n8so67011634wgi.0
        for <linux-wpan@vger.kernel.org>; Thu, 30 Apr 2015 08:46:10 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 03/13] mac802154: llsec: fix return value check in llsec_key_alloc()
Date: Thu, 30 Apr 2015 17:44:54 +0200
Message-Id: <1430408704-21815-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430408704-21815-1-git-send-email-alex.aring@gmail.com>
References: <1430408704-21815-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Alexander Aring <alex.aring@gmail.com>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the functions crypto_alloc_aead() and crypto_alloc_blkcipher()
returns ERR_PTR() and never returns NULL. The NULL test in the return value check
should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/llsec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index dcf7395..5b2be12 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -134,7 +134,7 @@ llsec_key_alloc(const struct ieee802154_llsec_key *template)
 	for (i = 0; i < ARRAY_SIZE(key->tfm); i++) {
 		key->tfm[i] = crypto_alloc_aead("ccm(aes)", 0,
 						CRYPTO_ALG_ASYNC);
-		if (!key->tfm[i])
+		if (IS_ERR(key->tfm[i]))
 			goto err_tfm;
 		if (crypto_aead_setkey(key->tfm[i], template->key,
 				       IEEE802154_LLSEC_KEY_SIZE))
@@ -144,7 +144,7 @@ llsec_key_alloc(const struct ieee802154_llsec_key *template)
 	}
 
 	key->tfm0 = crypto_alloc_blkcipher("ctr(aes)", 0, CRYPTO_ALG_ASYNC);
-	if (!key->tfm0)
+	if (IS_ERR(key->tfm0))
 		goto err_tfm;
 
 	if (crypto_blkcipher_setkey(key->tfm0, template->key,
-- 
2.3.6

