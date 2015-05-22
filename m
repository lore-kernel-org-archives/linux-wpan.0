Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36804 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756732AbbEVI5Y (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 22 May 2015 04:57:24 -0400
Received: by wgbgq6 with SMTP id gq6so11275677wgb.3
        for <linux-wpan@vger.kernel.org>; Fri, 22 May 2015 01:57:23 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/4] mac802154: use atomic ops for sequence incrementation
Date: Fri, 22 May 2015 10:57:11 +0200
Message-Id: <1432285031-3360-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1432285031-3360-1-git-send-email-alex.aring@gmail.com>
References: <1432285031-3360-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch will use atomic operations for sequence number incrementation
while MAC header generation. Upper layers like af_802154 or 6LoWPAN
could call this function in a parallel context while generating 802.15.4
MAC header before queuing into wpan interfaces transmit queue.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h |  4 ++--
 net/mac802154/iface.c   | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index c6aa1d2..4de59aa 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -177,9 +177,9 @@ struct wpan_dev {
 	__le64 extended_addr;
 
 	/* MAC BSN field */
-	u8 bsn;
+	atomic_t bsn;
 	/* MAC DSN field */
-	u8 dsn;
+	atomic_t dsn;
 
 	u8 min_be;
 	u8 max_be;
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 866d27f..f30788d 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -365,10 +365,7 @@ static int mac802154_header_create(struct sk_buff *skb,
 	hdr.fc.type = cb->type;
 	hdr.fc.security_enabled = cb->secen;
 	hdr.fc.ack_request = cb->ackreq;
-	/* TODO: use atomic_t as dsn, dsn need to be locked when AF_IEEE802154
-	 * and IEEE802154 6LoWPAN call this at the same time.
-	 */
-	hdr.seq = dev->ieee802154_ptr->dsn++;
+	hdr.seq = atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;
 
 	if (mac802154_set_header_security(sdata, &hdr, cb) < 0)
 		return -EINVAL;
@@ -464,13 +461,16 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 		       enum nl802154_iftype type)
 {
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+	u8 tmp;
 
 	/* set some type-dependent values */
 	sdata->vif.type = type;
 	sdata->wpan_dev.iftype = type;
 
-	get_random_bytes(&wpan_dev->bsn, 1);
-	get_random_bytes(&wpan_dev->dsn, 1);
+	get_random_bytes(&tmp, sizeof(tmp));
+	atomic_set(&wpan_dev->bsn, tmp);
+	get_random_bytes(&tmp, sizeof(tmp));
+	atomic_set(&wpan_dev->dsn, tmp);
 
 	/* defaults per 802.15.4-2011 */
 	wpan_dev->min_be = 3;
-- 
2.4.1

