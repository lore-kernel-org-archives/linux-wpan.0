Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36545 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbbFYGci (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Jun 2015 02:32:38 -0400
Received: by pdcu2 with SMTP id u2so46766413pdc.3
        for <linux-wpan@vger.kernel.org>; Wed, 24 Jun 2015 23:32:37 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: rename seq to sequence_number
Date: Thu, 25 Jun 2015 12:01:11 +0530
Message-Id: <1435213871-2450-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch rename ieee802154_hdr member seq to sequence_number.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 include/net/ieee802154_netdev.h |    2 +-
 net/ieee802154/header_ops.c     |    2 +-
 net/mac802154/iface.c           |    2 +-
 net/mac802154/rx.c              |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index 2c10a9f..9c95a74 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -88,7 +88,7 @@ struct ieee802154_hdr_fc {
 
 struct ieee802154_hdr {
 	struct ieee802154_hdr_fc fc;
-	u8 seq;
+	u8 sequence_number;
 	struct ieee802154_addr source;
 	struct ieee802154_addr dest;
 	struct ieee802154_sechdr sec;
diff --git a/net/ieee802154/header_ops.c b/net/ieee802154/header_ops.c
index a051b69..9c3291b 100644
--- a/net/ieee802154/header_ops.c
+++ b/net/ieee802154/header_ops.c
@@ -90,7 +90,7 @@ ieee802154_hdr_push(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 	int rc;
 	struct ieee802154_hdr_fc fc = hdr->fc;
 
-	buf[pos++] = hdr->seq;
+	buf[pos++] = hdr->sequence_number;
 
 	fc.dest_addr_mode = hdr->dest.mode;
 
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 416de90..0bc0f44 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -372,7 +372,7 @@ static int mac802154_header_create(struct sk_buff *skb,
 	hdr.fc.type = cb->type;
 	hdr.fc.security_enabled = cb->secen;
 	hdr.fc.ack_request = cb->ackreq;
-	hdr.seq = atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;
+	hdr.sequence_number = atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;
 
 	if (mac802154_set_header_security(sdata, &hdr, cb) < 0)
 		return -EINVAL;
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 5a258c1..48781a6 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -142,7 +142,7 @@ ieee802154_parse_frame_start(struct sk_buff *skb, struct ieee802154_hdr *hdr)
 	skb->mac_len = hlen;
 
 	pr_debug("fc: %04x dsn: %02x\n", le16_to_cpup((__le16 *)&hdr->fc),
-		 hdr->seq);
+		 hdr->sequence_number);
 
 	cb->type = hdr->fc.type;
 	cb->ackreq = hdr->fc.ack_request;
-- 
1.7.9.5

