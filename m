Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50888 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758584AbcCVNPk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 22 Mar 2016 09:15:40 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 01/19] ieee802154: cleanups for ieee802154.h
Date: Tue, 22 Mar 2016 14:14:57 +0100
Message-Id: <1458652515-7862-2-git-send-email-aar@pengutronix.de>
In-Reply-To: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

This patch removes some const from non-pointer types and fixes the
function name for the ieee802154_is_valid_extended_unicast_addr
comment.

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
2.7.4

