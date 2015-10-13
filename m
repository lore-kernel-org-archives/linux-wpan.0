Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38632 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbbJMLng (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 13 Oct 2015 07:43:36 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/6] mac802154: llsec: use kzfree
Date: Tue, 13 Oct 2015 13:42:54 +0200
Message-Id: <1444736579-27826-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This patch will use kzfree instead kfree for security related
information which can be offered by acccident.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/llsec.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 7799d3c..a13d02b 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -55,7 +55,7 @@ void mac802154_llsec_destroy(struct mac802154_llsec *sec)
 
 		msl = container_of(sl, struct mac802154_llsec_seclevel, level);
 		list_del(&sl->list);
-		kfree(msl);
+		kzfree(msl);
 	}
 
 	list_for_each_entry_safe(dev, dn, &sec->table.devices, list) {
@@ -72,7 +72,7 @@ void mac802154_llsec_destroy(struct mac802154_llsec *sec)
 		mkey = container_of(key->key, struct mac802154_llsec_key, key);
 		list_del(&key->list);
 		llsec_key_put(mkey);
-		kfree(key);
+		kzfree(key);
 	}
 }
 
@@ -161,7 +161,7 @@ err_tfm:
 		if (key->tfm[i])
 			crypto_free_aead(key->tfm[i]);
 
-	kfree(key);
+	kzfree(key);
 	return NULL;
 }
 
@@ -176,7 +176,7 @@ static void llsec_key_release(struct kref *ref)
 		crypto_free_aead(key->tfm[i]);
 
 	crypto_free_blkcipher(key->tfm0);
-	kfree(key);
+	kzfree(key);
 }
 
 static struct mac802154_llsec_key*
@@ -267,7 +267,7 @@ int mac802154_llsec_key_add(struct mac802154_llsec *sec,
 	return 0;
 
 fail:
-	kfree(new);
+	kzfree(new);
 	return -ENOMEM;
 }
 
@@ -347,10 +347,10 @@ static void llsec_dev_free(struct mac802154_llsec_device *dev)
 				      devkey);
 
 		list_del(&pos->list);
-		kfree(devkey);
+		kzfree(devkey);
 	}
 
-	kfree(dev);
+	kzfree(dev);
 }
 
 int mac802154_llsec_dev_add(struct mac802154_llsec *sec,
@@ -681,7 +681,7 @@ llsec_do_encrypt_auth(struct sk_buff *skb, const struct mac802154_llsec *sec,
 
 	rc = crypto_aead_encrypt(req);
 
-	kfree(req);
+	kzfree(req);
 
 	return rc;
 }
@@ -881,7 +881,7 @@ llsec_do_decrypt_auth(struct sk_buff *skb, const struct mac802154_llsec *sec,
 
 	rc = crypto_aead_decrypt(req);
 
-	kfree(req);
+	kzfree(req);
 	skb_trim(skb, skb->len - authlen);
 
 	return rc;
@@ -921,7 +921,7 @@ llsec_update_devkey_record(struct mac802154_llsec_device *dev,
 		if (!devkey)
 			list_add_rcu(&next->devkey.list, &dev->dev.keys);
 		else
-			kfree(next);
+			kzfree(next);
 
 		spin_unlock_bh(&dev->lock);
 	}
-- 
2.6.1

