Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:32804 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbbIXHhU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Sep 2015 03:37:20 -0400
Received: by wiclk2 with SMTP id lk2so15786108wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 24 Sep 2015 00:37:19 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/2] mac802154: iface: assume big endian for af_packet
Date: Thu, 24 Sep 2015 09:37:11 +0200
Message-Id: <1443080231-6416-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1443080231-6416-1-git-send-email-alex.aring@gmail.com>
References: <1443080231-6416-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The callback "create" and "parse" from header_ops are called from
netdev core upper-layer functionality, like af_packet. These callbacks
assumes big endian for addresses and we should not introduce a special
byteordering handling for ieee802154 over af_packet in userspace.

We have an identical issue with setting the mac address which also
assumes big endian byteordering.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index b5a0936..3954bcf 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -461,7 +461,7 @@ static int mac802154_header_create(struct sk_buff *skb,
 
 	hdr.dest.pan_id = wpan_dev->pan_id;
 	hdr.dest.mode = IEEE802154_ADDR_LONG;
-	memcpy(&hdr.dest.extended_addr, daddr, IEEE802154_EXTENDED_ADDR_LEN);
+	ieee802154_be64_to_le64(&hdr.dest.extended_addr, daddr);
 
 	hdr.source.pan_id = hdr.dest.pan_id;
 	hdr.source.mode = IEEE802154_ADDR_LONG;
@@ -469,8 +469,7 @@ static int mac802154_header_create(struct sk_buff *skb,
 	if (!saddr)
 		hdr.source.extended_addr = wpan_dev->extended_addr;
 	else
-		memcpy(&hdr.source.extended_addr, saddr,
-		       IEEE802154_EXTENDED_ADDR_LEN);
+		ieee802154_be64_to_le64(&hdr.source.extended_addr, saddr);
 
 	hlen = ieee802154_hdr_push(skb, &hdr);
 	if (hlen < 0)
@@ -496,8 +495,7 @@ mac802154_header_parse(const struct sk_buff *skb, unsigned char *haddr)
 	}
 
 	if (hdr.source.mode == IEEE802154_ADDR_LONG) {
-		memcpy(haddr, &hdr.source.extended_addr,
-		       IEEE802154_EXTENDED_ADDR_LEN);
+		ieee802154_le64_to_be64(haddr, &hdr.source.extended_addr);
 		return IEEE802154_EXTENDED_ADDR_LEN;
 	}
 
-- 
2.5.2

