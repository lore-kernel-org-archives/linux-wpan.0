Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46627 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051AbcGKTvR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Jul 2016 15:51:17 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 02/20] nhc: add TODO for nhc work
Date: Mon, 11 Jul 2016 21:50:26 +0200
Message-Id: <20160711195044.25343-3-aar@pengutronix.de>
In-Reply-To: <20160711195044.25343-1-aar@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com, Alexander Aring <aar@pengutronix.de>

This patch adds a TODO for nhc to do everything what we need inside
compress handling. Also we should check if the compression doesn't add
more bytes than sending raw next header format. We don't hit that issue
yet because NHC id is at worst case one byte long like the next header
byte in IPv6 header (which will be elided when using NHC). But on NHC
id's which are two bytes long it's likely that compressions adds more
data than sending raw next header.

The root of this issue to care about is that with running IPHC after a
IPv6 packet which is 1280 bytes long, the IPHC, NHC header with payload
should not exceed 1280 bytes. This will break bluetooth L2CAP mtu which
is 1280 bytes as well.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/nhc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
index 7008d53..55df7f7 100644
--- a/net/6lowpan/nhc.c
+++ b/net/6lowpan/nhc.c
@@ -94,6 +94,21 @@ static struct lowpan_nhc *lowpan_nhc_by_nhcid(const struct sk_buff *skb)
 	return NULL;
 }
 
+/* TODO remove this and do everything in compress callback,
+ * this means, setting NHC bit in IPHC, check if compression
+ * make sense and doing compression. We will hit the issue
+ * when having two bytes long NHC ID's that the IPHC compression
+ * could be have more bytes than using raw next header, this
+ * will break btle 6lowpan.
+ *
+ * Marcel told to look into skb frag and linearlize functionality.
+ * This way is very ugly.
+ * Additonal change handling that sending compressed on transmit
+ * is default disabled. Use a compression flag e.g. RFC6775
+ *
+ * I see nhc in a bad state currently, this need to be fixed
+ * before adding new nhc's.
+ */
 int lowpan_nhc_check_compression(struct sk_buff *skb,
 				 const struct ipv6hdr *hdr, u8 **hc_ptr)
 {
-- 
2.9.0

