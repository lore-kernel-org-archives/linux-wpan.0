Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34231 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaKPUGf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 16 Nov 2014 15:06:35 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so1802849wgh.30
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 12:06:34 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 2/2] interface: mac: fix byteorder issues
Date: Sun, 16 Nov 2014 21:05:58 +0100
Message-Id: <1416168358-28088-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1416168358-28088-1-git-send-email-alex.aring@gmail.com>
References: <1416168358-28088-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

The kernel except and delivers little endian byteorder. This patch fix
the current handling with byteorder.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/interface.c | 12 ++++++------
 src/mac.c       |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/interface.c b/src/interface.c
index 0ac9c5a..095753b 100644
--- a/src/interface.c
+++ b/src/interface.c
@@ -201,15 +201,15 @@ static int print_iface_handler(struct nl_msg *msg, void *arg)
 	if (tb_msg[NL802154_ATTR_WPAN_DEV])
 		printf("%s\twpan_dev 0x%llx\n", indent,
 		       (unsigned long long)nla_get_u64(tb_msg[NL802154_ATTR_WPAN_DEV]));
-	/* TODO byteorder? */
 	if (tb_msg[NL802154_ATTR_EXTENDED_ADDR])
-		printf("%s\textended_addr 0x%016llx\n", indent, nla_get_u64(tb_msg[NL802154_ATTR_EXTENDED_ADDR]));
-	/* TODO byteorder? */
+		printf("%s\textended_addr 0x%016llx\n", indent,
+		       le64toh(nla_get_u64(tb_msg[NL802154_ATTR_EXTENDED_ADDR])));
 	if (tb_msg[NL802154_ATTR_SHORT_ADDR])
-		printf("%s\tshort_addr 0x%04x\n", indent, nla_get_u16(tb_msg[NL802154_ATTR_SHORT_ADDR]));
-	/* TODO byteorder? */
+		printf("%s\tshort_addr 0x%04x\n", indent,
+		       le16toh(nla_get_u16(tb_msg[NL802154_ATTR_SHORT_ADDR])));
 	if (tb_msg[NL802154_ATTR_PAN_ID])
-		printf("%s\tpan_id 0x%04x\n", indent, nla_get_u16(tb_msg[NL802154_ATTR_PAN_ID]));
+		printf("%s\tpan_id 0x%04x\n", indent,
+		       le16toh(nla_get_u16(tb_msg[NL802154_ATTR_PAN_ID])));
 	if (tb_msg[NL802154_ATTR_IFTYPE])
 		printf("%s\ttype %s\n", indent, iftype_name(nla_get_u32(tb_msg[NL802154_ATTR_IFTYPE])));
 	if (!wpan_phy && tb_msg[NL802154_ATTR_WPAN_PHY])
diff --git a/src/mac.c b/src/mac.c
index 3f2dfc8..703d09f 100644
--- a/src/mac.c
+++ b/src/mac.c
@@ -30,7 +30,7 @@ static int handle_pan_id_set(struct nl802154_state *state,
 	if (*end != '\0')
 		return 1;
 
-	NLA_PUT_U16(msg, NL802154_ATTR_PAN_ID, pan_id);
+	NLA_PUT_U16(msg, NL802154_ATTR_PAN_ID, htole16(pan_id));
 
 	return 0;
 
@@ -57,7 +57,7 @@ static int handle_short_addr_set(struct nl802154_state *state,
 	if (*end != '\0')
 		return 1;
 
-	NLA_PUT_U16(msg, NL802154_ATTR_SHORT_ADDR, short_addr);
+	NLA_PUT_U16(msg, NL802154_ATTR_SHORT_ADDR, htole16(short_addr));
 
 	return 0;
 
-- 
2.1.3

