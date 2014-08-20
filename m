Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35166 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbaHTXSZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Aug 2014 19:18:25 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so7626705wib.4
        for <linux-wpan@vger.kernel.org>; Wed, 20 Aug 2014 16:18:23 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 5/8] nl802154: update to current header file
Date: Thu, 21 Aug 2014 01:17:54 +0200
Message-Id: <1408576677-28149-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
References: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/nl802154.h | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/src/nl802154.h b/src/nl802154.h
index c1f2f13..51d08b0 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -18,18 +18,14 @@
  *
  */
 
-#ifndef __LINUX_NL802154_H
-#define __LINUX_NL802154_H
+#ifndef NL802154_H
+#define NL802154_H
 
 #define NL802154_GENL_NAME "nl802154"
 
-/* commands */
-/* REQ should be responded with CONF
- * and INDIC with RESP
- */
 enum nl802154_commands {
 /* don't change the order or add anything between, this is ABI! */
-/* Currently we don't shipping this file via uapi, ignore the above one */
+/* currently we don't shipping this file via uapi, ignore the above one */
 	NL802154_CMD_UNSPEC,
 
 	NL802154_CMD_GET_WPAN_PHY,		/* can dump */
@@ -42,6 +38,11 @@ enum nl802154_commands {
 	NL802154_CMD_NEW_INTERFACE,
 	NL802154_CMD_DEL_INTERFACE,
 
+	NL802154_CMD_SET_PAGE,
+	NL802154_CMD_SET_CHANNEL,
+
+	NL802154_CMD_SET_PAN_ID,
+
 	/* add new commands above here */
 
 	/* used to define NL802154_CMD_MAX below */
@@ -51,7 +52,7 @@ enum nl802154_commands {
 
 enum nl802154_attrs {
 /* don't change the order or add anything between, this is ABI! */
-/* Currently we don't shipping this file via uapi, ignore the above one */
+/* currently we don't shipping this file via uapi, ignore the above one */
 	NL802154_ATTR_UNSPEC,
 
 	NL802154_ATTR_WPAN_PHY,
@@ -61,11 +62,14 @@ enum nl802154_attrs {
 	NL802154_ATTR_IFNAME,
 	NL802154_ATTR_IFTYPE,
 
-	NL802154_ATTR_GENERATION,
+	NL802154_ATTR_WPAN_DEV,
 
-	NL802154_ATTR_SUPPORTED_COMMANDS,
+	NL802154_ATTR_IFACE_SOCKET_OWNER,
 
-	NL802154_ATTR_WPAN_DEV,
+	NL802154_ATTR_PAGE,
+	NL802154_ATTR_CHANNEL,
+
+	NL802154_ATTR_PAN_ID,
 
 	/* add attributes here, update the policy in nl802154.c */
 
-- 
2.0.4

