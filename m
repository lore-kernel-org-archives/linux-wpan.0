Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:50396 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbaJZIhj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:37:39 -0400
Received: by mail-lb0-f178.google.com with SMTP id f15so532560lbj.23
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:37:38 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 14/15] mac802154: tx: add comment at sync xmit callback
Date: Sun, 26 Oct 2014 09:37:14 +0100
Message-Id: <1414312635-19396-15-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
References: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a warning that xmit_sync callback is deprecated and
should be removed soon. The 802.15.4 subsystem will not accept synced
drivers anymore.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 57b1202..942dd53 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -117,6 +117,10 @@ struct ieee802154_hw {
  *	  synchronous 802.15.4 drivers.
  *	  This function should return zero or negative errno.
  *
+ *	  WARNING:
+ *	  This will be deprecated soon. We don't accept synced xmit callbacks
+ *	  drivers anymore.
+ *
  * xmit_async:
  *	  Handler that 802.15.4 module calls for each transmitted frame.
  *	  skb cntains the buffer starting from the IEEE 802.15.4 header.
-- 
2.1.2

