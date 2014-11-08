Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:54741 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbaKHRBD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 8 Nov 2014 12:01:03 -0500
Received: by mail-wg0-f54.google.com with SMTP id n12so5857263wgh.13
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 09:01:01 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 5/5] nl802154: update nl802154 header
Date: Sat,  8 Nov 2014 18:00:50 +0100
Message-Id: <1415466050-2630-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415466050-2630-1-git-send-email-alex.aring@gmail.com>
References: <1415466050-2630-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/nl802154.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/src/nl802154.h b/src/nl802154.h
index f799d59..0f86ef8 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -38,7 +38,6 @@ enum nl802154_commands {
 	NL802154_CMD_NEW_INTERFACE,
 	NL802154_CMD_DEL_INTERFACE,
 
-	NL802154_CMD_SET_PAGE,
 	NL802154_CMD_SET_CHANNEL,
 
 	NL802154_CMD_SET_PAN_ID,
@@ -50,9 +49,8 @@ enum nl802154_commands {
 
 	NL802154_CMD_SET_MAX_FRAME_RETRIES,
 
-	NL802154_CMD_SET_MAX_BE,
+	NL802154_CMD_SET_BACKOFF_EXPONENT,
 	NL802154_CMD_SET_MAX_CSMA_BACKOFFS,
-	NL802154_CMD_SET_MIN_BE,
 
 	NL802154_CMD_SET_LBT_MODE,
 
@@ -77,10 +75,6 @@ enum nl802154_attrs {
 
 	NL802154_ATTR_WPAN_DEV,
 
-	NL802154_ATTR_IFACE_SOCKET_OWNER,
-
-	NL802154_ATTR_SPLIT_WPAN_PHY_DUMP,
-
 	NL802154_ATTR_PAGE,
 	NL802154_ATTR_CHANNEL,
 
@@ -96,8 +90,8 @@ enum nl802154_attrs {
 	NL802154_ATTR_MAX_FRAME_RETRIES,
 
 	NL802154_ATTR_MAX_BE,
-	NL802154_ATTR_MAX_CSMA_BACKOFFS,
 	NL802154_ATTR_MIN_BE,
+	NL802154_ATTR_MAX_CSMA_BACKOFFS,
 
 	NL802154_ATTR_LBT_MODE,
 
-- 
2.1.3

