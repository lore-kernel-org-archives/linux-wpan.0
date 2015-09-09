Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33980 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbbIITKF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Sep 2015 15:10:05 -0400
Received: by wicfx3 with SMTP id fx3so2612573wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 09 Sep 2015 12:10:04 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/2] ieee802154: iface: fix header parse buffer overflow
Date: Wed,  9 Sep 2015 21:09:40 +0200
Message-Id: <1441825780-6461-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1441825780-6461-1-git-send-email-alex.aring@gmail.com>
References: <1441825780-6461-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fixes a buffer overflow for header_parse callback. This
callback is used by net/packet/af_packet.c which calls:

sll->sll_halen = dev_parse_header(skb, sll->sll_addr);

The "sll->sll_addr" is an array of eight bytes, but the size of struct
ieee802154_addr is more than eight bytes long. I got funny mac header
overwrites while dumping with wireshark/tcpdump.

I suppose with this function we can do filtering stuff by source
address, so we do if extended address then copy the full address and
"sll->sll_addr" is eight bytes long. If short address we copy a
combination with "pan_id+short_addr", the "sll->sll_addr" should be four
then. In case of none, we do nothing and "sll->sll_addr" returns zero.
This should provide some unique address matching mechanism.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h |  2 ++
 net/mac802154/iface.c      | 26 +++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index db01492..7b1a28a 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -37,6 +37,8 @@
 #define IEEE802154_ADDR_SHORT_UNSPEC	0xfffe
 
 #define IEEE802154_EXTENDED_ADDR_LEN	8
+#define IEEE802154_SHORT_ADDR_LEN	2
+#define IEEE802154_PAN_ID_LEN		2
 
 #define IEEE802154_LIFS_PERIOD		40
 #define IEEE802154_SIFS_PERIOD		12
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index ed26952..87e4183 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -427,15 +427,35 @@ static int
 mac802154_header_parse(const struct sk_buff *skb, unsigned char *haddr)
 {
 	struct ieee802154_hdr hdr;
-	struct ieee802154_addr *addr = (struct ieee802154_addr *)haddr;
+	int pos = 0;
 
 	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0) {
 		pr_debug("malformed packet\n");
 		return 0;
 	}
 
-	*addr = hdr.source;
-	return sizeof(*addr);
+	switch (hdr.source.mode) {
+	case IEEE802154_ADDR_LONG:
+		memcpy(haddr + pos, &hdr.source.extended_addr,
+		       IEEE802154_EXTENDED_ADDR_LEN);
+		pos += IEEE802154_EXTENDED_ADDR_LEN;
+		break;
+	case IEEE802154_ADDR_SHORT:
+		memcpy(haddr + pos, &hdr.source.pan_id,
+		       IEEE802154_PAN_ID_LEN);
+		pos += IEEE802154_PAN_ID_LEN;
+		memcpy(haddr + pos, &hdr.source.short_addr,
+		       IEEE802154_SHORT_ADDR_LEN);
+		pos += IEEE802154_SHORT_ADDR_LEN;
+		break;
+	case IEEE802154_ADDR_NONE:
+		/* fall-through */
+
+	default:
+		break;
+	}
+
+	return pos;
 }
 
 static struct header_ops mac802154_header_ops = {
-- 
2.5.1

