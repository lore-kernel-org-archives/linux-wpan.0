Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:34386 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932405AbbCRN1U (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Mar 2015 09:27:20 -0400
Received: by wggv3 with SMTP id v3so35348770wgg.1
        for <linux-wpan@vger.kernel.org>; Wed, 18 Mar 2015 06:27:19 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 2/2] mac: use NL802154_CMD_SET_INTERFACE
Date: Wed, 18 Mar 2015 14:27:09 +0100
Message-Id: <1426685229-31900-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1426685229-31900-1-git-send-email-alex.aring@gmail.com>
References: <1426685229-31900-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch change all set commands for mac interface settings to
NL802154_CMD_SET_INTERFACE which is the new command. The decision which
setting should be set is now determined which attribute is set.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/mac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/mac.c b/src/mac.c
index 703d09f..9dd8456 100644
--- a/src/mac.c
+++ b/src/mac.c
@@ -38,7 +38,7 @@ nla_put_failure:
 	return -ENOBUFS;
 }
 COMMAND(set, pan_id, "<pan_id>",
-	NL802154_CMD_SET_PAN_ID, 0, CIB_NETDEV, handle_pan_id_set, NULL);
+	NL802154_CMD_SET_INTERFACE, 0, CIB_NETDEV, handle_pan_id_set, NULL);
 
 static int handle_short_addr_set(struct nl802154_state *state,
 				 struct nl_cb *cb,
@@ -65,7 +65,7 @@ nla_put_failure:
 	return -ENOBUFS;
 }
 COMMAND(set, short_addr, "<short_addr>",
-	NL802154_CMD_SET_SHORT_ADDR, 0, CIB_NETDEV, handle_short_addr_set, NULL);
+	NL802154_CMD_SET_INTERFACE, 0, CIB_NETDEV, handle_short_addr_set, NULL);
 
 static int handle_max_frame_retries_set(struct nl802154_state *state,
 					struct nl_cb *cb,
@@ -92,7 +92,7 @@ nla_put_failure:
 	return -ENOBUFS;
 }
 COMMAND(set, max_frame_retries, "<retries>",
-	NL802154_CMD_SET_MAX_FRAME_RETRIES, 0, CIB_NETDEV,
+	NL802154_CMD_SET_INTERFACE, 0, CIB_NETDEV,
 	handle_max_frame_retries_set, NULL);
 
 static int handle_backoff_exponent(struct nl802154_state *state,
@@ -127,7 +127,7 @@ nla_put_failure:
 	return -ENOBUFS;
 }
 COMMAND(set, backoff_exponents, "<min_be> <max_be>",
-	NL802154_CMD_SET_BACKOFF_EXPONENT, 0, CIB_NETDEV,
+	NL802154_CMD_SET_INTERFACE, 0, CIB_NETDEV,
 	handle_backoff_exponent, NULL);
 
 static int handle_max_csma_backoffs(struct nl802154_state *state,
@@ -155,7 +155,7 @@ nla_put_failure:
 	return -ENOBUFS;
 }
 COMMAND(set, max_csma_backoffs, "<backoffs>",
-	NL802154_CMD_SET_MAX_CSMA_BACKOFFS, 0, CIB_NETDEV,
+	NL802154_CMD_SET_INTERFACE, 0, CIB_NETDEV,
 	handle_max_csma_backoffs, NULL);
 
 
@@ -184,4 +184,4 @@ nla_put_failure:
 	return -ENOBUFS;
 }
 COMMAND(set, lbt, "<1|0>",
-	NL802154_CMD_SET_LBT_MODE, 0, CIB_NETDEV, handle_lbt_mode, NULL);
+	NL802154_CMD_SET_INTERFACE, 0, CIB_NETDEV, handle_lbt_mode, NULL);
-- 
2.3.3

