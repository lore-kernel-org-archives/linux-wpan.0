Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:65497 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbaIDJdX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Sep 2014 05:33:23 -0400
Received: by mail-wg0-f50.google.com with SMTP id x12so9961227wgg.9
        for <linux-wpan@vger.kernel.org>; Thu, 04 Sep 2014 02:33:22 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-tools 1/6] nl_extras: initial commit for extra nl bindings
Date: Thu,  4 Sep 2014 11:32:49 +0200
Message-Id: <1409823174-22491-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1409823174-22491-1-git-send-email-alex.aring@gmail.com>
References: <1409823174-22491-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This header file is needed for additional signed bindings which are not
in netlink library, currently.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/nl_extras.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 src/nl_extras.h

diff --git a/src/nl_extras.h b/src/nl_extras.h
new file mode 100644
index 0000000..39a97c6
--- /dev/null
+++ b/src/nl_extras.h
@@ -0,0 +1,36 @@
+#ifndef __NL_EXTRAS_H
+#define __NL_EXTRAS_H
+
+#ifndef NLA_S8
+
+#define NLA_S8	13
+#define NLA_PUT_S8(n, attrtype, value) \
+	NLA_PUT_TYPE(n, int8_t, attrtype, value)
+
+#endif /* NLA_S8 */
+
+#ifndef NLA_S16
+
+#define NLA_S16	14
+#define NLA_PUT_S16(n, attrtype, value) \
+	NLA_PUT_TYPE(n, int16_t, attrtype, value)
+
+#endif /* NLA_S16 */
+
+#ifndef NLA_S32
+
+#define NLA_S32	15
+#define NLA_PUT_S32(n, attrtype, value) \
+	NLA_PUT_TYPE(n, int32_t, attrtype, value)
+
+#endif /* NLA_S32 */
+
+#ifndef NLA_S64
+
+#define NLA_S64	16
+#define NLA_PUT_S64(n, attrtype, value) \
+	NLA_PUT_TYPE(n, int64_t, attrtype, value)
+
+#endif /* NLA_S64 */
+
+#endif /* __NL_EXTRAS_H */
-- 
2.1.0

