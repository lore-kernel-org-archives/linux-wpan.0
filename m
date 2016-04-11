Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48838 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753364AbcDKJE2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Apr 2016 05:04:28 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 01/11] ieee802154: cleanups for ieee802154.h
Date: Mon, 11 Apr 2016 11:04:14 +0200
Message-Id: <1460365464-12435-2-git-send-email-aar@pengutronix.de>
In-Reply-To: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
References: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, Alexander Aring <aar@pengutronix.de>

This patch removes some const from non-pointer types and fixes the
function name for the ieee802154_is_valid_extended_unicast_addr
comment.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/linux/ieee802154.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index d3e4156..303f446 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -260,17 +260,17 @@ static inline bool ieee802154_is_intra_pan(__le16 fc)
  *
  * @len: psdu len with (MHR + payload + MFR)
  */
-static inline bool ieee802154_is_valid_psdu_len(const u8 len)
+static inline bool ieee802154_is_valid_psdu_len(u8 len)
 {
 	return (len == IEEE802154_ACK_PSDU_LEN ||
 		(len >= IEEE802154_MIN_PSDU_LEN && len <= IEEE802154_MTU));
 }
 
 /**
- * ieee802154_is_valid_psdu_len - check if extended addr is valid
+ * ieee802154_is_valid_extended_unicast_addr - check if extended addr is valid
  * @addr: extended addr to check
  */
-static inline bool ieee802154_is_valid_extended_unicast_addr(const __le64 addr)
+static inline bool ieee802154_is_valid_extended_unicast_addr(__le64 addr)
 {
 	/* Bail out if the address is all zero, or if the group
 	 * address bit is set.
-- 
2.8.0

