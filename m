Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:51902 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbaKIHhd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:33 -0500
Received: by mail-wg0-f51.google.com with SMTP id l18so6523890wgh.38
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:32 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 08/15] ieee802154: add new nl802154 header
Date: Sun,  9 Nov 2014 08:36:52 +0100
Message-Id: <1415518619-4370-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds the new userspace header for nl802154. We don't place
this header in include/uapi now. This header could be modified in the
next time.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 MAINTAINERS            |   1 +
 include/net/nl802154.h | 122 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 include/net/nl802154.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b42eb50..7ec37a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4699,6 +4699,7 @@ F:	net/mac802154/
 F:	drivers/net/ieee802154/
 F:	include/linux/nl802154.h
 F:	include/linux/ieee802154.h
+F:	include/net/nl802154.h
 F:	include/net/mac802154.h
 F:	include/net/af_ieee802154.h
 F:	include/net/cfg802154.h
diff --git a/include/net/nl802154.h b/include/net/nl802154.h
new file mode 100644
index 0000000..6dbd406
--- /dev/null
+++ b/include/net/nl802154.h
@@ -0,0 +1,122 @@
+#ifndef __NL802154_H
+#define __NL802154_H
+/*
+ * 802.15.4 netlink interface public header
+ *
+ * Copyright 2014 Alexander Aring <aar@pengutronix.de>
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+
+#define NL802154_GENL_NAME "nl802154"
+
+enum nl802154_commands {
+/* don't change the order or add anything between, this is ABI! */
+/* currently we don't shipping this file via uapi, ignore the above one */
+	NL802154_CMD_UNSPEC,
+
+	NL802154_CMD_GET_WPAN_PHY,		/* can dump */
+	NL802154_CMD_SET_WPAN_PHY,
+	NL802154_CMD_NEW_WPAN_PHY,
+	NL802154_CMD_DEL_WPAN_PHY,
+
+	NL802154_CMD_GET_INTERFACE,		/* can dump */
+	NL802154_CMD_SET_INTERFACE,
+	NL802154_CMD_NEW_INTERFACE,
+	NL802154_CMD_DEL_INTERFACE,
+
+	NL802154_CMD_SET_CHANNEL,
+
+	NL802154_CMD_SET_PAN_ID,
+	NL802154_CMD_SET_SHORT_ADDR,
+
+	NL802154_CMD_SET_TX_POWER,
+	NL802154_CMD_SET_CCA_MODE,
+	NL802154_CMD_SET_CCA_ED_LEVEL,
+
+	NL802154_CMD_SET_MAX_FRAME_RETRIES,
+
+	NL802154_CMD_SET_BACKOFF_EXPONENT,
+	NL802154_CMD_SET_MAX_CSMA_BACKOFFS,
+
+	NL802154_CMD_SET_LBT_MODE,
+
+	/* add new commands above here */
+
+	/* used to define NL802154_CMD_MAX below */
+	__NL802154_CMD_AFTER_LAST,
+	NL802154_CMD_MAX = __NL802154_CMD_AFTER_LAST - 1
+};
+
+enum nl802154_attrs {
+/* don't change the order or add anything between, this is ABI! */
+/* currently we don't shipping this file via uapi, ignore the above one */
+	NL802154_ATTR_UNSPEC,
+
+	NL802154_ATTR_WPAN_PHY,
+	NL802154_ATTR_WPAN_PHY_NAME,
+
+	NL802154_ATTR_IFINDEX,
+	NL802154_ATTR_IFNAME,
+	NL802154_ATTR_IFTYPE,
+
+	NL802154_ATTR_WPAN_DEV,
+
+	NL802154_ATTR_PAGE,
+	NL802154_ATTR_CHANNEL,
+
+	NL802154_ATTR_PAN_ID,
+	NL802154_ATTR_SHORT_ADDR,
+
+	NL802154_ATTR_TX_POWER,
+
+	NL802154_ATTR_CCA_MODE,
+	NL802154_ATTR_CCA_MODE3_AND,
+	NL802154_ATTR_CCA_ED_LEVEL,
+
+	NL802154_ATTR_MAX_FRAME_RETRIES,
+
+	NL802154_ATTR_MAX_BE,
+	NL802154_ATTR_MIN_BE,
+	NL802154_ATTR_MAX_CSMA_BACKOFFS,
+
+	NL802154_ATTR_LBT_MODE,
+
+	NL802154_ATTR_GENERATION,
+
+	NL802154_ATTR_CHANNELS_SUPPORTED,
+	NL802154_ATTR_SUPPORTED_CHANNEL,
+
+	NL802154_ATTR_EXTENDED_ADDR,
+
+	/* add attributes here, update the policy in nl802154.c */
+
+	__NL802154_ATTR_AFTER_LAST,
+	NL802154_ATTR_MAX = __NL802154_ATTR_AFTER_LAST - 1
+};
+
+enum nl802154_iftype {
+	/* for backwards compatibility TODO */
+	NL802154_IFTYPE_UNSPEC = -1,
+
+	NL802154_IFTYPE_NODE,
+	NL802154_IFTYPE_MONITOR,
+	NL802154_IFTYPE_COORD,
+
+	/* keep last */
+	NUM_NL802154_IFTYPES,
+	NL802154_IFTYPE_MAX = NUM_NL802154_IFTYPES - 1
+};
+
+#endif /* __NL802154_H */
-- 
2.1.3

