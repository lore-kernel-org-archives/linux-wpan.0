Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58337 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbaLKHDB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 11 Dec 2014 02:03:01 -0500
Received: by mail-wg0-f44.google.com with SMTP id b13so5562193wgh.3
        for <linux-wpan@vger.kernel.org>; Wed, 10 Dec 2014 23:03:00 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools] phy: sync cca handling with mainline
Date: Thu, 11 Dec 2014 08:02:52 +0100
Message-Id: <1418281372-19873-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch updates the nl802154 header with current mainline and making
changes according to cca current mainline handling.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/info.c     | 23 +++++++++++------
 src/nl802154.h | 78 ++++++++++++++++++++++++++++++++++++++++++++--------------
 src/phy.c      | 14 ++++++-----
 3 files changed, 84 insertions(+), 31 deletions(-)

diff --git a/src/info.c b/src/info.c
index 50a7bba..83f2e3e 100644
--- a/src/info.c
+++ b/src/info.c
@@ -20,7 +20,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 	int64_t phy_id = -1;
 	bool print_name = true;
 	struct nlattr *nl_page;
-	unsigned long cca_mode;
+	enum nl802154_cca_modes cca_mode;
 
 	nla_parse(tb_msg, NL802154_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
 		  genlmsg_attrlen(gnlh, 0), NULL);
@@ -62,13 +62,22 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 		printf("current_channel: %d\n", nla_get_u8(tb_msg[NL802154_ATTR_CHANNEL]));
 
 	if (tb_msg[NL802154_ATTR_CCA_MODE]) {
-		cca_mode = nla_get_u8(tb_msg[NL802154_ATTR_CCA_MODE]);
+		cca_mode = nla_get_u32(tb_msg[NL802154_ATTR_CCA_MODE]);
 		printf("cca_mode: %d", cca_mode);
-		if (cca_mode == 3) {
-			if (nla_get_u8(tb_msg[NL802154_ATTR_CCA_MODE3_AND]))
-				printf(" AND ");
-			else
-				printf(" OR ");
+		if (cca_mode == NL802154_CCA_ENERGY_CARRIER) {
+			enum nl802154_cca_opts cca_opt;
+
+			cca_opt = nla_get_u32(tb_msg[NL802154_ATTR_CCA_OPT]);
+			switch (cca_opt) {
+			case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
+				printf(" logical and ");
+				break;
+			case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
+				printf(" logical or ");
+				break;
+			default:
+				printf(" logical op mode unkown ");
+			}
 		}
 		printf("\n");
 	}
diff --git a/src/nl802154.h b/src/nl802154.h
index 0f86ef8..f8b5bc9 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -1,26 +1,24 @@
+#ifndef __NL802154_H
+#define __NL802154_H
 /*
- * nl802154.h
+ * 802.15.4 netlink interface public header
  *
- * Copyright (C) 2007, 2008, 2009 Siemens AG
+ * Copyright 2014 Alexander Aring <aar@pengutronix.de>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  *
  */
 
-#ifndef NL802154_H
-#define NL802154_H
-
 #define NL802154_GENL_NAME "nl802154"
 
 enum nl802154_commands {
@@ -84,7 +82,7 @@ enum nl802154_attrs {
 	NL802154_ATTR_TX_POWER,
 
 	NL802154_ATTR_CCA_MODE,
-	NL802154_ATTR_CCA_MODE3_AND,
+	NL802154_ATTR_CCA_OPT,
 	NL802154_ATTR_CCA_ED_LEVEL,
 
 	NL802154_ATTR_MAX_FRAME_RETRIES,
@@ -109,6 +107,7 @@ enum nl802154_attrs {
 };
 
 enum nl802154_iftype {
+	/* for backwards compatibility TODO */
 	NL802154_IFTYPE_UNSPEC = -1,
 
 	NL802154_IFTYPE_NODE,
@@ -120,4 +119,47 @@ enum nl802154_iftype {
 	NL802154_IFTYPE_MAX = NUM_NL802154_IFTYPES - 1
 };
 
-#endif /* NL802154_H */
+/**
+ * enum nl802154_cca_modes - cca modes
+ *
+ * @__NL802154_CCA_INVALID: cca mode number 0 is reserved
+ * @NL802154_CCA_ENERGY: Energy above threshold
+ * @NL802154_CCA_CARRIER: Carrier sense only
+ * @NL802154_CCA_ENERGY_CARRIER: Carrier sense with energy above threshold
+ * @NL802154_CCA_ALOHA: CCA shall always report an idle medium
+ * @NL802154_CCA_UWB_SHR: UWB preamble sense based on the SHR of a frame
+ * @NL802154_CCA_UWB_MULTIPEXED: UWB preamble sense based on the packet with
+ *	the multiplexed preamble
+ * @__NL802154_CCA_ATTR_AFTER_LAST: Internal
+ * @NL802154_CCA_ATTR_MAX: Maximum CCA attribute number
+ */
+enum nl802154_cca_modes {
+	__NL802154_CCA_INVALID,
+	NL802154_CCA_ENERGY,
+	NL802154_CCA_CARRIER,
+	NL802154_CCA_ENERGY_CARRIER,
+	NL802154_CCA_ALOHA,
+	NL802154_CCA_UWB_SHR,
+	NL802154_CCA_UWB_MULTIPEXED,
+
+	/* keep last */
+	__NL802154_CCA_ATTR_AFTER_LAST,
+	NL802154_CCA_ATTR_MAX = __NL802154_CCA_ATTR_AFTER_LAST - 1
+};
+
+/**
+ * enum nl802154_cca_opts - additional options for cca modes
+ *
+ * @NL802154_CCA_OPT_ENERGY_CARRIER_OR: NL802154_CCA_ENERGY_CARRIER with OR
+ * @NL802154_CCA_OPT_ENERGY_CARRIER_AND: NL802154_CCA_ENERGY_CARRIER with AND
+ */
+enum nl802154_cca_opts {
+	NL802154_CCA_OPT_ENERGY_CARRIER_AND,
+	NL802154_CCA_OPT_ENERGY_CARRIER_OR,
+
+	/* keep last */
+	__NL802154_CCA_OPT_ATTR_AFTER_LAST,
+	NL802154_CCA_OPT_ATTR_MAX = __NL802154_CCA_OPT_ATTR_AFTER_LAST - 1
+};
+
+#endif /* __NL802154_H */
diff --git a/src/phy.c b/src/phy.c
index 8379786..2e25013 100644
--- a/src/phy.c
+++ b/src/phy.c
@@ -80,7 +80,7 @@ static int handle_cca_mode_set(struct nl802154_state *state,
 			       int argc, char **argv,
 			       enum id_input id)
 {
-	unsigned long cca_mode, cca_mode3_and;
+	enum nl802154_cca_modes cca_mode;
 	char *end;
 
 	if (argc < 1)
@@ -91,19 +91,21 @@ static int handle_cca_mode_set(struct nl802154_state *state,
 	if (*end != '\0')
 		return 1;
 
-	if (cca_mode == 3) {
+	if (cca_mode == NL802154_CCA_ENERGY_CARRIER) {
+		enum nl802154_cca_opts cca_opt;
+
 		if (argc < 2)
 			return 1;
 
-		/* CCA_MODE */
-		cca_mode3_and = strtoul(argv[1], &end, 10);
+		/* CCA_OPT */
+		cca_opt = strtoul(argv[1], &end, 10);
 		if (*end != '\0')
 			return 1;
 
-		NLA_PUT_U8(msg, NL802154_ATTR_CCA_MODE3_AND, cca_mode3_and);
+		NLA_PUT_U32(msg, NL802154_ATTR_CCA_OPT, cca_opt);
 	}
 
-	NLA_PUT_U8(msg, NL802154_ATTR_CCA_MODE, cca_mode);
+	NLA_PUT_U32(msg, NL802154_ATTR_CCA_MODE, cca_mode);
 
 	return 0;
 
-- 
2.1.3

