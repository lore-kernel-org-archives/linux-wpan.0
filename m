Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52442 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758847AbcCVNPn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 22 Mar 2016 09:15:43 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 10/19] 6lowpan: add lowpan_is_ll function
Date: Tue, 22 Mar 2016 14:15:06 +0100
Message-Id: <1458652515-7862-11-git-send-email-aar@pengutronix.de>
In-Reply-To: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

This patch adds the lowpan_is_ll function, which can be used to make a
special 6lowpan linklayer handling for a specific 6lowpan linklayer
type.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/6lowpan.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 04b877c..6c09d01 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -144,6 +144,13 @@ struct lowpan_dev *lowpan_dev(const struct net_device *dev)
 	return netdev_priv(dev);
 }
 
+static inline bool lowpan_is_ll(const struct net_device *dev,
+				enum lowpan_lltypes lltype)
+{
+	return (dev->type == ARPHRD_6LOWPAN &&
+		lowpan_dev(dev)->lltype == lltype);
+}
+
 /* private device info */
 struct lowpan_802154_dev {
 	struct net_device	*wdev; /* wpan device ptr */
-- 
2.7.4

