Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:52608 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbbEYMie (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 25 May 2015 08:38:34 -0400
Date: Mon, 25 May 2015 15:38:33 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCHv2 bluetooth-next 3/6] ieee802154: Remove
 ieee802154_reduced_mlme_ops references.
Message-ID: <20150525123833.GL11340@wantstofly.org>
References: <cover.1432535597.git.buytenh@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1432535597.git.buytenh@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

As there doesn't seem to be a definition of it or any users of it.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
Acked-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/ieee802154_netdev.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index 84a72a1..0a87975 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -430,10 +430,4 @@ ieee802154_mlme_ops(const struct net_device *dev)
 	return dev->ml_priv;
 }
 
-static inline struct ieee802154_reduced_mlme_ops *
-ieee802154_reduced_mlme_ops(const struct net_device *dev)
-{
-	return dev->ml_priv;
-}
-
 #endif
-- 
2.1.0

