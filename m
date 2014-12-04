Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:33587 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbaLDK6Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Dec 2014 05:58:16 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH bluetooth-next 4/5] net/mac802154: Remove extra blank lines.
Date: Thu,  4 Dec 2014 11:52:00 +0100
Message-Id: <1417690321-19450-4-git-send-email-s.schmidt@samsung.com>
In-Reply-To: <1417690321-19450-1-git-send-email-s.schmidt@samsung.com>
References: <1417690321-19450-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 net/mac802154/llsec.c | 15 ---------------
 net/mac802154/mib.c   |  6 ------
 2 files changed, 21 deletions(-)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index fa0d523..4a661f7 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -75,8 +75,6 @@ void mac802154_llsec_destroy(struct mac802154_llsec *sec)
 	}
 }
 
-
-
 int mac802154_llsec_get_params(struct mac802154_llsec *sec,
 			       struct ieee802154_llsec_params *params)
 {
@@ -117,8 +115,6 @@ int mac802154_llsec_set_params(struct mac802154_llsec *sec,
 	return 0;
 }
 
-
-
 static struct mac802154_llsec_key*
 llsec_key_alloc(const struct ieee802154_llsec_key *template)
 {
@@ -294,8 +290,6 @@ int mac802154_llsec_key_del(struct mac802154_llsec *sec,
 	return -ENOENT;
 }
 
-
-
 static bool llsec_dev_use_shortaddr(__le16 short_addr)
 {
 	return short_addr != cpu_to_le16(IEEE802154_ADDR_UNDEF) &&
@@ -411,8 +405,6 @@ int mac802154_llsec_dev_del(struct mac802154_llsec *sec, __le64 device_addr)
 	return 0;
 }
 
-
-
 static struct mac802154_llsec_device_key*
 llsec_devkey_find(struct mac802154_llsec_device *dev,
 		  const struct ieee802154_llsec_key_id *key)
@@ -475,8 +467,6 @@ int mac802154_llsec_devkey_del(struct mac802154_llsec *sec,
 	return 0;
 }
 
-
-
 static struct mac802154_llsec_seclevel*
 llsec_find_seclevel(const struct mac802154_llsec *sec,
 		    const struct ieee802154_llsec_seclevel *sl)
@@ -532,8 +522,6 @@ int mac802154_llsec_seclevel_del(struct mac802154_llsec *sec,
 	return 0;
 }
 
-
-
 static int llsec_recover_addr(struct mac802154_llsec *sec,
 			      struct ieee802154_addr *addr)
 {
@@ -609,7 +597,6 @@ found:
 	return llsec_key_get(key);
 }
 
-
 static void llsec_geniv(u8 iv[16], __le64 addr,
 			const struct ieee802154_sechdr *sec)
 {
@@ -786,8 +773,6 @@ fail:
 	return rc;
 }
 
-
-
 static struct mac802154_llsec_device*
 llsec_lookup_dev(struct mac802154_llsec *sec,
 		 const struct ieee802154_addr *addr)
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 3596b29..5cf019a 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -104,7 +104,6 @@ void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 	}
 }
 
-
 int mac802154_get_params(struct net_device *dev,
 			 struct ieee802154_llsec_params *params)
 {
@@ -136,7 +135,6 @@ int mac802154_set_params(struct net_device *dev,
 	return res;
 }
 
-
 int mac802154_add_key(struct net_device *dev,
 		      const struct ieee802154_llsec_key_id *id,
 		      const struct ieee802154_llsec_key *key)
@@ -168,7 +166,6 @@ int mac802154_del_key(struct net_device *dev,
 	return res;
 }
 
-
 int mac802154_add_dev(struct net_device *dev,
 		      const struct ieee802154_llsec_device *llsec_dev)
 {
@@ -198,7 +195,6 @@ int mac802154_del_dev(struct net_device *dev, __le64 dev_addr)
 	return res;
 }
 
-
 int mac802154_add_devkey(struct net_device *dev,
 			 __le64 device_addr,
 			 const struct ieee802154_llsec_device_key *key)
@@ -231,7 +227,6 @@ int mac802154_del_devkey(struct net_device *dev,
 	return res;
 }
 
-
 int mac802154_add_seclevel(struct net_device *dev,
 			   const struct ieee802154_llsec_seclevel *sl)
 {
@@ -262,7 +257,6 @@ int mac802154_del_seclevel(struct net_device *dev,
 	return res;
 }
 
-
 void mac802154_lock_table(struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-- 
1.9.3

