Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:55997 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516AbaIDIEM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Sep 2014 04:04:12 -0400
Received: by mail-wg0-f45.google.com with SMTP id k14so9752306wgh.16
        for <linux-wpan@vger.kernel.org>; Thu, 04 Sep 2014 01:04:10 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 1/6] nl_updates: initial commit of nl_updates
Date: Thu,  4 Sep 2014 10:03:49 +0200
Message-Id: <1409817834-14660-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1409817834-14660-1-git-send-email-alex.aring@gmail.com>
References: <1409817834-14660-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds a nl_updates header file to handle signed integer types
via netlink.

These types are support mainline at linux kernel but not supported by
current netlink library, this is a workaround to add these types.

It's protected by an ifdef, so it's safe when new netlink libraries will
add these functions.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/nl_updates.h | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 src/nl_updates.h

diff --git a/src/nl_updates.h b/src/nl_updates.h
new file mode 100644
index 0000000..066d5bb
--- /dev/null
+++ b/src/nl_updates.h
@@ -0,0 +1,75 @@
+/*
+ *   lib/nl_updates.h - Updates to libnl which are not synced from kernel yet
+ *   Copyright (C) 2012-2013 Jiri Pirko <jiri@resnulli.us>
+ *
+ *   This library is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU Lesser General Public
+ *   License as published by the Free Software Foundation; either
+ *   version 2.1 of the License, or (at your option) any later version.
+ *
+ *   This library is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *   Lesser General Public License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public
+ *   License along with this library; if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _NL_UPDATES_H_
+#define _NL_UPDATES_H_
+
+#ifndef NLA_BINARY
+#define NLA_BINARY 11
+#endif
+
+#ifndef NLA_S8
+/*
+ * Presume that libnl will add all types and relevant puts/gets at once
+ * so check only for NLA_S8.
+ */
+#define NLA_S8 12
+#define NLA_S16 13
+#define NLA_S32 14
+#define NLA_S64 15
+
+/**
+ * Add 8 bit signed integer attribute to netlink message.
+ * @arg msg		Netlink message.
+ * @arg attrtype	Attribute type.
+ * @arg value		Numeric value.
+ */
+#define NLA_PUT_S8(msg, attrtype, value) \
+	NLA_PUT_TYPE(msg, int8_t, attrtype, value)
+
+/**
+ * Add 16 bit signed integer attribute to netlink message.
+ * @arg msg		Netlink message.
+ * @arg attrtype	Attribute type.
+ * @arg value		Numeric value.
+ */
+#define NLA_PUT_S16(msg, attrtype, value) \
+	NLA_PUT_TYPE(msg, int16_t, attrtype, value)
+
+/**
+ * Add 32 bit signed integer attribute to netlink message.
+ * @arg msg		Netlink message.
+ * @arg attrtype	Attribute type.
+ * @arg value		Numeric value.
+ */
+#define NLA_PUT_S32(msg, attrtype, value) \
+	NLA_PUT_TYPE(msg, int32_t, attrtype, value)
+
+/**
+ * Add 64 bit signed integer attribute to netlink message.
+ * @arg msg		Netlink message.
+ * @arg attrtype	Attribute type.
+ * @arg value		Numeric value.
+ */
+#define NLA_PUT_S64(msg, attrtype, value) \
+	NLA_PUT_TYPE(msg, int64_t, attrtype, value)
+
+#endif
+
+#endif /* _NL_UPDATES_H_ */
-- 
2.1.0

