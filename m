Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55464 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932072AbcEKJoo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 11 May 2016 05:44:44 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 1/3] nl802154: move PAD to right position
Date: Wed, 11 May 2016 11:44:17 +0200
Message-Id: <1462959859-6669-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>, Nicolas Dichtel <nicolas.dichtel@6wind.com>

The PAD define should be above the experimental support. We don't care
about if we break userspace in experimental stuff but PAD is part of the
existing UAPI.

Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/nl802154.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index fcab4de..7aad2fd 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -124,6 +124,8 @@ enum nl802154_attrs {
 
 	NL802154_ATTR_ACKREQ_DEFAULT,
 
+	NL802154_ATTR_PAD,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
@@ -138,8 +140,6 @@ enum nl802154_attrs {
 	NL802154_ATTR_SEC_KEY,
 #endif /* CONFIG_IEEE802154_NL802154_EXPERIMENTAL */
 
-	NL802154_ATTR_PAD,
-
 	__NL802154_ATTR_AFTER_LAST,
 	NL802154_ATTR_MAX = __NL802154_ATTR_AFTER_LAST - 1
 };
-- 
2.8.2

