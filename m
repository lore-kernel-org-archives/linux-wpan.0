Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37865 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbbIRJaz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 18 Sep 2015 05:30:55 -0400
Received: by wicfx3 with SMTP id fx3so23171891wic.0
        for <linux-wpan@vger.kernel.org>; Fri, 18 Sep 2015 02:30:54 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/5] ieee802154: header_ops: fix frame control setting
Date: Fri, 18 Sep 2015 11:30:41 +0200
Message-Id: <1442568644-2158-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442568644-2158-1-git-send-email-alex.aring@gmail.com>
References: <1442568644-2158-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Sometimes upper-layer protocols wants to generate a new mac header by
filling "struct ieee802154_hdr" only. These upper-layers sets for the
address settings the source and dest fields, but not the fc fields for
indicate the source and dest address mode. This patch changes the
"ieee802154_hdr_push" function so the fc address fields are set
according the source and dest fields of "struct ieee802154_hdr".

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/ieee802154_netdev.h |  2 +-
 net/ieee802154/header_ops.c     | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index 2c10a9f..95a71bc 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -99,7 +99,7 @@ struct ieee802154_hdr {
  * hdr->fc will be ignored. this includes the INTRA_PAN bit and the frame
  * version, if SECEN is set.
  */
-int ieee802154_hdr_push(struct sk_buff *skb, const struct ieee802154_hdr *hdr);
+int ieee802154_hdr_push(struct sk_buff *skb, struct ieee802154_hdr *hdr);
 
 /* pulls the entire 802.15.4 header off of the skb, including the security
  * header, and performs pan id decompression
diff --git a/net/ieee802154/header_ops.c b/net/ieee802154/header_ops.c
index a051b69..d8443b0 100644
--- a/net/ieee802154/header_ops.c
+++ b/net/ieee802154/header_ops.c
@@ -83,35 +83,35 @@ ieee802154_hdr_push_sechdr(u8 *buf, const struct ieee802154_sechdr *hdr)
 }
 
 int
-ieee802154_hdr_push(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
+ieee802154_hdr_push(struct sk_buff *skb, struct ieee802154_hdr *hdr)
 {
 	u8 buf[MAC802154_FRAME_HARD_HEADER_LEN];
 	int pos = 2;
 	int rc;
-	struct ieee802154_hdr_fc fc = hdr->fc;
+	struct ieee802154_hdr_fc *fc = &hdr->fc;
 
 	buf[pos++] = hdr->seq;
 
-	fc.dest_addr_mode = hdr->dest.mode;
+	fc->dest_addr_mode = hdr->dest.mode;
 
 	rc = ieee802154_hdr_push_addr(buf + pos, &hdr->dest, false);
 	if (rc < 0)
 		return -EINVAL;
 	pos += rc;
 
-	fc.source_addr_mode = hdr->source.mode;
+	fc->source_addr_mode = hdr->source.mode;
 
 	if (hdr->source.pan_id == hdr->dest.pan_id &&
 	    hdr->dest.mode != IEEE802154_ADDR_NONE)
-		fc.intra_pan = true;
+		fc->intra_pan = true;
 
-	rc = ieee802154_hdr_push_addr(buf + pos, &hdr->source, fc.intra_pan);
+	rc = ieee802154_hdr_push_addr(buf + pos, &hdr->source, fc->intra_pan);
 	if (rc < 0)
 		return -EINVAL;
 	pos += rc;
 
-	if (fc.security_enabled) {
-		fc.version = 1;
+	if (fc->security_enabled) {
+		fc->version = 1;
 
 		rc = ieee802154_hdr_push_sechdr(buf + pos, &hdr->sec);
 		if (rc < 0)
@@ -120,7 +120,7 @@ ieee802154_hdr_push(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 		pos += rc;
 	}
 
-	memcpy(buf, &fc, 2);
+	memcpy(buf, fc, 2);
 
 	memcpy(skb_push(skb, pos), buf, pos);
 
-- 
2.5.2

