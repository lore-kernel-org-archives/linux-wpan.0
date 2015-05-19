Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:50613 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbEST4h (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 May 2015 15:56:37 -0400
Date: Tue, 19 May 2015 22:50:03 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 3/8] ieee802154: Remove ieee802154_reduced_mlme_ops
 references.
Message-ID: <20150519195003.GO11014@wantstofly.org>
References: <cover.1432064518.git.buytenh@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1432064518.git.buytenh@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

As there doesn't seem to be a definition of it or any users of it.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 include/net/ieee802154_netdev.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index 69452fc..e2c9b7d 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -443,10 +443,4 @@ ieee802154_mlme_ops(const struct net_device *dev)
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

